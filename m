Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC65A2F21FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbhAKVlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:41:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKVlf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:41:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 243FDAB7F;
        Mon, 11 Jan 2021 21:40:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C714DA701; Mon, 11 Jan 2021 22:39:02 +0100 (CET)
Date:   Mon, 11 Jan 2021 22:39:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Make btrfs_start_delalloc_root's nr argument
 a long
Message-ID: <20210111213902.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210111105812.423915-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111105812.423915-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 12:58:11PM +0200, Nikolay Borisov wrote:
> It's currently u64 which gets instantly translated either to LONG_MAX
> (if U64_MAX is passed) or casted to an unsigned long (which is in fact,
> wrong because iwriteback_control::nr_to_write is a signed, long type).
> 
> Just convert the function's argument to be long time which obviates the
> need to manually convert u64 value to a long. Adjust all call sites
> which pass U64_MAX to pass LONG_MAX. Finally ensure that in
> shrink_delalloc the u64 is converted to a long without overflowing,
> resulting in a negative number.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> David,
> 
> Here are 2 patches which I believe should be folded into
> "btrfs: shrink delalloc pages instead of full inodes"

That patch is about to be merged to Linus' tree so I'll apply your
patches separately.
