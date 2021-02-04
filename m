Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0730FB15
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhBDSRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 13:17:24 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:33316 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238908AbhBDSOr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 13:14:47 -0500
Received: from venice.bhome ([84.220.31.15])
        by smtp-33.iol.local with ESMTPA
        id 7j8YlvJHG11DD7j8YlxpQv; Thu, 04 Feb 2021 19:13:51 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612462431; bh=75jtVkWdbjGreGmx4q6RM7l/WW4a3Gt5DK/J6vg5E8w=;
        h=From;
        b=ZcCdG5zkQOWMvizHKWiKAwCONAK9ZqDh53btOMRwLL0kw62Ap/A0cEOv0YqFxk8UA
         W9jNWOygvW9aRU5BfWJoCAe0RiR/X/QRoq2U2/wCMCnjcS96lhlb5yXn12+wlmI76n
         srMA/RmDKQFYbkrYfRNdGG5t+bQP/X674NSrwHkh16WbmWi1577ABZkBjfZJPq5TsC
         iZ7Lps46y8DXMgJtvy9F451jMu5dUXrlmt+jFni5c/rEvt58xn1HC6sZmCLihoPC7b
         PCopDs1ut+9UzxI7Zie7MzCvfLegZFfuHUO/OL0MFvTT0dRBuSdcec3B53o7MR0gtM
         sCEjjZiUkru9Q==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=601c395f cx=a_exe
 a=x2dg/lNnxV9i/e65rnwt7A==:117 a=x2dg/lNnxV9i/e65rnwt7A==:17
 a=IkcTkHD0fZMA:10 a=eXeSR--iAAAA:8 a=MUmhE2euZ4i9oGPXPm8A:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=7cmWkHfeakIrVHqjGycf:22
Reply-To: kreijack@inwind.it
Subject: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs
 does, what's that called?
To:     Cedric.dewijs@eclipso.eu, Andy Smith <andy@strugglers.net>
Cc:     linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org
References: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
 <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
 <20210204105457.GI3712@bitfolk.com>
 <24e578627d205151df16b5aebe4a551e@mail.eclipso.de>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <adf8adda-015a-59a9-fdb9-32cad9f9ea49@libero.it>
Date:   Thu, 4 Feb 2021 19:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <24e578627d205151df16b5aebe4a551e@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDt6fsh2GCVTq9mWYH7yOFQ3uCMfRHnSMV7Xj07V4lQ413XXYnHbo2M+w7UR3honb4KFJqsGKYgwd0EFJQS/iHs8so2yPn6eSuYSDMZLSZMu+uFjK+TR
 89qoIIR09YjSD/eO9CU63Jnq8zFQznLI4Y1bJeg6CV+6qQ4a87KIsnZmZF7vEzn2Ocisq6J1dH1/tH13fw9Wu2YxbUo30+8ooLJCADWENSIivoonyjuQe5i2
 K7Ke/1C/QSiEngmOuxmJsgD3lqD0acQMY5mcf+AVA2pVhfBLsVetojJLluiRIEZT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]
> Hey Andy,
> 
> I would rather see performance figures for these setups:
> A) btrfs with 2 (or more) hard drives and one SSD in writeback bcache configuration (unsafe against failure of the ssd):
> +-----------------------------+
> |      btrfs raid 1 /mnt      |
> +--------------+--------------+
> | /dev/Bcache0 | /dev/Bcache1 |
> +--------------+--------------+
> |   bcache writeback Cache    |
> |           /dev/sdk1         |
> +--------------+--------------+
> | Data         | Data         |
> | /dev/sdv1    | /dev/sdw1    |
> +--------------+--------------+

Doing that, you loose the protection of raid1 redundancy: now there is a single point of failure /dev/sdk1. Writeback is even more dangerous...

> 
> B) btrfs with 2 (or more) hard drives and two SSD's in dm-raid 1 writeback bcache configuration (unsafe against corruption of any of the ssd's):
> +-----------------------------+
> |      btrfs raid 1 /mnt      |
> +--------------+--------------+
> | /dev/Bcache0 | /dev/Bcache1 |
> +--------------+--------------+
> |   bcache writeback Cache    |
> |           /dev/dm0          |
> +--------------+--------------+
> | 2x SSD in mdadm raid 1      |
> | /dev/sdk1       /dev/sdl1   |
> +--------------+--------------+
> | Data         | Data         |
> | /dev/sdv1    | /dev/sdw1    |
> +--------------+--------------+
> 
> C) Full stack: btrfs with 2 (or more) hard drives and two identical SSD's in dm-raid 1 with dm-integrity writeback bcache configuration (safe against any failed drive):
> +-----------------------------+
> |      btrfs raid 1 /mnt      |
> +--------------+--------------+
> | /dev/Bcache0 | /dev/Bcache1 |
> +--------------+--------------+
> |   bcache writeback Cache    |
> |           /dev/dm0          |
> +--------------+--------------+
> | 2 x dm-integrity devices    |
> | in mdadm raid 1             |
> +--------------+--------------+
> | SSD hosting  | SSD hosting  |
> | dm-integrity | dm-integrity |
> | /dev/sdk1    | /dev/sdl1    |
> +--------------+--------------+
> | Data         | Data         |
> | /dev/sdv1    | /dev/sdw1    |
> +--------------+--------------+
> 
> D) Full stack: btrfs with 2 (or more) hard drives and two SSD's (one slow, and one very fast) in dm-raid 1 with dm-integrity writeback bcache configuration (safe against any failed drive):
> +-----------------------------+
> |      btrfs raid 1 /mnt      |
> +--------------+--------------+
> | /dev/Bcache0 | /dev/Bcache1 |
> +--------------+--------------+
> |   bcache writeback Cache    |
> |           /dev/dm0          |
> +--------------+--------------+
> | 2 x dm-integrity devices    |
> | in mdadm raid 1             |
> +--------------+--------------+
> | SSD hosting  | SSD hosting  |
> | dm-integrity | dm-integrity |
> | /dev/sdk1    | /dev/sdl1    |
> +--------------+--------------+
> | Data         | Data         |
> | /dev/sdv1    | /dev/sdw1    |
> +--------------+--------------+
> 
> In all these setups, the performance of the hard drives is irrelevant, because the speed of the setups comes from the bcache SSD.
> 
> Cheers,
> Cedric
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
