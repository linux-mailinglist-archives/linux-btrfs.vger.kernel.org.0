Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D345144185
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUQFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 11:05:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:46252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgAUQFC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 11:05:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4F05B1CD;
        Tue, 21 Jan 2020 16:05:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75D8FDA738; Tue, 21 Jan 2020 17:04:44 +0100 (CET)
Date:   Tue, 21 Jan 2020 17:04:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: free block groups after free'ing fs trees
Message-ID: <20200121160442.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200121141706.2173895-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121141706.2173895-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 09:17:06AM -0500, Josef Bacik wrote:
> Sometimes when running generic/475 we would trip the
> WARN_ON(cache->reserved) check when free'ing the block groups on umount.
> This is because sometimes we don't commit the transaction because of IO
> errors and thus do not cleanup the tree logs until at umount time.
> These blocks are still reserved until they are cleaned up, but they
> aren't cleaned up until _after_ we do the free block groups work.  Fix
> this by moving the free after free'ing the fs roots, that way all of the
> tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
> loops of generic/475 confirmed this fixes the problem.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Add a comment to make sure we don't re-order the block group freeing.

Thanks, added to misc-next.
