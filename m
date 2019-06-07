Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3738B9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfFGN1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 09:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727840AbfFGN1O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 09:27:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42137AE08
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 13:27:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E846CDA849; Fri,  7 Jun 2019 15:28:02 +0200 (CEST)
Date:   Fri, 7 Jun 2019 15:28:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Further FITRIM improvements
Message-ID: <20190607132800.GB30187@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190603100602.19362-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603100602.19362-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 01:05:58PM +0300, Nikolay Borisov wrote:
> Qu reported beyond EOD (end of device) access with latest FITRIM improvements 
> that were merged. Further testing also showed that if ranged FITRIM request is 
> sent it's possible to cause u64 overflow which in turn cause calculations to 
> go off rail in btrfs_issue_discard (because it's called with start and len 
> as (u64)-1) and trim used data. 
> 
> This patchset aims to rectify this by: 
> 
> 1. Documenting the internal __etree_search since due to the rather high 
> number of output parameters it can be a bit confusing as to what the invariants 
> are. Due to this I got initially confused about possible return values on 
> boundary conditions. (Patch 1)
> 
> 2. Remove ranged support in btrfs_trim_free_extents - having range support in 
> btrfs_trim_free_extent is problematic because it's interpreted in device physical 
> space whilst range values from userspace should always be interpreted in 
> logical space. (Patch 2)
> 
> 3. Change slightly the semantics of find_first_clear_extent_bit to return the 
> range that contains the passed address or in case no such range exists the 
> next one, document the function and finally add tests (Patch 3 preps 
> btrfs_trim_free_extents to handle the change semantics and Patch 4 change 
> the semantics). 
> 
> This has been fully tested with xfstest and no regressions were found. 
> 
> Nikolay Borisov (4):
>   btrfs: Document __etree_search
>   btrfs: Always trim all unallocated space in btrfs_trim_free_extents
>   btrfs: Skip first megabyte on device when trimming
>   btrfs: Don't trim returned range based on input value in
>     find_first_clear_extent_bit

Added to misc-next, with some adjustments and 2/4 will go to the next
5.2-rc. Thanks.
