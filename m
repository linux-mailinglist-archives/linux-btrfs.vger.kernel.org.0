Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF437AE21
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 20:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhEKSNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 14:13:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhEKSN3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 14:13:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D96DAC38;
        Tue, 11 May 2021 18:12:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27D1CDAF29; Tue, 11 May 2021 20:09:52 +0200 (CEST)
Date:   Tue, 11 May 2021 20:09:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: next-20210511 - btrfs build failure on arm
Message-ID: <20210511180951.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <564681.1620756482@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <564681.1620756482@turing-police>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 02:08:02PM -0400, Valdis Klētnieks wrote:
> An arm allmodconfig build died with:
> 
> ERROR: modpost: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!
> 
> Some digging around with nm and looking at the assembler points at:
> 
> @ /usr/src/linux-next/fs/btrfs/extent_io.c:2676:        const int nr_bits = (end + 1 - start) / fs_info->sectorsize_bits;
>         adds    r1, r1, #1      @, tmp552, 
>         adc     r0, r0, #0      @, tmp551, 
>         ldr     r3, [r5, #1576] @ tmp2, _47->sectorsize_bits
>         bl      __aeabi_uldivmod                @       
> 
> Introduced by this commit:
> 
> commit 6512659d8f13015dccfb38a13c6d117d22572019
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Mon May 3 10:08:55 2021 +0800
> 
>     btrfs: submit read time repair only for each corrupted sector
> 
> Looks like that line could use something from include/linux/math.h

We got another report already, there's division instead of shift (a
mistake), so the expression would require u64/u32 division. The correct
one is (end + 1 - start) >> fs_info->sectorsize_bits; and will be fixed
in upcoming next.
