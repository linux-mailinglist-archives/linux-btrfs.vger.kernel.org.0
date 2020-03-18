Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C0189E2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCROov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 10:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCROov (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 10:44:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20880ACAE;
        Wed, 18 Mar 2020 14:44:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2D61DA70E; Wed, 18 Mar 2020 15:44:21 +0100 (CET)
Date:   Wed, 18 Mar 2020 15:44:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/2] Drop some mis-uses of READA
Message-ID: <20200318144421.GZ12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200313210954.148686-1-josef@toxicpanda.com>
 <91bf00f3-a851-2e84-4213-761b0d776af2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91bf00f3-a851-2e84-4213-761b0d776af2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 14, 2020 at 10:56:06AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/14 上午5:09, Josef Bacik wrote:
> > In debugging Zygo's huge commit delays I noticed we were burning a bunch of time
> > doing READA in cases where we don't need to.  The way READA works in btrfs is
> > we'll load up adjacent nodes and leaves as we walk down.  This is useful for
> > operations where we're going to be reading sequentially across the tree.
> > 
> > But for delayed refs we're looking up one bytenr, and then another one which
> > could be elsewhere in the tree.  With large enough extent trees this results in
> > a lot of unneeded latency.
> > 
> > The same applies to build_backref_tree, but that's even worse because we're
> > looking up backrefs, which are essentially randomly spread out across the extent
> > root.  Thanks,
> 
> There are quite some other locations abusing READA.
> 
> E.g. btrfs_read_block_groups(), where we're just searching for block
> group items. There is no guarantee that next block group item is in next
> a few leaves.
> 
> I guess it's a good time to review all READA abuse. Or would you mind me
> to do that?

If you find some clear example where the items are scattered over the
tree then yes. For the rest it would be good to put a comment that the
readahead really helps. Thanks.
