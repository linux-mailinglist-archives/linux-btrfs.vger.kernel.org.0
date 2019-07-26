Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17D76397
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 12:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGZKcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 06:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726489AbfGZKcz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 06:32:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECD8CB62D;
        Fri, 26 Jul 2019 10:32:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 856B2DA80E; Fri, 26 Jul 2019 12:33:30 +0200 (CEST)
Date:   Fri, 26 Jul 2019 12:33:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: fix extent_state leak in
 btrfs_lock_and_flush_ordered_range
Message-ID: <20190726103330.GY2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190726074705.27513-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726074705.27513-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 04:47:05PM +0900, Naohiro Aota wrote:
> btrfs_lock_and_flush_ordered_range() loads given "*cached_state" into
> cachedp, which, in general, is NULL. Then, lock_extent_bits() updates
> "cachedp", but it never goes backs to the caller. Thus the caller still
> see its "cached_state" to be NULL and never free the state allocated
> under btrfs_lock_and_flush_ordered_range(). As a result, we will
> see massive state leak with e.g. fstests btrfs/005. Fix this bug by
> properly handling the pointers.
> 
> Fixes: bd80d94efb83 ("btrfs: Always use a cached extent_state in btrfs_lock_and_flush_ordered_range")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Queued for 5.3, thanks.
