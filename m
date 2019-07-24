Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E207339B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfGXQX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 12:23:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfGXQX4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 12:23:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9680FACB4;
        Wed, 24 Jul 2019 16:23:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 935EEDA808; Wed, 24 Jul 2019 18:24:32 +0200 (CEST)
Date:   Wed, 24 Jul 2019 18:24:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: ctree: Checking key orders before merged tree
 blocks
Message-ID: <20190724162432.GR2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-6-wqu@suse.com>
 <ba828afc-46b9-b48f-1b05-e5bd3b78af6e@suse.com>
 <3547c87e-5da0-d4d5-0c37-9e4957a2d390@gmx.com>
 <49581349-af2d-f800-c3fc-095ef96ab755@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49581349-af2d-f800-c3fc-095ef96ab755@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 10, 2019 at 03:12:37PM +0300, Nikolay Borisov wrote:
> On 10.07.19 г. 15:02 ч., Qu Wenruo wrote:
> > On 2019/7/10 下午7:19, Nikolay Borisov wrote:
> >> nit: I wonder if it will make it a bit easier to reason about the code
> >> if that function is renamed to valid_cross_block_key_order and make it
> >> return true or false, then it's callers will do if
> >> (!valid_cross_block_key_ordered) {
> >> return -EUCLEAN
> >> }>
> > I'm always uncertain what's the correct schema for check function.
> > 
> > Sometimes we have bool check_whatever() sometimes we have bool
> > is_whatever(), and sometimes we have int check_whatever().
> > 
> > If we have a good guidance for btrfs, it will be a no-brain choice.
> 
> There is no such guidance in this case my logic is that this function
> really returns a boolean value - 0 or -EUCLEAN to make that explicit I'd
> define it as returning bool and rename it to valid_cross_block_key_order
> to really emphasize the fact it's a predicated-type of function. Thus if
> someone reads the they will be certain that this function return either
> true or false depending on whether the input parameters make sense.

Also what
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#function-return-values-and-names
says.

Int in place of bool is in the old code, we should use bool in new code,
and convert the old code eventually. The naming of predicates prefixed
wich check_ sounds understandable to me, like going through a check
list, if it's ok continue, otherwise exit.

	if (check_this_is_fine())
		goto out_it_is_not;

Using 'is_' could be possible in some cases, and eg. for is_fstree or
is_bad_inode is ok.

> Whereas right now I will have to go and look at the implementation to
> determine what are the return values because of the "int" return type.
> 
> Again, that's just me and if you deem it doesn't bring value then feel
> free to ignore it.

I think this becomes important in a large code base that btrfs is slowly
turning into, so it's not just you. As I have to read a lot of code I
can notice patterns that are easy to understand and where checking other
files is necessary, which takes time and is distracting. New code should
follow the best practices and old code should be updated when changed.
