Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBD485A33
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiAEUqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 15:46:09 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:55402 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244196AbiAEUp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 15:45:58 -0500
Received: from venice.bhome ([84.220.25.125])
        by michael.mail.tiscali.it with 
        id f8lv2601f2hwt04018lwus; Wed, 05 Jan 2022 20:45:56 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH][V2] btrfs-progs: allow autodetect_object_types() to handle link.
Date:   Wed,  5 Jan 2022 21:45:52 +0100
Message-Id: <da4a4e0cf18df259e63c19872093bf12635da576.1641415488.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641415556; bh=14gRAPqQVDzWBB64W+qcfcYn/WPFiBg95T1ddjmg15E=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=EPxyZtcIVReMDg4xJozhJ8nIwb4zZoV+lcLfbibi1Q7H+Q+GxjUyPlBSbUmljrS8o
         FMDwQKgvlkhcz8cF470KPkmJcOhsod31T8oOspM4CY49JsY4Z6iyAl7WEHRpIBVl1v
         q3TXSJYYx1Dt5ziArjNTe4IBqKJAvuXxPFEEmy2M=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The function autodetect_object_types() tries to detect the type of
btrfs object passed. If it is an "inode" type (e.g. file) this function
returns the type as "inode". If it is a block device, it return it as
"block device".
However it doesn't handle the case where the object passed is a link
to a block device (which could be a valid btrfs device). For example
LVM/DM creates link to block devices. In this case it should return
the type as "block device".

This patch replace the lstat() call with a stat().

Reported-by: Boris Burkov <boris@bur.io>
Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/property.c b/cmds/property.c
index 59ef997c..b3ccc0ff 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -373,7 +373,7 @@ static int autodetect_object_types(const char *object, int *types_out)
 
 	is_btrfs_object = check_btrfs_object(object);
 
-	ret = lstat(object, &st);
+	ret = stat(object, &st);
 	if (ret < 0) {
 		ret = -errno;
 		goto out;
-- 
2.34.1

