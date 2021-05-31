Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E439683C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEaTHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 15:07:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhEaTHS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 15:07:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622487935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpDehEt995L/bn7m/mGaEnXDy5JlLUBaNIOPonc8cmc=;
        b=ZzX4SdQ0Tu06Aot4ijuhS3BgJaE1pkqj/AoqQ/aE0IoQhce1z3hqrRoSTqlmmozyHn3a4w
        kLf04/soguFw9C6qll1JYbTSWL0SVPevskZ135O5EARzMFEg1k6Bj3FNgUGhc2cn0nxSzj
        9okM39Smab/gPVcCgveupfhDy5ysKFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622487935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpDehEt995L/bn7m/mGaEnXDy5JlLUBaNIOPonc8cmc=;
        b=41PlB1nuM+KSQJXVTC2Udstmn7t+Kz0QBeAd2VMk6eaUZEEPH6WEOJxRJS/QuDh/v0lN2W
        NDQHeamBzEuGx4Cg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6C79AD6C;
        Mon, 31 May 2021 19:05:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C66ADA77B; Mon, 31 May 2021 21:02:56 +0200 (CEST)
Date:   Mon, 31 May 2021 21:02:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Message-ID: <20210531190256.GG31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <20210521163705.GO7604@twin.jikos.cz>
 <DM6PR04MB7081AF42EBA082FD09A07BD5E7279@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416299E1493D6A243375B9F9B259@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416299E1493D6A243375B9F9B259@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 25, 2021 at 09:40:22AM +0000, Johannes Thumshirn wrote:
> On 24/05/2021 01:05, Damien Le Moal wrote: 
> >>> +	if (fs_info && fs_info->max_zone_append_size)
> >>> +		max_bytes = ALIGN_DOWN(fs_info->max_zone_append_size,
> >>> +				       PAGE_SIZE);
> >>
> >> Why is the alignment needed? Are the max zone append values expected to
> >> be so random? Also it's using memory-related value for something that's
> >> more hw related, or at least extent size (which ends up on disk).
> 
> I did the ALIGN_DOWN() call because we want to have complete pages added.
> 
> > It is similar to max_hw_sectors: the hardware decides what the value is. So we
> > cannot assume anything about what max_zone_append_size is.
> > 
> > I think that Johannes patch here limits the extent size to the HW value to avoid
> > having to split the extent later one. That is efficient but indeed is a bit of a
> > layering violation here.
> 
> Damien just brought up a good idea: what about a function to lookup the max extent
> size depending on the block group. For regular btrfs it'll for now just return 
> BTRFS_MAX_EXTENT_SIZE, for zoned btrfs it'll return 
> ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE) and it also gives us some 
> headroom for future improvements in this area.

Hm, right that sounds safer. I've grepped for BTRFS_MAX_EXTENT_SIZE and
it's used in many places so it's not just the one you fixed. If the
maximum extent size is really limited by max_zone_append it needs to be
used consistently everywhere, thus needing a helper.
