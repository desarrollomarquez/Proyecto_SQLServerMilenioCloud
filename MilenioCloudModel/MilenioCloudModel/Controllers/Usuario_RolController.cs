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
    public class Usuario_RolController : Controller
    {
        private MilenioCloudEntities1 db = new MilenioCloudEntities1();

        // GET: Usuario_Rol
        public ActionResult Index()
        {
            var usuario_Rol = db.Usuario_Rol.Include(u => u.Rol).Include(u => u.Usuario);
            return View(usuario_Rol.ToList());
        }

        // GET: Usuario_Rol/Details/5
        public ActionResult Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuario_Rol usuario_Rol = db.Usuario_Rol.Find(id);
            if (usuario_Rol == null)
            {
                return HttpNotFound();
            }
            return View(usuario_Rol);
        }

        // GET: Usuario_Rol/Create
        public ActionResult Create()
        {
            ViewBag.Rol_Id = new SelectList(db.Rols, "Codigo_Id", "Nombre");
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email");
            return View();
        }

        // POST: Usuario_Rol/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Usuario_Id,Rol_Id,fecha_caducidad,Estado,Descripcion")] Usuario_Rol usuario_Rol)
        {
            if (ModelState.IsValid)
            {
                usuario_Rol.Usuario_Id = Guid.NewGuid();
                db.Usuario_Rol.Add(usuario_Rol);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Rol_Id = new SelectList(db.Rols, "Codigo_Id", "Nombre", usuario_Rol.Rol_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", usuario_Rol.Usuario_Id);
            return View(usuario_Rol);
        }

        // GET: Usuario_Rol/Edit/5
        public ActionResult Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuario_Rol usuario_Rol = db.Usuario_Rol.Find(id);
            if (usuario_Rol == null)
            {
                return HttpNotFound();
            }
            ViewBag.Rol_Id = new SelectList(db.Rols, "Codigo_Id", "Nombre", usuario_Rol.Rol_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", usuario_Rol.Usuario_Id);
            return View(usuario_Rol);
        }

        // POST: Usuario_Rol/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Usuario_Id,Rol_Id,fecha_caducidad,Estado,Descripcion")] Usuario_Rol usuario_Rol)
        {
            if (ModelState.IsValid)
            {
                db.Entry(usuario_Rol).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Rol_Id = new SelectList(db.Rols, "Codigo_Id", "Nombre", usuario_Rol.Rol_Id);
            ViewBag.Usuario_Id = new SelectList(db.Usuarios, "Codigo_Id", "Email", usuario_Rol.Usuario_Id);
            return View(usuario_Rol);
        }

        // GET: Usuario_Rol/Delete/5
        public ActionResult Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Usuario_Rol usuario_Rol = db.Usuario_Rol.Find(id);
            if (usuario_Rol == null)
            {
                return HttpNotFound();
            }
            return View(usuario_Rol);
        }

        // POST: Usuario_Rol/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(Guid id)
        {
            Usuario_Rol usuario_Rol = db.Usuario_Rol.Find(id);
            db.Usuario_Rol.Remove(usuario_Rol);
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
