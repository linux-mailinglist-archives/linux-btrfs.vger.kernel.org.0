Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F741A0FC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgDGO64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 10:58:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbgDGO64 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 10:58:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9457CAE95;
        Tue,  7 Apr 2020 14:58:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CE9DDA727; Tue,  7 Apr 2020 16:57:52 +0200 (CEST)
Date:   Tue, 7 Apr 2020 16:57:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Move on-disk structure definition to btrfs_tree.h
Message-ID: <20200407145752.GU5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200407084434.46143-1-wqu@suse.com>
 <20200407131414.GS5920@twin.jikos.cz>
 <2751ebbf-dfc4-b453-b807-17e86be43929@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2751ebbf-dfc4-b453-b807-17e86be43929@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 09:43:12PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/4/7 下午9:14, David Sterba wrote:
> > On Tue, Apr 07, 2020 at 04:44:33PM +0800, Qu Wenruo wrote:
> >> These structures all are on-disk format. Move them to btrfs_tree.h
> >>
> >> This move includes:
> >> - btrfs magic
> >>   It's a surprise that it's not even definied in btrfs_tree.h
> >>
> >> - tree block max level
> >>   Move it before btrfs_header definition.
> >>
> >> - tree block backref revision
> >> - btrfs_header structure
> >> - btrfs_root_backup structure
> >> - btrfs_super_block structure
> >> - BTRFS_FEATURE_* flags
> >>
> >> - btrfs_item structure
> >> - btrfs_leaf structure
> >> - btrfs_key_ptr structure
> >> - btrfs_node structure
> >>
> >> - BTRFS_INODE_* flags
> >>   Move them before btrfs_inode_item definition.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> This moved btree_tree.h is more appropriate for btrfs-progs to reuse.
> > 
> > This actually answers 'why' the change is made so this should be in the
> > changelog but I still want to know the reason to move it to the header.
> > Do you mean that progs from git would be built #including this header
> > directly?
> > 
> No. As you answered a long long time before, btrfs-progs shouldn't
> include global kernel header directly.
> 
> Your answer was for case like building btrfs-progs on older kernel, and
> I still believe you're right.

Yes, this still holds.

> For btrfs-progs, I will just cross-port (copy) the header to btrfs-progs.
> 
> The re-use part doesn't only limit to btrfs-progs.
> In fact, there are already two more projects which can benefit from such
> move: grub and u-boot.
> 
> This patch is the base stone for later u-boot cross ports.
> The idea is to use kernel headers (copy them to related projects), then
> re-use a subset of btrfs-progs to implement a full read-only btrfs code
> base in u-boot.

Ok, I understand the motivation, copying and syncing header from one
source is what we want.
