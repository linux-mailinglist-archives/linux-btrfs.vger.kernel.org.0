Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3691E44AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbgE0NzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 09:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388984AbgE0NzB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 09:55:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93A40B03C;
        Wed, 27 May 2020 13:55:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F499DA72D; Wed, 27 May 2020 15:54:03 +0200 (CEST)
Date:   Wed, 27 May 2020 15:54:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Open code key_search
Message-ID: <20200527135403.GF18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200527101053.7340-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527101053.7340-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 01:10:53PM +0300, Nikolay Borisov wrote:
> This function wraps the optimisation implemented by d7396f07358a,
> however this optimisation is really used in only one place -
> btrfs_search_slot. Just open code the optimisation and also add a
> comment explaining how it works since it's not clear just by looking
> at the code - the key point here is it depends on an internal invariant
> that BTRFS' btree provides, namely intermediate pointers always contain
> the key at slot0 at the child node. So in the case of exact match we
> can safely assume that the given key will always be in slot 0 on lower
> levels.
> 
> Furthermore this results in a reduction of btrfs_search_slot's size:
> 
> ./scripts/bloat-o-meter ctree.orig fs/btrfs/ctree.o
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-75 (-75)
> Function                                     old     new   delta
> btrfs_search_slot                           2783    2708     -75
> Total: Before=50423, After=50348, chg -0.15%
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
