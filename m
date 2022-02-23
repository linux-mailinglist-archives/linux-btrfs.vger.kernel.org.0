Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6C4C16C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbiBWP2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 10:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiBWP2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 10:28:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27256593BC;
        Wed, 23 Feb 2022 07:27:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D097A21637;
        Wed, 23 Feb 2022 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645630073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3FUhPQarNWrhGr4m2gNeysZcuzjEBU8QonfmZqFkhwg=;
        b=Gwx4JXhqNYI+8pCgbWW5r6+eUYyL9vqm2RRPkC7EMCHlmj5rplJGjMI0Z3oomsH96JlZMX
        Ftjo93oJcMmZN9WVx9ZREiwTpwMPJRrrA33JknO94BqsEJi90rdvITSZUWd2LewXxsOkgq
        GYqQMTQ0GTEaYRoizFVFlAzZ02xdSsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645630073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3FUhPQarNWrhGr4m2gNeysZcuzjEBU8QonfmZqFkhwg=;
        b=2/L9RvuUBNywcU0Y+N+TaZUkAOiL2ZjWGKn7MAHm5CUmDDnO0r8sO45ce62PSJMojqBeZ1
        5TbJbuQcQy65DoAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C4741A3B87;
        Wed, 23 Feb 2022 15:27:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45407DA7F7; Wed, 23 Feb 2022 16:24:05 +0100 (CET)
Date:   Wed, 23 Feb 2022 16:24:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: add fs state details to error messages.
Message-ID: <20220223152405.GO12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <8a2a73ab4b48a4e73d24cf7f10cc0fe245d50a84.1645562216.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2a73ab4b48a4e73d24cf7f10cc0fe245d50a84.1645562216.git.sweettea-kernel@dorminy.me>
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

On Tue, Feb 22, 2022 at 03:42:28PM -0500, Sweet Tea Dorminy wrote:
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -66,6 +66,46 @@ static struct file_system_type btrfs_root_fs_type;
>  
>  static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>  
> +#define STATE_STRING_PREFACE ": state "
> +#define STATE_STRING_BUF_LEN \
> +	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
> +
> +/* Characters to print to indicate error conditions. RO is not an error. */
> +static const char * const fs_state_strings[] = {
> +	[BTRFS_FS_STATE_ERROR]			= "E",
> +	[BTRFS_FS_STATE_REMOUNTING]		= "M",
> +	[BTRFS_FS_STATE_RO]			= NULL,
> +	[BTRFS_FS_STATE_TRANS_ABORTED]		= "A",
> +	[BTRFS_FS_STATE_DEV_REPLACING]		= "P",
> +	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= NULL,
> +	[BTRFS_FS_STATE_NO_CSUMS]		= NULL,
> +	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= "L",

Yeah that's the idea with the table, but I think you don't need to use
strings, it should be sufficient to use chars, and 0 works for the empty
ones.  The way you did it consumes more memory and has indirection with
the pointers to the actual single letter strings.

I'm not sure if we want the non-error states like remounting or
replacing, but actually why not, even if it's a transient state it's
another piece of information that could be useful eventually.
