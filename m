Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3283B9077
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhGAK0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 06:26:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhGAK0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 06:26:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38D7222862;
        Thu,  1 Jul 2021 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625135017;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCC9KNc3ut1ZtCY9YfptSUZbkeqR3xSLZjRFo+w1LMM=;
        b=pqEUfbKnvXLB4uh+BykkjifdgfqKMiFC0XdR6QQEFfsSfq5CJyJ+PAXAJwYEZ7mt0p2VuD
        PcFKrC71B0qvHHXR4VgARBgC4215I5dJ2K3I7fQFvHSOpSsa0LrQlnIP/VqX10qWi7QTnk
        ofw/IiW/lWjusewu+Iu0LFUIOKE3Yfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625135017;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCC9KNc3ut1ZtCY9YfptSUZbkeqR3xSLZjRFo+w1LMM=;
        b=cx00+x2l8X8umkv9gA+6dnK977hkGAHZqymyJ3iFFlUy06615IqDoMva+ihbc/1qsiRlVB
        CQf5vgYAlK4kZhBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 08366A3B87;
        Thu,  1 Jul 2021 10:23:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 645BDDA6FD; Thu,  1 Jul 2021 12:21:06 +0200 (CEST)
Date:   Thu, 1 Jul 2021 12:21:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Message-ID: <20210701102106.GW2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
 <20210630184851.GR2610@twin.jikos.cz>
 <PH0PR04MB7416EADB226778E4CA09C8309B009@PH0PR04MB7416.namprd04.prod.outlook.com>
 <DM6PR04MB7081B6FD97AD001BCF85BBD5E7009@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB7081B6FD97AD001BCF85BBD5E7009@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 01, 2021 at 10:06:22AM +0000, Damien Le Moal wrote:
> On 2021/07/01 17:02, Johannes Thumshirn wrote:
> > On 30/06/2021 20:51, David Sterba wrote:
> >> On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:
> >>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.
> >>>
> >>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>>
> >>> ---
> >>> Changes to v1:
> >>> - also remove the local max_zone_append_size variable in
> >>>   btrfs_check_zoned_mode() (Anand)
> >>
> >> And what about btrfs_zoned_device_info::max_zone_append_size, should it
> >> also be removed? In case you don't have plans with it I'll remove it, no
> >> need to resend, it's just a few more lines but want to know if it's
> >> accidental or intentional.
> >>
> > 
> > I /think/ this one can stay until we work on multi-device/RAID support.
> 
> We are nowhere near close to this for now, so I am all for removing it.

Ok then, I'll update the patch.
