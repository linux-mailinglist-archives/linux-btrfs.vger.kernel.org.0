Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3783C77FEE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354726AbjHQULc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354817AbjHQULV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:11:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25C359B
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:11:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C33062185A;
        Thu, 17 Aug 2023 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692303078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5V5fGzI15T8qaik1ph3eK75OeM+yB/k4yKz3m98NmM=;
        b=V5oXCSzd+1UTtMVnCs2fIiFUrjke2BlBM3DpDbJ4tzb0z+lAgtXV6SHw4pMZ3VtnbAo6cM
        bYwr/6pscG2CWpm13yVYoq9IveFdcuVC7zjf4i91EwdThXhi17RPGkgRu7TnO0V4Pu8EVh
        jUdb7wUkzkKG2VzQwVa1XgukeNRwLxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692303078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5V5fGzI15T8qaik1ph3eK75OeM+yB/k4yKz3m98NmM=;
        b=2TcxyajHEGeOvkNXUfgluGC9eFHTH4M8nagMO8TMeFtUcUIr9HIzYy2GiZqgSHFA9uIncG
        M6xn53J73zvmjsBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 960B41392B;
        Thu, 17 Aug 2023 20:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N+vaI+Z+3mSNWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 20:11:18 +0000
Date:   Thu, 17 Aug 2023 22:04:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/7] btrfs-progs: subvol get-default: implement json
 format output
Message-ID: <20230817200449.GX2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230813094555.106052-7-christoph@c8h4.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813094555.106052-7-christoph@c8h4.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 11:45:01AM +0200, Christoph Heiss wrote:
> Implements JSON-formatted output for the `subvolume get-default` command
> using the `--format json` global option, much like it is implemented for
> other commands.
> 
> Signed-off-by: Christoph Heiss <christoph@c8h4.io>
> ---
>  cmds/subvolume.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index cb863ac7..f7076655 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -701,6 +701,8 @@ static DEFINE_SIMPLE_COMMAND(subvolume_snapshot, "snapshot");
>  static const char * const cmd_subvolume_get_default_usage[] = {
>  	"btrfs subvolume get-default <path>",
>  	"Get the default subvolume of a filesystem",
> +	HELPINFO_INSERT_GLOBALS,
> +	HELPINFO_INSERT_FORMAT,
>  	NULL
>  };
>  
> @@ -712,6 +714,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
>  	DIR *dirstream = NULL;
>  	enum btrfs_util_error err;
>  	struct btrfs_util_subvolume_info subvol;
> +	struct format_ctx fctx;
>  	char *path;
>  
>  	clean_args_no_options(cmd, argc, argv);
> @@ -731,7 +734,14 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
>  
>  	/* no need to resolve roots if FS_TREE is default */
>  	if (default_id == BTRFS_FS_TREE_OBJECTID) {
> -		pr_verbose(LOG_DEFAULT, "ID 5 (FS_TREE)\n");
> +		if (bconf.output_format == CMD_FORMAT_JSON) {
> +			fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
> +			fmt_print(&fctx, "ID", 5);
> +			fmt_end(&fctx);
> +		} else {
> +			pr_verbose(LOG_DEFAULT, "ID 5 (FS_TREE)\n");
> +		}
> +
>  		ret = 0;
>  		goto out;
>  	}
> @@ -748,8 +758,17 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
>  		goto out;
>  	}
>  
> -	pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
> -	       subvol.id, subvol.generation, subvol.parent_id, path);
> +	if (bconf.output_format == CMD_FORMAT_JSON) {
> +		fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
> +		fmt_print(&fctx, "ID", subvol.id);
> +		fmt_print(&fctx, "gen", subvol.generation);
> +		fmt_print(&fctx, "top level", subvol.parent_id);
> +		fmt_print(&fctx, "path", path);
> +		fmt_end(&fctx);

Such block can be in a helper and used for 'list' and 'get-default' so
it's unified.

> +	} else {
> +		pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
> +		       subvol.id, subvol.generation, subvol.parent_id, path);

The formatter always prints '\n' at the end of the plain text values, so
with a minor update the same helper can be used to produce the plain
output.
