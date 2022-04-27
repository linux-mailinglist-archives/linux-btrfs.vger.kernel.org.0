Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD6511AF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiD0OyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiD0OyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 10:54:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417240E7B
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:51:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D97241F37B
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651071067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sN5PaeF2fLPGmD+pgQjb+llmR1C+kutongU4h9o6eTg=;
        b=cxoDT/PRKcxlreDiREMJ4ZDQJD8Tze7CYBOwGbv6VOi+XF35uSjA45JrpazVf1Kjn3nv2Q
        x+CV7CZgWBO7uKXV/9GEubOcH//ljCzyO3UtIepH/aAwdRDFmrX4O3R8FyfplQmgWoKnJP
        zcvwJiSVJvtlfUEp/ww6DgDchc9El0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8F8613A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pjhWK1tYaWIVAwAAMHmgww
        (envelope-from <gniebler@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:51:07 +0000
Message-ID: <b110e69e-d371-a29e-fd89-f810a4391e7b@suse.com>
Date:   Wed, 27 Apr 2022 16:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220426214525.14192-1-gniebler@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220426214525.14192-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 26.04.22 um 23:45 schrieb Gabriel Niebler:
> … rename it to simply fs_roots and adjust all usages of this object to use
> the XArray API, because it is notionally easier to use and unserstand, as
> it provides array semantics, and also takes care of locking for us,
> further simplifying the code.
> 
> Also do some refactoring, esp. where the API change requires largely
> rewriting some functions, anyway.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>   fs/btrfs/ctree.h       |   5 +-
>   fs/btrfs/disk-io.c     | 176 ++++++++++++++++++++---------------------
>   fs/btrfs/inode.c       |  13 +--
>   fs/btrfs/transaction.c |  67 +++++++---------
>   4 files changed, 126 insertions(+), 135 deletions(-)
> 
> [...]
> @@ -2346,28 +2340,23 @@ void btrfs_put_root(struct btrfs_root *root)
>   
>   void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
>   {
> -	int ret;
> -	struct btrfs_root *gang[8];
> -	int i;
> +	struct btrfs_root *root;
> +	unsigned long index = 0;
>   
>   	while (!list_empty(&fs_info->dead_roots)) {
> [...]   
> -		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
> -			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
> -		btrfs_put_root(gang[0]);
> +		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state))
> +			btrfs_drop_and_free_fs_root(fs_info, root);
> +		btrfs_put_root(root);

It occurs to me that BTRFS_ROOT_IN_RADIX should probably be renamed to 
something else within or following this patch...

... but what to rename it /to/?

Naming things is hard. Here are some ideas I've had:

BTRFS_ROOT_IN_XARRAY is obvious, but it also includes kind of a needless 
implementation detail.

BTRFS_ROOT_IN_(FS_)ROOTS would be technically accurate, but might be 
confusing for the reader (e.g. if they don't know about 
btrfs_fs_indo->fs_roots of the top off their head).

BTRFS_ROOT_IN_FS_INFO_ROOTS makes that a bit clearer (someone might 
think it refers to fbtrfs_fs_info->roots, but when they find that 
doesn't exist they'd quickly catch on, I think), but a bit lengthy.

BTRFS_ROOT_IN_FS_INFO_FS_ROOTS is probably the most accurate, but really 
quite long...

Does anyone else have any ideas?
