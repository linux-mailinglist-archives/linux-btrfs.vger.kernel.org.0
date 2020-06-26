Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A284D20B1B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgFZMtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 08:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFZMtf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 08:49:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A92FBAAC3;
        Fri, 26 Jun 2020 12:49:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82F29DAA08; Fri, 26 Jun 2020 14:49:20 +0200 (CEST)
Date:   Fri, 26 Jun 2020 14:49:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200626124920.GF27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
 <20200626103847.GA27795@twin.jikos.cz>
 <1336b64d-9cd3-6787-d7e7-d07a49c48893@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336b64d-9cd3-6787-d7e7-d07a49c48893@knorrie.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 02:06:01PM +0200, Hans van Kranenburg wrote:
> >> @@ -250,10 +250,19 @@ struct btrfs_ioctl_fs_info_args {
> >>  	__u32 nodesize;				/* out */
> >>  	__u32 sectorsize;			/* out */
> >>  	__u32 clone_alignment;			/* out */
> >> -	__u32 reserved32;
> >> -	__u64 reserved[122];			/* pad to 1k */
> >> +	__u32 flags;				/* out */
> >> +	__u16 csum_type;			/* out */
> >> +	__u8 reserved[974];			/* pad to 1k */
> > 
> > I think 32 bits for out flags should be enough (or at least for a long
> > time).
> 
> Otherwise just add a flags2 later somewhere further on, and continue in
> there?. :) Yolo.
> 
> > I'm not sure if we should make the flags also input.
> 
> Remember that the only thing that the ioctl code now does is blindly
> copying the output data over the provided user buf.
> 
> This is the famous "there's no check if user provided buf was properly
> zeroed".

Should there such check? Zeroing the ioctl buffers is expected as a
convention to make future extensions possible.

> Combine this with "what to do if a bit is set to ask for a
> feature that's not implemented yet?" -> ENOENT? That would mean that any
> user who's calling the ioctl with a buffer filled with garbage will
> likely hit it.

Yes, users filling garbage values are either fuzzing or not the using
the interface correctly, so any sane error is fine.

> So, there you go, BTRFS_IOC_FS_INFO_V2. I don't think it's worth it.

That I don't what to happen of course, but so far I'm not conviced that
it would be needed. If you have another counter example, other than
filling with garbage values, please post it.

> > Right now I
> > think not and if we need to pass flags to request potentially expensive
> > data to retrieve, we'd add another member for that. I don't have a
> > concrete example and the whole FS_INFO ioctl is supposed to be
> > lightweight so as it is now looks good to me.
> 
> As a user of this ioctl, my impression also always has been that there's
> just a collection of simple interesting values returned, that can't be
> easily read from other metadata, so mostly stuff from the super block.

Yes that is how I understand it too.

> E.g. a generation field would also be interesting, to see what the last
> committed transaction is. One could e.g. create a monitoring graph that
> shows how often they happen.

So the FS_INFO is clearly underused and can be extended with at least:

- generation
- metadata_uuid

and now that I'm reading the output of dump-super, we maybe should also
add the 'csum_size' so the user does not need to do the translation
type -> size.

The compat features or label have their own ioctls, the stats about
roots are IMHO not that useful and devices have own ioctl. Maybe
total_bytes and that's probably all.
