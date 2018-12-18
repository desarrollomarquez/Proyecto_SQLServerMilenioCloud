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
    public class ColegiosController : Controller
    {
        private MilenioCloudEntities1 db = new MilenioCloudEntities1();

        // GET: Colegios
        public ActionResult Index()
        {
            return View(db.Colegios.ToList());
        }

        // GET: Colegios/Details/5
        public ActionResult Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio colegio = db.Colegios.Find(id);
            if (colegio == null)
            {
                return HttpNotFound();
            }
            return View(colegio);
        }

        // GET: Colegios/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Colegios/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Codigo_Id,Nit,Nombre,CodigoColegio,CodigoDane,Direccion,Telefono,FiniFiscal,FfinFiscal,UbicacionGeo,Foto")] Colegio colegio)
        {
            if (ModelState.IsValid)
            {
                colegio.Codigo_Id = Guid.NewGuid();
                db.Colegios.Add(colegio);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(colegio);
        }

        // GET: Colegios/Edit/5
        public ActionResult Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio colegio = db.Colegios.Find(id);
            if (colegio == null)
            {
                return HttpNotFound();
            }
            return View(colegio);
        }

        // POST: Colegios/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Codigo_Id,Nit,Nombre,CodigoColegio,CodigoDane,Direccion,Telefono,FiniFiscal,FfinFiscal,UbicacionGeo,Foto")] Colegio colegio)
        {
            if (ModelState.IsValid)
            {
                db.Entry(colegio).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(colegio);
        }

        // GET: Colegios/Delete/5
        public ActionResult Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Colegio colegio = db.Colegios.Find(id);
            if (colegio == null)
            {
                return HttpNotFound();
            }
            return View(colegio);
        }

        // POST: Colegios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(Guid id)
        {
            Colegio colegio = db.Colegios.Find(id);
            db.Colegios.Remove(colegio);
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
