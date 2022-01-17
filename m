Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287E3490057
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiAQCuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:50:05 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:44344 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAQCuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:50:04 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 6527D1E00086;
        Mon, 17 Jan 2022 04:50:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642387803; bh=bsbG4lnT+zr08G/tRlKpwiSWnW0p1mjSDnvISc5myCE=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date;
        b=aSTax7+kSt/doPkFU3MlDNAkXIuN1t044thfyqbdp8n22V76rcNbxLpUwxIlc73J3
         FiTqLJpGovpP2kZSdEXGLwX3tyl+3Ucgbc4Ddfm3MArtS0Esh1mwvAuEVIdV6HyjV+
         ApgJuNK7WanlIj4HnJ82CnmmIyu8Cw/wOsKjsYGQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 4BA961E0008B;
        Mon, 17 Jan 2022 04:50:03 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id LMBy71Qz9tI4; Mon, 17 Jan 2022 04:50:01 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 864FA1E00086;
        Mon, 17 Jan 2022 04:50:01 +0200 (EET)
References: <20220117023850.40337-1-wqu@suse.com>
 <20220117023850.40337-3-wqu@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Stickstoff <stickstoff@posteo.de>
Subject: Re: [PATCH 2/3] btrfs: check/original: reject bad metadata backref
 with invalid level
Date:   Mon, 17 Jan 2022 10:48:29 +0800
In-reply-to: <20220117023850.40337-3-wqu@suse.com>
Message-ID: <1r17vzxp.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzQh1+nQ3rcDQU2qyxVL57ogYemsm5Un2eDUSOFfksTURS1g21yTGK6vjYX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 17 Jan 2022 at 10:38, Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> There is a bug report that kernel tree-checker rejected an 
> invalid
> metadata item:
>
>  corrupt leaf: block=934474399744 slot=68 extent 
>  bytenr=425173254144 len=16384 invalid tree level, have 33554432 
>  expect [0, 7]
>
> But original mode btrfs-check reports nothing wrong.
> (BTW, lowmem mode will just crash, and fixed in previous patch).
>
> [CAUSE]
> For original mode it doesn't really check tree level, thus 
> didn't find
> the problem.
>
> [FIX]
> I don't have a good idea to completely make original mode to 
> verify the
> level in backref and in the tree block (while lowmem does that).
>
> But at least we can detect obviouly corrupted level just like 
> kernel.
>
> Now original mode will detect such problem:
>
>  ...
>  [2/7] checking extents
>  ERROR: tree block 30457856 has bad backref level, has 256 
>  expect [0, 7]
>  ref mismatch on [30457856 16384] extent item 0, found 1
>  tree backref 30457856 root 5 not found in extent tree
>  backpointer mismatch on [30457856 16384]
>  ERROR: errors found in extent allocation tree or chunk 
>  allocation
>  [3/7] checking free space tree
>  ...
>
> Reported-by: Stickstoff <stickstoff@posteo.de>
> Link: 
> https://lore.kernel.org/linux-btrfs/6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/check/main.c b/check/main.c
> index 540130b8e223..2dea2acf5104 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5447,6 +5447,25 @@ static int process_extent_item(struct 
> btrfs_root *root,
>  	if (metadata)
>  		btrfs_check_subpage_eb_alignment(gfs_info, 
>  key.objectid, num_bytes);
>
> +	ptr = (unsigned long)(ei + 1);
> +	if (metadata) {
> +		u64 level;
> +
> +		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
> +			struct btrfs_tree_block_info *info;
> +
> +			info = (struct btrfs_tree_block_info 
> *)ptr;
> +			level = btrfs_tree_block_level(eb, info);
> +		} else {
> +			level = key.offset;
> +		}
> +		if (level >= BTRFS_MAX_LEVEL) {
> +			error(
> +	"tree block %llu has bad backref level, has %llu expect 
> [0, %u]",
> +			      key.objectid, level, BTRFS_MAX_LEVEL 
> - 1);
> +			return -EIO;
>
-EUCLEAN is better?

Reviewed-by: Su Yue <l@damenly.su>
--
Su
> +		}
> +	}
>  	memset(&tmpl, 0, sizeof(tmpl));
>  	tmpl.start = key.objectid;
>  	tmpl.nr = num_bytes;
