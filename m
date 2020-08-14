Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5560D24460B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHNH7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 03:59:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgHNH7k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 03:59:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E920DABE2;
        Fri, 14 Aug 2020 08:00:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 823ECDA6EF; Fri, 14 Aug 2020 09:58:36 +0200 (CEST)
Date:   Fri, 14 Aug 2020 09:58:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 4/4] btrfs: ctree: Checking key orders before merged
 tree blocks
Message-ID: <20200814075836.GS2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-5-wqu@suse.com>
 <20200813142121.GJ2026@twin.jikos.cz>
 <455de733-ce1a-0c4f-19c9-6503d8bf9bca@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <455de733-ce1a-0c4f-19c9-6503d8bf9bca@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 08:54:27AM +0800, Qu Wenruo wrote:
> On 2020/8/13 下午10:21, David Sterba wrote:
> > On Wed, Aug 12, 2020 at 02:05:09PM +0800, Qu Wenruo wrote:
> [...]
> >> ---
> >>  fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >>
> >> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> >> index 70e49d8d4f6c..497abb397ea1 100644
> >> --- a/fs/btrfs/ctree.c
> >> +++ b/fs/btrfs/ctree.c
> >> @@ -3159,6 +3159,52 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
> >>  		fixup_low_keys(path, &disk_key, 1);
> >>  }
> >>
> >> +/*
> >> + * Check the cross tree block key ordering.
> >> + *
> >> + * Tree-checker only works inside one tree block, thus the following
> >> + * corruption can not be rejected by tree-checker:
> >> + * Leaf @left			| Leaf @right
> >> + * --------------------------------------------------------------
> >> + * | 1 | 2 | 3 | 4 | 5 | f6 |   | 7 | 8 |
> >> + *
> >> + * Key f6 in leaf @left itself is valid, but not valid when the next
> >> + * key in leaf @right is 7.
> >> + * This can only be checked at tree block merge time.
> >> + * And since tree checker has ensured all key order in each tree block
> >> + * is correct, we only need to bother the last key of @left and the first
> >> + * key of @right.
> >> + */
> >> +static bool valid_cross_tree_key_order(struct extent_buffer *left,
> >> +				       struct extent_buffer *right)
> >
> > I think this naming is confusing, my first thought was that keys from
> > two trees were being checked, but this is for two leaves in the same
> > tree.
> >
> > The arguments should be constified.
> >
> > Elsewhere we use a check_<something> naming scheme with return value
> > true - problem, and 0/false - all ok. The 'valid' is the reverse and
> > also not following the scheme.
> 
> Any good candidate?
> 
> My current top list candidate is, check_sibling_keys().

That sounds perfect.
