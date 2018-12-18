using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MilenioCloudModel.Models;

namespace MilenioCloudModel.Controllers
{
    public class Colegio_UsuarioController : Controller
    {
        private MilenioCloudEntities1 db = new MilenioCloudEntities1();

        // GET: Colegio_Usuario
        public ActionResult Index()
        {
            var colegio_Usuario = db.Colegio_Usuario.Include(c => c.Colegio).Include(c => c.Usuario);
            return View(colegio_Usuario.ToList());
        }

        // GET: Colegio_Usuario/Details/5
        public ActionResult Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio_Usuario colegio_Usuario = db.Colegio_Usuario.Find(id);
            if (colegio_Usuario == null)
            {
                return HttpNotFound();
            }
            return View(colegio_Usuario);
        }

        // GET: Colegio_Usuario/Create
        public ActionResult Create()
        {
            ViewBag.Colegio_Id = new SelectList(db.Colegios, "Codigo_Id", "Nombre");
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email");
            return View();
        }

        // POST: Colegio_Usuario/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Colegio_Id,Usuario_Id,fecha_caducidad,Estado,Descripcion")] Colegio_Usuario colegio_Usuario)
        {
            if (ModelState.IsValid)
            {
                colegio_Usuario.Colegio_Id = Guid.NewGuid();
                db.Colegio_Usuario.Add(colegio_Usuario);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Colegio_Id = new SelectList(db.Colegios, "Codigo_Id", "Nombre", colegio_Usuario.Colegio_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", colegio_Usuario.Usuario_Id);
            return View(colegio_Usuario);
        }

        // GET: Colegio_Usuario/Edit/5
        public ActionResult Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio_Usuario colegio_Usuario = db.Colegio_Usuario.Find(id);
            if (colegio_Usuario == null)
            {
                return HttpNotFound();
            }
            ViewBag.Colegio_Id = new SelectList(db.Colegios, "Codigo_Id", "Nombre", colegio_Usuario.Colegio_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", colegio_Usuario.Usuario_Id);
            return View(colegio_Usuario);
        }

        // POST: Colegio_Usuario/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Colegio_Id,Usuario_Id,fecha_caducidad,Estado,Descripcion")] Colegio_Usuario colegio_Usuario)
        {
            if (ModelState.IsValid)
            {
                db.Entry(colegio_Usuario).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Colegio_Id = new SelectList(db.Colegios, "Codigo_Id", "Nombre", colegio_Usuario.Colegio_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", colegio_Usuario.Usuario_Id);
            return View(colegio_Usuario);
        }

        // GET: Colegio_Usuario/Delete/5
        public ActionResult Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio_Usuario colegio_Usuario = db.Colegio_Usuario.Find(id);
            if (colegio_Usuario == null)
            {
                return HttpNotFound();
            }
            return View(colegio_Usuario);
        }

        // POST: Colegio_Usuario/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(Guid id)
        {
            Colegio_Usuario colegio_Usuario = db.Colegio_Usuario.Find(id);
            db.Colegio_Usuario.Remove(colegio_Usuario);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
