Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBD9D166
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfHZOJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 10:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730713AbfHZOJk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 10:09:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36B53ADDC
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 14:09:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F34EDDA98E; Mon, 26 Aug 2019 16:10:02 +0200 (CEST)
Date:   Mon, 26 Aug 2019 16:10:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
Message-ID: <20190826141002.GT2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190826123728.2854-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826123728.2854-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 03:37:28PM +0300, Nikolay Borisov wrote:
> Support for asynchronous snapshot creation was originally added in
> 72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
> ceph's backend needs. However, since Ceph has deprecated support for
> btrfs there is no longer need for that support in btrfs. Additionally,
> this was never supported by btrfs-progs, the official userspace tools.

As there were some questions, changelog could link to the mails that
explain why ceph is not intrested anymore.

> @@ -1837,8 +1837,12 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
>  		goto free_args;
>  	}
>  
> -	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
> +	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
> +		pr_warn("BTRFS: async snapshot creation is deprecated and will"

Why not btrfs_warn? pr_warn lacks identification of the filesystem. I'd
also write shortened identifiers of the ioctl and flags. 'async
snapshot' sounds cryptic and it might be hard to actually find what's
the actual source line implementing it.

Though we all know there are no users left, the deprecation process
assumes there are and should make it possible to notice and update the
affected code.

btrfs_warn("SNAP_CREATE_V2 ioctl with CREATE_ASYNC is deprecated and will be removed in ...")


> +			" be removed in kernel 5.7\n");

> +	pr_warn("BTRFS: START_SYNC ioctl is deprecated and will be removed in "
> +		"kernel 5.7\n");

> +	pr_warn("BTRFS: WAIT_SYNC ioctl is deprecated and will be removed in "
> +		"kernel 5.7\n");

Yeah, like here the ioctl is sufficiently described.
