Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E182AF44C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKKPAo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 10:00:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgKKPAo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 10:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28C62AEC2;
        Wed, 11 Nov 2020 15:00:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DFAADA6E1; Wed, 11 Nov 2020 15:59:01 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:59:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs: remove the recursion handling code in
 locking.c
Message-ID: <20201111145901.GR6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604697895.git.josef@toxicpanda.com>
 <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
 <20201111142930.GP6756@twin.jikos.cz>
 <007a92c9-7af3-9aec-ba65-fc9ff3cda132@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007a92c9-7af3-9aec-ba65-fc9ff3cda132@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 09:43:50AM -0500, Josef Bacik wrote:
> > 185
> > 186 /*
> > 187  * Helper to output refs and locking status of extent buffer.  Useful to debug
> > 188  * race condition related problems.
> > 189  */
> > 190 static void print_eb_refs_lock(struct extent_buffer *eb)
> > 191 {
> > 192 #ifdef CONFIG_BTRFS_DEBUG
> > 193         btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
> > 194                    atomic_read(&eb->refs), eb->lock_owner, current->pid);
> > 195 #endif
> > 196 }
> > 
> > The safety check added in b72c3aba09a53fc7c18 ("btrfs: locking: Add
> > extra check in btrfs_init_new_buffer() to avoid deadlock") and it seems
> > to be useful but I think it builds on the assumptions of the previous
> > tree locks. The mentioned warning uses the recursive locking which is
> > being removed.
> 
> Sorry I should have explained why I was leaving this in my cover letter.  The 
> safety check is for the case that the free space cache is corrupted and we try 
> to allocate a block that we are currently using and have locked in the path.  I 
> would have preferred to move it under CONFIG_BTRFS_DEBUG, but it does actually 
> help in the case of a bad free space cache, so I think we have to keep it.  Thanks,

Yeah that's a valid reason to keep it, I'll update the changelog.
