Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00AA4909B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiAQNpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 08:45:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44226 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiAQNpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 08:45:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9386212BD;
        Mon, 17 Jan 2022 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642427117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8c3wOMb9BakQ3EMX+F3efCDYShekol71IPByrM9hEQ=;
        b=pTvb0mRLQkwf3BghMvt2HUs5y8k1mzKHJ901B2KozmX7Rxpxi4NH003NE4nNnBTmxvL9UK
        SS+Ml1sI8UEXu9JaRRlzZc1JqYFVXE80Kzn0mDXPUgxaboOgYYtSwoNs0uiBWu4WLCaEj5
        MiOt3PDiixTqDEPjm7c/cBydGJS1yM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642427117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8c3wOMb9BakQ3EMX+F3efCDYShekol71IPByrM9hEQ=;
        b=V4CvKA3kDTqCtAxxTyPp8UA2lBjE6A7EdbkjzfuFEbJbJo6w2VoS4/8Ogdhwk1/RtZPHib
        z1awMgiwiWCdUzCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C1A0A3B8C;
        Mon, 17 Jan 2022 13:45:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F823DA781; Mon, 17 Jan 2022 14:44:41 +0100 (CET)
Date:   Mon, 17 Jan 2022 14:44:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: allow user to insert property
 compression=none to file.
Message-ID: <20220117134441.GG14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1642323163-2235-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642323163-2235-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 16, 2022 at 04:52:43PM +0800, Li Zhang wrote:
> 1. If the user adds the property "compression=none" to the file,
> remove the code that converts the None string to an empty string.

This is related to 5548c8c6f55b ("btrfs: props: change how empty value
is interpreted") and needs some explanation that what it does on old and
new kernel. Maybe some backward compatibility code in progs is needed to
take the version into account.

> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  cmds/property.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index b3ccc0f..ec1b408 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -190,8 +190,6 @@ static int prop_compression(enum prop_object_type type,
>  	xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] = '\0';
>  
>  	if (value) {
> -		if (strcmp(value, "no") == 0 || strcmp(value, "none") == 0)
> -			value = "";
>  		sret = fsetxattr(fd, xattr_name, value, strlen(value), 0);
>  	} else {
>  		sret = fgetxattr(fd, xattr_name, NULL, 0);
> -- 
> 1.8.3.1
