Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54FF2EB7BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAFBnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:43:19 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:52802 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFBnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 20:43:19 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 33A9244DE4E;
        Wed,  6 Jan 2021 03:42:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609897352; bh=4EiieDBqUcbUMpyHp4WbkI/ly6FeMMXF1ZZK+UfRMIw=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=Slm6C9Fcif6mHEYYOu/ECbMoNK96dOfOigKGh8CSDFGEP7Fc6SeLPadGcS/GKRECC
         NgrAdC36/1J3LnJ1Uy0nJxq6SDV6H2Iu7sfqDeE6j2HnynIntK9OcdEP7eUWCrP71G
         bmZ+M+SKnNPIe5iDJ90oBOfGwPmN0Cwlx3X4D0IU=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 244ED44DE57;
        Wed,  6 Jan 2021 03:42:32 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id JotcWxYg7bnB; Wed,  6 Jan 2021 03:42:31 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 9DF4F44DE4E;
        Wed,  6 Jan 2021 03:42:31 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id CFB111BE00E9;
        Wed,  6 Jan 2021 03:42:29 +0200 (EET)
References: <845796bfab85f02919d64908b63f3f7201a2abb3.1609882807.git.josef@toxicpanda.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: properly exclude leaves for lowmem
In-reply-to: <845796bfab85f02919d64908b63f3f7201a2abb3.1609882807.git.josef@toxicpanda.com>
Message-ID: <v9calu2o.fsf@damenly.su>
Date:   Wed, 06 Jan 2021 09:42:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mkI9QEjm6g1u/QXjfGWRDoitPXOzn8+S71BtF/gj3MjL3AEVND1Cr7h97Nxyk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 06 Jan 2021 at 05:40, Josef Bacik <josef@toxicpanda.com> 
wrote:

> The lowmem mode excludes all referenced blocks from the 
> allocator in
> order to avoid accidentally overwriting blocks while fixing the 
> file
> system.  However for leaves it wouldn't exclude anything, it 
> would just
> pin them down, which gets cleaned up on transaction commit. 
> We're safe
> for the first modification, but subsequent modifications could 
> blow up
> in our face.  Fix this by properly excluding leaves as well as 
> all of
> the nodes.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>

LGTM.
Reviewed-by: Su Yue <l@damenly.su>
> ---
>  check/mode-common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/check/mode-common.c b/check/mode-common.c
> index a6489191..ef77b060 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -667,8 +667,12 @@ static int traverse_tree_blocks(struct 
> extent_buffer *eb, int tree_root, int pin
>
>  			/* If we aren't the tree root don't read the block */
>  			if (level == 1 && !tree_root) {
> -				btrfs_pin_extent(gfs_info, bytenr,
> -						 gfs_info->nodesize);
>
> +				if (pin)
> +					btrfs_pin_extent(gfs_info, bytenr,
> +							 gfs_info->nodesize);
> +				else
> +					set_extent_dirty(tree, bytenr,
> +							 gfs_info->nodesize);
>  				continue;
>  			}

