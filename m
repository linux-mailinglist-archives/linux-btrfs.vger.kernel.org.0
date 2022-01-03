Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CB4836A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiACSN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:13:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiACSNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:13:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A3B82210F0;
        Mon,  3 Jan 2022 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641233604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzZchxi+TR4IE3cZQjb0YuFYQJw5uhG2j8DvVF8bOic=;
        b=RUerQin6ZBA4anP+Ueaia7xk0PXt49jUxwKR4nHIczQ50gdatEyf1/oBDGuyTMUeiI6acD
        lFu1ugHUYSXQV+6QNMXKEP+EmZv2ukYPm8yu/aqO6bY6nAat91i1nGiNVMRND+WT2aKf1D
        GKoCJhEvplSj8AH7pRq+4gaep/NnvKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641233604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzZchxi+TR4IE3cZQjb0YuFYQJw5uhG2j8DvVF8bOic=;
        b=KTkvCmcRlSvTkzzVXR6cK8oM0fqExFGdLfamkz4yKz1ZAsiiFNGHm9EVx4xZkUyR0MtOZK
        15arC5OIOx8v5yBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7528BA3B89;
        Mon,  3 Jan 2022 18:13:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9481ADA729; Mon,  3 Jan 2022 19:12:55 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:12:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: Use min() instead of doing it manually
Message-ID: <20220103181255.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211227113435.88262-1-jiapeng.chong@linux.alibaba.com>
 <7a37b841-3b82-ce8d-0459-ebaea539fc89@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a37b841-3b82-ce8d-0459-ebaea539fc89@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 27, 2021 at 07:49:01PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/12/27 19:34, Jiapeng Chong wrote:
> > Eliminate following coccicheck warning:
> > 
> > ./fs/btrfs/volumes.c:7768:13-14: WARNING opportunity for min().
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   fs/btrfs/volumes.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 730355b55b42..dca3f0cedff9 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7765,7 +7765,7 @@ static int btrfs_device_init_dev_stats(struct btrfs_device *device,
> >   			btrfs_dev_stat_set(device, i, 0);
> >   		device->dev_stats_valid = 1;
> >   		btrfs_release_path(path);
> > -		return ret < 0 ? ret : 0;
> > +		return min(ret, 0);
> 
> Nope, please don't blindly follow whatever the static checker reports, 
> but spend sometime on the code.
> 
> In this particular case, min(ret, 0) is not really making the code any 
> easier to read.
> 
> The "if (ret)" branch means, either we got a critical error (ret < 0) or 
> we didn't find the dev status item
> 
> For no dev status item case, it's no big deal and we can continue 
> returning 0. For fatal error case, it mostly means the device tree is 
> corrupted, and we return @ret directly.
> 
> Are you really thinking we're calculating a minimal value between 0 and ret?

That's probably the most important point. Although the expression could
be equivalent to calculating minimum, the code should read "if there was
an error, return it, otherwise return 0". Using min() for that obscures
that.
