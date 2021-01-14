Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18752F68F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbhANSGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 13:06:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:50326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbhANSGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 13:06:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AE55B699;
        Thu, 14 Jan 2021 18:05:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C31D7DA7EE; Thu, 14 Jan 2021 19:03:37 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:03:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 11/13] btrfs: keep track of the root owner for relocation
 reads
Message-ID: <20210114180337.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
 <1daf94fcbd66162c6b227404e2e0db257ca1c91c.1608135557.git.josef@toxicpanda.com>
 <20210111222315.GN6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111222315.GN6430@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 11:23:15PM +0100, David Sterba wrote:
> On Wed, Dec 16, 2020 at 11:22:15AM -0500, Josef Bacik wrote:
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -98,6 +98,7 @@ struct tree_block {
> >  		u64 bytenr;
> >  	}; /* Use rb_simple_node for search/insert */
> >  	struct btrfs_key key;
> > +	u64 owner;
> >  	unsigned int level:8;
> >  	unsigned int key_ready:1;
> 
> This would probably lead to bad packing, key is 17 bytes and placing
> u64 after that adds 7 bytes for proper alignment. The bitfield members
> following the key are aligned to a byte so it would work if owner is
> before key.

Easy fix and size 64 is also more cache friendly.

@@ -12256,22 +12256,18 @@ struct tree_block {
                struct rb_node     rb_node __attribute__((__aligned__(8))); /*     0    24 */
                u64                bytenr;               /*    24     8 */
        } __attribute__((__aligned__(8))) __attribute__((__aligned__(8)));               /*     0    32 */
-       struct btrfs_key           key;                  /*    32    17 */
+       u64                        owner;                /*    32     8 */
+       struct btrfs_key           key;                  /*    40    17 */

-       /* XXX 7 bytes hole, try to pack */
+       /* Bitfield combined with next fields */

-       u64                        owner;                /*    56     8 */
-       /* --- cacheline 1 boundary (64 bytes) --- */
-       unsigned int               level:8;              /*    64: 0  4 */
-       unsigned int               key_ready:1;          /*    64: 8  4 */
+       unsigned int               level:8;              /*    56: 8  4 */
+       unsigned int               key_ready:1;          /*    56:16  4 */

-       /* size: 72, cachelines: 2, members: 5 */
-       /* sum members: 57, holes: 1, sum holes: 7 */
-       /* sum bitfield members: 9 bits (1 bytes) */
+       /* size: 64, cachelines: 1, members: 5 */
        /* padding: 4 */
-       /* bit_padding: 23 bits */
+       /* bit_padding: 15 bits */
        /* forced alignments: 1 */
-       /* last cacheline: 8 bytes */
 } __attribute__((__aligned__(8)));
