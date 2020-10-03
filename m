Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2659D281FEB
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Oct 2020 03:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJCBEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 21:04:49 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:39158 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJCBEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 21:04:49 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 1274F6C00736;
        Sat,  3 Oct 2020 04:04:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1601687087; bh=rP1SpII8IfYLyn/Duc/a2Uv9a8cxe5kZgqutMyfoNp4=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=lKHqTME3BKFdahpEWa9pHuudtFTOkciYRzgTKZPCThpMTMGxidgUt687HYEZHeO3N
         Z9MIOmSYChUOJitm1C6WWDlbK1FFJ1QHe7E0eOGwT38ePlFQzgS0UeDb5HK0XiHNQZ
         WCqVwd1BdaUIV8DIprCxJYtqcXJ2D5QHG5CuhCzQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 00CB26C0071E;
        Sat,  3 Oct 2020 04:04:47 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id dsh-QdpKNSkL; Sat,  3 Oct 2020 04:04:46 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 6826A6C0071B;
        Sat,  3 Oct 2020 04:04:46 +0300 (EEST)
Received: from nas (unknown [103.116.47.50])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 929CF1BE00ED;
        Sat,  3 Oct 2020 04:04:43 +0300 (EEST)
References: <20201003001151.1306-1-shipujin.t@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        hankinsea@gmail.com
Subject: Re: [PATCH] fs: tree-checker: fix missing brace warning for old
 compilers
In-reply-to: <20201003001151.1306-1-shipujin.t@gmail.com>
Message-ID: <tuvcnmqj.fsf@damenly.su>
Date:   Sat, 03 Oct 2020 09:04:36 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtKxjYrL+Dt55TE3V0G3GeDUSOFfksTURGxg2hxU3m4og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 03 Oct 2020 at 08:11, Pujin Shi <shipujin.t@gmail.com> 
wrote:

> For older versions of gcc, the array = {0}; will cause warnings:
>
So what's the version number of the gcc? "struct foo = { 0 }" 
should be
correct.

May be the compiler issue[1] related?

1: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119


> fs/btrfs/tree-checker.c: In function 'check_root_item':
> fs/btrfs/tree-checker.c:1038:9: warning: missing braces around 
> initializer [-Wmissing-braces]
>   struct btrfs_root_item ri = { 0 };
>          ^
> fs/btrfs/tree-checker.c:1038:9: warning: (near initialization 
> for 'ri.inode') [-Wmissing-braces]
>
> 1 warnings generated
>
> Fixes: 443b313c7ff8 ("btrfs: tree-checker: fix false alert 
> caused by legacy btrfs root item")
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index f0ffd5ee77bd..5028b3af308c 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1035,7 +1035,7 @@ static int check_root_item(struct 
> extent_buffer *leaf, struct btrfs_key *key,
>  			   int slot)
>  {
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
> -	struct btrfs_root_item ri = { 0 };
> +	struct btrfs_root_item ri = {};
>  	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
>  				     BTRFS_ROOT_SUBVOL_DEAD;
>  	int ret;

