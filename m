Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602B424F86
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfEUNBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 09:01:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbfEUNA7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 09:00:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A99F4AC6E;
        Tue, 21 May 2019 13:00:58 +0000 (UTC)
Date:   Tue, 21 May 2019 15:00:58 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>
Subject: Re: [PATCH v2 05/13] btrfs: dont assume compressed_bio sums to be 4
 bytes
Message-ID: <20190521130058.GB7200@x250>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-6-jthumshirn@suse.de>
 <8bb202e9-935d-eed8-f0d5-58f6a44bc991@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bb202e9-935d-eed8-f0d5-58f6a44bc991@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 03:56:09PM +0300, Nikolay Borisov wrote:
[...]
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
> >  	struct btrfs_ordered_sum *ordered_sum;
> >  	struct btrfs_ordered_extent *ordered;
> > -	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
> > +	struct btrfs_ordered_inode_tree *tree = &btrfs_inode->ordered_tree;
> >  	unsigned long num_sectors;
> >  	unsigned long i;
> >  	u32 sectorsize = btrfs_inode_sectorsize(inode);
> > 
> 
> Irrelevant change, this hunk could be dropped. Furthermore, I don't see
> how having an explicit variable brings any value apart from increased
> stack usage.
> 

I have no idea how and why this crept in, probably due to a rebase.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
