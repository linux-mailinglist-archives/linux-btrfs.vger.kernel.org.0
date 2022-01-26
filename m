Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D349CEF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiAZPw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 10:52:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAZPw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 10:52:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A105C21110;
        Wed, 26 Jan 2022 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643212375;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XLaEi/KKjHyVDI7rJ5tgr9Fshzc2soptjm1MMUtMDo=;
        b=HWLKMZ2KIBK1LQlhQFp2ul+YeddVveB1NpF3UFJ4xG0w1KI9hE/TJN+EPYg7a2PizssyxN
        /iy8glLzeASmlMZeBEGomH36hN2gX1mLzpLYlfHVHDlWrcHnyg2W520myJm6snErGoT+G7
        DNJNCIRKc4vy+YLVV+28AO/Y3m4DGvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643212375;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XLaEi/KKjHyVDI7rJ5tgr9Fshzc2soptjm1MMUtMDo=;
        b=Smxl0NjeNruX34B7a/rhCP4mzrqV9ScO3e97vP8EdnL/4FlBc/5ALMff75NrN8U2rsn6S3
        pCdJRPPmPXGpDEAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93A74A3B8D;
        Wed, 26 Jan 2022 15:52:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9E39DA7A9; Wed, 26 Jan 2022 16:52:14 +0100 (CET)
Date:   Wed, 26 Jan 2022 16:52:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 00/11] btrfs: extent tree v2, support for global roots
Message-ID: <20220126155214.GZ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <6ac1b7c7-b775-a48e-f84b-9feced206b77@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac1b7c7-b775-a48e-f84b-9feced206b77@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 12, 2022 at 05:09:15PM +0200, Nikolay Borisov wrote:
> Overall this is a low-risk series and generally looks LGTM. I have a
> couple of points which apply too all patches and I'm gonna list them here:
> 
> 1. This is minor but might be a bit more informative - instead of
> returning -EINVAL when an operation which is forbidden returning
> -EOPNOTSUPP is closer to what is actually meant. ANd not that something
> is invalid per-se. This is a minor point given for now this is purely a
> developer feature.

Makes sense to use EOPNOTSUPP.

> 2. The extent tree would be in development for quite some time, perhaps
> at least 3-4 release if not more, during that time the code will be
> sprinkled with the checks for the forbidden ops and even everyone will
> be paying the (arguably small cost) of having them in the code. My point
> is can't those compatibility checks be also gated behind
> CONFIG_BTRFS_DEBUG? Eventually they will be removed but until this time
> comes we'll have them in the respective call paths.

That's a good point, we could make it compile-time condition with some
magic that should remove any cost of the checks. Something like

	if (EXTENT_V2_ENABLED(fs_info)) {
		...
	}

where the macro is

#ifdef CONFIG_BTRFS_DEBUG
#define EXTENT_V2_ENABLED(fs_info) 	btrfs_incompat(fs_info, EXTENT_TREE_V2)
#else
#define EXTENT_V2_ENABLED(fs_info)	false
#endif
