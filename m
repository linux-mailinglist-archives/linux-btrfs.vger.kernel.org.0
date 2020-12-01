Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762F2CAA1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgLARr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 12:47:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLARr1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Dec 2020 12:47:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E8B1AC2D;
        Tue,  1 Dec 2020 17:46:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A6EADA7D2; Tue,  1 Dec 2020 18:45:14 +0100 (CET)
Date:   Tue, 1 Dec 2020 18:45:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs-progs: check: add the ability to repair
 extent item generation corruption
Message-ID: <20201201174514.GO6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200811114451.28862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811114451.28862-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 07:44:47PM +0800, Qu Wenruo wrote:
> Although we have introduced the check ability to detect bad extent item
> generation, there is no repair ability.
> 
> I thought it would be rare to hit, but real world cases prove I'm a
> total idiot.
> 
> So this patchset will add the ability to repair, for both lowmem mode
> and original mode, along with enhanced test images.
> 
> There is also a bug fix for original mode, which fails to detect such
> problem if it's a tree block.
> 
> Changelog:
> v2:
> - Fix a type in the subject of the 4th patch
> - Fix a bracket for for a logical and and bit and
>   The old code is fine and bit and has higher priority, but
>   the bracket is intended to make that higher priority more obvious.
> 
> Qu Wenruo (4):
>   btrfs-progs: check/lowmem: add the ability to repair extent item
>     generation
>   btrfs-progs: check/original: don't reset extent generation for
>     check_block()
>   btrfs-progs: check/original: add the ability to repair extent item
>     generation
>   btrfs-progs: tests/fsck: enhance invalid extent item generation test
>     cases

Added to devel, thanks.
