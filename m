Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC21E9339
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgE3Sx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 14:53:26 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:54390 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729204AbgE3Sx0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 14:53:26 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id f6bjjAOJZLNQWf6bjj3fyG; Sat, 30 May 2020 20:53:24 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590864804; bh=EXoiyzieeCN92GwJJgbkVuECx2joo98RT/a6fEz9KvM=;
        h=From;
        b=l9WAYmnACpCHV5I6uL0QLr2dhO/rzYNPDGd6mNJyvQ/6+jCVvwV74P6toaytqIIJU
         4vEx/i0/2Uy1InrPtFFOTXb8wpvGJVUgbdNm1Ah3WWqVYsPSihinxCzdixluixIas7
         S9s7nti58TbuR/LJGcRr0z20lrKLMkFwNqwD3qHmw9iquE7xyUiwN0upka/GffHxC5
         bT7ObYbAOpUh6wCFGm/FjV6lKKgUsxna3D27bo9X9V+ZMg11GRFfLPB1NIQ0/9uKq6
         6g9VcMEdv1whbA9KiwWGC1vH3FRmNExqhc8Mw2rg/FWSs/GuEE4BDTLXvas28foKxv
         YAnDKwRc3TDiA==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17 a=VwQbUJbxAAAA:8
 a=vlfz8IUs9gY04UKbm1IA:9 a=AjGcO6oz07-iQ99wixmX:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: [BUG][PATCH] btrfs: a mixed profile DUP and RAID1C3/RAID1C4 prevent to alloc a new chunk
Date:   Sat, 30 May 2020 20:53:20 +0200
Message-Id: <20200530185321.8373-1-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHqK044pkb0oXXuWBi+WWeSkt18Iv+ABHmtxs5DE6KaL9iplsa8rjjfrPJN+HmjtlSiyRHBAtbcZFyJkV5YrTrxZiC5CRc+3+0vi0MraYZyKB9sA6E7E
 /eFSQ6BILRHKQgnJXCYc5tebbiBVkhEC7P47Vao7n1Rnoe3E4/oBlxxdpag/rLqjUrASgTVfgN49SXJ0XhYASSgXiL6H2mhDh/Y=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi All,

after the thread "Question: how understand the raid profile of a btrfs
filesystem" [*] I was working to cleanup the function
btrfs_reduce_alloc_profile(), when I figured that it was incompatible with
a mixed profile of DUP and RAID1C3/RAID1C4.

This is a very uncommon situation; to be honest it very unlikely that it will
happen at all.

However if the filesystem has a mixed profiles of DUP and RAID1C3/RAID1C4 (of
the same type of chunk of course, i.e. if you have metadata RAID1C3 and data
DUP there is no problem because the type of chunks are different), the function
btrfs_reduce_alloc_profile() returns both the profiles and subsequent calls
to alloc_profile_is_valid() return invalid.

The problem is how the function btrfs_reduce_alloc_profile "reduces" the
profiles.

[...]
static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
[...]
        allowed &= flags;

        if (allowed & BTRFS_BLOCK_GROUP_RAID6)
                allowed = BTRFS_BLOCK_GROUP_RAID6;
        else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
                allowed = BTRFS_BLOCK_GROUP_RAID5;
        else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
                allowed = BTRFS_BLOCK_GROUP_RAID10;
        else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
                allowed = BTRFS_BLOCK_GROUP_RAID1;
        else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
                allowed = BTRFS_BLOCK_GROUP_RAID0;

	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;

[...]

"allowed" are all the possibles profiles allowed by the disks. 
"flags" contains the existing profiles.

If "flags" contains both DUP, RAID1C3 no reduction is performed and both
the profiles are returned.

If full conversion from DUP to RAID1C3 is performed, there is no problem.
But a partial conversion from DUP to RAID1C3 is performed, then there is no
possibility to allocate a new chunk.

On my tests the filesystem was never corrupted, but only force to RO.
However I was unable to exit from this state without my patch.

[*] https://lore.kernel.org/linux-btrfs/517dac49-5f57-2754-2134-92d716e50064@alice.it/

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

