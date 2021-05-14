Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4D381419
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhENXJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 19:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENXJi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 19:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D848AFE2;
        Fri, 14 May 2021 23:08:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47167DAEB9; Sat, 15 May 2021 01:05:54 +0200 (CEST)
Date:   Sat, 15 May 2021 01:05:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514230554.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210514113040.GV7604@twin.jikos.cz>
 <b2490ac7-7bb8-238c-1602-043bfcb09c8f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2490ac7-7bb8-238c-1602-043bfcb09c8f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 15, 2021 at 06:45:42AM +0800, Qu Wenruo wrote:
> > [27273.028163] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
> > [27273.030710] CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-default+ #1463
> > [27273.032295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > [27273.034731] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [btrfs]
> 
> It's in the new function introduced, and considering how few parameteres
> are passed in, I guess it's really something wrong in the function,
> other than some conflicts with other patches.
> 
> Any line number for it?

(gdb) l *(btrfs_lookup_first_ordered_range+0x46)
0x2366 is in btrfs_lookup_first_ordered_range (fs/btrfs/ordered-data.c:960).
955              * and screw up the search order.
956              * And __tree_search() can't return the adjacent ordered extents
957              * either, thus here we do our own search.
958              */
959             while (node) {
960                     entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
961
962                     if (file_offset < entry->file_offset) {
963                             node = node->rb_left;
964                     } else if (file_offset >= entry_end(entry)) {

Line 960 and it's the rb_node.
