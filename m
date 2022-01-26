Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A749CE97
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiAZPfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 10:35:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiAZPfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 10:35:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA0C4218D9;
        Wed, 26 Jan 2022 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643211313;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZKFmI3BB8GAs0x2SVtwys2k0G6jQkistmCl2d5ZHDI=;
        b=oBNIP328pCGdOmCHzEHUlHF8nrjnc5FhK2sdE8U1TLLlhs5K7yJ7FeIXGzEtk/Vd1RkPI0
        CIgeLdwK8OGi1NaviBJ9bd9ZxlAHyRbeAnTLCbT/7F+oMaW6o1oXVzUWvYroF2LBxmbUtU
        PaaqaFiEyIGK/Hle07XVBx3GyBBI/yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643211313;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZKFmI3BB8GAs0x2SVtwys2k0G6jQkistmCl2d5ZHDI=;
        b=wgfsvneFfA/rbYsQq98tx+wP7GtUgP/1Tb3RsWCEJzyt7Zb5+1IvTswC8zpVBEXiKxg6yk
        PHDPkX449r5NedAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D0793A3B8C;
        Wed, 26 Jan 2022 15:35:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E0F9DA7A9; Wed, 26 Jan 2022 16:34:32 +0100 (CET)
Date:   Wed, 26 Jan 2022 16:34:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 10/11] btrfs: add code to support the block group root
Message-ID: <20220126153432.GY14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <6989c644d619aa6c829310bb9f508e12a36ea8af.1639600719.git.josef@toxicpanda.com>
 <37128edf-7bdd-0d36-3103-8e12805ed761@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37128edf-7bdd-0d36-3103-8e12805ed761@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 12, 2022 at 05:16:29PM +0200, Nikolay Borisov wrote:
> 
> 
> On 15.12.21 г. 22:40, Josef Bacik wrote:
> > This code adds the on disk structures for the block group root, which
> > will hold the block group items for extent tree v2.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Ok, this is formally not needed for the extent v2 but the major rework
> for extent v2 is used to introduce this change and it's idea is to speed
> up fs mount right? If so I'd like this to be stated more explicitly in
> the changelog of the patch. I guess this can be done by David as well.

You mean that extent tree v2 is mainly for speeding up mount? AFAIK it's
only one of the improvements it brings. I'm not sure what you'd like to
see in the commit message but could update it eventually.
