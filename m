Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4E3C7559
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGMQ5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGMQ5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 12:57:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9085C0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 09:54:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so1805419pju.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vPnUUKZoH0nu9POtZVmpnN0439mrFYfYsdc6AqQRJ2I=;
        b=LD93ejegvsQqcZHuAC8x4wgGt76ez9ykYzGAorx72goo/M05FyKSqDZewwxtJtXt43
         ZxibANNiil2KOQ7KvdLC+ivvS/ETssFa73Hy0Gsvyi+fEsWjHtUSlgBa0//x/lJO4IB1
         z2792uHbjxqBc8VKWhGpyb66z9+BBsDQU7LcCojp4Gg7jBwPJj0t/ZcvjhxmxHCxsGjj
         Zu4vUfqwO0u/LlnBnLVjVE2WMY8lIAcJuankJ+FPffYnD0lzs8Kjs1EMAzOdAFi1IV9R
         DnLbj3YIWA1sBQt/DJAtFjJIrbSGrFNAuAPc6zLKIJmGd0Q7+gESXQ8KILNgEX2hm11U
         7H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vPnUUKZoH0nu9POtZVmpnN0439mrFYfYsdc6AqQRJ2I=;
        b=TWUGQf41Bk6C5GVUrtAm/rsqXiOWdDJPKNGs1xlEPX026OgYGJC+j7rvVvM2CZAPIE
         k1zRTZUni/XHiJbTc1a/0Netw6gyvMRQHhFwWXoGxoyY7vWMx30hP6+mvy9ti5UrpjTb
         4Fj6m/wM0pcZ+7NnKy4CabnKnKjR0/6XtofkguqRCRCh41l6nOW9FrzXqEmrabY/L99A
         mpDB1O7oFmvXsZIdHUaIGoijTYIUw+J+ZqMNHEzvHhKGjxnPSnfcnF9DjKRDn0yHvxzG
         JcSc0X6D4D+dVXTCN/GIhwEbvfBooEHe/gc4hHJYEL7RJWP7MhwoM9tLX9SiHxquyGAf
         4iNw==
X-Gm-Message-State: AOAM532r7r6zFQBQDgMtkBAumw+SZ7kB+7JJi3dzgGDhjEyV3dYD+Iti
        HNz9ItnrGPcigrCnOisrLqaC4jl8ZLB/FA==
X-Google-Smtp-Source: ABdhPJzYdNCjwknwGP/V+zisXLlqvDIb888jqDddGEhM9f6nCNpdmkwla/hmBuidhXUbgyKhW7SyOA==
X-Received: by 2002:a17:90a:9282:: with SMTP id n2mr301503pjo.92.1626195289297;
        Tue, 13 Jul 2021 09:54:49 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n5sm14566023pfv.29.2021.07.13.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:54:49 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:54:44 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210713165444.GB71156@realwakka>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <PH0PR04MB7416299F37110AAD9FC7131E9B159@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416299F37110AAD9FC7131E9B159@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 12, 2021 at 06:52:28AM +0000, Johannes Thumshirn wrote:

Hi, Thanks for review!

> On 11/07/2021 18:10, Sidong Yang wrote:
> > +static void compress_type_to_str(u8 compress_type, char *ret)
> > +{
> > +	switch (compress_type) {
> > +	case BTRFS_COMPRESS_NONE:
> > +		strcpy(ret, "none");
> > +		break;
> > +	case BTRFS_COMPRESS_ZLIB:
> > +		strcpy(ret, "zlib");
> > +		break;
> > +	case BTRFS_COMPRESS_LZO:
> > +		strcpy(ret, "lzo");
> > +		break;
> > +	case BTRFS_COMPRESS_ZSTD:
> > +		strcpy(ret, "zstd");
> > +		break;
> > +	default:
> > +		sprintf(ret, "UNKNOWN.%d", compress_type);
> > +	}
> > +}
> 
> [....]
> > +	char compress_str[16];
> 
> [...]
> 
> > +					compress_type_to_str(extent_item->compression, compress_str);
> 
> While this looks safe at a first glance, can we change this to:
> 
> #define COMPRESS_STR_LEN 5
> 
> [...]
> 
> switch (compress_type) {
> case BTRFS_COMPRESS_NONE:
> 	strncpy(ret, "none", COMPRESS_STR_LEN);
> 
> [...]
> 
> char compress_str[COMPRESS_STR_LEN];
> 
> One day someone will factor out 'compress_type_to_str()' and make it public, read user
> supplied input and then it's a disaster waiting to happen.

This can be happen when @ret is too short? If it so, I think it also has
problem when @ret is shorter than COMPRESS_STR_LEN. I wonder that I
understood this problem you said.

Thanks,
Sidong

> 
> Thanks,
> 	Johannes
