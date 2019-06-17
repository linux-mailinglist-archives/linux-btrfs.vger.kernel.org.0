Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92244879A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFQPlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 11:41:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfFQPlR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 11:41:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF367AC2E
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 15:41:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39FA9DA8D1; Mon, 17 Jun 2019 17:42:05 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:42:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Factor out logical address mapping
Message-ID: <20190617154204.GG19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190617133717.19759-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617133717.19759-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 17, 2019 at 04:37:16PM +0300, Nikolay Borisov wrote:
> Prepare for refactoring and simplifying the code in __btrfs_map_block
> by factoring out common code into a separete function -
> btrfs_get_io_geometry. It perform necessary actions to map a
> (logical addr, len) pair to the underlying physical disk. This code is
> also necessary to figure if particular IO req will span a btrfs stripe,
> to that effect __btrfs_map_block was called with bio_ret parameter set
> to NULL as a way to indicate we only need the "mapping" logic and not
> submit.
> 
> Further it introduces a simple wrapper over its numerous return
> parameters. Having multiple return params rather than a single struct
> is a deliberate choice so as not to bloat the stack.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

This turns out a bit worse compared to the struct approach in v1. The
stack stats for v2:

__btrfs_map_block                                  +64 (200 -> 264)

NEW (152):

btrfs_get_io_geometry
btrfs_get_stripe_rem

LOST/NEW DELTA:     +152
PRE/POST DELTA:     +216

From the code prespective the struct is more readable than a series of NULL
parameters. That would be justifiable in case the stack consumption would be
dramatically better, but it's not.

Thanks for the v2, I think this exercise was useful. I'm going to merge v1.
