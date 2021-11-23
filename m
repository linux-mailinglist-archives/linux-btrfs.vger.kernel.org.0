Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEF45AD9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 21:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhKWU4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 15:56:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60060 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhKWU4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 15:56:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70EAF212BA;
        Tue, 23 Nov 2021 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637700788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Yu0lr6ufDPm42/ErK0wJcSqMMMRxNGl4O0FTdu5kOM=;
        b=n34Zm36Fo4lcz8IEyh1m5UEH0xao6YzSOugwEkjNdXWZngX6Ys72AMwoHocWLCXzj0LTNw
        4IedT9YfbTIZmBZe0pL/AJ3xMG+O4cpPJMAAh1C6u9xTr02szu/aNd8J83XMlcVGLUmvqn
        DO1B8rny0mU/V/Pfoo/pYhO/3pheMTE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3942A139B7;
        Tue, 23 Nov 2021 20:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z4r2CrRUnWHKRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 20:53:08 +0000
Subject: Re: [PATCH 08/25] btrfs: remove BUG_ON() in find_parent_nodes()
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <be1a91360aa5e5eaae56cb09a90333f7da07b3a6.1636144971.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <adf7aeac-5e5c-f58b-b377-ebb6af808677@suse.com>
Date:   Tue, 23 Nov 2021 22:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <be1a91360aa5e5eaae56cb09a90333f7da07b3a6.1636144971.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 22:45, Josef Bacik wrote:
> We search for an extent entry with .offset = -1, which shouldn't be a
> thing, but corruption happens.  Add an ASSERT() for the developers,
> return -EUCLEAN for mortals.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/backref.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 12276ff08dd4..7d942f5d6443 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1210,7 +1210,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
>  	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  	if (ret < 0)
>  		goto out;
> -	BUG_ON(ret == 0);
> +	if (ret == 0) {
> +		/* This shouldn't happen, indicates a bug or fs corruption. */
> +		ASSERT(ret != 0);

This can never trigger in this branch, because ret is guaranteed to be 0
o_O?

> +		ret = -EUCLEAN;
> +		goto out;
> +	}
>  
>  	if (trans && likely(trans->type != __TRANS_DUMMY) &&
>  	    time_seq != BTRFS_SEQ_LAST) {
> 
