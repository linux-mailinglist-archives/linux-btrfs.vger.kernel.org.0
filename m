Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538E93F9C68
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhH0Q3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 12:29:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhH0Q3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 12:29:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 345F622328;
        Fri, 27 Aug 2021 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630081701;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0xMh2m63TJOg81PBKZGdpst1Ebpv3NcfIrnSbia8Mc=;
        b=vr6hGou1Cc3e+62VLFRRBQ2cqNAHcncJiJP/V86p3HN565OdA1+eN3ipDGnlQ+L97aEX5s
        2Cs+YtoSCKbD9ilHMn5kVV3geo65o91Vgfq3a8wIifDTZqEKspOekPw94d4Y53OoqTjTsr
        yCOJGUZjlj59bBWTUOX7r3AFvV2bZ0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630081701;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0xMh2m63TJOg81PBKZGdpst1Ebpv3NcfIrnSbia8Mc=;
        b=8LtpzcRalhac3leOfvR5wZtNyXB9aCLavaUCtkiDKDDSF8An3OaRSZF+09mGumkePzu5rI
        8P/1H2CLvaiDB8Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D7577A3B9C;
        Fri, 27 Aug 2021 16:28:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8453DA7F3; Fri, 27 Aug 2021 18:25:31 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:25:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/17] ZNS Support for Btrfs
Message-ID: <20210827162530.GY3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 09:19:07PM +0900, Naohiro Aota wrote:
> This series extends zoned support for Zoned Namespace (ZNS) SSDs [1].
> 
> [1] https://zonedstorage.io/introduction/zns/
> 
> This series is available on GitHub at
> v1    https://github.com/naota/linux/tree/btrfs-zns-v1
> HEAD  https://github.com/naota/linux/tree/btrfs-zns
> 
> The ZNS specification introduces extra functionalities listed below.
> 
>   - No conventional zones
>   - Zone Append write command
>   - Zone Capacity
>   - Active Zones
> 
> 
> Naohiro Aota (17):
>   btrfs: zoned: load zone capacity information from devices
>   btrfs: zoned: move btrfs_free_excluded_extents out from
>     btrfs_calc_zone_unusable
>   btrfs: zoned: calculate free space from zone capacity
>   btrfs: zoned: tweak reclaim threshold for zone capacity
>   btrfs: zoned: consider zone as full when no more SB can be written
>   btrfs: zoned: locate superblock position using zone capacity
>   btrfs: zoned: finish superblock zone once no space left for new SB
>   btrfs: zoned: load active zone information from devices
>   btrfs: zoned: introduce physical_map to btrfs_block_group
>   btrfs: zoned: implement active zone tracking
>   btrfs: zoned: load active zone info for block group
>   btrfs: zoned: activate block group on allocation
>   btrfs: zoned: activate new block group
>   btrfs: move ffe_ctl one level up
>   btrfs: zoned: avoid chunk allocation if active block group has enough
>     space
>   btrfs: zoned: finish fully written block group
>   btrfs: zoned: finish relocating block group

This is contained in the zoned mode and I don't see much reason to hold
it back, so it's in misc-next now. I've fixed some minor style issues.
In case there are small fixups worth folding please let me know,
otherwise please send separate patches. Thanks.
