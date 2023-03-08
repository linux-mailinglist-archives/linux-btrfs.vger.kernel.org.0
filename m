Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872026B0FED
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCHRM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCHRMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 12:12:55 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F39A5D7
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 09:12:53 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17671fb717cso17907332fac.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Mar 2023 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295572;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/qbY4+KJZ6Ge0yWKCznoEdR/JvWY2Qi1jqDjpGsaN8=;
        b=OLOgMj0EiuocH8sfSrCsEVFguXz5Mdezr0ZUPLz1bZ6fl7LGkkf3bnfJrmYoVEoSOK
         WpQggR0sMWAWv9DA0bmp/BklGjH41WE3BshnZ6q3yWUg0WJsli0MXLh3tESoW1/hqkK+
         w+HzgoU3HgeP7BDZowDBt+WSXT/daGWf9LhtxqcacDrnNFef0tOPEt0PbJl2hTD3w/8h
         o+DluYSCdWdksw7KvAIKWrfv8BoRt0HJETaXcADoXP5MdJSeoV/ILaBfP9VAuH3nmdCp
         RxNompXvPheeaYPo8SW3ru4lXWXhJdJvIAUTRJeAChwrzQoP8iULZvTbpMZyDyN1deW7
         gDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295572;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/qbY4+KJZ6Ge0yWKCznoEdR/JvWY2Qi1jqDjpGsaN8=;
        b=OSpG8Q3jk2Me2lGEozfKHsEiMYNlhqrAaRnY7V7b6NWCPuiXDOtX5eqbMl3IzD5lKN
         ecNvNBfk2srO6bjf8YcHk6e6rzod9r+P+fkmgXOFDUCQCNcgYQ2hIb1fe3HXx8lCNk2Y
         +UUm7hwVv8GoU9OFAZ9QCjKAEbAwEhSAMoTrg08TSSisXG+VZn7ujWmzj3E6EWc9bVhm
         a1oXu6Qk74vA+AB5JLbn8FsPoQ/PWxzX+MrbBXZYMxNccXzoiIrBNwkHgQ7IK30jEnJJ
         BPNsZ9ErdS3pBh0bZ1EJNWmTha0sYV84aXOAbsv2S53r20UubDJ8I6hfF9qtkc0KvU03
         9q8w==
X-Gm-Message-State: AO0yUKUv+QuIWZAMz/aimbXrFQB+FsdgS4dQI1zh+4YjfNStBosuof2F
        o7gqyQ1vcURkOJdedFc3uONQY2Js2eg=
X-Google-Smtp-Source: AK7set8wlSJaUj+CbH0MzNOqbIMrLZmS3Nc9USgPrCWiRk9jjWNuMPkX3jKEqhBfFnYFYJt0o3atAg==
X-Received: by 2002:a05:6870:5703:b0:172:7220:a9eb with SMTP id k3-20020a056870570300b001727220a9ebmr10758771oap.8.1678295572265;
        Wed, 08 Mar 2023 09:12:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10-20020a4a840a000000b00525398a1144sm6254840oog.32.2023.03.08.09.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:12:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6a21d9ae-a6ee-e5de-10f9-8a40b9a8f3f2@roeck-us.net>
Date:   Wed, 8 Mar 2023 09:12:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] btrfs: fix compilation error on sparc/parisc
In-Reply-To: <dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/8/23 07:58, Sweet Tea Dorminy wrote:
> Commit 1ec49744ba83 ("btrfs: turn on -Wmaybe-uninitialized") exposed
> that on sparc and parisc, gcc is unaware that fscrypt_setup_filename()
> only returns negative error values or 0. This ultimately results in a
> maybe-uninitialized warning in btrfs_lookup_dentry().
> 
> Change to only return negative error values or 0 from
> fscrypt_setup_filename() at the relevant callsite, and assert that no
> positive error codes are returned (which would have wider implications
> involving other users).
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net/
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>   fs/btrfs/inode.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 45102785c723..50178609f241 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5409,8 +5409,13 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
>   		return -ENOMEM;
>   
>   	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
> -	if (ret)
> +	if (ret < 0)
>   		goto out;
> +	/*
> +	 * fscrypt_setup_filename() should never return a positive value, but
> +	 * gcc on sparc/parisc thinks it can, so assert that doesn't happen.
> +	 */

Here is some food for thought:

1) Make sure that "location" is never initialized in btrfs_inode_by_name(),
    and that the functions returns a value >= 0.

2) compile. gcc never reports an error or warning (tested with 10.3, 11.3,
    and 12.2).

On x86, gcc doesn't report a problem even if I replace btrfs_inode_by_name()
with a simple "return 0;".

I looks like there is something else going on which prevents gcc on
architectures other than parisc and sparc from reporting uninitialized
stack variables (or at least uninitialized structure elements),
and I am not entirely sure if this should be blamed on the architecture.

More specifically and importantly, it may not be a good idea to expect
gcc to report potentially uninitialized variables on architectures
other than parisc and sparc.

Guenter

> +	ASSERT(ret == 0);
>   
>   	/* This needs to handle no-key deletions later on */
>   

