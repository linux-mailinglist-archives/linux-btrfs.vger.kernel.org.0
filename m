Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC63E4162
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhHIIJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 04:09:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60052 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhHIIJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 04:09:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF5D621F21;
        Mon,  9 Aug 2021 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628496571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zW0rTZpSZTSzMeFr8ssfYQbV600TVD5hhIE7W+rrV9g=;
        b=fTSk03A6lHfuUvIUYIYL3scf9b8rmRIzRW4saL3MiNcnNL/t6eobg23i2c08+tacq1RE4A
        Us84AAlw0ymfqyrPOmlw44LwKE2DY2Fx0f380igBwgmPjhSkTmgNBCNV0fNZZBz5SV+Yn3
        dAztVwMejusOd1eajmYvLoNS7QWiOh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628496571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zW0rTZpSZTSzMeFr8ssfYQbV600TVD5hhIE7W+rrV9g=;
        b=nBDZxOMImuj6C4MfPE48fQwqwdwAv2IHs3gTJQZsJp0VTzkvKPQuDT/B/kmHG6zfroNNe/
        0+FmnXj889K6RfDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BDB91A3B8F;
        Mon,  9 Aug 2021 08:09:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41CFEDA880; Mon,  9 Aug 2021 10:06:40 +0200 (CEST)
Date:   Mon, 9 Aug 2021 10:06:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Message-ID: <20210809080640.GI5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fc988b42d58cf2e6b0ae2030fe0e67033ce27eca.1628242009.git.johannes.thumshirn@wdc.com>
 <20210809075059.odgjmdq4kyu7gyya@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809075059.odgjmdq4kyu7gyya@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 07:50:59AM +0000, Naohiro Aota wrote:
> On Fri, Aug 06, 2021 at 06:27:04PM +0900, Johannes Thumshirn wrote:
> > Automatically reclaiming dirty zones might not always be desired for all
> > workloads, especially as there are currently still some rough edges with
> > the relocation code on zoned filesystems.
> > 
> > Allow disabling zone auto reclaim on a per filesystem basis.
> > 
> > Cc: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
> > ---
> >  fs/btrfs/free-space-cache.c | 3 ++-
> >  fs/btrfs/sysfs.c            | 5 ++++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index 8eeb65278ac0..933e9de37802 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2567,7 +2567,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> >  	/* All the region is now unusable. Mark it as unused and reclaim */
> >  	if (block_group->zone_unusable == block_group->length) {
> >  		btrfs_mark_bg_unused(block_group);
> > -	} else if (block_group->zone_unusable >=
> > +	} else if (fs_info->bg_reclaim_threshold &&
> > +		   block_group->zone_unusable >=
> >  		   div_factor_fine(block_group->length,
> >  				   fs_info->bg_reclaim_threshold)) {
> 
> nit: can this race with btrfs_bg_reclaim_threshold_store()'s
> bg_reclaim_threshold assignment? Then, we can end up doing
> div_factor_fine(block_group->length, 0)?

Good point, this should be READ_ONCE and then check if it's 0.
