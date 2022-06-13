Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547495482FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiFMJOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbiFMJNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 05:13:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C013CE4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 02:13:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4904C1F8C3;
        Mon, 13 Jun 2022 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655111625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yofaKPhQ52emHiRVnyC/ES1BEphbsJL3yP2Q3Fv9mqc=;
        b=krpbjk6lwgayaWXiE/DYIUp2Tngq7M8bxugdkB+h6CKR80ghgmXVdbDKJMxm/bwle9Dro/
        iUPzE+OsRUe8ZQqtu5KoaS5NVOQg9wGitBJFvsRv2yu1cV36zt0d1WE+z22BSqUdGBGCt5
        MkRciEjf2zuLOwa4/7Kw/4kjxXgIEJo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 215CB134CF;
        Mon, 13 Jun 2022 09:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2K11Bcn/pmIIPAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Jun 2022 09:13:45 +0000
Message-ID: <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
Date:   Mon, 13 Jun 2022 12:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.22 г. 10:06 ч., Qu Wenruo wrote:
> Since btrfs-progs v4.1, mkfs.btrfs will reserve the first 1MiB for the
> primary super block (at offset 64KiB) and other legacy bootloaders which
> may want to store their data there.
> 
> Kernel is doing the same behavior around the same time.
> 
> However in kernel we just use SZ_1M to express the reserved space, normally
> with extra comments when using above SZ_1M.
> 
> Here we introduce a new macro, BTRFS_DEFAULT_RESERVED to replace such
> SZ_1M usage.
> 
> This will make later enlarged per-dev reservation easier to implement.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.h       |  7 +++++++
>   fs/btrfs/extent-tree.c |  6 +++---
>   fs/btrfs/super.c       | 10 +++++-----
>   fs/btrfs/volumes.c     |  7 +------
>   4 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7afdfd0bae7..62028e7d5799 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -229,6 +229,13 @@ struct btrfs_root_backup {
>   #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
>   #define BTRFS_SUPER_INFO_SIZE			4096
>   
> +/*
> + * The default reserved space for each device.
> + * This range covers the primary superblock, and some other legacy programs like
> + * older bootloader may want to store their data there.
> + */
> +#define BTRFS_DEFAULT_RESERVED			(SZ_1M)
> +

The name of this macros is too generic and uninformative. How about 
BTRFS_BOOT_RESERVED or simply BTRFS_RESERVED_SPACE, because 
BTRFS_DEFAULT_RESERVED implies  there is something else, apart from 
"default" and there won't be ...

<snip>
