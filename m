Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852BA1D7AC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEROL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 10:11:59 -0400
Received: from smtp-32-i2.italiaonline.it ([213.209.12.32]:59641 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbgEROL7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 10:11:59 -0400
Received: from oxapps-31-138.iol.local ([10.101.8.184])
        by smtp-32.iol.local with ESMTPA
        id agUmjcsr6zS33agUmjnJon; Mon, 18 May 2020 16:11:56 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1589811116; bh=+FpH1QAMT6DOKOh8441nl5gT7OLPtqwKUlhtLrmyPUM=;
        h=From;
        b=Qm6AZFeeR/qpZNExcWc5VTfPpz92uZdsaWEFW7cBpqzf7Xfa0W9onsJP1lBIBnonG
         FnTUTtvMoeQIG+MCP2o7IbtV+FVKkpxlnrbiwC2IkL8vPLUfpEwA6cAIueu+BVE0sm
         gKsqrXUW+8Vz9QOu8As2EmeUunKdg+nYnjzv3wl6gH/hk2q1+97yebqolky6m/gHQ3
         hu8ZKg9NjsuCOm6+BuUUsaMw8GazbuDlt21KIy8hpid6iiHoeWVPGeZpKTAwDnyU2i
         CjUnmPLy8oFHKlgFhoegq6LakfS8pysmHmvWj9jGxZlX+KzG5NO3aJcIDdSxJIyXYj
         2ynnkc2PWYKfQ==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=SkAuTGSu9wVn7tcq8ZjrZA==:117 a=_tD8r2k5ebcA:10 a=IkcTkHD0fZMA:10
 a=95PdqeJ5NFIA:10 a=XpEOl_WarqFRWi9CyZkA:9 a=QEXdDO2ut3YA:10
Date:   Mon, 18 May 2020 16:11:56 +0200 (CEST)
From:   a.mux@inwind.it
To:     linux-btrfs@vger.kernel.org
Message-ID: <1899345116.843043.1589811116462@mail1.libero.it>
Subject: how to recover unmountable partition (crash while resizing)?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev30
X-Originating-IP: 188.217.70.17
X-Originating-Client: open-xchange-appsuite
x-libjamsun: z0hRSXSmP13AXy1gcuxi8w==
x-libjamv: GBRYIpNd3sg=
X-CMAE-Envelope: MS4wfI15nnR6894DtCDT1un4mkJOshZEkuHiyCsk+QxSF42Vp8YTCpcOWzO9N4t0Tms54Bu4laWgfplrWWPaHgeERGDTBBwbreHYzdW0SaWU9kgr+G8018Ww
 V41evEi8jVFhpXosrQDOfQUa864bDwKQP59Ha9bgds/k7kHFxGXG9MR4LtWd3xBqJY0/6hq+jKGjFw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

due to a crash while resizing my / btrfs partition with gparted, my HD was left in a unmountable state.

This is on me: resizing a partition moving it to the right via gparted is a risky operation per se.

I am confident that all my data is still in the HD, and with proper guidance from the tools it will be possible to mount back the fs. The UI of the tools is a bit hard for me to understand.


```
# mount -t btrfs /dev/sda7 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda7, missing codepage or helper program, or other error.

dmesg output:
[ 3417.869264] BTRFS info (device sda7): disk space caching is enabled
[ 3417.869268] BTRFS info (device sda7): has skinny extents
[ 3417.882863] BTRFS error (device sda7): bad tree block start, want 83301548032 have 83284770816
[ 3417.882873] BTRFS error (device sda7): failed to read block groups: -5
[ 3417.953867] BTRFS error (device sda7): open_ctree failed
```

Find root maybe complains and maybe not:
```
# btrfs-find-root /dev/sda7 
Superblock thinks the generation is 107621
Superblock thinks the level is 1
Found tree root at 25657344 gen 107621 level 1
Well block 22315008(gen: 107620 level: 1) seems good, but generation/level doesn't match, want gen: 107621 level: 1
```

What is the most reasonable next step?

Many thanks!
Antonio


===============

This is the current sw versions on my LiveUSB.
I could upgrade to ubuntu it 20.04 (kernel 5.4), and I am comfortable in recompiling btrfs-progs if needed.

# uname -a
Linux kubuntu 5.3.0-18-generic #19-Ubuntu SMP Tue Oct 8 20:14:06 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.2.1
