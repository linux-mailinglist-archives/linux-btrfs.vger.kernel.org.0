Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51AF406741
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhIJGhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:37:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGhd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:37:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F6DF1FE47;
        Fri, 10 Sep 2021 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631255782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss9wV4B3iaN2uzHNfoLGnKRzbBSaGsOSuLOi8KykrzQ=;
        b=L/GIyRVdTniEHKlK6EInZol7fIF3rE/cI0f1rgF/D8wgywrNUjeV+oGbHvNXp6p898HqmQ
        ImYnJ1WFpyjvW7uyvJmFveiUaQgKgQ5ER00bedCajPnpnf504PCKyy6olD3amxwvO7oxOj
        xar32CbfSzCYaR7eWTa0Bn132SGowmg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE8EF13D12;
        Fri, 10 Sep 2021 06:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JAm9N+X8OmHyHgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 06:36:21 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: do extra warning when setting ro false
 on received subvolume
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e1dbfdc6-d1d8-12d4-cbcf-1dd02c935df4@suse.com>
Date:   Fri, 10 Sep 2021 09:36:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210910060335.38617-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.21 г. 9:03, Qu Wenruo wrote:
> When flipping received subvolume from RO to RW, any new write to the
> subvolume could cause later incremental receive to fail or corrupt data.
> 
> Thus we're trying to clear received UUID when doing such RO->RW flip, to
> prevent data corruption.
> 
> But unfortunately the old (and wrong) behavior has been there for a
> while, and changing the kernel behavior will make existing users
> confused.
> 
> Thus here we enhance subvolume read-only prop to do extra warning on
> users to educate them about both the new behavior and the problems of
> old behaviors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  props.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/props.c b/props.c
> index 81509e48cd16..b86ecc61b5b3 100644
> --- a/props.c
> +++ b/props.c
> @@ -39,6 +39,15 @@
>  #define ENOATTR ENODATA
>  #endif
>  
> +static void do_warn_about_rorw_flip(const char *path)
> +{
> +	warning("Flipping subvolume %s from RO to RW will cause either:", path);
> +	warning("- No more incremental receive based on this subvolume");
> +	warning("  Newer kernels will remove the recevied UUID to prevent corruption");
> +	warning("- Data corruption or receive corruption doing incremental receive");
> +	warning("  Older kernels can't detect the modification, and cause corruption or receive failure");

This is a bad format for a warning, let's keep it simple - just state
that flipping ro->rw would break incremental send and that's that.

> +}
> +
>  static int prop_read_only(enum prop_object_type type,
>  			  const char *object,
>  			  const char *name,
> @@ -48,6 +57,9 @@ static int prop_read_only(enum prop_object_type type,
>  	bool read_only;
>  
>  	if (value) {
> +		struct btrfs_util_subvolume_info subvol;
> +		u8 empty_uuid[BTRFS_UUID_SIZE] = { 0 };
> +
>  		if (!strcmp(value, "true")) {
>  			read_only = true;
>  		} else if (!strcmp(value, "false")) {
> @@ -57,6 +69,15 @@ static int prop_read_only(enum prop_object_type type,
>  			return -EINVAL;
>  		}
>  
> +		err = btrfs_util_subvolume_info(object, 0, &subvol);
> +		if (err) {
> +			warning("unable to get subvolume info for path %s",
> +				object);
> +		} else if (!read_only && memcmp(empty_uuid, subvol.received_uuid,
> +				   BTRFS_UUID_SIZE)){
> +			do_warn_about_rorw_flip(object);
> +		}
> +
>  		err = btrfs_util_set_subvolume_read_only(object, read_only);
>  		if (err) {
>  			error_btrfs_util(err);
> 
