Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE064BC962
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiBSQn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 11:43:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBSQn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 11:43:26 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ADB5F4DD
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 08:43:06 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id AECA29BC8E; Sat, 19 Feb 2022 16:43:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1645288984;
        bh=LGMpS+zN/Gj+Ryp4wnZg0zJo2QbPOFtQOhg4y+dMJ0o=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=tzRVoKJaoqIUc4lpAFHssyuBDfgG/JyLcWg1jTr/BeBBxgVoiAGz9MyMd407Y4zku
         uT4PWPcg01XoZ51sj9WcODpmWNIZWulZAMQkAFgLcFH2wwV9DsOKIoLjaB4T4cVtx0
         d3OfGJxsCjk3hGOpuPfBQW4ooeTk381hI4HJB1WwbsFf4KvhVZLwhqX6gZiNo5yYVW
         BexxlC6TUlQQt43BOzLLPrv8raCoPaaBnb6LOIu1Mue40eI5pSRBB4gapm2hCghnRs
         yhwP7uMq7ngVvIqr7ObuwvyG0MjsJ/Xvywqam0TTSQ1IMI1sin8u2qTHKdmFPGKRFW
         scfyg4X4VvrKA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A0EB89BA0A;
        Sat, 19 Feb 2022 16:38:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1645288683;
        bh=LGMpS+zN/Gj+Ryp4wnZg0zJo2QbPOFtQOhg4y+dMJ0o=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=dUwPQCTIT3GLtTmp7eBPLvfEbn8M7zqa/4amG3hr/bk0v7w9Ee1mFaI+u+29UiC3v
         0RaBHSEgO6yaw74pZMWtWghln65b2WeWN1N/extJSsmrgvo+gbx1CFcRpsI2/Oy5kY
         Z5b5loLaMyUN3BsfkjjZi1O1gOB6AEbs7QocFiynSlTpJ60An00v02bPlnEAqS7HYK
         Iw9FOehweTvP9V9WNRjKeJE1Hdvg2th3CVFEj5URTxyIeABaIiLxl4vmqd65+itmbR
         FVK/6pLLQFEF2H7gwpoTD759UMeiRxGFNReRfGAJCpIuKbH0jvUkoD8JfNt6RPMONO
         mI7uRjcaAKU4Q==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6A9D91234D8;
        Sat, 19 Feb 2022 16:38:03 +0000 (GMT)
Message-ID: <65d64775-565e-c257-d65f-7ab9da22f1c9@cobb.uk.net>
Date:   Sat, 19 Feb 2022 16:38:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v2] btrfs-progs: cmds: subvolume: add -p option on
 creating subvol
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20220219151143.52091-1-realwakka@gmail.com>
In-Reply-To: <20220219151143.52091-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/02/2022 15:11, Sidong Yang wrote:
> This patch resolves github issue #429. This patch adds an option that
> create parent directories when it creates subvolumes on nonexisting
> parents. This option tokenizes dstdir and checks each paths whether
> it's existing directory and make directory for creating subvolume.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2: fixed the case using realpath() that path nonexists, added
> description on docs.
> ---
>  Documentation/btrfs-subvolume.rst |  3 +++
>  cmds/subvolume.c                  | 34 ++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
> index 4591d4bb..89809822 100644
> --- a/Documentation/btrfs-subvolume.rst
> +++ b/Documentation/btrfs-subvolume.rst
> @@ -61,6 +61,9 @@ create [-i <qgroupid>] [<dest>/]<name>
>                  Add the newly created subvolume to a qgroup. This option can be given multiple
>                  times.
>  
> +        -p
> +                Make any missing parent directories for each argument.
> +
>  delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid> <path>
>          Delete the subvolume(s) from the filesystem.
>  
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index fbf56566..7df0d2ec 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
>  	"",
>  	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
>  	"               option can be given multiple times.",
> +	"-p             make any missing parent directories for each argument.",
>  	HELPINFO_INSERT_GLOBALS,
>  	HELPINFO_INSERT_QUIET,
>  	NULL
> @@ -105,10 +106,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  	char	*dst;
>  	struct btrfs_qgroup_inherit *inherit = NULL;
>  	DIR	*dirstream = NULL;
> +	bool create_parents = false;
>  
>  	optind = 0;
>  	while (1) {
> -		int c = getopt(argc, argv, "c:i:");
> +		int c = getopt(argc, argv, "c:i:p");
>  		if (c < 0)
>  			break;
>  
> @@ -127,6 +129,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  				goto out;
>  			}
>  			break;
> +		case 'p':
> +			create_parents = true;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> @@ -167,6 +172,33 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
>  		goto out;
>  	}
>  
> +	if (create_parents) {
> +		char p[PATH_MAX] = {0};

I'm not a fan of single letter variable names, especially for
substantive objects such as large character arrays (as opposed to a
pointer keeping track of a position in some other object). But maybe
that is just me.

> +		char dstdir_dup[PATH_MAX];
> +		char *token;
> +
> +		strcpy(dstdir_dup, dstdir);

Has dstdir already been checked its length is PATH_MAX-1 or less?
Wouldn't it be safer to at least use strncpy plus overwriting the final
byte with zero?

> +		if (dstdir_dup[0] == '/')
> +			strcat(p, "/");
> +
> +		token = strtok(dstdir_dup, "/");
> +		while(token) {
> +			strcat(p, token);
> +			res = path_is_dir(p);
> +			if (res == -ENOENT) {
> +				if (mkdir(p, 0755)) {

Why 0755? Personally I make use of groups and run with umask 0002. Why
not just use 0777? I realise this is unlikely to be significantly
important but I dislike programs overriding the user's choice of umask.
I assume the requestor's intention was that the behaviour should be the
same as "mkdir -p".

Graham

> +					error("failed to make dir: %s", p);
> +					goto out;
> +				}
> +			} else if (res <= 0) {
> +				error("failed to check dir: %s", p);				
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

