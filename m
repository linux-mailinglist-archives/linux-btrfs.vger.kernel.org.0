Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B502F7586
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 10:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbhAOJdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbhAOJdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 04:33:37 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25AC0613C1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LPvMXvj8kuJt/nvoVdEN22kVpc+M8DbpKiBCEowAcj0=; b=z3NkULbyhmaUBQZl6yazOwA4oY
        P9HCPJr9QFOgr3in2TQ77wARBKe9MClRtDbsUQI4I6GaxgVEqWfD+c6VF/w8GfeihlbitO0bkZWIP
        r0ZAKw8155eQxFKOnHar6BLC/jyPfyjsO+qf1hqSu0uwuZ/LdLuFjlvzyxNddKFYNumIgfv+yWntc
        HbYRIsFd11IEFEk5zJAEJKhy6LaVfDToj75ll9s+PKqYlFTrZZo/Z1HnzsugXHjBsQZxOafbwPT0m
        TUYzspK4qRHgkkEbs+uobGH98n+Xeqg1YtlbsoU1yqfi8z8Hs8mFJV9+Yiz/Em+3d1j6rVZAQBGVz
        tBz9zTUQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:47635 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1l0LTF-00011l-S8; Fri, 15 Jan 2021 10:32:41 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why do we need these mount options?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz> <20210115035448.GD31381@hungrycats.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <649487eb-0161-877c-9e80-b0400d1097bf@dirtcellar.net>
Date:   Fri, 15 Jan 2021 10:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20210115035448.GD31381@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell wrote:
> 
>>> commit
>>> space_cache / nospace_cache
>>> sdd / ssd_spread / nossd / no_ssdspread
> 
> How could those be anything other than filesystem-wide options?
> 

Well being me, I tend to live in a fantasy world where BTRFS have 
complete world domination and has become the VFS layer.
As I have nagged about before on this list - I really think that the 
only sensible way forward for BTRFS (or dare I say BTRFS2) would be to 
make it possible to assign "storage device groups" where you can make 
certain btrfs device ids belong to group a,b,c, etc...

And with that it would be possible to assign a weight to subvolumes so 
that they would be preferred to be stored on group a (SSD's perhaps), 
while other subvolumes would be stored mostly or exlusively on HDD's, 
Fast HDD's, Archival HDD's etc... So maybe a bit over enthusiastic in 
thinking perhaps , but hopefully you see now why I think it is right 
that this is not filesystem-wide , but subvolume baseed properties.

>>> discard / nodiscard
> 
> Maybe, but probably requires too much introspection in a fast path (we'd
> have to add a check for the last owner of a deleted extent to see if it
> had 'discard' set on some parent level).
> 
> On the other hand, I'm in favor of deprecating the whole discard option
> and going with fstrim instead.  discard in its current form tends to
> increase write wear rather than decrease it, especially on metadata-heavy
> workloads.  discard is roughly equivalent to running fstrim thousands
> of times a day, which is clearly bad for many (most?  all?) SSDs.
> 
> It might be possible to make the discard mount option's behavior more
> sane (e.g. discard only full chunks, configurable minimum discard length,
> discard only within data chunks, discard only once per hour, etc).
> 
Interesting, it might as well make sense to perhaps use the free space 
cache and a slow LRU mechanism e.g. "these chunks has not been in use 
for 64 hours/days" or something similar.

>>> compress / compress-force
>>> datacow / nodatacow
>>> datasum / nodatasum
> 
> Here's where I prefer the mount option over the more local attributes,
> because I'd like filesystem-level sysadmin overrides for those.
> i.e. disallow all users, even privileged ones, from being able to create
> files that don't have csums or compression on a filesystem.
> 
Then how about a mount option that allow only root to do certain things? 
e.g. a security restriction.

> 
>>> user_subvol_rm_allowed
> 
> I'd like "user_subvol_create_disallowed" too.  Unprivileged users can
> create subvols, and that breaks backups that rely on atomic btrfs
> snapshots.  It could be a feature (it allows users to exclude parts of
> their home directory from backups) but most users I've met who have
> discovered this "feature" the hard way didn't enjoy it.
> 
> Historically I had other reasons to disallow subvol creates by
> unprivileged users, but they are mostly removed in 4.18, now that 'rmdir'
> works on an empty subvol.
> 
Again see above...
