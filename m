Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE6FFE87
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfKRGbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 01:31:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:38358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfKRGbF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 01:31:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C05C9B246;
        Mon, 18 Nov 2019 06:31:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
Subject: [PATCH 3/4] btrfs-progs: libbtrfsutil: Convert to designated initialization for QgroupInherit_type
Date:   Mon, 18 Nov 2019 14:30:51 +0800
Message-Id: <20191118063052.56970-4-wqu@suse.com>
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

  qgroup.c:110:2: warning: initialization of ‘long int’ from ‘void *’ makes integer from pointer without a cast [-Wint-conversion]
    110 |  NULL,     /* tp_print */
        |  ^~~~
  qgroup.c:110:2: note: (near initialization for ‘QgroupInherit_type.tp_vectorcall_offset’)

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
 libbtrfsutil/python/qgroup.c | 43 +++++++-----------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/libbtrfsutil/python/qgroup.c b/libbtrfsutil/python/qgroup.c
index 44ac5ebc19d2..163fbbf077e6 100644
--- a/libbtrfsutil/python/qgroup.c
+++ b/libbtrfsutil/python/qgroup.c
@@ -103,39 +103,12 @@ static PyMethodDef QgroupInherit_methods[] = {
 
 PyTypeObject QgroupInherit_type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
-	"btrfsutil.QgroupInherit",		/* tp_name */
-	sizeof(QgroupInherit),			/* tp_basicsize */
-	0,					/* tp_itemsize */
-	(destructor)QgroupInherit_dealloc,	/* tp_dealloc */
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
-	(getattrofunc)QgroupInherit_getattro,	/* tp_getattro */
-	NULL,					/* tp_setattro */
-	NULL,					/* tp_as_buffer */
-	Py_TPFLAGS_DEFAULT,			/* tp_flags */
-	QgroupInherit_DOC,			/* tp_doc */
-	NULL,					/* tp_traverse */
-	NULL,					/* tp_clear */
-	NULL,					/* tp_richcompare */
-	0,					/* tp_weaklistoffset */
-	NULL,					/* tp_iter */
-	NULL,					/* tp_iternext */
-	QgroupInherit_methods,			/* tp_methods */
-	NULL,					/* tp_members */
-	NULL,					/* tp_getset */
-	NULL,					/* tp_base */
-	NULL,					/* tp_dict */
-	NULL,					/* tp_descr_get */
-	NULL,					/* tp_descr_set */
-	0,					/* tp_dictoffset */
-	(initproc)QgroupInherit_init,		/* tp_init */
+	.tp_name		= "btrfsutil.QgroupInherit",
+	.tp_basicsize		= sizeof(QgroupInherit),
+	.tp_dealloc		= (destructor)QgroupInherit_dealloc,
+	.tp_getattro		= (getattrofunc)QgroupInherit_getattro,
+	.tp_flags		= Py_TPFLAGS_DEFAULT,
+	.tp_doc			= QgroupInherit_DOC,
+	.tp_methods		= QgroupInherit_methods,
+	.tp_init		= (initproc)QgroupInherit_init,
 };
-- 
2.24.0

