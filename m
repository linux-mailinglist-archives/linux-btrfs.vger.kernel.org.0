Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BE72DD566
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLQQoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:44:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:34612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgLQQoB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:44:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B57EAC90;
        Thu, 17 Dec 2020 16:43:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C4F6DA83A; Thu, 17 Dec 2020 17:41:40 +0100 (CET)
Date:   Thu, 17 Dec 2020 17:41:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: account for new extents being deleted in
 total_bytes_pinned
Message-ID: <20201217164140.GR6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608137123.git.josef@toxicpanda.com>
 <0826b647d5dd12f8134614e05519156d9351f2c1.1608137123.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0826b647d5dd12f8134614e05519156d9351f2c1.1608137123.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:46:54AM -0500, Josef Bacik wrote:
> My recent set of patches to reduce lock contention on the extent root by
> running delayed refs resulted in a regression in generic/371.

As you write that often in patches, I want to point out that references
to 'my recent patches doing something' are too vague and don't stand the
test of time. Reading the patch in a year won't give me much clue what
patches are that. Also as patches don't get merged in the order they've
sent, 'recent' could be referring to something that would be in fact
committed after this patch, making it more confusing and hard to find.

If the patches are yet to be merged, referencing by subject should be
sufficient, Filipe has been doing that and I find it really convenient
to get more background to understand the changes or put them to context
in case there's some dependency.

> This test
> fallocate()'s the fs until it's full, deletes all the files, and then
> tries to fallocate() until full again.
> 
> Before my delayed refs patches we would run all of the delayed refs

And another one. If there's a hard patchset-to-patchset dependency and
they get merged in that order, that's fine to refer to it like that and
we've been doing that. The difference is that the patches are serialized
in git and going back in git history will end up in the referred patches
eventually. Unlike when it's still in the mailinglist, but still a more
specific reference is better.
