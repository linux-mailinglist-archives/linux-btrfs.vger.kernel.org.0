Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1F77FEDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354717AbjHQUGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbjHQUGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:06:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4934B30DF
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:06:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B79721845;
        Thu, 17 Aug 2023 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692302775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjMdptZxDhwyZNcTGg78ySJOjELACw6wF9rml6Ks3DM=;
        b=3GIVfMwUfrp9VltsQyhivv0zKRrfAzVOi7mWY4/1Z4Ky8LcVd/Rrt5BPOXjXjiBQfdalUg
        vls79HNQeUythPYLgR9CC5l85paR4rNrEhRdC/9YHGxYl4lafKIm8RFqqSapLaKdB53wjT
        PofGtL/agIppMtCmkYofGPmU9M8uM60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692302775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjMdptZxDhwyZNcTGg78ySJOjELACw6wF9rml6Ks3DM=;
        b=HipM3DbmetcjyleZO+eF8qlUCQmmU4r86IC+0HZcYBFXqGa77njqOI+N9vqXbCBxF484Gb
        uUpMdILHwiRXAmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC2D51392B;
        Thu, 17 Aug 2023 20:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5cLzNLZ93mR9VwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 20:06:14 +0000
Date:   Thu, 17 Aug 2023 21:59:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/7] btrfs-progs: subvol list: implement json format
 output
Message-ID: <20230817195946.GV2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230813094555.106052-6-christoph@c8h4.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813094555.106052-6-christoph@c8h4.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 11:45:00AM +0200, Christoph Heiss wrote:
> Implements JSON-formatted output for the `subvolume list` command using
> the `--format json` global option, much like it is implemented for other
> commands.
> 
> Re-uses the `btrfs_list_layout` infrastructure to nicely fit it into the
> existing formatting code.
> 
> A notable difference to the normal, text-based output is that in the
> JSON output, timestamps include the timezone offset as well.
> 
> Signed-off-by: Christoph Heiss <christoph@c8h4.io>
> ---
>  cmds/subvolume-list.c | 91 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
> index 382b0676..be7faca6 100644
> --- a/cmds/subvolume-list.c
> +++ b/cmds/subvolume-list.c
> @@ -35,7 +35,9 @@
>  #include "common/open-utils.h"
>  #include "common/string-utils.h"
>  #include "common/utils.h"
> +#include "common/format-output.h"
>  #include "cmds/commands.h"
> +#include "cmds/subvolume.h"
>  
>  /*
>   * Naming of options:
> @@ -75,6 +77,8 @@ static const char * const cmd_subvolume_list_usage[] = {
>  	OPTLINE("--sort=gen,ogen,rootid,path", "list the subvolume in order of gen, ogen, rootid or path "
>  		"you also can add '+' or '-' in front of each items. "
>  		"(+:ascending, -:descending, ascending default)"),
> +	HELPINFO_INSERT_GLOBALS,
> +	HELPINFO_INSERT_FORMAT,
>  	NULL,
>  };
>  
> @@ -84,7 +88,8 @@ static const char * const cmd_subvolume_list_usage[] = {
>  enum btrfs_list_layout {
>  	BTRFS_LIST_LAYOUT_DEFAULT = 0,
>  	BTRFS_LIST_LAYOUT_TABLE,
> -	BTRFS_LIST_LAYOUT_RAW
> +	BTRFS_LIST_LAYOUT_RAW,
> +	BTRFS_LIST_LAYOUT_JSON

Json should not be a layout, that's relevant only for plain text output.
