Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530AB3D7156
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhG0Img (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 04:42:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhG0Img (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 04:42:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A78D221FC9;
        Tue, 27 Jul 2021 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627375355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhdkw6yZRMHdst5GSVL7RnwuRhSvoS+HqhQ/4ZI+exs=;
        b=JoC6O/iqxAnVVctg/ldL7LPL2Yo6Tic7Q/Kyjg1HZCTEKdE8mqmxMiU3hr0AHDyanMewIi
        mb4T+gUAlDSOwalKvATkR+We9acwZV7zogTO6AOaAQKS5pno4rr8nvc6cStkzzlWAxciOt
        Wyp/oM7LsUCKvLWTXvlkieD7sjESZu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627375355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhdkw6yZRMHdst5GSVL7RnwuRhSvoS+HqhQ/4ZI+exs=;
        b=w0h3/GvxO21U9cpzxOsA0AkATIYE3hQawvK4M/tkc2JjXm072YlRntqZH6BR2obI7NbAvv
        wtKGvA0BlJRhBSDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A10AEA3B8C;
        Tue, 27 Jul 2021 08:42:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D356DA8CC; Tue, 27 Jul 2021 10:39:51 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:39:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
Message-ID: <20210727083951.GJ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
 <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
 <20210726150651.GF5047@twin.jikos.cz>
 <b1af7184-740c-457d-b8ac-daad094ce7cb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1af7184-740c-457d-b8ac-daad094ce7cb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 06:23:03AM +0800, Qu Wenruo wrote:
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int num_stripes)
> >>>    	const int ncopies = btrfs_raid_array[index].ncopies;
> >>>    	const int nparity = btrfs_raid_array[index].nparity;
> >>>
> >>> -	if (nparity)
> >>> -		return num_stripes - nparity;
> >>> -	else
> >>> -		return num_stripes / ncopies;
> >>
> >> I would prefer an ASSERT() here to be extra sure.
> >> But it's my personal taste (and love for tons of ASSERT()).
> >
> > Assert for what exactly? I had a thought about that too but was not sure
> > what to put there.
> >
> 
> To ensure we have either non-zero nparity with 1 ncopy or zero nparity
> with ncopies > 1.

Yeah but that's statically defined in the raid table, it does not change
so we don't have to verify it on each call. If anything, such
constraints could be verified as _static_assert right after the table
but IMO that's pointless and definitely not a runtime check.
