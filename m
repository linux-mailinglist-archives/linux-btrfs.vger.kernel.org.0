Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC083641F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhDSMq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 08:46:27 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:40024 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhDSMqZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 08:46:25 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 33515475B5D;
        Mon, 19 Apr 2021 15:45:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1618836354; bh=xHdYf1Ot6faBfLJ0mmU8p0a+YYD5s3D3APcB6+Eg9vU=;
        h=From:To:Cc:Subject:Date;
        b=BPkNjkEgaltPMYVjzC/OG7aP2lrMAKaT3XD7U5YaXmhDq0KTvhfN658uq7brCWf1w
         vNk4hysOIX1uB4uFCaOfsClBfIOhDxgjCbSlwcKb9dsuJmVRT9/TpERxtSU+8dKwZR
         dgErM6C5pCMeofDmkUAkrbYOo84blzQN4dT2UnTQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 20417475B5B;
        Mon, 19 Apr 2021 15:45:54 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id d_ipZCw49s8d; Mon, 19 Apr 2021 15:45:53 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id BBBCE4758DE;
        Mon, 19 Apr 2021 15:45:53 +0300 (EEST)
Received: from localhost.localdomain (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id C74DD1BE00EF;
        Mon, 19 Apr 2021 15:45:51 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs-progs: fi resize: fix false 0.00B sized output
Date:   Mon, 19 Apr 2021 20:45:41 +0800
Message-Id: <20210419124541.148269-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSeE2piULSPXaeWkYr1kpEWOj78+Ck2RhHn3jmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Resize to nums without sign prefix makes false output:
Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B

The resize operation would take effect though.

Fix it by handling the case if mod is 0 in check_resize_args().

Issue: #307
Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Su Yue <l@damenly.su>
---
 cmds/filesystem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 9e3cce687d6e..607c85a0bccc 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1158,6 +1158,13 @@ static int check_resize_args(const char *amount, const char *path) {
 		}
 		old_size = di_args[dev_idx].total_bytes;
 
+		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
+		if (mod == 0) {
+			new_size = diff;
+			diff = new_size - old_size;
+			mod = diff;
+		}
+
 		if (mod < 0) {
 			if (diff > old_size) {
 				error("current size is %s which is smaller than %s",
-- 
2.30.1

