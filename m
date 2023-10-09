Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA57BE2CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjJIOaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376790AbjJIOaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 10:30:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75D99
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 07:30:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FE5A1F749;
        Mon,  9 Oct 2023 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696861800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBy9G3Gy876mJeDX8DEngz5/GMg6Ol0FA6D1k1Re+PQ=;
        b=AR/8TsgmqJWHbQm6A0j2622EqWai9t0jB9HXJnF261DXH7g3ykxXFYXL+HLebSh450hS7b
        9XFoZxcVOuGmFLFR7WyX7g7KNdJF8sNxnCjYDr69O0XiqSwskHsjk8NsglCWOmLwpT1tnf
        rv4dlOHAYDeI1uTpEL+TfTYnb9S3FpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696861800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBy9G3Gy876mJeDX8DEngz5/GMg6Ol0FA6D1k1Re+PQ=;
        b=P58gC/vL4EdytiTOYUPk1KsacCltJMIwflv6WU9NO0NpldyNShwdmcDhdyjKWk6lW9wk4z
        XrLrdW5Hg61MvmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D51C713905;
        Mon,  9 Oct 2023 14:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dQ5SM2cOJGUQEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 14:29:59 +0000
Date:   Mon, 9 Oct 2023 16:23:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: move inode cache removal to rescue group
Message-ID: <20231009142314.GP28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696826531.git.wqu@suse.com>
 <1d5cc97d664fc10c0244ff2c255f2fc4bbf58dfa.1696826531.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5cc97d664fc10c0244ff2c255f2fc4bbf58dfa.1696826531.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 03:17:00PM +1030, Qu Wenruo wrote:
> The option "--clear-ino-cache" is not really that suitable for "btrfs
> check" group.
> 
> Let's move it to "btrfs rescue" group to fix those small hiccups, just
> like the existing "btrfs rescue fix-device-size" command.
> 
> For now, "btrfs check --clear-ino-cache" would still work, with one
> extra warning referring to "btrfs rescue clear-ino-cache".
> This is mostly to reduce the surprise, and keep script users (I doubt if
> there is any though) happy for now.
> 
> In the next or two releases, we would fully remove the support in "btrfs
> check" group.
> 
> Another small change is, in the documents, we refer to the feature as
> "inode map", which doesn't match with the mount option documents.
> Since we're here, unify them to "inode cache" feature.
> 
> Issue: #669
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please don't forget to add the new command to btrfs-completion. I've
noticed 2 more were missing so it's done in a separate commit.

> ---
>  Documentation/btrfs-check.rst  |  5 +++-
>  Documentation/btrfs-rescue.rst |  6 ++++
>  check/main.c                   |  1 +
>  cmds/rescue.c                  | 52 ++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
> index cf8de9fcc888..3c5f96f1951f 100644
> --- a/Documentation/btrfs-check.rst
> +++ b/Documentation/btrfs-check.rst
> @@ -84,8 +84,11 @@ SAFE OR ADVISORY OPTIONS
>          See also the *clear_cache* mount option.
>  
>  --clear-ino-cache
> -        remove leftover items pertaining to the deprecated inode map feature
> +        remove leftover items pertaining to the deprecated `inode cache` feature
>  
> +	.. warning::
> +		This option is deprecated, please use `btrfs rescue clear-ino-cache`
> +		instead, this option would be removed in the future eventually.
>  
>  DANGEROUS OPTIONS
>  -----------------
> diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
> index 39d250cefa48..e99aa4ad8a7e 100644
> --- a/Documentation/btrfs-rescue.rst
> +++ b/Documentation/btrfs-rescue.rst
> @@ -50,6 +50,12 @@ fix-device-size <device>
>  
>                  WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
>  
> +clear-ino-cache <device>
> +        Remove leftover items pertaining to the deprecated `inode cache` feature.
> +
> +	The `inode cache` feature (enabled by mount option "inode_cache") is
> +	fully removed in v5.11 kernel.
> +
>  clear-uuid-tree <device>
>          Clear UUID tree, so that kernel can re-generate it at next read-write
>          mount.
> diff --git a/check/main.c b/check/main.c
> index 1174939fd6eb..7760511b85d9 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10242,6 +10242,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	}
>  
>  	if (clear_ino_cache) {
> +		warning("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead.")

No "." at the end of the text and the ";" is missing, does not
compile.

>  		ret = clear_ino_cache_items(gfs_info);
>  		err = ret;
>  		goto close_out;
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index be6f5016d5a9..38f4e1423434 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -34,6 +34,7 @@
>  #include "common/utils.h"
>  #include "common/help.h"
>  #include "common/open-utils.h"
> +#include "common/clear-cache.h"
>  #include "cmds/commands.h"
>  #include "cmds/rescue.h"
>  
> @@ -405,6 +406,56 @@ out:
>  }
>  static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree");
>  
> +static const char * const cmd_rescue_clear_ino_cache_usage[] = {
> +	"btrfs rescue clear-ino-cache <device>",
> +	"remove leftover items pertaining to the deprecated inode cache feature",
> +	NULL
> +};
> +
> +static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
> +				      int argc, char **argv)
> +{
> +	struct open_ctree_args oca = { 0 };
> +	struct btrfs_fs_info *fs_info;
> +	char *devname;
> +	int ret;
> +
> +	clean_args_no_options(cmd, argc, argv);
> +
> +	if (check_argc_exact(argc, 2))
> +		return 1;
> +
> +	devname = argv[optind];
> +	ret = check_mounted(devname);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("could not check mount status: %m");
> +		goto out;
> +	} else if (ret) {
> +		error("%s is currently mounted", devname);
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	oca.filename = devname;
> +	oca.flags = OPEN_CTREE_WRITES;
> +	fs_info = open_ctree_fs_info(&oca);
> +	if (!fs_info) {
> +		error("could not open btrfs");
> +		ret = -EIO;
> +		goto out;
> +	}
> +	ret = clear_ino_cache_items(fs_info);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to clear ino cache: %m");
> +	} else {
> +		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache");
> +	}
> +out:
> +	return !!ret;
> +}
> +static DEFINE_SIMPLE_COMMAND(rescue_clear_ino_cache, "clear-ino-cache");
> +
>  static const char rescue_cmd_group_info[] =
>  "toolbox for specific rescue operations";
>  
> @@ -416,6 +467,7 @@ static const struct cmd_group rescue_cmd_group = {
>  		&cmd_struct_rescue_fix_device_size,
>  		&cmd_struct_rescue_create_control_device,
>  		&cmd_struct_rescue_clear_uuid_tree,
> +		&cmd_struct_rescue_clear_ino_cache,
>  		NULL
>  	}
>  };
> -- 
> 2.42.0
