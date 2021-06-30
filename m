Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9113B8082
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhF3KEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 06:04:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhF3KEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 06:04:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 169EF226A6;
        Wed, 30 Jun 2021 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625047314;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEaqOwNKhLBYQYGwrJ2xjFd6h5j+BZiGEF8gCH4qcxo=;
        b=s0EZRUJJbcIudsbIuaAqxWseq93rzjbXGMlgvkBwQ2UagpILzlLhZctv2ENdbGMHN6BAG2
        xb0Np6nEmH1W+Wk6BiApcVl/FAXVuP8QLpNfDTwOTRl1UCFoe7kRW/G/k6XOE0uoMf0Qvr
        8tl+pv0k/1KU0QoAdGb1e66Dqki3TLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625047314;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEaqOwNKhLBYQYGwrJ2xjFd6h5j+BZiGEF8gCH4qcxo=;
        b=G06LDiu6vW031ghZytUvS3eGZtumrxr1Ulxe8q44AFRJmkKMJ6zzr2B1MSPSpY5SBdoRcO
        PS+DES4eRHi+XOCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8F8F3A3B8A;
        Wed, 30 Jun 2021 10:01:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A06C3DA7A2; Wed, 30 Jun 2021 11:59:23 +0200 (CEST)
Date:   Wed, 30 Jun 2021 11:59:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "lijian_8010a29@163.com" <lijian_8010a29@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijian <lijian@yulong.com>
Subject: Re: [PATCH] fs: btrfs: extent_map: removed unneeded variable
Message-ID: <20210630095923.GH2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "lijian_8010a29@163.com" <lijian_8010a29@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijian <lijian@yulong.com>
References: <20210629085025.98437-1-lijian_8010a29@163.com>
 <PH0PR04MB741666CF29DB96CF0DB0C26B9B029@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741666CF29DB96CF0DB0C26B9B029@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 09:04:40AM +0000, Johannes Thumshirn wrote:
> On 29/06/2021 10:51, lijian_8010a29@163.com wrote:
> > From: lijian <lijian@yulong.com>
> > 
> > removed unneeded variable 'ret'.
> 
> Wouldn't it make more sense to return an error (-ENOENT??) in case
> the em lookup fails and handle the error in btrfs_finish_ordered_io()
> as this is the only caller of unpin_extent_cache()?
> 
> I've actually tripped over this a couple of times already when 
> investigating extent map and ordered extent splitting problems
> on zoned filesystems:
> 
> 	em = lookup_extent_mapping(tree, start, len);
> 	WARN_ON(!em || em->start != start);
> 
> Maybe even turn this WARN_ON() into an ASSERT() when introducing proper
> error handling, as we shouldn't really get there unless we have a logical
> error.

If you have real workloads hitting the warning then it really should be
proper error handling, not even an assert.
