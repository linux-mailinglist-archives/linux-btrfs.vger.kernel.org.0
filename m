Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAC338B70
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhCLLZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 06:25:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:44122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233730AbhCLLZ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 06:25:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03CE7B03C;
        Fri, 12 Mar 2021 11:25:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 388D2DA81D; Fri, 12 Mar 2021 12:23:27 +0100 (CET)
Date:   Fri, 12 Mar 2021 12:23:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Use memzero_page() instead of open coded kmap
 pattern
Message-ID: <20210312112327.GP7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309212137.2610186-1-ira.weiny@intel.com>
 <20210309212137.2610186-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309212137.2610186-4-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 09, 2021 at 01:21:37PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There are many places where kmap/memset/kunmap patterns occur.
> 
> Use the newly lifted memzero_page() to eliminate direct uses of kmap and
> leverage the new core functions use of kmap_local_page().
> 
> The development of this patch was aided by the following coccinelle
> script:
> 
> // <smpl>
> // SPDX-License-Identifier: GPL-2.0-only
> // Find kmap/memset/kunmap pattern and replace with memset*page calls
> //
> // NOTE: Offsets and other expressions may be more complex than what the script
> // will automatically generate.  Therefore a catchall rule is provided to find
> // the pattern which then must be evaluated by hand.
> //
> // Confidence: Low
> // Copyright: (C) 2021 Intel Corporation
> // URL: http://coccinelle.lip6.fr/
> // Comments:
> // Options:
> 
> //
> // Then the memset pattern
> //
> @ memset_rule1 @
> expression page, V, L, Off;
> identifier ptr;
> type VP;
> @@
> 
> (
> -VP ptr = kmap(page);
> |
> -ptr = kmap(page);
> |
> -VP ptr = kmap_atomic(page);
> |
> -ptr = kmap_atomic(page);
> )
> <+...
> (
> -memset(ptr, 0, L);
> +memzero_page(page, 0, L);
> |
> -memset(ptr + Off, 0, L);
> +memzero_page(page, Off, L);
> |
> -memset(ptr, V, L);
> +memset_page(page, V, 0, L);
> |
> -memset(ptr + Off, V, L);
> +memset_page(page, V, Off, L);
> )
> ...+>
> (
> -kunmap(page);
> |
> -kunmap_atomic(ptr);
> )
> 
> // Remove any pointers left unused
> @
> depends on memset_rule1
> @
> identifier memset_rule1.ptr;
> type VP, VP1;
> @@
> 
> -VP ptr;
> 	... when != ptr;
> ? VP1 ptr;
> 
> //
> // Catch all
> //
> @ memset_rule2 @
> expression page;
> identifier ptr;
> expression GenTo, GenSize, GenValue;
> type VP;
> @@
> 
> (
> -VP ptr = kmap(page);
> |
> -ptr = kmap(page);
> |
> -VP ptr = kmap_atomic(page);
> |
> -ptr = kmap_atomic(page);
> )
> <+...
> (
> //
> // Some call sites have complex expressions within the memset/memcpy
> // The follow are catch alls which need to be evaluated by hand.
> //
> -memset(GenTo, 0, GenSize);
> +memzero_pageExtra(page, GenTo, GenSize);
> |
> -memset(GenTo, GenValue, GenSize);
> +memset_pageExtra(page, GenValue, GenTo, GenSize);
> )
> ...+>
> (
> -kunmap(page);
> |
> -kunmap_atomic(ptr);
> )
> 
> // Remove any pointers left unused
> @
> depends on memset_rule2
> @
> identifier memset_rule2.ptr;
> type VP, VP1;
> @@
> 
> -VP ptr;
> 	... when != ptr;
> ? VP1 ptr;
> 
> // </smpl>
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: David Sterba <dsterba@suse.com>
