Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFA34D78F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhC2Sqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:46:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:45346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhC2Sqk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:46:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B397AFF5;
        Mon, 29 Mar 2021 18:46:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A276DA842; Mon, 29 Mar 2021 20:44:31 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:44:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] btrfs: zoned: bail out in btrfs_alloc_chunk for bad
 input
Message-ID: <20210329184431.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323143128.1476527-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323143128.1476527-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 03:31:19PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc complains that the ctl->max_chunk_size member might be used
> uninitialized when none of the three conditions for initializing it in
> init_alloc_chunk_ctl_policy_zoned() are true:
> 
> In function ‘init_alloc_chunk_ctl_policy_zoned’,
>     inlined from ‘init_alloc_chunk_ctl’ at fs/btrfs/volumes.c:5023:3,
>     inlined from ‘btrfs_alloc_chunk’ at fs/btrfs/volumes.c:5340:2:
> include/linux/compiler-gcc.h:48:45: error: ‘ctl.max_chunk_size’ may be used uninitialized [-Werror=maybe-uninitialized]
>  4998 |         ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
>       |                               ^~~
> fs/btrfs/volumes.c: In function ‘btrfs_alloc_chunk’:
> fs/btrfs/volumes.c:5316:32: note: ‘ctl’ declared here
>  5316 |         struct alloc_chunk_ctl ctl;
>       |                                ^~~
> 
> If we ever get into this condition, something is seriously
> wrong, so the same logic as in init_alloc_chunk_ctl_policy_regular()
> and a few other places should be applied. This avoids both further
> data corruption, and the compile-time warning.
> 
> Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> Link: https://lore.kernel.org/lkml/20210323132343.GF7604@twin.jikos.cz/
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to misc-next, thanks.
