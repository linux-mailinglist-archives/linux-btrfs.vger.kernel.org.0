Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D9824BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfHESQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:16:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbfHESQm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 14:16:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4035AC91;
        Mon,  5 Aug 2019 18:16:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4623DDABC7; Mon,  5 Aug 2019 20:17:13 +0200 (CEST)
Date:   Mon, 5 Aug 2019 20:17:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        paulmck@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs: Hook btrfs' DRW lock to locktorture
 infrastructure
Message-ID: <20190805181712.GH28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        paulmck@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20190719083949.5351-1-nborisov@suse.com>
 <20190719084808.5877-1-nborisov@suse.com>
 <20190805163621.GA94502@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805163621.GA94502@archlinux-threadripper>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 09:36:21AM -0700, Nathan Chancellor wrote:
> Looks like this is in next-20190805 and causes a link time error when
> CONFIG_BTRFS_FS is unset:
> 
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   MODINFO modules.builtin.modinfo
> ld.lld: error: undefined symbol: btrfs_drw_lock_init
> >>> referenced by locktorture.c
> >>>               locking/locktorture.o:(torture_drw_init) in archive kernel/built-in.a
> 
> ld.lld: error: undefined symbol: btrfs_drw_write_lock
> >>> referenced by locktorture.c
> >>>               locking/locktorture.o:(torture_drw_write_lock) in archive kernel/built-in.a
> 
> ld.lld: error: undefined symbol: btrfs_drw_write_unlock
> >>> referenced by locktorture.c
> >>>               locking/locktorture.o:(torture_drw_write_unlock) in archive kernel/built-in.a
> 
> ld.lld: error: undefined symbol: btrfs_drw_read_lock
> >>> referenced by locktorture.c
> >>>               locking/locktorture.o:(torture_drw_read_lock) in archive kernel/built-in.a
> 
> ld.lld: error: undefined symbol: btrfs_drw_read_unlock
> >>> referenced by locktorture.c
> >>>               locking/locktorture.o:(torture_drw_read_unlock) in archive kernel/built-in.a
> 
> If this commit is to remain around, there should probably be static
> inline stubs in fs/btrfs/locking.h. Apologies if this has already been
> reported, I still see the commit in the btrfs for-next branch.

Sorry for the build breakage, the patch is not essential for the
patchset so I'll remove it from the upcoming for-next branch.
