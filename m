Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830F1228A29
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgGUUvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 16:51:01 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:52927 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUUvA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 16:51:00 -0400
Received: from [2001:8b0:162c:2:b967:df01:f018:57e2]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1jxzE3-006yon-FL; Tue, 21 Jul 2020 21:50:59 +0100
Subject: Re: [PATCH] btrfs: allow more subvol= option
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200721203340.275921-1-kreijack@libero.it>
 <20200721203340.275921-2-kreijack@libero.it>
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <abe1d1f0-42ed-4ac8-3bab-adda0af7afba@steev.me.uk>
Date:   Tue, 21 Jul 2020 21:50:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721203340.275921-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/07/2020 21:33, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When more than one subvol= options are passed, btrfs try to mount
> each subvolume until the first one succeed. Up to 5 subvol= options
> can be passed.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> 
> ---
>   fs/btrfs/super.c | 71 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index bc73fd670702..12d066e8d52c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -52,6 +52,8 @@
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/btrfs.h>
>   
> +#define SUBVOL_NAMES_COUNT 5

As this is a maximum, perhaps MAX_SUBVOL_NAMES or SUBVOL_NAMES_MAX

> +
>   static const struct super_operations btrfs_super_ops;
>   
>   /*
> @@ -974,12 +976,13 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
>    *
>    * The value is later passed to mount_subvol()
>    */
> -static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
> -		u64 *subvol_objectid)
> +static int btrfs_parse_subvol_options(const char *options, char **subvol_names,
> +					u64 *subvol_objectid)
>   {
>   	substring_t args[MAX_OPT_ARGS];
>   	char *opts, *orig, *p;
>   	int error = 0;
> +	int svi = 0;
>   	u64 subvolid;
>   
>   	if (!options)
> @@ -1002,12 +1005,17 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
>   		token = match_token(p, tokens, args);
>   		switch (token) {
>   		case Opt_subvol:
> -			kfree(*subvol_name);
> -			*subvol_name = match_strdup(&args[0]);
> -			if (!*subvol_name) {
> +			if (svi >= SUBVOL_NAMES_COUNT) {
> +				pr_err("BTRFS: too much 'subvol=' mount options\n");

s/too much/too many/

Perhaps also include ", maximum is %d", SUBVOL_NAMES_COUNT

--snip--

-- 
Steven Davies
