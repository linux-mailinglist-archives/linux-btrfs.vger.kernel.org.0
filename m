Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5952DD184
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgLQMbz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 07:31:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgLQMbz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 07:31:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6C4AACF9;
        Thu, 17 Dec 2020 12:31:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB900DA83A; Thu, 17 Dec 2020 13:29:33 +0100 (CET)
Date:   Thu, 17 Dec 2020 13:29:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: inode: remove variable shadowing in
 btrfs_invalidatepage()
Message-ID: <20201217122933.GM6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-3-wqu@suse.com>
 <cdc92e68-90be-d88e-85d7-5e7191d35cd0@suse.com>
 <b7c83de9-24e5-3702-96b3-467363ada642@suse.com>
 <b89449d9-9918-8f0f-2739-eae2fad7fe58@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b89449d9-9918-8f0f-2739-eae2fad7fe58@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 02:13:37PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/12/17 下午1:59, Nikolay Borisov wrote:
> > 
> > 
> > On 17.12.20 г. 7:55 ч., Nikolay Borisov wrote:
> >>
> >>
> >> On 17.12.20 г. 6:57 ч., Qu Wenruo wrote:
> >>> In btrfs_invalidatepage() we re-declare @tree variable as
> >>> btrfs_ordered_inode_tree.
> >>>
> >>> Remove such variable shadowing which can be very confusing.
> >>
> >> You can't do that, because lock_extent_bits expects extent_io_tree !
> >>
> > 
> > Ok, nvm, you just factored the var at the beginning of the functions.
> > OTOH since the ordered tree is used just for lock/unlock why not do
> > spin_(un)lock(&inode->ordered_tree->lock);
> > 
> Oh, that indeed looks better and since Su is also complaining about the 
> declaration at the beginning of the function, I guess that's the better 
> way to go.

The preferred style is to declare variables in the closest scope, so
there's not a huge blob of declarations that are randomly used inside
nested blocks. It's more like a recommendation, eg. when the function is
short and there are a few variables  used inside a for/while.
