Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1913CBC3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfJDNvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 09:51:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37789 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388657AbfJDNvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 09:51:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so8651266qtr.4
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=MucImSndfgKhiOzC/RvRWmk2TdhUDILHbRpTCoSWaak=;
        b=OkOr/7DYGBEmRXPJXRCFbq7gG9ZqlO/ITtwkd312340KjmzCjw5onOKcg+1WOPJbpd
         9PAtkl+ZWWt9XuR/0G0PS3HwKq4LES77+FXfldH1tRzzYVW2ciNJao2kuYG5kQsTfL9P
         CeAONQOUovYdrA+C/ofzsDcoKHPBRqI1uDhATkkPW4gRr2IIRuoDJRAS1juJ5wSeXtd/
         imlojflw4dowVOyyJqSVuwDjB9pMCsTfDs91gtvo8R5Vfwi9hf+ktwqzYT1CV4ME4VqQ
         RzkpWRy/OegVTC3/6EH47PG3VpInRcpyfOqbRopLNNNQnaf/qg2Ewcum32cQFrNDIbNR
         4HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MucImSndfgKhiOzC/RvRWmk2TdhUDILHbRpTCoSWaak=;
        b=PJGS0gm+gBQ2LsoZXH0gMSSs8trJDZqLLMJtRxeXzzGw+hXPwgAsX5PuTfnR60tc3c
         WEAIUHJU/hpyRM+pWB6rMbN2If4bMWTwMS3vA2BJJ15nt59bxXVnK7pwfiVIRYq8RNFz
         +1dX0hPOtc1WjQ0PR/0BKf32dr5K93sJ+oopzsJK9QWEZcegrWfQV6sKpdc+/VnKjIM1
         WqEvdD+f9uDBfDGt1xjFYNSpxyzu+/jrvXeSL9MXZvOlYYFNsrRXzhPz37dJXW6eHVj7
         busdByW3UAA0SmeTS80jL3KBFMFvejII9g5ZZOOCbX1F6Q2ugm1lSb2REwSY+WMBbd50
         XRDQ==
X-Gm-Message-State: APjAAAXtHR/2BQ/SclY+WWqFi5vcI2WjteTS4/WlZdyHUiG1NT/mDWv1
        40MSqotaHKpG0f7eXsxPVGEllHSqkuw=
X-Google-Smtp-Source: APXvYqwEV7eLH+9eFMg33cFtyMM6/9EH7c6a9eEaoDIQRRR+8KziQzTSIFbMdsodFkrKmloouQLTRw==
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr15786688qtj.204.1570197075296;
        Fri, 04 Oct 2019 06:51:15 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:c428:5029:cbb2:41f? ([2604:6000:1014:c7c6:c428:5029:cbb2:41f])
        by smtp.gmail.com with ESMTPSA id m186sm3627408qkb.88.2019.10.04.06.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:51:14 -0700 (PDT)
Message-ID: <b71763288425b339f0bd5b94109522c1fcae6a08.camel@gmail.com>
Subject: Re: while (1) in btrfs_relocate_block_group didn't end
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:51:13 -0400
In-Reply-To: <0b9207ba-384e-d51c-cce0-832d85964fa9@gmx.com>
References: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
         <6476e5f02a4bdf26c8f342db11f6dc1675c94394.camel@gmail.com>
         <d19eb085373417fb13f5ec3c634224ecefa9dca2.camel@gmail.com>
         <0b9207ba-384e-d51c-cce0-832d85964fa9@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 2019-09-29 at 07:37 +0800, Qu Wenruo wrote:
> 
> On 2019/9/29 上午2:36, Cebtenzzre wrote:
> > On Mon, 2019-09-16 at 17:20 -0400, Cebtenzzre wrote:
> > > On Sat, 2019-09-14 at 17:36 -0400, Cebtenzzre wrote:
> > > > Hi,
> > > > 
> > > > I started a balance of one block group, and I saw this in dmesg:
> > > > 
> > > > BTRFS info (device sdi1): balance: start -dvrange=2236714319872..2236714319873
> > > > BTRFS info (device sdi1): relocating block group 2236714319872 flags data|raid0
> > > > BTRFS info (device sdi1): found 1 extents
> > > > BTRFS info (device sdi1): found 1 extents
> > > > BTRFS info (device sdi1): found 1 extents
> > > > BTRFS info (device sdi1): found 1 extents
> > > > BTRFS info (device sdi1): found 1 extents
> > > > 
> > > > [...]
> > > > 
> > > > I am using Arch Linux with kernel version 5.2.14-arch2, and I specified
> > > > "slub_debug=P,kmalloc-2k" in the kernel cmdline to detect and protect
> > > > against a use-after-free that I found when I had KASAN enabled. Would
> > > > that kernel parameter result in a silent retry if it hit the use-after-
> > > > free?
> > > 
> > > Please disregard the quoted message. This behavior does appear to be a
> > > result of using the slub_debug option instead of KASAN. It is not
> > > directly caused by BTRFS.
> > 
> > Actually, I just reproduced this behavior without slub_debug in the
> > cmdline, on Linux 5.3.0 with "[PATCH] btrfs: relocation: Fix KASAN
> > report about use-after-free due to dead reloc tree cleanup race" (
> > https://patchwork.kernel.org/patch/11153729/) applied.
> > 
> > So, this issue is still relevant and possible to trigger, though under
> > different conditions (different volume, kernel version, and cmdline).
> > 
> 
> That patch is not to solve the while loop problem, so we still need some
> extra info for this problem.
> 
> Is the problem always reproducible on that fs or still with some randomness?
> 
> And, can you still reproduce it with v5.1/v5.2?
> 
> Thanks,
> Qu
> 

I mentioned that patch because it was the only patch I had applied to my
kernel at the time. The "issue" I was referring to was the looping issue
that I reported in the first email.

I have only come across this behavior without slub_debug once or twice,
so I don't have enough of a sample size to say whether it can happen on
older kernels. It's caused by running a balance with *just* the right
amount of free space, such that the correct behavior is probably ENOSPC.

I might eventually dedicate a volume to reproducing this issue, and
bisect the kernel. But I need all of my disks to be usable right now.
-- 
Cebtenzzre <cebtenzzre@gmail.com>

