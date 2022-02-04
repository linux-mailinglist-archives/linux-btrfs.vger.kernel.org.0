Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AD4A984F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358234AbiBDLSE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiBDLSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:18:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F5BC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 237D9B83659
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 11:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A865C004E1;
        Fri,  4 Feb 2022 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643973480;
        bh=MIM3ChEQYQYPYFfATiP2IrfiwfZVzhLt+nfC9fULJC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHrwsal5ruTnpAnTA7e8wCWNBMwqPd1UVO00ILuX0+rC241Tl11t5WK5wcHFZnj44
         QDzxEm+t5xG9Z+Mz2lm7tUY/hc/JOtcQyIx9oGXqmcmwpfkwE00tUSC5Qu8uTqxjAi
         u98LkhcDPg7Nkp23A7RNKKU53qVm6XI4t3QwzKv2a7z92BtqBmvWVfNC/pS3tAEMYi
         2X269jGaVjss5hLxhYDbGa3CPaJbptGyn0fSDW/O7+Uh3fL7Zv0DkZ24lGmDp8Awij
         UTWscf5VqNq3x7qmYJHKxem3uuJjiI7F4/zWgiAIO4PNvZV3rqvmlDndp++yyKa27W
         KQvnBH3MTKQsg==
Date:   Fri, 4 Feb 2022 11:17:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: stop checking for NULL return from
 btrfs_get_extent()
Message-ID: <Yf0LZsuAKfhkXy0f@debian9.Home>
References: <cover.1643902108.git.fdmanana@suse.com>
 <4296f624e349be0b08984cb3a5276ab4e693c57b.1643902108.git.fdmanana@suse.com>
 <PH0PR04MB74166389066CAEC3C1F84B2F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74166389066CAEC3C1F84B2F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 08:19:08AM +0000, Johannes Thumshirn wrote:
> On 03/02/2022 16:37, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > At extent_io.c, in the read page and write page code paths, we are testing
> > if the return value from btrfs_get_extent() can be NULL. However that is
> > not possible, as btrfs_get_extent() always returns either an error pointer
> > or a (non-NULL) pointer to an extent map structure.
> > 
> > Eveywhere else outside extent_io.c we never check for NULL, we always
> > treat any returned value as a non-NULL pointer if it does not encode an
> > error.
> > 
> > So check only for the IS_ERR() case at extent_io.c.
> > 
> 
> Isn't the same true for btrfs_get_extent_fiemap()? In get_extent_skip_holes() 
> we're also checking for IS_ERR_OR_NULL() but AFAICS btrfs_get_extent_fiemap()
> will never return NULL only a valid em or an error pointer.

Yep.
I was focused on the read and write page paths, due to the next change, so I
missed that one.

I can send another patch to fix that one, or if you want to do it yourself,
please go ahead.

Thanks.

> 
> Anyways for this patch:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
