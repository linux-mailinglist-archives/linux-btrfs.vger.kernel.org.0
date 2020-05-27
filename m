Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5821E4F65
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgE0Uh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 16:37:56 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:44398 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbgE0Uhz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 16:37:55 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id e2oDjlBCFLNQWe2oDjo7pW; Wed, 27 May 2020 22:37:54 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590611874; bh=RXdyw7I7cBSzYa1j62Pc2FG/MEIx6XgJp6HAgw0FNX8=;
        h=From;
        b=WXzfz4M3F3fopO/BPEIdhD3j6qNYFP/rDRXmG+y/4mQoYYVwOHLyjko2xJzA6Srq9
         OEV8pI8JROzYA3qP0r3ZUJok182BSyHTHQ+hoj9NMFwKJ36pzn7O965Ef/2XMh5Z/8
         Elxl0VvkjAsGn0MJhlrbaTpokPmoZfBSn+tUIBJKIS50pwX1bg7xTQfLwEKVDCHtM9
         cGFK0HL0PGmBqUV7qmeJQvPB9/m0dGZKGrIb8obO+fhTwIKxnhna8n2ZpLerUScRW2
         HU83GwnjVOL14xTD8RpzgxzXZCMuasylFfCyUqj83iEjF0QxSQxR8b30cxVGGXpuxg
         HztEdFuacUGwg==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=T537hWVpV7_BkzWz0EwA:9 a=9QsNii9Oh3O0Hkhw:21 a=LXJyeTO21fNu0dah:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua Houghton <joshua.houghton@yandex.ru>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH V2] btrfs-progs: add RAID5/6 support to btrfs fi us
Date:   Wed, 27 May 2020 22:37:47 +0200
Message-Id: <20200527203748.32860-1-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHf1WVmlbQFBby4NokLPJbGeGwF55xax9BA0sav+b0UYMK/I0wWaVOXRxlKPeI0ulvG5+kBdrWC2X35GurGgNPJE7kaxauOlQGzBDH693pKxzRXcD5ML
 Dh29O5BZ6W0sRG4FH88OljyT/NL6KPO/kwZiS3RPoZAN6BUSrYv5n+QHtUK5CHZYp4RkmijxqV92QdsWRHJ+Umt2fsmcb5/mPGgr7ss00q/eIsLBuEbq53YU
 Tg+FGXIIWJYlrxQNw7OdW9TtFUi+Tcj3yx1FmH9P5ulV9pT+eh5bR9ye2YfYJ6ui
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

this patch adds support for the raid5/6 profiles in the command
'btrfs filesystem usage'.

Until now the problem was that the value r_{data,metadata}_used is not
easy to get for a RAID5/6, because it depends by the number of disks.
And in a filesystem it is possible to have several raid5/6 chunks with a
different number of disks.

In order to bypass this issue, I compute these values from the 
r_{data,metadata,system}_chunks values and the ratio
l_*_used / l_*_chunks.

So now if you run btrfs fi us in a raid6 filesystem you get:

$ sudo btrfs fi us / 
Overall:
    Device size:		  40.00GiB
    Device allocated:		   8.28GiB
    Device unallocated:		  31.72GiB
    Device missing:		     0.00B
    Used:			   5.00GiB
    Free (estimated):		  17.36GiB	(min: 17.36GiB)
    Data ratio:			      2.00
    Metadata ratio:		      0.00
    Global reserve:		   3.25MiB	(used: 0.00B)

Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
[...]

Instead before:

$ sudo btrfs fi us /
WARNING: RAID56 detected, not implemented
WARNING: RAID56 detected, not implemented
WARNING: RAID56 detected, not implemented
Overall:
    Device size:		  40.00GiB
    Device allocated:		     0.00B
    Device unallocated:		  40.00GiB
    Device missing:		     0.00B
    Used:			     0.00B
    Free (estimated):		     0.00B	(min: 8.00EiB)
    Data ratio:			      0.00
    Metadata ratio:		      0.00
    Global reserve:		   3.25MiB	(used: 0.00B)

Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
[...]


I want to point out that this patch should be compatible with my
previous patches set (the ones related to the new ioctl 
BTRFS_IOC_GET_CHUNK_INFO). If both are merged we will have a 'btrfs fi us'
commands with full support a raid5/6 filesystem without needing root
capability.

I rewrote the patch after some David's comments about the difficult to
review it because I changed too much code. So this time I tried to be less
intrusive. I leaved the old logic and I computed only the missing
values.

Comments are welcome.
BR
G.Baroncelli

V2:
The patch is completely rewritten to be less intrusive

V1:
First issue

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5



