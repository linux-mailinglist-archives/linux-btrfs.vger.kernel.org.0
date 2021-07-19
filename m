Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015593CCBD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 02:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGSAnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 20:43:21 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:33150 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhGSAnV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 20:43:21 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 7FEEA1E005B3;
        Mon, 19 Jul 2021 03:40:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1626655221; bh=IT5yDM3zS+6G+oUKx9PDUHKkkOMJHUGK8SW3799D4TA=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=bJAkOq8FN5S/tuj+W6JLNtGEkPS5zPY72QrRmlo2QDpAlqZXKJa1IFtoCUBOFs4pf
         2hdosYaylp8ba9+pH9/ObXrn8M63sGvwtTykVlfRrfwrZPZQquNgfR8jFCBPOOlNhq
         cSk0PdohWNIc/tE6N68rcpXTxRHY6X4cS5gpCS1U=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 7381F1E005BD;
        Mon, 19 Jul 2021 03:40:21 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id cnQ9A6Kj6JOe; Mon, 19 Jul 2021 03:40:21 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 332A21E005B3;
        Mon, 19 Jul 2021 03:40:21 +0300 (EEST)
Received: from nas (unknown [103.138.53.19])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id F15C71BE019A;
        Mon, 19 Jul 2021 03:40:19 +0300 (EEST)
References: <20210718125449.311815-1-wqu@suse.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: check/original: detect directory inode
 with nlinks >= 2
Date:   Mon, 19 Jul 2021 08:39:11 +0800
In-reply-to: <20210718125449.311815-1-wqu@suse.com>
Message-ID: <lf63w2z5.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7PFSeEqpi1ihQnnWBgczqTYwPODk++Sk0R5Rgn75Ly+NYjtzXVDo3XAUPnG6og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun 18 Jul 2021 at 20:54, Qu Wenruo <wqu@suse.com> wrote:

> Linux VFS doesn't allow directory to have hard links, thus for 
> btrfs
> on-disk directory inode items, their nlinks should never go 
> beyond 1.
>
> Lowmem mode already has the check and will report it without 
> problem.
> Only original mode needs this update.
>
> Reported-by: Pepperpoint <pepperpoint@mb.ardentcoding.com>
> Link: 
> https://lore.kernel.org/linux-btrfs/162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
Reviewed-by: Su Yue <l@damenly.su>

--
Su
> ---
>  check/main.c          | 7 +++++++
>  check/mode-original.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/check/main.c b/check/main.c
> index ee6cf793251c..df2303939ffe 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -623,6 +623,9 @@ static void print_inode_error(struct 
> btrfs_root *root, struct inode_record *rec)
>  			rec->imode & ~07777);
>  	if (errors & I_ERR_INVALID_GEN)
>  		fprintf(stderr, ", invalid inode generation or transid");
> +	if (errors & I_ERR_INVALID_NLINK)
> +		fprintf(stderr, ", directory has invalid nlink %d",
> +			rec->nlink);
>  	fprintf(stderr, "\n");
>
>  	/* Print the holes if needed */
> @@ -909,6 +912,10 @@ static int process_inode_item(struct 
> extent_buffer *eb,
>  	if (S_ISLNK(rec->imode) &&
>  	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
>  		rec->errors |= I_ERR_ODD_INODE_FLAGS;
> +
> +	/* Directory should never have hard link */
> +	if (S_ISDIR(rec->imode) && rec->nlink >= 2)
> +		rec->errors |= I_ERR_INVALID_NLINK;
>  	/*
>  	 * We don't have accurate root info to determine the correct
>  	 * inode generation uplimit, use super_generation + 1 anyway
> diff --git a/check/mode-original.h b/check/mode-original.h
> index b075a95c9757..eed16d92d0db 100644
> --- a/check/mode-original.h
> +++ b/check/mode-original.h
> @@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
>  #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
>  #define I_ERR_INVALID_IMODE		(1 << 19)
>  #define I_ERR_INVALID_GEN		(1 << 20)
> +#define I_ERR_INVALID_NLINK		(1 << 21)
>
>  struct inode_record {
>  	struct list_head backrefs;
