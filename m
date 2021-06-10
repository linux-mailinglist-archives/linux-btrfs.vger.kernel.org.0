Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E63A307C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFJQZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 12:25:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhFJQZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 12:25:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF84E2199E;
        Thu, 10 Jun 2021 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623342211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjKhr3a6YXymIHtw/GA/lThxHjdin/LlLBM4rjmo30o=;
        b=OaCK2JwDCJzSG8mw0/KxhlY24EZJYzmrY1pCXj1ftvfhrFWiJeWwKCF6VRt/3GNGIZQTKI
        64uAumwxrCoYdgNTs61JjnnHSiudVprP6OUXn6eQhEtgRh2PJr0hss4Xc4UV44n8M0sx8X
        PenUaTJWzag3UNmGuL8gosguy0gx3Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623342211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjKhr3a6YXymIHtw/GA/lThxHjdin/LlLBM4rjmo30o=;
        b=Q1+SIX5fmet/R8yDOZj1UmQUYKVKEEmnbImI7UgkAOw2mAruK7BtMq2iRopww2P1n1GTgZ
        Q69a5hyw9tRxW6Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6326CA3B93;
        Thu, 10 Jun 2021 16:23:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6DC9DAEB9; Thu, 10 Jun 2021 18:20:46 +0200 (CEST)
Date:   Thu, 10 Jun 2021 18:20:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Message-ID: <20210610162046.GB28158@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 10, 2021 at 04:50:09PM +0200, Christophe Leroy wrote:
> 
> 
> Le 10/06/2021 à 15:54, Chris Mason a écrit :
> > 
> >> On Jun 10, 2021, at 1:23 AM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >>
> >> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> >> with the following message
> >>
> >> include/linux/compiler_types.h:326:38: error: call to '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
> >>
> >> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
> >> 256K pages at the time being.
> >>
> >> There are two platforms that can select 256K pages:
> >> - hexagon
> >> - powerpc
> >>
> >> Disable BTRFS when 256K page size is selected.
> >>
> > 
> > We’ll have other subpage blocksize concerns with 256K pages, but this BTRFS_MAX_COMPRESSED #define is arbitrary.  It’s just trying to have an upper bound on the amount of memory we’ll need to uncompress a single page’s worth of random reads.
> > 
> > We could change it to max(PAGE_SIZE, 128K) or just bump to 256K.
> > 
> 
> But if 256K is problematic in other ways, is it worth bumping BTRFS_MAX_COMPRESSED to 256K ?
> 
> David, in below mail, said that 256K support would require deaper changes. So disabling BTRFS 
> support seems the easiest solution for the time being, at least for Stable (I forgot the Fixes: tag 
> and the CC: to stable).
> 
> On powerpc, 256k pages is a corner case, it requires customised binutils, so I don't think disabling 
> BTRFS is a issue there. For hexagon I don't know.

That it blew up due to the max compressed size is a coincidence. We
could have explicit BUILD_BUG_ONs for page size or other constraints
derived from the page size like INLINE_EXTENT_BUFFER_PAGES.

And there's no such thing like "just bump BTRFS_MAX_COMPRESSED to 256K".
The constant is part of on-disk format for lzo and otherwise changing it
would impact performance so this would need proper evaluation.
