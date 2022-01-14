Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F120F48EEB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiANQvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 11:51:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiANQvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 11:51:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C7FD21940;
        Fri, 14 Jan 2022 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642179069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HuoUzLxtho0TtOltxle201G+TymM5+MT3mUH7NfNrNY=;
        b=FdMMIa7TqVupgHxxfIcD+o+C8PU/dihVVDt/lSvbXfKG5yqLWdSifEZZoLvGCDO7P+H2K3
        qiqVQHWRbeZYvK64NUvRgXCLaZlgtfJaHaw/dz4NQwIumsfPvueACfdyUTqauumlqw7wGs
        GQ8K+AdSQerLscx/y0LRSOwwLzzkHqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642179069;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HuoUzLxtho0TtOltxle201G+TymM5+MT3mUH7NfNrNY=;
        b=psQ9v2mcbyy0sNSJMW0AjAPpnQRrR3MjDZc23VTI7nJs35rQnOSlNgb07cmaYwj+ZtfXrX
        ekVO9fRYO42BA2AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16DA1A3B85;
        Fri, 14 Jan 2022 16:51:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F7F8DA781; Fri, 14 Jan 2022 17:50:34 +0100 (CET)
Date:   Fri, 14 Jan 2022 17:50:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs-progs: check: properly generate csum for
 various complex combinations
Message-ID: <20220114165034.GE14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220114005123.19426-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 14, 2022 at 08:51:18AM +0800, Qu Wenruo wrote:
> [BUG]
> Issue #420 mentions that --init-csum-tree creates extra csum for
> preallocated extents.
> 
> Causing extra errors after --init-csum-tree.
> 
> [CAUSE]
> Csum re-calculation code doesn't take the following factors into
> consideration:
> 
> - NODATASUM inodes
> - Preallocated extents
>   No csum should be calculated for those data extents
> 
> - Partically written preallocated csum
>   Csum should only be created for the referred part
> 
> So currently csum recalculation will just create csum for any data
> extents it found, causing the mentioned errors.
> 
> [FIX]
> - Bug fix for backref iteration
>   Firstly fix a bug in backref code where indirect ref is not properly
>   resolved.
> 
>   This allows us to use iterate_extent_inodes() to make our lives much
>   easier checking the file extents.
> 
> - Code move for --init-csum-tree
>   Move it to mode independent mode-common.[ch]
> 
> - Fix for --init-csum-tree
>   There are some extreme corner cases to consider, in fact we can not
>   really determine a range should have csum or not:
>   * Preallocated, written, then hole punched range
>     Should still have csum for the written (now hole) part.
> 
>   * Preallocated, then hole punched range.
>     Should not have csum for the now hole part.
> 
>   * Regular written extent, then hole punched range
>     Should have csum for the now hole part.
> 
>   But there is still one thing to follow, if a range is preallocated,
>   it should not have csum.
> 
>   So here we go a different route, by always generate csum for the whole
>   extent (as long as it's not belonging to NODATASUM inode), then remove
>   csums for preallocated range.
> 
> - Fix for --init-csum-tree --init-extent-tree
>   The same fix, just into a different context
> 
> - New test case
> 
> [CHANGELOG]
> v2:
> - Handle written extents then hole punched cases
>   Now we always generate csum for a data extent as long as it doesn't
>   belong to a NODATASUM inode, then remove the csum for preallocated
>   range.
> 
> - Enhance test case to include hole punching and compressed extents

Added to devel, thanks, I guess this fixes some of the problems that I
saw when trying to implement the checksum algo switch.
