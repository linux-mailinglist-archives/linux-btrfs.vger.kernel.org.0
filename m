Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEA3C7EA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhGNGoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbhGNGoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:44:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A4C06175F
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 23:41:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 17so1153166pfz.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xD5UQ3BgaAuMxfW8YtBvAze1e3QKcHi8RI5KuQWQ3EY=;
        b=SBhL5kc3gN13L7B1aIkarhIiEUUXgYGDWNrqPC5CGQhmPijU5YPOJ6k7hd5OF62V45
         nRXIKekaGo93dQ0zwjX3JVLY4dEVMGhcCAnpPsJPx7RmUjieY2VpcV/UaO+eROGiFdJV
         TCwUfUyrJ+FfHXmS7BsNkfa8n3pqzTcytryobKt5iMerkuZjbdd161YYkXROCjn8k5M2
         srAG+I3OdiP6tn3MNEzePcg/etMKZiPZmuHXXForuW13GHyCf9EI4ikWAZmkWOEHcftS
         R7GMDAEoKUB/2Urb8MMC1OJ56RkNsFWgkM4EN/2Y2a20pWuHAulrfqQkqd6GAFTje53i
         CjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xD5UQ3BgaAuMxfW8YtBvAze1e3QKcHi8RI5KuQWQ3EY=;
        b=dIzdtXDcfAoOJPNgh6HhSBl4fx1+vc2j/FOszGTe/noksgsfU1pXLJwV7hq4JL1w6w
         fACzk4IfT84LGhGsk+um9af6xXzZJrobJythonR/NkECvyjQ5tQ9LAEvBEPWp+ZMRwKd
         Ovr8a96RGv24LmwaUAOiGMVBtoWIryJa3tm5gAU9+Ly/IOer0auuqWR19oATmn95HiZF
         14aw1Hq5XvZ64B60JQOVIU3gl6+LRrJj9lZafHp6mPDmaabFb4CqC5kAhhmRbOaIAbfr
         xT7ofIRE5Px5p1Q8obgIx+zKoO1f9ZtGwYNGyqGugE0ZWlOHxogAZ1KfA2c8ph4ZjLYU
         jBmQ==
X-Gm-Message-State: AOAM532uEqvuZQ9YmB4OndBNPWsgwZIR2mBdYck6zzkZB8s86m50f5i1
        dr9u/wFGhOxd2VawluxY0Y4=
X-Google-Smtp-Source: ABdhPJyRAN3smvJCze+MuwsSZ3ZzwBqtgMALvD5A05L8j99lFcGywFo0assV3L0NO8ZCYURamCpWFQ==
X-Received: by 2002:a65:67ce:: with SMTP id b14mr7987804pgs.322.1626244884751;
        Tue, 13 Jul 2021 23:41:24 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id ev20sm1165705pjb.43.2021.07.13.23.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 23:41:24 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:41:16 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210714064116.GA71963@realwakka>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <PH0PR04MB7416299F37110AAD9FC7131E9B159@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210713165444.GB71156@realwakka>
 <2c0484ff-670d-5a26-0a96-e396289a784f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0484ff-670d-5a26-0a96-e396289a784f@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 14, 2021 at 06:16:08AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/14 上午12:54, Sidong Yang wrote:
> > On Mon, Jul 12, 2021 at 06:52:28AM +0000, Johannes Thumshirn wrote:
> > 
> > Hi, Thanks for review!
> > 
> > > On 11/07/2021 18:10, Sidong Yang wrote:
> > > > +static void compress_type_to_str(u8 compress_type, char *ret)
> > > > +{
> > > > +	switch (compress_type) {
> > > > +	case BTRFS_COMPRESS_NONE:
> > > > +		strcpy(ret, "none");
> > > > +		break;
> > > > +	case BTRFS_COMPRESS_ZLIB:
> > > > +		strcpy(ret, "zlib");
> > > > +		break;
> > > > +	case BTRFS_COMPRESS_LZO:
> > > > +		strcpy(ret, "lzo");
> > > > +		break;
> > > > +	case BTRFS_COMPRESS_ZSTD:
> > > > +		strcpy(ret, "zstd");
> > > > +		break;
> > > > +	default:
> > > > +		sprintf(ret, "UNKNOWN.%d", compress_type);
> > > > +	}
> > > > +}
> > > 
> > > [....]
> > > > +	char compress_str[16];
> > > 
> > > [...]
> > > 
> > > > +					compress_type_to_str(extent_item->compression, compress_str);
> > > 
> > > While this looks safe at a first glance, can we change this to:
> > > 
> > > #define COMPRESS_STR_LEN 5
> > > 
> > > [...]
> > > 
> > > switch (compress_type) {
> > > case BTRFS_COMPRESS_NONE:
> > > 	strncpy(ret, "none", COMPRESS_STR_LEN);
> > > 
> > > [...]
> > > 
> > > char compress_str[COMPRESS_STR_LEN];
> > > 
> > > One day someone will factor out 'compress_type_to_str()' and make it public, read user
> > > supplied input and then it's a disaster waiting to happen.
> > 
> > This can be happen when @ret is too short? If it so, I think it also has
> > problem when @ret is shorter than COMPRESS_STR_LEN. I wonder that I
> > understood this problem you said.
> 
> I guess Johannes means that, if we support more and more new compression
> algos, it can go beyond your original 16 bytes length for the
> compression algo name.
> 
> While using strncpy, it will never go beyond COMPRESS_STR_LEN forever.
> (Although it will truncating the output, but that would be easier to
> spot the problem and then enlarge the macro)
Okay, I understood. I'll do this in next version.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Sidong
> > 
> > > 
> > > Thanks,
> > > 	Johannes
