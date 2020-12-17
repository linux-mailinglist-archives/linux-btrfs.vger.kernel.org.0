Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48842DCC1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 06:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLQFjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 00:39:42 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:55868 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgLQFjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 00:39:42 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 0A2284436CE;
        Thu, 17 Dec 2020 07:38:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1608183530; bh=QYKjDuaYl7PAf2VWVlYp7Wt/BqRZ80U53Nnn7YIioLE=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=KKH3IzaTrN0uRFrE0whu2WQc+ibC+ZglAbXCQ4lws0uTY0W5NA0FOq9ynL5q/gS7w
         C6OHCAf3Tq49xZ7w/rvbF9YGQjMUeqbEzq35gBZ215jHS2504sne29skJAvqjq0lhr
         nvAVuafUHLhZdFL9CKhqL6id2sy/s0Gs+yNW6gKg=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id F0389440B9B;
        Thu, 17 Dec 2020 07:38:49 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id GQnx0jHd3HzA; Thu, 17 Dec 2020 07:38:49 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 75EED44373A;
        Thu, 17 Dec 2020 07:38:49 +0200 (EET)
Received: from nas (unknown [117.89.173.90])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 4E47F1BE0090;
        Thu, 17 Dec 2020 07:38:48 +0200 (EET)
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-3-wqu@suse.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: inode: remove variable shadowing in
 btrfs_invalidatepage()
In-reply-to: <20201217045737.48100-3-wqu@suse.com>
Message-ID: <k0thhu00.fsf@damenly.su>
Date:   Thu, 17 Dec 2020 13:38:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlYtJBDatlF+mQGXXBRpV3CdLQJ6b9qflkAE76Hb7Ny6FfEAOURSxgR8FQA/Gog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 17 Dec 2020 at 12:57, Qu Wenruo <wqu@suse.com> wrote:

> In btrfs_invalidatepage() we re-declare @tree variable as
> btrfs_ordered_inode_tree.
>
> Remove such variable shadowing which can be very confusing.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index dced71bccaac..b4d36d138008 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8169,6 +8169,7 @@ static void btrfs_invalidatepage(struct 
> page *page, unsigned int offset,
>  				 unsigned int length)
>  {
>  	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> +	struct btrfs_ordered_inode_tree *ordered_tree = 
> &inode->ordered_tree;
>
Any reason for the declaration here? I didn't find that patch[3/4] 
use it.

>  	struct extent_io_tree *tree = &inode->io_tree;
>  	struct btrfs_ordered_extent *ordered;
>  	struct extent_state *cached_state = NULL;
> @@ -8218,15 +8219,11 @@ static void btrfs_invalidatepage(struct 
> page *page, unsigned int offset,
>  		 * for the finish_ordered_io
>  		 */
>  		if (TestClearPagePrivate2(page)) {
> -			struct btrfs_ordered_inode_tree *tree;
> -
Better to just rename the @tree to @ordered_tree.

> -			tree = &inode->ordered_tree;
> -
> -			spin_lock_irq(&tree->lock);
> +			spin_lock_irq(&ordered_tree->lock);
>  			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>  			ordered->truncated_len = min(ordered->truncated_len,
>  					start - ordered->file_offset);
> -			spin_unlock_irq(&tree->lock);
> +			spin_unlock_irq(&ordered_tree->lock);
>
>  			ASSERT(end - start + 1 < U32_MAX);
>  			if (btrfs_dec_test_ordered_pending(inode, &ordered,

