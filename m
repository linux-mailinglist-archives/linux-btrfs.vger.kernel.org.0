Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACB2A68C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgKDPzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:55:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgKDPzf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 10:55:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8983ADD9;
        Wed,  4 Nov 2020 15:55:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E7CBDA6E3; Wed,  4 Nov 2020 16:53:54 +0100 (CET)
Date:   Wed, 4 Nov 2020 16:53:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
Message-ID: <20201104155354.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103211101.4221-1-dsterba@suse.com>
 <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 04, 2020 at 07:44:33AM +0800, Qu Wenruo wrote:
> On 2020/11/4 上午5:11, David Sterba wrote:
> > After the rwsem replaced the tree lock implementation, the extent buffer
> > got smaller but leaving some holes behind. By changing log_index type
> > and reordering, we can squeeze the size further to 240 bytes, measured on
> > release config on x86_64. Log_index spans only 3 values and needs to be
> > signed.
> > 
> > Before:
> > 
> > struct extent_buffer {
> >         u64                        start;                /*     0     8 */
> >         long unsigned int          len;                  /*     8     8 */
> >         long unsigned int          bflags;               /*    16     8 */
> >         struct btrfs_fs_info *     fs_info;              /*    24     8 */
> >         spinlock_t                 refs_lock;            /*    32     4 */
> >         atomic_t                   refs;                 /*    36     4 */
> >         atomic_t                   io_pages;             /*    40     4 */
> >         int                        read_mirror;          /*    44     4 */
> >         struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         pid_t                      lock_owner;           /*    64     4 */
> >         bool                       lock_recursed;        /*    68     1 */
> > 
> >         /* XXX 3 bytes hole, try to pack */
> > 
> >         struct rw_semaphore        lock;                 /*    72    40 */
> 
> An off-topic question, for things like aotmic_t/spinlock_t and
> rw_semaphore, wouldn't various DEBUG options change their size?

Yes they do. For example spinlock_t is 4 bytes on release config and 72
on debug. Semaphore is 40 vs 168. Atomic_t is 4 bytes always, it's just
an int.

> Do we need to consider such case, by moving them to the end of the
> structure, or we only consider production build for pa_hole?

We should optimize for the release build for structure layout or
cacheline occupation, the debugging options make it unpredictable and it
affects only development. There are way more deployments without
debugging options enabled anyway.

The resulting size of the structures is also bigger so this has
completely different slab allocation pattern and performance
characteristics.

Here's the layout of eb on the debug config I use:

struct extent_buffer {
        u64                        start;                /*     0     8 */
        long unsigned int          len;                  /*     8     8 */
        long unsigned int          bflags;               /*    16     8 */
        struct btrfs_fs_info *     fs_info;              /*    24     8 */
        spinlock_t                 refs_lock;            /*    32    72 */
        /* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
        atomic_t                   refs;                 /*   104     4 */
        atomic_t                   io_pages;             /*   108     4 */
        int                        read_mirror;          /*   112     4 */

        /* XXX 4 bytes hole, try to pack */

        struct callback_head       callback_head __attribute__((__aligned__(8))); /*   120    16 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        pid_t                      lock_owner;           /*   136     4 */
        bool                       lock_recursed;        /*   140     1 */
        s8                         log_index;            /*   141     1 */

        /* XXX 2 bytes hole, try to pack */

        struct rw_semaphore        lock;                 /*   144   168 */
        /* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
        struct page *              pages[16];            /*   312   128 */
        /* --- cacheline 6 boundary (384 bytes) was 56 bytes ago --- */
        struct list_head           leak_list;            /*   440    16 */

        /* size: 456, cachelines: 8, members: 15 */
        /* sum members: 450, holes: 2, sum holes: 6 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));
