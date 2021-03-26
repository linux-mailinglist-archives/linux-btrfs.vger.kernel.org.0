Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79434A954
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZOLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 10:11:42 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57832 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCZOLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 10:11:17 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id E10776C00B6C;
        Fri, 26 Mar 2021 16:11:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1616767875; bh=hXfB0ov0ZEkszHB1du2tXMaw7Qr6kbhBZ0IwgeqcLEg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=k41cLDS9AssyGtU759I53RjGxXnY5tMabDP1AlYmbiQ3OyifhhLJWkEzZfWvlJbzl
         eGwHZWbsXmXT3H5n6uh9j7ug5qvwpNjmH3eJw7sqnYluY4fp6GVjmZzhndGCqIbvz/
         DIHAN4ZQ4Uq/KBnXhjTmALzVSHmN7NICyCuwb8eM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D3D686C00B6A;
        Fri, 26 Mar 2021 16:11:15 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id xM_cc2hrhoYg; Fri, 26 Mar 2021 16:11:15 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 4E80D6C00B27;
        Fri, 26 Mar 2021 16:11:15 +0200 (EET)
Received: from nas (unknown [45.87.95.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id A75931BE009E;
        Fri, 26 Mar 2021 16:11:13 +0200 (EET)
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-2-wqu@suse.com>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: image: remove the dead stat() call
Date:   Fri, 26 Mar 2021 22:08:36 +0800
In-reply-to: <20210326125047.123694-2-wqu@suse.com>
Message-ID: <sg4i6m4r.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBk3XhyTBXxmtCAQr1kpEWOj78+Ck2RhHmHPmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 26 Mar 2021 at 20:50, Qu Wenruo <wqu@suse.com> wrote:

> In restore_metadump(), we call stat() but never uses the result 
> get.
>
> This call site is left by some code refactor, as the stat() call 
> is now
> moved into fixup_device_size().
>
fixup_device_size() already calls fstat() on out_fd.

Reviewed-by: Su Yue <l@damenly.su>


> So we can safely remove the call.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  image/main.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/image/main.c b/image/main.c
> index 48070e52c21f..24393188e5e3 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2690,7 +2690,6 @@ static int restore_metadump(const char 
> *input, FILE *out, int old_restore,
>  	if (!ret && !multi_devices && !old_restore &&
>  	    btrfs_super_num_devices(mdrestore.original_super) != 1) {
>  		struct btrfs_root *root;
> -		struct stat st;
>
>  		root = open_ctree_fd(fileno(out), target, 0,
>  					  OPEN_CTREE_PARTIAL |
> @@ -2703,13 +2702,6 @@ static int restore_metadump(const char 
> *input, FILE *out, int old_restore,
>  		}
>  		info = root->fs_info;
>
> -		if (stat(target, &st)) {
> -			error("stat %s failed: %m", target);
> -			close_ctree(info->chunk_root);
> -			free(cluster);
> -			return 1;
> -		}
> -
>  		ret = fixup_chunks_and_devices(info, &mdrestore, 
>  fileno(out));
>  		close_ctree(info->chunk_root);
>  		if (ret)

