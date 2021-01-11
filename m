Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04122F2291
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbhAKWTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 17:19:54 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:39086 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389560AbhAKWTx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 17:19:53 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id z5WokjNai11DDz5WokswW5; Mon, 11 Jan 2021 23:19:11 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1610403551; bh=NjRRo3h5Q7C7CJM1OJnjBpsv5KZuK1PLU8xOWzrXmpQ=;
        h=From;
        b=SeH5uDrpz6Cs33lgjiR4YsWPVf+UVTvaU0soqvs4IZji3UcDnqz2QW0384Z78twEC
         Q3gIje3N98Ur24/YO9yjEdKluNxxoYxMsYna9LQfb8VDenKmQ5HA8i0H2ABdGNM74r
         npfaRSwcLrVtNW19WXBJkLZYMeqhTEKBF05t6Tv8XhbzT948SXw2qDU2lVLPOCSGGG
         5FwWhcF/LRjG3XDc74GDaO1nAz7+bm/en24jJUYc9+43qWeo/SMQO2wf0vw1fSLlEo
         kipjcp+UNYoUrntIiZZxOyiq47Yc3g5q/XMurn948MKdzmu6YXSWwkBLiihLU7RhFM
         cgCfjQrsvNaiQ==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=5ffccedf cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=IEdHAB3zJeMWESHrsgoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
Reply-To: kreijack@inwind.it
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, Forza <forza@tnonline.net>,
        Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Subject: [RFC][PATCH] btrfs : avoid O_DIRECT when the file is protected by
 CSUM
Message-ID: <5d52220b-177d-72d4-7825-dbe6cbf8722f@inwind.it>
Date:   Mon, 11 Jan 2021 23:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGe+oBKGIttBWa2M8isl9uMV37vrNK5cgk9UqeqecyK1hRiHjnbDtQGSMFjazaWk/72akbO/Q9SgjoDNSzfscsAM675W1gpVyoxv8RG/LGC9tsFMSYTe
 Er831YPC5jQfwZd1Xypcwlq3tjHtXkFYHClvFEuPaG5Ejink8LQa5BnhxVuJWel6LmLm5a1mkpEkXVkuK8hKfjWv2Mi0867mgBt0MOMOwsHCQbGOmr5X6t9J
 bWZHKhIvKr0qjyerCwXGxgLQ3ehyCqqZ5h1gato/n0WciOcno6MTiVg7806g3GdkyujShPbSEQAlZ1LI+mretg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,

this is an RFC. I made very few test, so use at your risk.

In the past there were several reports [1][2] about corruption when O_DIRECT is used.
Every time the analysis was the same: it is too difficult to sync the checksum
with the data when O_DIRECT is used.

This aim of this patch is to avoid the corruption disabling the O_DIRECT write when
the file is NOT marked as NODATACSUM. In other words, O_DIRECT is honored only for
the file not protected by CSUM: O_DIRECT ^ DATASUM

The user-space is not informed that O_DIRECT is not honored.

On the best of my knowledge, ZFS does the same thing.

It is not a regression: today an O_DIRECT file update may compromise the checksum
calculation. So may be the file content is correct, but the checksum no.This prevent
to read the file.

In [2] there is a test program which trigger the problem. With this patch the program
doesn't trigger the problem.

Open question:
- does the kernel return an error when a file is opened with O_DIRECT and the file has
   the checksum ?
- does make sense to have a mount option to select different behaviours:
	1) let the kernel to behave as today (O_DIRECT is allowed even at risk of
            having some form of corruption)
	2) let the kernel to ignore O_DIRECT if the file is protected by checksum
	3) let the kernel to return error when O_DIRECT is used with file with
            checksum
    ?

Comments are welcome.

BR
G.Baroncelli

[1] https://lore.kernel.org/linux-btrfs/1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org/#r
[2] https://lore.kernel.org/linux-btrfs/cf8a733f-2c9d-7ffe-e865-4c13d99dfb60@libero.it/


-----

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..af73157e8200 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2018,7 +2018,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
         if (sync)
                 atomic_inc(&BTRFS_I(inode)->sync_writers);
  
-       if (iocb->ki_flags & IOCB_DIRECT)
+       /*
+        * O_DIRECT doesn't play well with CSUM, so allow the O_DIRECT
+        * only if the file is marked BTRFS_INODE_NODATASUM
+        */
+       if (iocb->ki_flags & IOCB_DIRECT &&
+           (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
                 num_written = btrfs_direct_write(iocb, from);
         else
                 num_written = btrfs_buffered_write(iocb, from);



-----------

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
