Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41644952E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 18:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbiATRJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 12:09:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377237AbiATRJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 12:09:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA8661F3C0;
        Thu, 20 Jan 2022 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642698571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpVwFnp+XptEzmtoe8g+erYbPXD0NtKn5AnKRTZedMo=;
        b=JZaVu+HrkZuH09p4f8Wn8uti4hW+3s7EtGtZ8RTmFQ2AWaDS704acuH4nzh6mKmK4P5nbA
        VFMvIoQX7rFE+e8VXqzIFHafxA8Iajk7prp3VL/Frx/pgBQB7Xg5bcxChlgnOA0dtqeVc4
        vaCW/P6VnkMaMCnQ7STF4iyY9cNKQxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642698571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpVwFnp+XptEzmtoe8g+erYbPXD0NtKn5AnKRTZedMo=;
        b=WS4ly6MIhJIJ4vjMq83xR3fdpggjgSAXQv2zGreYy6LZnXSkpgryXizQ9KI4KldJnabXkH
        ZG7F8aqH9eFoaMCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E1652A3B8F;
        Thu, 20 Jan 2022 17:09:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD1F3DA7A3; Thu, 20 Jan 2022 18:08:53 +0100 (CET)
Date:   Thu, 20 Jan 2022 18:08:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: cleanup finding rotating device
Message-ID: <20220120170853.GW14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
 <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
 <20220118154330.GN14046@twin.jikos.cz>
 <56f7ab3d-e0da-0bff-2d85-847c89aea3b8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f7ab3d-e0da-0bff-2d85-847c89aea3b8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 19, 2022 at 03:43:42PM +0800, Anand Jain wrote:
> On 18/01/2022 23:43, David Sterba wrote:
> > On Thu, Jan 13, 2022 at 03:48:54PM +0800, Anand Jain wrote:
> >> -	q = bdev_get_queue(bdev);
> >> -	if (!blk_queue_nonrot(q))
> >> -		fs_devices->rotating = true;
> >> +	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
> > 
> > This is an equivalent change, in the new code fs_devices->rotating will
> > be always set according to the last device, while in the old code, any
> > rotational device will set it to true and never back.
> 
> Oh. The previous status gets overwritten based on the current device
> non-rot check. This is not good. My bad. However, V1 is ok could you
> pls consider that?

Yes, v1 applied to misc-next, thanks.

> Also, there is a bug in the original code - If we have at least one
> rotating device (HDD) we won't enable SSD benefit. However, if that
> HDD is deleted later on, we won't still enable the SSD status. This
> bug can be fixed easily on top of the patch
> 
>   '[PATCH 1/2] btrfs: keep device type in the struct btrfs_device'
> 
>   I will wait for some comments before fixing this.

Right, I think that mixed HDD/SSD devices were not considered and
keeping the status should be fixed.
