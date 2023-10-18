Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065E7CDD70
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJRNhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJRNhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 09:37:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05154BA
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 06:37:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F35121A5E;
        Wed, 18 Oct 2023 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697636268;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ck1r7zmZ3fy3aK4NqCPnFBi2JIOCRtt0TSNmxbpA06c=;
        b=Dd7vARNZUQr7+z3kWXZ0FXVWPc0rqiiMEIkau27r7Y+el6Uy3qDor4YwiZ5f4ngM6mhF24
        6L8YCNNkk8oMn0hW/PFm9sBriXfrxaKVdcHDKJgA5rJXeRTLRXyNtemJRTMR4zUZxdcM7j
        XpitxsVPfcT81v+phHH0e5eq28anyfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697636268;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ck1r7zmZ3fy3aK4NqCPnFBi2JIOCRtt0TSNmxbpA06c=;
        b=0WKdvijdAlkA4AGgNhv3z4g98D8IQguiRQO0wG38JILEeNsDQjn8vNxtZnBdcy/VcHjcMC
        WY7I5fIUzFa2DICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56D8B13915;
        Wed, 18 Oct 2023 13:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEGSFKzfL2UPPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 Oct 2023 13:37:48 +0000
Date:   Wed, 18 Oct 2023 15:30:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: cmds: subvolume: add -p option on
 creating subvol
Message-ID: <20231018133057.GC26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220220031254.58297-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220031254.58297-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,libero.it];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FREEMAIL_CC(0.00)[cobb.uk.net,libero.it,vger.kernel.org]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 20, 2022 at 03:12:54AM +0000, Sidong Yang wrote:
> This patch resolves github issue #429. This patch adds an option that
> create parent directories when it creates subvolumes on nonexisting
> parents. This option tokenizes dstdir and checks each paths whether
> it's existing directory and make directory for creating subvolume.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2: fixed the case using realpath() that path nonexists, added
> description on docs.
> v3: added longopt, used strncpy_null than strcpy, use perm 0777

I've noticed the issue and this patch, sorry for the delay, now added to
devel.

> ---
>  Documentation/btrfs-subvolume.rst |  5 +++-
>  cmds/subvolume.c                  | 41 ++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
> index 4591d4bb..2c138154 100644
> --- a/Documentation/btrfs-subvolume.rst
> +++ b/Documentation/btrfs-subvolume.rst
> @@ -49,7 +49,7 @@ do not affect the files in the original subvolume.
>  SUBCOMMAND
>  -----------
>  
> -create [-i <qgroupid>] [<dest>/]<name>
> +create [options] [<dest>/]<name>
>          Create a subvolume *name* in *dest*.
>  
>          If *dest* is not given, subvolume *name* will be created in the current
> @@ -61,6 +61,9 @@ create [-i <qgroupid>] [<dest>/]<name>
>                  Add the newly created subvolume to a qgroup. This option can be given multiple
>                  times.
>  
> +        -p|--parents
> +                Make any missing parent directories for each argument.
> +
>  delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid> <path>
>          Delete the subvolume(s) from the filesystem.
>  
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index fbf56566..9c13839e 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
>  	"",
>  	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
>  	"               option can be given multiple times.",
> +	"-p|--parents   make any missing parent directories for each argument.",
>  	HELPINFO_INSERT_GLOBALS,
>  	HELPINFO_INSERT_QUIET,
>  	NULL
> @@ -105,10 +106,18 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  	char	*dst;
>  	struct btrfs_qgroup_inherit *inherit = NULL;
>  	DIR	*dirstream = NULL;
> +	bool create_parents = false;
>  
>  	optind = 0;
>  	while (1) {
> -		int c = getopt(argc, argv, "c:i:");
> +		int c;
> +		static const struct option long_options[] = {
> +			{NULL, required_argument, NULL, 'i'},

Plain short options don't need the long option definition.

> +			{"parents", no_argument, NULL, 'p'},
> +			{NULL, 0, NULL, 0}
> +		};
> +
> +		c = getopt_long(argc, argv, "i:p", long_options, NULL);
>  		if (c < 0)
>  			break;
>  
> @@ -127,6 +136,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  				goto out;
>  			}
>  			break;
> +		case 'p':
> +			create_parents = true;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> @@ -167,6 +179,33 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  		goto out;
>  	}
>  
> +	if (create_parents) {
> +		char p[PATH_MAX] = {0};
> +		char dstdir_dup[PATH_MAX];
> +		char *token;
> +
> +		strncpy_null(dstdir_dup, dstdir);
> +		if (dstdir_dup[0] == '/')
> +			strcat(p, "/");
> +
> +		token = strtok(dstdir_dup, "/");
> +		while(token) {
> +			strcat(p, token);
> +			res = path_is_dir(p);
> +			if (res == -ENOENT) {
> +				if (mkdir(p, 0777)) {

The exact error values from mkfs should be reported, so I used the 'res'
value for that.

> +					error("failed to make dir: %s", p);
> +					goto out;
> +				}
> +			} else if (res <= 0) {
> +				error("failed to check dir: %s", p);				

Here also it's good to print the exact error, not just the path.

> +				goto out;
> +			}
> +			strcat(p, "/");
> +			token = strtok(NULL, "/");
> +		}
> +	}
> +
>  	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
>  	if (fddst < 0)
>  		goto out;
> -- 
> 2.25.1
