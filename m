Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C74DC013
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiCQHWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiCQHWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 03:22:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529219FF79
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 00:21:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E8241F38D;
        Thu, 17 Mar 2022 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647501659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqBawY4rbq3J00wjMu++gJSKNKc4/UOIzYiQXt67/eQ=;
        b=PHoy81hw6kuaFhV3T+d8Vks6+VZT75HWQXcHQc1MPV1Cg9+V+6mnmLimwDfGs/2u2AHa4G
        DCaSl3BdKJQHZrWrDLfASY1N6a0xnglYkrBDCJCuhHtLe5XzaoUzWbGPGlTZsunluJ1s+3
        WgprWE8QKjhAoZSwUDfXD2zlp6xC9aA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B016E13B5B;
        Thu, 17 Mar 2022 07:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TiLnJ1rhMmJHXwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 17 Mar 2022 07:20:58 +0000
Message-ID: <e23301f7-5d5f-0a9c-7ae5-e9b521ef8b2b@suse.com>
Date:   Thu, 17 Mar 2022 09:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v0 0/1] Add Btrfs messages to printk index
Content-Language: en-US
To:     Jonathan Lassoff <jof@thejof.com>, linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
References: <fe7dcb58ac812fb6c37a92a1f74a42890c8c0bc8.1647493897.git.jof@thejof.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <fe7dcb58ac812fb6c37a92a1f74a42890c8c0bc8.1647493897.git.jof@thejof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.03.22 г. 7:13 ч., Jonathan Lassoff wrote:
> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage this printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
> 
> So that detailed Btrfs messages are captured by this printk index, this patch
> wraps btrfs_printk and btrfs_handle_fs_error with macros.
> 
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>
> ---
>   fs/btrfs/ctree.h | 28 ++++++++++++++++++++++++++--
>   fs/btrfs/super.c |  6 +++---
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ebb2d109e8bb..cc768f71d0a5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3344,9 +3344,22 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
>   }
>   
>   #ifdef CONFIG_PRINTK
> +#define btrfs_printk(fs_info, fmt, args...)                          \
> +do {                                                                 \
> +	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt); \
> +	_btrfs_printk(fs_info, fmt, ##args);                             \
> +} while (0)
>   __printf(2, 3)
>   __cold
> -void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
> +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
> +#elif defined(CONFIG_PRINTK)

But you already checked for #idef CONFIG_PRINTK ? In case CONFIG_PRINTK 
is not defined we'll call btrfs_no_printk as btrfs_printk would be 
compiled-out. So what's your intention here?

> +#define btrfs_printk(fs_info, fmt, args...)                          \
> +do {                                                                 \
> +	_btrfs_printk(fs_info, fmt, ##args);                             \
> +} while (0)
> +__printf(2, 3)
> +__cold
> +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
>   #else
>   #define btrfs_printk(fs_info, fmt, args...) \
>   	btrfs_no_printk(fs_info, fmt, ##args)
> @@ -3598,11 +3611,22 @@ do {								\
>   				  __LINE__, (errno));		\
>   } while (0)
>   


<snip>
