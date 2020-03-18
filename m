Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F418A6D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCRVUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 17:20:12 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:38200 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCRVUM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 17:20:12 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id EfyqjciCzjfNYEfyqjb08X; Wed, 18 Mar 2020 22:12:00 +0100
x-libjamoibt: 1601
X-CNFS-Analysis: v=2.3 cv=TY3oSiYh c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=ocJrZOoFI7Uy19bJYXgA:9 a=m-J9tRtHPPii4zKH:21 a=NYP64uv_4VMO61J-:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
Date:   Wed, 18 Mar 2020 22:11:56 +0100
Message-Id: <20200318211157.11090-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBruu9ByDmuioY+aSZSZ/2iv1oVCv8QFP+1A/owm9KZjJPA0SO2beNinU8R8WYaepI4QEsEheEbg11Yr5ECkgB3ijkYqbCIEGYjZFr7YqTiwnyw0Wp8f
 QgGyWr9zP4OPVlYyVas5QXrcPhUtyuQcs6T4VfqlWrxfCE2GkSfrTsoQBDqY01oGWEIFvGZCRFqY8xuK3q1oRZhsynN0itb3bo8=
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

In order to bypass this issue, I reworked the code to get rid of these
values where possible and to use the l_{data,metadata}_used ones.
Notably the biggest differences is in how the free space estimation
is computed. Before it was:

	free_estimated = (r_data_chunks - r_data_used) / data_ratio;

After it is:

	free_estimated = l_data_chunks - l_data_used;

which give the same results when there is no mixed raid level, but a
better result in the other case. I have to point out that before in the 
code there was a comment that said the opposite.

The other place where the r_{data,metadata}_used are use is for the
"Used:" field. For this case I estimated these values using the
following formula (only for raid5/6 profiles):

	r_data_used += (double)r_data_chunks * l_data_used /
                               l_data_chunks;

Note that this is not fully accurate. Eg. suppose to have two raid5 chunks,
the first one with 3 disks, the second one with 4 disks, and that each
chunk is 1GB.
r_data_chunks_r56, l_data_used_r56, l_data_chunks_r56 are completely defined,
but real r_data_used is completely different in these two cases:
- the first chunk is full and the second one id empty
- the first chunk is full empty and the second one is full
However now this error affect only the "Used:" field.


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

Comments are welcome.
BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

