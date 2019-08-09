Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB19687B3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406904AbfHINeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:34:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406662AbfHINeM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 09:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F756AC9A
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 13:34:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FC74DA7C5; Fri,  9 Aug 2019 15:34:42 +0200 (CEST)
Date:   Fri, 9 Aug 2019 15:34:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     WenRuo Qu <wqu@suse.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v1.1 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
Message-ID: <20190809133442.GC24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190807140843.2728-1-wqu@suse.com>
 <20190807140843.2728-2-wqu@suse.com>
 <20190808145407.GA8267@twin.jikos.cz>
 <23a97139-f304-5e01-6d42-5a05d9f5b62b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a97139-f304-5e01-6d42-5a05d9f5b62b@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 08, 2019 at 11:55:37PM +0000, WenRuo Qu wrote:
> 
> 
> On 2019/8/8 下午10:54, David Sterba wrote:
> > On Wed, Aug 07, 2019 at 10:08:41PM +0800, Qu Wenruo wrote:
> >> +
> >> +static int check_extent_item(struct extent_buffer *leaf,
> >> +			     struct btrfs_key *key, int slot)
> >> +{
> >> +	struct btrfs_fs_info *fs_info = leaf->fs_info;
> >> +	struct btrfs_extent_item *ei;
> >> +	bool is_tree_block = false;
> >> +	u64 ptr;	/* Current pointer inside inline refs */
> > 
> > While u64 is wide enough, I suggest to use unsigned long as the
> > intermediate type for pointer conversions.
> 
> In fact, we only need u32 for pointer.
> (u16 is enough for 0~64k-1 but I'm not sure if we would use 64K as offset)
> 
> So regular unsigned int should be enough?

No, ther's pointer arithmetic done, u32 is not guaranteed to contain a
pointer:

+       ptr = (u64)(struct btrfs_extent_item *)(ei + 1);

here

+
+       /* Check the special case of btrfs_tree_block_info */
+       if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
+               struct btrfs_tree_block_info *info;
+
+               info = (struct btrfs_tree_block_info *)ptr;

and here

+               if (btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL) {
+                       extent_err(leaf, slot,
+                       "invalid tree block info level, have %u expect [0, %u]",
+                                  btrfs_tree_block_level(leaf, info),
+                                  BTRFS_MAX_LEVEL - 1);
+                       return -EUCLEAN;
+               }
+               ptr = (u64)(struct btrfs_tree_block_info *)(info + 1);

etc

+       }
