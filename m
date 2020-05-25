Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D81E12D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbgEYQkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 12:40:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:35376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEYQkj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 12:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7859AC51;
        Mon, 25 May 2020 16:40:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 318D9DA72D; Mon, 25 May 2020 18:39:41 +0200 (CEST)
Date:   Mon, 25 May 2020 18:39:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC V3] new ioctl BTRFS_IOC_GET_CHUNK_INFO
Message-ID: <20200525163941.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200319203913.3103-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319203913.3103-1-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 09:39:12PM +0100, Goffredo Baroncelli wrote:
> This patch creates a new ioctl BTRFS_IOC_GET_CHUNK_INFO.
> The aim is to replace the BTRFS_IOC_TREE_SEARCH ioctl
> used by "btrfs fi usage" to obtain information about the 
> chunks/block groups. 
> 
> The problems in using the BTRFS_IOC_TREE_SEARCH is that it access
> the very low data structure of BTRFS. This means: 
> 1) this would be complicated a possible change of the disk format
> 2) it requires the root privileges
> 
> The BTRFS_IOC_GET_CHUNK_INFO ioctl can be called even from a not root
> user: I think that the data exposed are not sensibile data.
> 
> These patches allow to use "btrfs fi usage" without root privileges.
> 
> before:
> -------------------------------------------
> 
> $ btrfs fi us /
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> Overall:
>     Device size:                 100.00GiB
>     Device allocated:             26.03GiB
>     Device unallocated:           73.97GiB
>     Device missing:                  0.00B
>     Used:                         17.12GiB
>     Free (estimated):             80.42GiB      (min: 80.42GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:               53.12MiB      (used: 0.00B)
> 
> Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
> 
> Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> 
> after:
> -----------------------------------------------
> $ ./btrfs fi us /
> Overall:
>     Device size:                 100.00GiB
>     Device allocated:             26.03GiB
>     Device unallocated:           73.97GiB
>     Device missing:                  0.00B
>     Used:                         17.12GiB
>     Free (estimated):             80.42GiB      (min: 80.42GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:               53.12MiB      (used: 0.00B)
> 
> Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
>    /dev/sdd3      23.00GiB
> 
> Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
>    /dev/sdd3       3.00GiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>    /dev/sdd3      32.00MiB
> 
> Unallocated:
>    /dev/sdd3      73.97GiB
> 
> Comments are welcome

I'm going to send more comments, the new ioctl is among features
considered for 5.9.
