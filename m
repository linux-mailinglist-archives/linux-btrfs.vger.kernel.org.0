Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C997B2DE6CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgLRPk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 10:40:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgLRPk4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 10:40:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A508CAD09;
        Fri, 18 Dec 2020 15:40:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35127DA806; Fri, 18 Dec 2020 16:38:35 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:38:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] Fixes and tweaks around error handling
Message-ID: <20201218153835.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135381.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:42AM -0500, Josef Bacik wrote:
> Hello,
> 
> These patches were originally in my reloc error handling patches that have been
> broken out on their own.  They stand on their own and are simple and don't
> affect the code in a real way.  Simply fixing some cosmetic stuff, or allowing
> error injection in certain places.  They were patches I needed while running
> error injection.  Thanks,
> 
> Josef
> 
> Josef Bacik (5):
>   btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
>   btrfs: print the actual offset in btrfs_root_name
>   btrfs: noinline btrfs_should_cancel_balance
>   btrfs: pass down the tree block level through ref-verify
>   btrfs: make sure owner is set in ref-verify

Added to misc-next, with some changelog adjustments, thanks.
