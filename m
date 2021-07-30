Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4DA3DBA1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhG3OL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 10:11:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbhG3OL4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 10:11:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2EA622432;
        Fri, 30 Jul 2021 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627654310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9o7YQTHmdx0FR49MiBWv0nfaKZkXtyBxrWlrh+W6WU=;
        b=cX4IwOgT3IDlDLlDXsNzX31hFaW249fbk5NKeZeIe4MlehRnbvKckUATW7tvh/4FsWqQgG
        oMTwhqtu/cEtXRuVr2q3tkn7zO9W4EMTPHeiHbRkeav2GUQV81njmt7zYXdRx/ZLLVf5Nn
        e4g1IAOFm9aNnv1KiY9BfR2YVxZ8MHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627654310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9o7YQTHmdx0FR49MiBWv0nfaKZkXtyBxrWlrh+W6WU=;
        b=dQHm1IXJjW+PgqmWNeL/SmE7M5LkM8FOQUKidmLMjwlOFc0Xjw8JoRtSB+FdoEWRcincZ+
        BlJszbMJeEUsTFDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 95229A3B87;
        Fri, 30 Jul 2021 14:11:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F8DEDB284; Fri, 30 Jul 2021 16:09:04 +0200 (CEST)
Date:   Fri, 30 Jul 2021 16:09:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
Message-ID: <20210730140904.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
 <20210707145048.GK2610@twin.jikos.cz>
 <PH0PR04MB74164EDF2921DB4141CD40579B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74163E89A308E4A7760B41119B159@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74163E89A308E4A7760B41119B159@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 12, 2021 at 07:16:36PM +0000, Johannes Thumshirn wrote:
> On 07/07/2021 17:02, Johannes Thumshirn wrote:
> > On 07/07/2021 16:53, David Sterba wrote:
> >> On Tue, Jul 06, 2021 at 06:19:22PM +0900, Johannes Thumshirn wrote:
> >>> On zoned devices we're currently not supporting any other block group
> >>> profile than the SINGLE profile, so pick it as default value otherwise a
> >>> user would have to specify it manually at mkfs time for rotational zoned
> >>> devices.
> >>
> >> Yes this is annoying but careful with setting defaults, it's hard to
> >> change them. And in case of zoned devices it will be possible to set
> >> something else in the future so defaulting to single/single needs to be
> >> justified in another way than "currently we don't support anything
> >> else".
> >>
> >> The SSD fallback to single is not showing as useful and there's ongoing
> >> work to make it default to dup for metadata again. For consistency I'd
> >> rather have simple logic for selecting defaults and give hints
> >> eventually instead of checking random things in the system and then
> >> selectin on behalf of the user. Unfortunatelly it's not that easy as
> >> there are conflicting valid interests and we don't have defaults that
> >> fits all scenarios.
> >>
> > 
> > Agreed, but without this patch mkfs with default parameters on a rotational
> > zoned device will fail with:
> > 
> > johannes@redsun60:btrfs-progs(master)$ sudo ./mkfs.btrfs /dev/sda
> > btrfs-progs v5.12.1 
> > See http://btrfs.wiki.kernel.org for more information.
> > 
> > Zoned: /dev/sda: host-managed device detected, setting zoned feature
> > ERROR: cannot use RAID/DUP profile in zoned mode
> > 
> > So defaulting to not creating a filesystem won't work either.
> > 
> > We could improve the error message hinting the user to specify 
> > "-m single -d single" on mkfs but that feels more hacky than setting 
> > the defaults to something working.
> > 
> 
> So what's the way to go here? The current default won't create a file
> system so it's unusable.

I've updated the message to ask for -d single -m single.
