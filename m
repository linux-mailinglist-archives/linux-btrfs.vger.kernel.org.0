Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10963F61A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhHXPak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 11:30:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhHXPak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 11:30:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A09E220C8;
        Tue, 24 Aug 2021 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629818995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNPljS1LGyZ0KzowE5fcHuC6SVrJzMJaQJAnv2kBmAU=;
        b=h4H84vjFq2o72LQOLav5/EvTrLDSpPqCgrjhdfdGpMxZwDD7NycJzifvJdAdungX8GWbJw
        oF8uD+HxZl2sTpfysrm8IakGEhGl8W92hgkbC3XBjMnvew6SY6HHC+cA9NLnEEqNzhVPwv
        GOrHDgFaxZPWxvf7hDuU8QkfCTb5+24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629818995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNPljS1LGyZ0KzowE5fcHuC6SVrJzMJaQJAnv2kBmAU=;
        b=nZz3ifZiTie+0XbFwbcrs4OixjpmmpqjN+OIcGsUbC367HH9X1EwmporUTXBZYevz2EmKV
        1HjX/N0IxN57irDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B82BAA3BBC;
        Tue, 24 Aug 2021 15:29:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51D49DABDA; Tue, 24 Aug 2021 17:27:06 +0200 (CEST)
Date:   Tue, 24 Aug 2021 17:27:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone
 capacity
Message-ID: <20210824152706.GA3379@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <03bf2db22301fcc6706d489dab1dc3ed6ac54a8e.1629349224.git.naohiro.aota@wdc.com>
 <PH0PR04MB7416F7E5FAB3EECCBC58777D9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416F7E5FAB3EECCBC58777D9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 07:59:38AM +0000, Johannes Thumshirn wrote:
> On 19/08/2021 14:27, Naohiro Aota wrote:
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index da0eee7c9e5f..bb2536c745cd 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2539,10 +2539,15 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> >  	u64 offset = bytenr - block_group->start;
> >  	u64 to_free, to_unusable;
> >  	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
> > +	bool initial = (size == block_group->length);
> > +
> 
> Nit: Unneeded parenthesis

No it's actually preferred this way for clarity.
