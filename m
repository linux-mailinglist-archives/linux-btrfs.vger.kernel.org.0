Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14E230CA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgG1OoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 10:44:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbgG1OoR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 10:44:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69362B165;
        Tue, 28 Jul 2020 14:44:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58928DA6FD; Tue, 28 Jul 2020 16:43:47 +0200 (CEST)
Date:   Tue, 28 Jul 2020 16:43:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
Message-ID: <20200728144346.GW3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727142805.4896-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 10:28:05AM -0400, Josef Bacik wrote:
> In try_to_merge_free_space we attempt to find entries to the left and
> right of the entry we are adding to see if they can be merged.  We
> search for an entry past our current info (saved into right_info), and
> then if right_info exists and it has a rb_prev() we save the rb_prev()
> into left_info.
> 
> However there's a slight problem in the case that we have a right_info,
> but no entry previous to that entry.  At that point we will search for
> an entry just before the info we're attempting to insert.  This will
> simply find right_info again, and assign it to left_info, making them
> both the same pointer.
> 
> Now if right_info _can_ be merged with the range we're inserting, we'll
> add it to the info and free right_info.  However further down we'll
> access left_info, which was right_info, and thus get a UAF.
> 
> Fix this by only searching for the left entry if we don't find a right
> entry at all.
> 
> The CVE referenced had a specially crafted file system that could
> trigger this UAF.  However with the tree checker improvements we no
> longer trigger the conditions for the UAF.  But the original conditions
> still apply, hence this fix.
> 
> Reference: CVE-2019-19448
> Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - Updated the changelog.

Added to misc-next, thanks.
