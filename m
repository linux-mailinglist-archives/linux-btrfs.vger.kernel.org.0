Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD731FA46
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 15:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBSOHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 09:07:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:52882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhBSOHj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 09:07:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5776DAC6E;
        Fri, 19 Feb 2021 14:06:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0536DA813; Fri, 19 Feb 2021 15:05:00 +0100 (CET)
Date:   Fri, 19 Feb 2021 15:05:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH btrfs-progs] btrfs-progs: do not fail when offset of a
 ROOT_ITEM is not -1
Message-ID: <20210219140500.GB1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
References: <20210209173406.16691-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209173406.16691-1-marek.behun@nic.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 06:34:06PM +0100, Marek Behún wrote:
> When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
> location key offset other than -1, it currently fails via BUG_ON.
> 
> The offset can have other value than -1, though. This can happen for
> example if a subvolume is renamed:
> 
>   $ btrfs subvolume create X && sync
>   Create subvolume './X'
>   $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
>         location key (270 ROOT_ITEM 18446744073709551615) type DIR
>         transid 283 data_len 0 name_len 1
>         name: X
>   $ mv X Y && sync
>   $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
>         location key (270 ROOT_ITEM 0) type DIR
>         transid 285 data_len 0 name_len 1
>         name: Y
> 
> As can be seen the offset changed from -1ULL to 0.
> 
> Do not fail in this case.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

Added to devel, thanks.
