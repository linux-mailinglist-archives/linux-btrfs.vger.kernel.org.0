Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0C42A235
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhJLKhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:37:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhJLKhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:37:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37A6620194;
        Tue, 12 Oct 2021 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634034911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbmpYzT4G8iDhlbsOlpbq0hvGO5yvOPea8GNsNdLbjs=;
        b=JJjo4ZMGr25ruSfGfRd/HyZg2H9BXmc67Ito49vTKfIHwnmj3BTfy0TUmLMNRxs3YysbFx
        SbKNbS2KW5OzJy7l5LKnzzl8EUn/m+Oz4Gc468GKKkivBVkXH5262gAiByc9ijCvSYeNtf
        q/dOW0NWVSC1Ie9PQ0dojo6E0XL9UAc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F9EF13B2A;
        Tue, 12 Oct 2021 10:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f35KAd9kZWG1CQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 10:35:11 +0000
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
Date:   Tue, 12 Oct 2021 13:35:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012021719.18496-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

<snip>

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/print-tree.c | 47 +++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index 67b654e6d2d5..39655590272e 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -159,40 +159,51 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
>  	}
>  }
>  
> -/* Caller should ensure sizeof(*ret)>=21 "DATA|METADATA|RAID10" */
> +/* The minimal length for the string buffer of block group/chunk flags */
> +#define BG_FLAG_STRING_LEN	64
> +
>  static void bg_flags_to_str(u64 flags, char *ret)
>  {
>  	int empty = 1;
> +	char profile[BG_FLAG_STRING_LEN] = {};
>  	const char *name;
>  
> +	ret[0] = '\0';
>  	if (flags & BTRFS_BLOCK_GROUP_DATA) {
>  		empty = 0;
> -		strcpy(ret, "DATA");
> +		strncpy(ret, "DATA", BG_FLAG_STRING_LEN);

I find using strncpy rather odd, it guarantees it will copy num
characters, and if source is smaller than dest, it will overwrite the
rest with 0. So what happens is you are copying 4 chars here, and
writing 60 zeros. Frankly I think it's better to use

snprintf(ret, BG_FLAG_STRING_LEN, "DATA");

>  	}
>  	if (flags & BTRFS_BLOCK_GROUP_METADATA) {
>  		if (!empty)
> -			strcat(ret, "|");
> -		strcat(ret, "METADATA");
> +			strncat(ret, "|", BG_FLAG_STRING_LEN);
> +		strncat(ret, "METADATA", BG_FLAG_STRING_LEN);
>  	}
>  	if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>  		if (!empty)
> -			strcat(ret, "|");
> -		strcat(ret, "SYSTEM");
> +			strncat(ret, "|", BG_FLAG_STRING_LEN);
> +		strncat(ret, "SYSTEM", BG_FLAG_STRING_LEN);
>  	}
> -	strcat(ret, "|");
>  	name = btrfs_bg_type_to_raid_name(flags);
>  	if (!name) {
> -		strcat(ret, "UNKNOWN");
> +		snprintf(profile, BG_FLAG_STRING_LEN, "UNKNOWN.0x%llx",
> +			 flags & BTRFS_BLOCK_GROUP_PROFILE_MASK);
>  	} else {
> -		char buf[32];
> -		char *tmp = buf;
> +		int i;
>  
> -		strcpy(buf, name);
> -		while (*tmp) {
> -			*tmp = toupper(*tmp);
> -			tmp++;
> -		}
> -		strcpy(ret, buf);
> +		/*
> +		 * Special handing for SINGLE profile, we don't output "SINGLE"
> +		 * for SINGLE profile, since there is no such bit for it.
> +		 * Thus here we only fill @profile if it's not single.
> +		 */
> +		if (strncmp(name, "single", strlen("single")) != 0)
> +			strncpy(profile, name, BG_FLAG_STRING_LEN);
> +
> +		for (i = 0; i < BG_FLAG_STRING_LEN && profile[i]; i++)

nit: It's guaranteed that the profile is shorted than
BG_FLAG_STRING_LEN, then this check can simply be profile[i] without the
i/BG_FLAG_STRING_LEN constant comparison.

> +			profile[i] = toupper(profile[i]);
> +	}
> +	if (profile[0]) {
> +		strncat(ret, "|", BG_FLAG_STRING_LEN);
> +		strncat(ret, profile, BG_FLAG_STRING_LEN);
>  	}

This if can really be put in the above 'else' branch and eliminate the
check altogether.

>  }

<snip>
