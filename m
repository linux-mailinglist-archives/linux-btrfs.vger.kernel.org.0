Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806893DCE34
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 01:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhHAX4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 19:56:02 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:41738 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhHAX4C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 19:56:02 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 273671E00611;
        Mon,  2 Aug 2021 02:55:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1627862152; bh=YZbu3go+29iKmjG4uICL6C4vwDmYykuUpOb1hrz+mDM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=LKrZJzx5f+G19zAerd/mpK0xks3g09MyQULkOMC11N+EgohvqBxgXcdOZmPWiQWMv
         m12SOkpk9RiidjY/6yaqpzIiCGuVVsdXsM6NsXVQcmlgcA6RyQBZz1b9/gebI0pNrC
         zMdZuAjuBu+IgutY4Mm2NEIRi8roVGvcSfRLrZjk=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1C1D21E0060D;
        Mon,  2 Aug 2021 02:55:52 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 6HTN0R0gVWSr; Mon,  2 Aug 2021 02:55:51 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C642F1E0060B;
        Mon,  2 Aug 2021 02:55:51 +0300 (EEST)
Received: from nas (unknown [222.95.55.26])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 5F9251BE00BF;
        Mon,  2 Aug 2021 02:55:49 +0300 (EEST)
References: <20210801233549.25480-1-mpdesouza@suse.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, fdmanana@suse.com
Subject: Re: [PATCH] btrfs: send: Simplify send_create_inode_if_needed
Date:   Mon, 02 Aug 2021 07:55:03 +0800
In-reply-to: <20210801233549.25480-1-mpdesouza@suse.com>
Message-ID: <7dh43ekh.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSeEqpi1ihQnnWBgczqTY6IuClpKemsm5UmGeDUSOGfEoTWRWpmGloT3qk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 02 Aug 2021 at 07:35, Marcos Paulo de Souza 
<mpdesouza@suse.com> wrote:

> The out label is being overused, we can simply return if the 
> condition
> permits.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>
Reviewed-by: Su Yue <l@damenly.su>

--
Su
> ---
>  fs/btrfs/send.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 75cff564dedf..17cd67e41d3a 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2727,19 +2727,12 @@ static int 
> send_create_inode_if_needed(struct send_ctx *sctx)
>  	if (S_ISDIR(sctx->cur_inode_mode)) {
>  		ret = did_create_dir(sctx, sctx->cur_ino);
>  		if (ret < 0)
> -			goto out;
> -		if (ret) {
> -			ret = 0;
> -			goto out;
> -		}
> +			return ret;
> +		if (ret > 0)
> +			return 0;
>  	}
>
> -	ret = send_create_inode(sctx, sctx->cur_ino);
> -	if (ret < 0)
> -		goto out;
> -
> -out:
> -	return ret;
> +	return send_create_inode(sctx, sctx->cur_ino);
>  }
>
>  struct recorded_ref {
