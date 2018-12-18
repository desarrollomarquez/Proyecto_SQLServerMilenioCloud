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
    public class PobladoesController : Controller
    {
        private MilenioCloudEntities1 db = new MilenioCloudEntities1();

        // GET: Pobladoes
        public ActionResult Index()
        {
            var pobladoes = db.Pobladoes.Include(p => p.Municipio);
            return View(pobladoes.ToList());
        }

        // GET: Pobladoes/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Poblado poblado = db.Pobladoes.Find(id);
            if (poblado == null)
            {
                return HttpNotFound();
            }
            return View(poblado);
        }

        // GET: Pobladoes/Create
        public ActionResult Create()
        {
            ViewBag.Municipio_Id = new SelectList(db.Municipios, "Dane_Id", "Departamento_Id");
            return View();
        }

        // POST: Pobladoes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Codigo_Id,Municipio_Id,Poblado_Id,Nombre,Tipo,Latitud,Longitud")] Poblado poblado)
        {
            if (ModelState.IsValid)
            {
                db.Pobladoes.Add(poblado);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Municipio_Id = new SelectList(db.Municipios, "Dane_Id", "Departamento_Id", poblado.Municipio_Id);
            return View(poblado);
        }

        // GET: Pobladoes/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Poblado poblado = db.Pobladoes.Find(id);
            if (poblado == null)
            {
                return HttpNotFound();
            }
            ViewBag.Municipio_Id = new SelectList(db.Municipios, "Dane_Id", "Departamento_Id", poblado.Municipio_Id);
            return View(poblado);
        }

        // POST: Pobladoes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Codigo_Id,Municipio_Id,Poblado_Id,Nombre,Tipo,Latitud,Longitud")] Poblado poblado)
        {
            if (ModelState.IsValid)
            {
                db.Entry(poblado).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Municipio_Id = new SelectList(db.Municipios, "Dane_Id", "Departamento_Id", poblado.Municipio_Id);
            return View(poblado);
        }

        // GET: Pobladoes/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Poblado poblado = db.Pobladoes.Find(id);
            if (poblado == null)
            {
                return HttpNotFound();
            }
            return View(poblado);
        }

        // POST: Pobladoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Poblado poblado = db.Pobladoes.Find(id);
            db.Pobladoes.Remove(poblado);
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
