Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6142F2293
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 23:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbhAKWUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 17:20:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:38894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388713AbhAKWUh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 17:20:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95610B173;
        Mon, 11 Jan 2021 22:19:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DC4CDA701; Mon, 11 Jan 2021 23:18:04 +0100 (CET)
Date:   Mon, 11 Jan 2021 23:18:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/13] btrfs: add ASSERT()'s for deleting backref cache
 nodes
Message-ID: <20210111221804.GL6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
 <3fc2e3dd35d339a7251a2ed48af3ba484769002e.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fc2e3dd35d339a7251a2ed48af3ba484769002e.1608135557.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Regarding the subject, you can write plain 'assert', no need to spell
it exactly as it's in the code.

On Wed, Dec 16, 2020 at 11:22:10AM -0500, Josef Bacik wrote:
> A weird KASAN problem that Zygo reported

Please add the relevant part of the report to the changelog and/or link
to the report itself.

> could have been easily caught
> if we checked for basic things in our backref freeing code.  We have two
> methods of freeing a backref node
> 
> - btrfs_backref_free_node: this just is kfree() essentially.
> - btrfs_backref_drop_node: this actually unlinks the node and cleans up
>   everything and then calls btrfs_backref_free_node().
> 
> We should mostly be using btrfs_backref_drop_node(), to make sure the
> node is properly unlinked from the backref cache, and only use
> btrfs_backref_free_node() when we know the node isn't actually linked to
> the backref cache.  We made a mistake here and thus got the KASAN splat.
> Make this style of issue easier to find by adding some ASSERT()'s to
> btrfs_backref_free_node() and adjusting our deletion stuff to properly
> init the list so we can rely on list_empty() checks working properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
