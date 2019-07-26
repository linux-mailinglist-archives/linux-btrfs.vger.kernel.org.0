Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8C75E4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 07:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfGZF1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 01:27:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9402 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZF1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 01:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564118864; x=1595654864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VjG4mezlrcJB/bc9X2SLWG1Aw9iPjCEPMFAbs6YmLCc=;
  b=LYwUCliGZSNbhjxs3wcI9wa5SzDZtXmwF+9ouekaHnZQoYCy+fBM2jdT
   DVuoegJOQePGkMnKikgh8hAkWzwR7XOpS0NN8kLOjTomkIIwjPeRLdeE9
   rO1qxf9Q7f+wm8GIg14/RXBexNKjfUaIKriThsU481LEJNbLXWMkyWV/Y
   vjfg82mwr2VaBb7pfVBEn7kGCGJ9ZT6u8ZFSP8kXcXedoG186oRb6ysG6
   hFyJbKHQrzjUn0IOsJXrnyRRjKvOkPLRvu4UmlWIWqKCwT4la3xfNtFoR
   8NR6K04pxSvn6cOzEgWlrqYQpM0bm5U59ccREIN1TuoItXbMLUP1VBfPU
   w==;
IronPort-SDR: UIw8haikmJ1FmBMy0ZiPsqBxsU/NX9CQ/2KN+NRCW8aNqmeeevD1P0c4fpFtZqXZkG7wVwbVCM
 VsO+fQT+u5/259cO5vw48tUwDz5VEiiMnD0SlroX/vnUXaAkukKNwHhq3KcwD1Rn722L2ruod3
 uBYKGMHiK4lFRd8aZpIc5q7ctH705R714JCGPed+yczaoUUpWb6S1MY9XKwtHC1Sq/eOLzmwlc
 DITvRMUlXkzepLP7zSB6xNm32kzvDqn0I59YNfJcwZdEHJuX71kFTaArPlI49Wjcw3PHirXPJV
 O7A=
X-IronPort-AV: E=Sophos;i="5.64,309,1559491200"; 
   d="scan'208";a="114168748"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 13:27:44 +0800
IronPort-SDR: D8hfeR0EpJL2ACdnygkfO0FjhX1XL8kdVFhwI2I2eqFwd4BegrTPnUU+XF2+b2HjW48JW8+Nx8
 UsTgY7vvX7WGXzmbBk7CZGFcouPdq5iO3NA7Go4TxreCX9Zz8rAZaUmiS3oksuAEJr8HLSXp+D
 QUi7Xk5LzzF/o8Je+N+fD5nNVs42elmQFFKctLC6c+6mU58YpSUvWw0cSj6vtMAjXP8+bBCFCD
 KbWHJgDdfivCdkAZp3IMEf0G8VTCrAsDEX6V7TdOPiLfi5RGJ4LLNXrRPrW2OCZH8o7UuFsoI6
 Ld+oP6Ft6TwkmwI4RctPNH/F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 22:25:53 -0700
IronPort-SDR: aNwjbrJW4JO17IDzB6BS8zpJ0bRyFn8kAgQ3Ub2WMTUlSI98XgJHAUKqzlnLiE7gy4NPMVURSz
 ugzImUHStlomncGpg+T8HLBcVMEdzW2Y72E1PXyzE6A6dUey33EgzsRWm+v67Jb5iAtb6vwV5U
 C825MZj79ch3Ec14qzlb2gNTeGqeSYkTQnP2K1Y9wYiG9SDGDmDbJOVk+oVH40uFUkSO1pVfPF
 DuIHlP5koPLNA3qNyNanszayyK1Fl4xdl1AYYjGWu0aqLb+NMoD8qgCuSRKECvNgs88YWpqtZ8
 t4A=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2019 22:27:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix extent buffer read/write range checks
Date:   Fri, 26 Jul 2019 14:27:24 +0900
Message-Id: <20190726052724.12338-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several functions to read/write an extent buffer check if specified offset
range resides in the size of the extent buffer. However, those checks have
two problems:

(1) they don't catch "start == eb->len" case.
(2) it checks offset in extent buffer against logical address using
    eb->start.

Generally, eb->start is much larger than the offset, so the second WARN_ON
was almost useless.

Fix these problems in read_extent_buffer_to_user(),
{memcmp,write,memzero}_extent_buffer().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 50cbaf1dad5b..c0174f530568 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5545,8 +5545,8 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start >= eb->len);
+	WARN_ON(start + len > eb->len);
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5623,8 +5623,8 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start >= eb->len);
+	WARN_ON(start + len > eb->len);
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5678,8 +5678,8 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
 	size_t start_offset = offset_in_page(eb->start);
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start >= eb->len);
+	WARN_ON(start + len > eb->len);
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5708,8 +5708,8 @@ void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
 	size_t start_offset = offset_in_page(eb->start);
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start >= eb->len);
+	WARN_ON(start + len > eb->len);
 
 	offset = offset_in_page(start_offset + start);
 
-- 
2.22.0

