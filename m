Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA7304D36
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbhAZXFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:05:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:32980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbhAZRFB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 12:05:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1F8CB761;
        Tue, 26 Jan 2021 16:43:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DC60DA7D2; Tue, 26 Jan 2021 17:41:53 +0100 (CET)
Date:   Tue, 26 Jan 2021 17:41:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/5] Serious fixes for different error paths
Message-ID: <20210126164153.GQ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 14, 2021 at 02:02:41PM -0500, Josef Bacik wrote:
> v1->v2:
> - Rebased onto misc-next, dropping everything that's been merged so far.
> - Fixed "btrfs: splice remaining dirty_bg's onto the transaction dirty bg list"
>   to handle the btrfs_alloc_path() failure and cleaned up the error handling as
>   a result of that change.
> - dropped "btrfs: don't clear ret in btrfs_start_dirty_block_groups" as I fixed
>   it differently in "btrfs: splice remaining dirty_bg's onto the transaction
>   dirty bg list"
> - Added a link to Zygo's original report in "btrfs: add asserts for deleting
>   backref cache nodes".
> - Clarified the error condition that lead to the WARN_ON() in the changelog for
>   "btrfs: do not WARN_ON() if we can't find the reloc root".
> - Added the stack trace that the error injection triggered in order to get the
>   error that happened in "btrfs: abort the transaction if we fail to inc ref in
>   btrfs_copy_root".

Added to misc-next, thanks.
