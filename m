Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D903D5CA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhGZO3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 10:29:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59010 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhGZO3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:29:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8DFCE1FEB6;
        Mon, 26 Jul 2021 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627312175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IT4mGRniAHlBQtNP7pr2Ji5OsxgPSDtywo1BX/yLaE=;
        b=EY/XulcSferR3iinI2GFGlSSV0uYj6H6e1MXRhbZrSMxw+OZj/1Ik4Fkgglonf/Eirzr8S
        LkERSFLx7ABPzwWz6VsRRg5AS6HR/1ifC15XTJ5ozrCesz+EJRmFS3hIEA8ewk+aIXjNAK
        6m21pFddsyNF7PzsD/uzwBn5q9vtEvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627312175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IT4mGRniAHlBQtNP7pr2Ji5OsxgPSDtywo1BX/yLaE=;
        b=AwgdvvoBddENRfPqEvQfHYF1nfALuIOHQ/x10g1V1QhArtJg/UwskG1smz1ltKEjzoGdCZ
        9KplMWFCVZf9dxDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 863AFA3B88;
        Mon, 26 Jul 2021 15:09:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA864DA8D8; Mon, 26 Jul 2021 17:06:51 +0200 (CEST)
Date:   Mon, 26 Jul 2021 17:06:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
Message-ID: <20210726150651.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
 <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 08:38:16PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/26 下午8:15, David Sterba wrote:
> > There are two helpers doing the same calculations based on nparity and
> > ncopies. calc_data_stripes can be simplified into one expression, so far
> > we don't have profile with both copies and parity, so there's no
> > effective change. calc_stripe_length should reuse the helper and not
> > repeat the same calculation.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Just one nitpick inlined below.
> > ---
> >   fs/btrfs/volumes.c | 15 ++-------------
> >   1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index d98e29556d79..78dd013d0ee3 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int num_stripes)
> >   	const int ncopies = btrfs_raid_array[index].ncopies;
> >   	const int nparity = btrfs_raid_array[index].nparity;
> >
> > -	if (nparity)
> > -		return num_stripes - nparity;
> > -	else
> > -		return num_stripes / ncopies;
> 
> I would prefer an ASSERT() here to be extra sure.
> But it's my personal taste (and love for tons of ASSERT()).

Assert for what exactly? I had a thought about that too but was not sure
what to put there.
