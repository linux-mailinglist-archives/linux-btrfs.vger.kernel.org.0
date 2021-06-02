Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC22398E36
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhFBPTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 11:19:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhFBPTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 11:19:49 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D47922228;
        Wed,  2 Jun 2021 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJAknTpib6H8yV1AzzPRY/KX+zUf869res+P+7xY97o=;
        b=VVkPdpYeuONlQs85iIcHke3/3X31wWtiUYSYM+aiIyLzaOjW9hKRSmQvFRdISyFE2S+YYi
        KHCk3WhlRIj+N9Ik2+MKPsbFTIsEJVcSUarIGu3zr36OAek5KBtZbO9MQ1G1SKfLnXPfHo
        cQPGELiu3uQbZF8Osmd+HSbQgoTirjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJAknTpib6H8yV1AzzPRY/KX+zUf869res+P+7xY97o=;
        b=I5ilhvDkIg6+ej/9nmj8aobHIHq01Hl2hP8vlvHoHlwC9fz3pf/oqiloQoOU5QP+FltV2g
        vzy0z3DWyiP3fADA==
Received: by relay2.suse.de (Postfix, from userid 51)
        id 8955BA3C27; Wed,  2 Jun 2021 15:54:46 +0000 (UTC)
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 826C5A4B13;
        Wed,  2 Jun 2021 11:16:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10C86DA734; Wed,  2 Jun 2021 13:13:42 +0200 (CEST)
Date:   Wed, 2 Jun 2021 13:13:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: limit ordered extent to zoned append
 size
Message-ID: <20210602111341.GL31483@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1622552385.git.johannes.thumshirn@wdc.com>
 <da3a097233a87541120dbb2a9624841c7a9e3962.1622552385.git.johannes.thumshirn@wdc.com>
 <20210601161747.GH31483@suse.cz>
 <PH0PR04MB7416169F15A06D565C175A899B3D9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416169F15A06D565C175A899B3D9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 02, 2021 at 06:05:45AM +0000, Johannes Thumshirn wrote:
> On 01/06/2021 18:20, David Sterba wrote:
> >> ---
> >>  fs/btrfs/ctree.h | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index 5d0398528a7a..6fbafaaebda0 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -1373,7 +1373,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
> >>  
> >>  static inline u64 btrfs_get_max_extent_size(struct btrfs_fs_info *fs_info)
> >>  {
> >> -	return BTRFS_MAX_EXTENT_SIZE;
> >> +	if (!fs_info || !fs_info->max_zone_append_size)
> >> +		return BTRFS_MAX_EXTENT_SIZE;
> >> +	return min_t(u64, BTRFS_MAX_EXTENT_SIZE,
> >> +		     ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE));
> > 
> > Should this be set only once in btrfs_check_zoned_mode ?
> 
> Do you mean adding a fs_info->max_extent_size member or 
> fs_info->max_zone_append_size = min(BTRFS_MAX_EXTENT_SIZE, queue_max_append_size())?
> 
> I'd opt for #1 

Yeah, replace BTRFS_MAX_EXTENT_SIZE by a fs_info member and then adjust
it for max append zone.
