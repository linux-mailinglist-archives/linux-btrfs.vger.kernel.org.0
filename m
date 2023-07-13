Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81A752A71
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGMSrl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjGMSrk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:47:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72308E65
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CCE81F37C;
        Thu, 13 Jul 2023 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689274058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Jz3K4hES4+79TqBzsDfIu+xWBLF3hASegtcTSlbqLQ=;
        b=bRfvA09f5UuXl5Ote9WbVOvaNpkM5FQ2JfC3Og7i7mqix3MWLC9gqAnYHlQbkzpKlI++du
        zNeR/vHEF9JeUWCNNolzjiBVQKJQ22GEtRwzGPXOI1vITTXRTDl6cipRMrT+v0zaQPpzAG
        SiQz09Mqq4JycBPqNSeoYX4DjS2zmPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689274058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Jz3K4hES4+79TqBzsDfIu+xWBLF3hASegtcTSlbqLQ=;
        b=KhvTe4FIt2ffxPP8iQh4+h1HTJt5GPw3ao9JJlFor3j2+Q2LFS+bTbzkUCR9v/03i0lRHF
        I+wJ/CE2X15lWtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02F8A13489;
        Thu, 13 Jul 2023 18:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I/6UO8lGsGTvAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:47:37 +0000
Date:   Thu, 13 Jul 2023 20:41:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs-progs: common: add --device option helpers
Message-ID: <20230713184101.GA30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687943122.git.anand.jain@oracle.com>
 <b369f8c90aabf121c53533ff60004b14cb19ec7b.1687943122.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b369f8c90aabf121c53533ff60004b14cb19ec7b.1687943122.git.anand.jain@oracle.com>
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

On Wed, Jun 28, 2023 at 07:56:08PM +0800, Anand Jain wrote:
> Preparatory patch adds two helper functions: array_append() and free_array(),
> which facilitate reading the device list provided at the --device option.

That it's for --device is for later and not that interesting when adding
some API.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/device-scan.c | 32 ++++++++++++++++++++++++++++++++
>  common/device-scan.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 68b94ecd9d77..ba11c58d00d2 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -31,6 +31,7 @@
>  #include <dirent.h>
>  #include <limits.h>
>  #include <stdbool.h>
> +#include <ctype.h>
>  #include <blkid/blkid.h>
>  #include <uuid/uuid.h>
>  #ifdef HAVE_LIBUDEV
> @@ -540,3 +541,34 @@ int btrfs_scan_argv_devices(int dev_optind, int dev_argc, char **dev_argv)
>  
>  	return 0;
>  }
> +
> +bool array_append(char **dest, char *src, int *cnt)
> +{
> +	char *this_tok = strtok(src, ",");
> +	int ret_cnt = *cnt;
> +
> +	while(this_tok != NULL) {
> +		ret_cnt++;
> +		dest = realloc(dest, sizeof(char *) * ret_cnt);
> +		if (!dest)
> +			return false;
> +
> +		dest[ret_cnt - 1] = strdup(this_tok);
> +		*cnt = ret_cnt;
> +
> +		this_tok = strtok(NULL, ",");
> +	}
> +
> +	return true;
> +}
> +
> +void free_array(char **prt, int cnt)
> +{
> +	if (!prt)
> +		return;
> +
> +	for (int i = 0; i < cnt; i++)
> +		free(prt[i]);
> +
> +	free(prt);
> +}

Looks like this is an extensible pointer array, we could use that in
more places where there are repeated parameters and we need to track all
the values (not just the last one).

Then this should be in a structure and the usage side will do only
something like ptr_array_append(&array, newvalue), and not that all
places will have to track the base double pointer, count and has to
handle allocation failures. This should be wrapped into an API.
