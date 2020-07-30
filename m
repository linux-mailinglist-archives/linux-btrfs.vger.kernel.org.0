Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0A233748
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG3RET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 13:04:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3RET (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 13:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD982ABE2;
        Thu, 30 Jul 2020 17:04:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79BB0DA842; Thu, 30 Jul 2020 19:03:48 +0200 (CEST)
Date:   Thu, 30 Jul 2020 19:03:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200730170348.GK3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200730111921.60051-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730111921.60051-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 07:19:21PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4705,6 +4705,18 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  	}
>  
>  	mutex_lock(&fs_info->chunk_mutex);
> +	/*
> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
> +	 * current device boundary.
> +	 */
> +	ret = clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> +				CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +	if (ret < 0) {
> +		mutex_unlock(&fs_info->chunk_mutex);
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_end_transaction(trans);

Can this be made more lightweight? If the device shrink succeeded, we
now update only the device status, so failing the whole transaction here
seems to be too much.

As the device size is being reduced, we could possibly update the last
relevant entry in the alloc_state tree and delete everything after that,
instead of clearing the bits.
