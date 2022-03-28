Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF554E97EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiC1NXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243131AbiC1NXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBFA5E15E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEBDBB81123
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 13:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F014C004DD;
        Mon, 28 Mar 2022 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648473691;
        bh=dj0P98xJRjma2BN5nz+V+Utih45W2JtRslqigLVy2m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fC7jHqBwQSl6mlTzPtL8J/D7uspJkjMkaJFVbEmnVdYfMQ4nP0qLwrLUQEyu6U+gT
         3Owyd59htscBe5Pwb0wr4S5E8WGbBTMAd/y88hlPVbPX9fgTCCxaSLbm+kC4jx53Wz
         dY4wX7DiTMsKEky9XODdbFnGRcjBLQrvdcz/Y8SQoBk57Vdbmwi2AFgexN9XF+ILnX
         H2E8wfTKEH4HQrBYLg5x/xMQuaehGxvIXhZCQ9IJulQJdPVoYvHLi+f05A5j+k7bl5
         BI2pR+tcIPi/5lj79cbqENe0O8/P3qdhWuWqBXOEVBvje5ItGiqDTyI0KB/mnsqua2
         Bk3LIQnWZBl+w==
Date:   Mon, 28 Mar 2022 14:21:28 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Message-ID: <YkG2WL4Fa096+6xt@debian9.Home>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home>
 <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 01:14:02PM +0000, Johannes Thumshirn wrote:
> On 28/03/2022 15:09, Filipe Manana wrote:
> > On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:
> >> Running generic/406 causes the following WARNING in btrfs_destroy_inode()
> >> which tells there is outstanding extents left.
> > 
> > I can't trigger the warning with generic/406.
> > Any special setup or config to trigger it?
> > 
> > The change looks fine to me, however I'm curious why this isn't triggered
> > with generic/406, nor anyone else reported it before, since the test is
> > fully deterministic.
> > 
> 
> I am able to trigger the WARN() with a different test (which is for a different,
> not yet solved problem) on my zoned setup. With this patch, the WARN() is gone.

I have no doubts about the fix being correct.
I'm just puzzled why I can't trigger it with generic/406, given that it's a very
deterministic test.

If there's any special config or setup (mount options, zoned fs, etc), I would
like to have it explicitly mentioned in the changelog.
