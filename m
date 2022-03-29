Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B04EAADD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiC2J7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiC2J7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 05:59:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234223C0EB
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 02:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA5A9CE183D
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 09:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3517C2BBE4;
        Tue, 29 Mar 2022 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648547880;
        bh=Obmu6HtDN4bagaC4JUL591cAtOPMLwbWC0HpQ2zPHDw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SSMUf6ClDwxwedovlUr9X9nA+/jwDGx1O+qVEcBn2D2DSkzw6dZ6NT3IRWOmDuRFc
         xFLw9ABakexVfBZ9Oj0WDn3hU0W29uF3tvCtu5emOKImpmEHHjO/r4CbW7VfiUNRoz
         aPk5ni3ndEEOA/big7R281o/aBcsg+lnOtaybgW6L6TY/0POrbhBx0O+Jx0R/lwdyK
         4vCrsJxPd6H2mkbgLyK/W3YQ2kWfwfvO9XuO/Gn5LixlEvO5lDmbgtUy1kj0KFqEWu
         /3ZQ3P9hCk6T7n6WYzTQlLqXPpbxp79xp9G1q76l1S501pGP9oeOJOKO6wmPQtNh9+
         2S2Dzp1XyGNtw==
Date:   Tue, 29 Mar 2022 10:57:59 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkLYJ+xRvmm0yN9Y@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328185121.GQ2237@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> > The original code is not really setting the memory to 0x00 but 0x01.
> > 
> > To prevent such problem from happening, use memzero_page() instead.
> 
> This should at least mention we think that setting it to 0 is right, as
> you call it wrong but give no hint why it's thought to be wrong.

My guess is that something different from zero makes it easier to spot
the problem in user space, as 0 is not uncommon (holes, prealloced extents)
and may get unnoticed by applications/users.

I don't see a good reason to change this behaviour. Maybe it's just the
label name 'zeroit' that makes it confusing.

> 
> > Since we're here, also make @len const since it's just sectorsize.
> 
> Please don't do that, adding const is fine when the line gets touched
> but otherwise adding it to an unrelated fix is not what I want to
> encourage.
