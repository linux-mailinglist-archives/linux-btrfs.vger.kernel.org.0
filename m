Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD79779683
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjHKRxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKRxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 13:53:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2E110
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 10:53:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EAFF218CE;
        Fri, 11 Aug 2023 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691776411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7xAL8zCPS4fYGNDguh91PRVbePdpvdLc+fM6Oz/H8Q=;
        b=ybOtWBDJZp91csJXzJM6cMIp8LwAvCEJL33yHKO5RyjsYyH/vwuQFDWmbi1LLj55OYhwiv
        Taha/EganRgxoepk4TvdzPBUHc+Wmi/YQInNjiGLe+Ibm182+2uu/U8tlQbyNHAH7Dp6HU
        L2b/4Uk7Qpv+TPgW1nQqpx5nICwGerM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691776411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7xAL8zCPS4fYGNDguh91PRVbePdpvdLc+fM6Oz/H8Q=;
        b=sInAvW56Wx6ft4l4+c8Q1o4HixXFtlOZc1nXeaIlT+Jbb8WzGajWMSTd8bPi7YvSlQzxnq
        nruvrEskAm2e91DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F285613592;
        Fri, 11 Aug 2023 17:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cg1fOpp11mSyaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 17:53:30 +0000
Date:   Fri, 11 Aug 2023 19:47:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs-progs: tune: consolidate return goto free-out
Message-ID: <20230811174705.GZ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690985783.git.anand.jain@oracle.com>
 <27568376033263288027ccb60dbbc0d9f78c4744.1690985783.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27568376033263288027ccb60dbbc0d9f78c4744.1690985783.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 07:29:46AM +0800, Anand Jain wrote:
> The upcoming "--device" option requires memory to parse devices, which
> should be freed before returning from the main() function. As a
> preparation for adding the "--device" option to the "btrfstune" command,
> provide a consolidated error return exit from the main function with a
> "goto" labeled "free_out". The label "free_out" may not make sense
> currently, but it will when the "--device" option is added.
> 
> There are several return statements within the main function, and
> changing all of them in the main "--device" feature patch would deviate
> from the actual for the feature changes. Hence, it made sense to create
> a preparatory patch.
> 
> The return value for any failure remains the same as in the original code.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tune/main.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tune/main.c b/tune/main.c
> index d6c01bb75261..7951fa15b59d 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -145,7 +145,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>  	bool to_fst = false;
>  	int csum_type = -1;
>  	char *new_fsid_str = NULL;
> -	int ret;
> +	int ret = 1;

The pattern I'd like to use is to keep ret either uninitialized or 0 and
let each jump to error set the value explicitly, so it's clear without
going back to the initialization.

>  	u64 super_flags = 0;
>  	int fd = -1;
>  
> @@ -233,18 +233,18 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>  	set_argv0(argv);
>  	device = argv[optind];
>  	if (check_argc_exact(argc - optind, 1))
> -		return 1;
> +		goto free_out;
>  
>  	if (random_fsid && new_fsid_str) {
>  		error("random fsid can't be used with specified fsid");
> -		return 1;

ie. ret = 1;

> +		goto free_out;
>  	}
>  	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
>  	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
>  	    !to_extent_tree && !to_fst) {
>  		error("at least one option should be specified");
>  		usage(&tune_cmd, 1);
> -		return 1;
> +		goto free_out;
