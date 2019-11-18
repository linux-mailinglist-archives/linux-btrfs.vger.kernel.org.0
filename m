Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23B0FFE88
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfKRGbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 01:31:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfKRGbH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 01:31:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB614B256;
        Mon, 18 Nov 2019 06:31:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
Subject: [PATCH 4/4] btrfs-progs: libbtrfsutil: Convert to designated initialization for SubvolumeIterator_type
Date:   Mon, 18 Nov 2019 14:30:52 +0800
Message-Id: <20191118063052.56970-5-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118063052.56970-1-wqu@suse.com>
References: <20191118063052.56970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When compiling btrfs-progs with libbtrfsutil on a python3.8 system, we
got the following warning:

  subvolume.c:636:2: warning: initialization of ‘long int’ from ‘void *’ makes integer from pointer without a cast [-Wint-conversion]
    636 |  NULL,     /* tp_print */
        |  ^~~~
  subvolume.c:636:2: note: (near initialization for ‘SubvolumeIterator_type.tp_vectorcall_offset’)

[CAUSE]
C definition of PyTypeObject changed in python 3.8.
Now at the old tp_print, we have tp_vectorcall_offset.

So we got above warning.

[FIX]
C has designated initialization, which can assign values to each named
member, without hard coding to match the offset.
And all the other uninitialized values will be set to 0, so we can save
a lot of unneeded "= 0" or "= NULL" lines.

Just use that awesome feature to avoid any future breakage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/subvolume.c | 44 +++++++--------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/libbtrfsutil/python/subvolume.c b/libbtrfsutil/python/subvolume.c
index 0f893b9171fa..a837d2e32f36 100644
--- a/libbtrfsutil/python/subvolume.c
+++ b/libbtrfsutil/python/subvolume.c
@@ -629,39 +629,13 @@ static PyMethodDef SubvolumeIterator_methods[] = {
 
 PyTypeObject SubvolumeIterator_type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
-	"btrfsutil.SubvolumeIterator",		/* tp_name */
-	sizeof(SubvolumeIterator),		/* tp_basicsize */
-	0,					/* tp_itemsize */
-	(destructor)SubvolumeIterator_dealloc,	/* tp_dealloc */
-	NULL,					/* tp_print */
-	NULL,					/* tp_getattr */
-	NULL,					/* tp_setattr */
-	NULL,					/* tp_as_async */
-	NULL,					/* tp_repr */
-	NULL,					/* tp_as_number */
-	NULL,					/* tp_as_sequence */
-	NULL,					/* tp_as_mapping */
-	NULL,					/* tp_hash  */
-	NULL,					/* tp_call */
-	NULL,					/* tp_str */
-	NULL,					/* tp_getattro */
-	NULL,					/* tp_setattro */
-	NULL,					/* tp_as_buffer */
-	Py_TPFLAGS_DEFAULT,			/* tp_flags */
-	SubvolumeIterator_DOC,			/* tp_doc */
-	NULL,					/* tp_traverse */
-	NULL,					/* tp_clear */
-	NULL,					/* tp_richcompare */
-	0,					/* tp_weaklistoffset */
-	PyObject_SelfIter,			/* tp_iter */
-	(iternextfunc)SubvolumeIterator_next,	/* tp_iternext */
-	SubvolumeIterator_methods,		/* tp_methods */
-	NULL,					/* tp_members */
-	NULL,					/* tp_getset */
-	NULL,					/* tp_base */
-	NULL,					/* tp_dict */
-	NULL,					/* tp_descr_get */
-	NULL,					/* tp_descr_set */
-	0,					/* tp_dictoffset */
-	(initproc)SubvolumeIterator_init,	/* tp_init */
+	.tp_name		= "btrfsutil.SubvolumeIterator",
+	.tp_basicsize		= sizeof(SubvolumeIterator),
+	.tp_dealloc		= (destructor)SubvolumeIterator_dealloc,
+	.tp_flags		= Py_TPFLAGS_DEFAULT,
+	.tp_doc			= SubvolumeIterator_DOC,
+	.tp_iter		= PyObject_SelfIter,
+	.tp_iternext		= (iternextfunc)SubvolumeIterator_next,
+	.tp_methods		= SubvolumeIterator_methods,
+	.tp_init		= (initproc)SubvolumeIterator_init,
 };
-- 
2.24.0

