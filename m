Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583D438457
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Oct 2021 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJWQnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Oct 2021 12:43:11 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:38668 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229901AbhJWQnL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Oct 2021 12:43:11 -0400
Received: from venice.bhome ([78.14.151.87])
        by smtp-34.iol.local with ESMTPA
        id eK4fmTmHf7YJJeK4fmYgCS; Sat, 23 Oct 2021 18:40:50 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1635007250; bh=F0+m0kRlp2e9O1zoN8wKbv20lTfJXtr5mmK3w+ybe6U=;
        h=From;
        b=HCnACcsRn1kwtHjhtjfGOSkxiV/JEpO0iLfznCIh201R6hPtdMY+wQ2q+COQmnAA2
         oc81zgV8cNaaVaHB6SxEyaH2CosYgbOvTDJNXBlAPQg/7Q3C9rJ7Gl1dhQoSRme+cF
         g+RjQmpOAUA4hgoABMQ5xBQo0lKSpg+39WSBsOXTHERd41bAjNjFeKoLPLV7h0NGfO
         EbWyBNuV6c5kaK0eftk/nSdRF5wjEnTHHO5CKmrJ037tANJ2xMYq6+lpTLVo9KHjEJ
         PB1HNZzO2HNUPUW4Roaf1Oe44R+QgBU4d/vWp/clLTdPqyLTS8W3+8s6ldBTRuLBro
         40LPUm0d1nJkg==
X-CNFS-Analysis: v=2.4 cv=dvYet3s4 c=1 sm=1 tr=0 ts=61743b12 cx=a_exe
 a=s8rBCFaCIOijKbcNVo+3rw==:117 a=s8rBCFaCIOijKbcNVo+3rw==:17
 a=IkcTkHD0fZMA:10 a=A695XayFOBEGylKwg94A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH] btrfs-progs: remove path_cat[3]_out() double declaration
Message-ID: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
Date:   Sat, 23 Oct 2021 18:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDtgeRY7G3+78SW0qYDt0weyBVRNIX8Z520ukWR746sul2HUNEO5iQy1cIO0JOcYzCvaxM3+d2NWIpaNap0ZAWU/zm/WLYZ1OElBs1FLBXEP2SGkV6PV
 JweRVOjmjgstfyPffUO4CUwyL1jXHZJ4DRzmGCF5v3LJ1YI9VBd5dQ4ZOHBmQm7DSf2LLNR3fupnoA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the double declaration of path_cat_out()/path_cat3_out()

The functions
   - path_cat_out()
   - path_cat3_out()
are declared two times in the following header files:
   - common/path-utils.h
   - common/send-utils.h

Remove the double declaration from send-utils.h and add the path-utils.h include file
where needed.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>


--

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 058e8918..e8862165 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -34,6 +34,7 @@
  #include <asm/types.h>
  #include <uuid/uuid.h>
  #include "common/utils.h"
+#include "common/path-utils.h"
  #include "cmds/commands.h"
  #include "common/send-utils.h"
  #include "common/send-stream.h"
diff --git a/common/send-utils.h b/common/send-utils.h
index dd67b3fe..74cc6fc4 100644
--- a/common/send-utils.h
+++ b/common/send-utils.h
@@ -104,9 +104,6 @@ void subvol_uuid_search_add(struct subvol_uuid_search *s,
  
  int btrfs_subvolid_resolve(int fd, char *path, size_t path_len, u64 subvol_id);
  
-int path_cat_out(char *out, const char *p1, const char *p2);
-int path_cat3_out(char *out, const char *p1, const char *p2, const char *p3);
-
  #ifdef __cplusplus
  }
  #endif
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 471d49da..f35544d6 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -33,6 +33,7 @@
  #include "common/messages.h"
  #include "kernel-shared/transaction.h"
  #include "common/utils.h"
+#include "common/path-utils.h"
  #include "mkfs/rootdir.h"
  #include "mkfs/common.h"
  #include "common/send-utils.h"


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
