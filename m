Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2446325388
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhBYQa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 11:30:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:41560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhBYQaY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 11:30:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C90F8AC1D;
        Thu, 25 Feb 2021 16:29:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EF33DA790; Thu, 25 Feb 2021 17:27:50 +0100 (CET)
Date:   Thu, 25 Feb 2021 17:27:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] btrfs: Export qgroup_reserve_meta
Message-ID: <20210225162749.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-3-nborisov@suse.com>
 <c5936976-95af-b937-dbb8-6545bca70792@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5936976-95af-b937-dbb8-6545bca70792@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 23, 2021 at 07:42:48AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/2/23 上午12:40, Nikolay Borisov wrote:
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Considering how small the export is, I prefer this to be merged with
> next patch, as it's much easier to understand why we want to export the
> function.
> 
> And since it will be exported, may be it's a good idea to rename it as
> btrfs_qgroup_reserve_meta_atomic() or btrfs_qgroup_reserve_meta_noflush()?

Yes the exported functions should have the btrfs_ prefix and because
that needs changing all callers it's usually a good idea to do it in a
separate patch.

About the rename, using _atomic could be confusing as it has already two
other meanings in linux.  There's already __btrfs_qgroup_reserve_meta,
looking at all the other reserve_meta helpers, I think we can keep it as
btrfs_qgroup_reserve_meta, but the _noflush suffix also makes sense.
