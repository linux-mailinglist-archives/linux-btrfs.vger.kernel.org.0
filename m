Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747AB1E6968
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405872AbgE1SfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:35:01 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:47090 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405868AbgE1Se7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:34:59 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMjjt6vcLNQWeNMnjtDeO; Thu, 28 May 2020 20:34:57 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690897; bh=H9WRSFd82hbCDotLF6a/tKsukwxA6ocUzLx0ZSBBwwI=;
        h=From;
        b=HavJfKbJA0qh+niC3RXbBFeM0gw1gdMwrcviaAbVvh3ZXA6kWTdrN4ZrNFHIMPcMa
         v95+C49F0YZJKFuDnpZCCZ99sR5+XO62sfYAEeFqu1TvP1ojtFHWfjFdAcICL+mfra
         gSAyN+N/lJid0LIGl3RohEQaYpJqwAfUdNLgjRS9oxBZh6cSSH52XvyH3xBnGxIaQO
         s0rR5PdXYhJnjhs8n2AwU+J6D9vpCu7SemURoV6r1a2/efzpZ0SoLfBZifNnrNXloS
         M3CIxqWPRy8qpzFUOfuAfC/0WOEHbHrI0EVRd1d9SQ4+sVBMSCbOA/NiHlM4gNggM1
         bfpztHILfnn4A==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=V5MRcGaKH_fqCW5OQCMA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/4] Add flags for dedicated metadata disks
Date:   Thu, 28 May 2020 20:34:49 +0200
Message-Id: <20200528183451.16654-3-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528183451.16654-1-kreijack@libero.it>
References: <20200528183451.16654-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDrXuWwqW9ik1CG+woYMSGvNfWh9IhnmcXwPbE8nfDLRf4NfgySGejXwrgFP7yFQQnItySqGDeTWk+6WpDrHqrs7f5/5Q+dXlaH5VbLUDBl3F059ypjE
 X3Xtq4rMt2ZBHXvPUzalvLQ+8Jl9bHdA69EVN399/ZGPOlgSD1658C0hf9mc6TjEErDwSyLmVwkZFwJBEnzaEngys9yzvq7AKE3802VxIxk4UsesQytgqLkO
 zurn1hiwQZ7sRGSWpGD5ol8FlF4Cp82U+gB/NCojpIkXkxlNIxvdxaSrBTxE6+/JlicmdJZuXrSDO/rtxIvqMBDq+NMOIvkb/7gAbIZCiSzHT5fIpX+ODEkd
 vh0ml1XrsIwk0c5Ul7kzpUZ8CN1l4vFWVIeZPsasJCikVh5lg6hPzSa1ocg6K1a6CyJKBrjQi51gH3ZptvB0l3oc8orHCg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

---
 include/uapi/linux/btrfs_tree.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8e322e2c7e78..a45d09591db8 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -355,6 +355,9 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+#define BTRFS_DEV_PREFERRED_METADATA	(1ULL << 0)
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.27.0.rc2

