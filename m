Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457151931A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYUKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 16:10:49 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:49843 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbgCYUKs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 16:10:48 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id HCMOjh5MEjfNYHCMOjKIfG; Wed, 25 Mar 2020 21:10:45 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585167045; bh=cAxVH6hLWzDRu/JCKHeQjQOhNxzp9oNLDmVQr13rN0E=;
        h=From;
        b=mBqpTKxr1zJ/aITeQ5F71+mdYGazifanI1F0mJjgcEA+QnizbYYEddBhBJ+sTN1rc
         NtzgnMoMWlXrc2yCcpqHaPRe2v5Fvgu3y3E4QpprMAP74KdGNNqu9HUvwvSP6ETodo
         jNfGwacyAQTmjOCg6ubwiCM7kwBQoj0YFmaGcLnloPrtAtQhstEqJuV53eYOT2l0dF
         wvN2Lcfq86FUgKN/+lf9C8RiwIRQ5gEPwCY8BgesdOTuGYA2B8G71y8tAhC0Uq6P8B
         5tkNuUBaoqdp4vVZ5u7MbCCQvAGevpvXDFiWDU3R0aVl9pG1ZOtZ4Wg7WK/07D2M36
         GohQ9kRY7kRWg==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=X8O9t2tcqu8mHWPlI2QA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [RFC][PATCH] btrfs-progs: add warning for mixed prfofiles filesystem
Date:   Wed, 25 Mar 2020 21:10:38 +0100
Message-Id: <20200325201042.190332-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEuCnovtdD+TRoeabWypWzplUOR+GkQayJ7V99CQYO85L74ziUcBkhKEpmAheyuIWsJLjTH4xPCec77502nddjJO1i3YdjhU/zRctjhI8g7IdiRAsFz7
 Ld9XB5oxruih8lCZ98VZVF+dW0G66Y90aZGvPLGotlKEWhD9uUTCSPJ6jd9gRsFeDElpw53O1SLvnQ77+7PmxVbQulvNAOj0weXuSebh9mia8c5X7r3XAX8H
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

the aim of this patch set is to issue a warning when a mixed profiles
filesystem is detected. This happens when the filesystems contains
(i.e.) raid1c3 and single chunk for data.

BTRFS has the capability to support a filesystem with mixed profiles.
However this could lead to an unexpected behavior when a new chunk is
allocated (i.e. the chunk profile is not what is wanted). Moreover
if the user is not aware of this, he could assume a redundancy which
doesn't exist (for example because there is some 'single' chunk when
it is expected the filesystem to be full raid1).
A possible cause of a mixed profiles filesystem is an interrupted
balance operation or a not fully balance due to very specific filter.

In this first attempt the check is only added to the 'btrfs fi us'
command. I hope to receive suggestion about which commands should
have this check (I think all the commands which interact with a
mounted filesystem).

Example of output:

$ sudo ./btrfs fi us /tmp/t/
WARNING: ------------------------------------------------------
WARNING: Detection of multiple profiles for a block group type:
WARNING:
WARNING: * DATA ->          [raid1c3, single]
WARNING: * METADATA ->      [raid1, single]
WARNING:
WARNING: Please consider using 'btrfs balance ...' commands set
WARNING: to solve this issue.
WARNING: ------------------------------------------------------
Overall:
    Device size:		  30.00GiB
    Device allocated:		   7.78GiB
    Device unallocated:		  22.22GiB
    Device missing:		     0.00B
    Used:			   1.84GiB
    Free (estimated):		  11.93GiB	(min: 9.82GiB)
    Data ratio:			      2.33
    Metadata ratio:		      1.50
    Global reserve:		   3.25MiB	(used: 0.00B)

Data,single: Size:1.00GiB, Used:1023.91MiB (99.99%)
   /dev/loop0	   1.00GiB

Data,RAID1C3: Size:2.00GiB, Used:128.90MiB (6.29%)
   /dev/loop0	   2.00GiB
   /dev/loop1	   2.00GiB
   /dev/loop2	   2.00GiB

Metadata,single: Size:256.00MiB, Used:88.67MiB (34.64%)
   /dev/loop1	 256.00MiB

Metadata,RAID1: Size:256.00MiB, Used:194.28MiB (75.89%)
   /dev/loop1	 256.00MiB
   /dev/loop2	 256.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop2	  32.00MiB

Unallocated:
   /dev/loop0	   7.00GiB
   /dev/loop1	   7.50GiB
   /dev/loop2	   7.72GiB


In this case there are two kind of chunks for data (raid1c3 and single)
and metadata (raid1, single).

Patch #1 and #2 are preparatory ones.
Patch #3 contains the code for the check.
Patch #4 adds the check to the command 'btrfs fi us'

Comments are welcome

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

