Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FA4E477E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiCVU36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiCVU35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 16:29:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307913D01
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 13:28:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 67DF1210F0;
        Tue, 22 Mar 2022 20:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647980907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhfJZC2iGllad/joV2lNjp5VEWBOoiChNxCuYNSlbUk=;
        b=fCwBMIpTnr6PU+CZVpiSr2jhu0FUaEuESC2l/Edf+5FgePooeTWJklAX9t0IPMc+hh7LCn
        CAtAnI0KodZBWHMR2scrYZgnAz5OB0ZUK+CkNE8BTLxSTTe1ek86sPoXWPWoFh4tKyLkmF
        kK6uJgGTWxHVRoWgGfm5+XZSqWjXCg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647980907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhfJZC2iGllad/joV2lNjp5VEWBOoiChNxCuYNSlbUk=;
        b=xzUWp2d9GeFKImehFvnsNh4c21++BXD0T3Kp0y3fNv4BbXNhYCj4r/TvOCPzhoNW+tYlcu
        /Iy0Chu8RWbgGFAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5ACA1A3B83;
        Tue, 22 Mar 2022 20:28:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBF39DA818; Tue, 22 Mar 2022 21:24:24 +0100 (CET)
Date:   Tue, 22 Mar 2022 21:24:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v1 1/2] Add Btrfs messages to printk index
Message-ID: <20220322202424.GJ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jonathan Lassoff <jof@thejof.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
References: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 17, 2022 at 10:45:08AM -0700, Jonathan Lassoff wrote:
> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage this printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
> 
> So that detailed Btrfs messages are captured by this printk index, this patch
> wraps btrfs_printk and btrfs_handle_fs_error with macros.
> 
> PATCH v1
>   - Fix conditional: CONFIG_PRINTK should be CONFIG_PRINTK_INDEX
>   - Fix whitespace
> 
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>
> ---
>  fs/btrfs/ctree.h | 34 +++++++++++++++++++++++++++++-----
>  fs/btrfs/super.c |  6 +++---
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ebb2d109e8bb..afb860d0bf89 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3343,10 +3343,23 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
>  {
>  }
>  
> -#ifdef CONFIG_PRINTK
> +#ifdef CONFIG_PRINTK_INDEX
> +#define btrfs_printk(fs_info, fmt, args...)				\
> +do {									\
> +	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);\
> +	_btrfs_printk(fs_info, fmt, ##args);				\
> +} while (0)
> +__printf(2, 3)
> +__cold
> +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
> +#elif defined(CONFIG_PRINTK)
> +#define btrfs_printk(fs_info, fmt, args...)	\
> +do {						\
> +	_btrfs_printk(fs_info, fmt, ##args);	\

This is just a single statement, does it need the do { } while(0)
protection?

> +} while (0)
>  __printf(2, 3)
>  __cold
> -void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
> +void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
>  #else
>  #define btrfs_printk(fs_info, fmt, args...) \
>  	btrfs_no_printk(fs_info, fmt, ##args)
> @@ -3598,11 +3611,22 @@ do {								\
>  				  __LINE__, (errno));		\
>  } while (0)
>  
> +#ifdef CONFIG_PRINTK_INDEX
>  #define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
> -do {								\
> -	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,	\
> -			  (errno), fmt, ##args);		\
> +do {									\
> +	printk_index_subsys_emit(					\
> +		"BTRFS: error (device %s) in %s:%d: errno=%d %s",	\
> +		KERN_CRIT, fmt, ##args);				\

I've looked at printk_index_subsys_emit and it does not need the
arguments (##args), only the prefix, level and format, though the
arguments are consumed by the macro.

I'd rather keep it simple and drop ##args in this case, unless there are
plans to make use of that in the future.
