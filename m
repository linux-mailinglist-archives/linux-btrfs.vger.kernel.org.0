Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16F3295035
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444190AbgJUPxb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 11:53:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444179AbgJUPxb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 11:53:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0448DACB5;
        Wed, 21 Oct 2020 15:53:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5651BDA7C5; Wed, 21 Oct 2020 17:51:59 +0200 (CEST)
Date:   Wed, 21 Oct 2020 17:51:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: protect the fs_info->caching_block_groups
 differently
Message-ID: <20201021155159.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1603137558.git.josef@toxicpanda.com>
 <64816a7abd985112ddd7c44998753f72b5775a1a.1603137558.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64816a7abd985112ddd7c44998753f72b5775a1a.1603137558.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 19, 2020 at 04:02:30PM -0400, Josef Bacik wrote:
> while testing another lockdep fix.  This happens because we're using the
> commit_root_sem to protect fs_info->caching_block_groups, which creates
> a dependency on the groups_sem -> commit_root_sem, which is problematic
> because we will allocate blocks while holding tree roots.  Fix this by
> making the list itself protected by the fs_info->block_group_cache_lock.

That's lacking explanation why this is supposed to be correct. Replacing
semaphore by a spin lock has implications and given that he commit root
sem does not protect a single structure or is sometimes used for context
exclusion, this requires more in the changelog and updated perhaps
comments for the locks.
