Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B61100C05
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 20:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRTLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 14:11:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfKRTLz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 14:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74CE8B24A;
        Mon, 18 Nov 2019 19:11:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90D74DAB3A; Mon, 18 Nov 2019 20:11:54 +0100 (CET)
Date:   Mon, 18 Nov 2019 20:11:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not corrupt the fs with rename exchange on a
 subvol
Message-ID: <20191118191154.GM3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191115204306.3446-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115204306.3446-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 15, 2019 at 03:43:06PM -0500, Josef Bacik wrote:
> Testing with the new fsstress support for subvolumes uncovered a pretty
> bad problem with rename exchange on subvolumes.  We're modifying two
> different subvolumes, but we only start the transaction on one of them,
> so the other one is not added to the dirty root list.  This is caught by
> btrfs_cow_block() with a warning because the root has not been updated,
> however if we do not modify this root again we'll end up pointing at an
> invalid root because the root item is never updated.
> 
> Fix this by making sure we add the destination root to the trans list,
> the same as we do with normal renames.  This fixes the corruption.
> 
> Fixes: cdd1fedf8261 ("btrfs: add support for RENAME_EXCHANGE and RENAME_WHITEOUT")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
