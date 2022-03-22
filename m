Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EE4E45B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 19:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiCVSGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiCVSGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 14:06:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0E4C430
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 11:05:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id hu11so3564901qvb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pmxzezQGur+rUQFVYFik0j1yeKxbxZYrQHSOeBahdQ=;
        b=bnFh3uqRF2TwFdym/WGL6OuKOyuvWh1So0WMbJv2lvO4vOLT8D1TCYN+Ds7n1h3TrP
         EA1xKBbgnPsGoe1Z0GM9v4FYSaYDmooCRHWg66deiWAOwSq1k1YGO7vpgwWrFVORenRl
         xF45/1YpHNzo4oiWKtPXIOAiEwFNX1fa80Bf5ZLSFPg6cYUoEEfGtHBwbH9YAXNi8Omi
         AVPJjzVQKvv3Do0Nbzsxi56j0srGaehak7ebwCPZ099lpP19oQqak37Wcg8rCjl3F2Mz
         mQ4cl02W4MaysbY8ZBIy9s+O4R5l/gHZj2t66O9tNsBhNVkLK+v0x9E+iKyUgovmgJZd
         VZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pmxzezQGur+rUQFVYFik0j1yeKxbxZYrQHSOeBahdQ=;
        b=EizHTDxTBI7egj+RLZv+COSYaAdfnS2HSVq3FnadQylHZQTKUb/5E0czOlAIz50N9Z
         zbi3bOutgdLE/SR3nVALYqAOU+Mqe8mWVImnhxHXApowkzVswa85o/gl8r6eu+OdUIkw
         oNSGnAgBuuGQ/TzkYnnLJpo0jjojUITg2PcDhqHccikiH5k3rcjlcr5JG3OeQEl6k1KJ
         /Z8JXeU+4eawMNYOpG3QNkZZoSz17PZZ6/5wDIPZhjRnSgLhrvu9hs4ESQ/lx6MOmj70
         tipdjvYf5EBrbxljjw/BKcqIQ/9AWEgm1/iypvJbszL/VZEgH+gM03n0aszFUtCFCok9
         5yTA==
X-Gm-Message-State: AOAM532S86eXzdVovk3k/CnVUAc+QpV3t1BGGptJ6wzVkGLAFsChCS8H
        XkWkhe56zRL5Bkq93364SuMl8Q==
X-Google-Smtp-Source: ABdhPJzxh/4ULjoTHDme1RjsJfJxpkFuRpfZJ52vGj8bjlG7qEebBYWfW6YvD5AzHa8qunDWj3Qwaw==
X-Received: by 2002:a05:6214:1c8e:b0:432:4f21:aedb with SMTP id ib14-20020a0562141c8e00b004324f21aedbmr20310717qvb.74.1647972320264;
        Tue, 22 Mar 2022 11:05:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b002e1c508ba41sm13857383qtk.19.2022.03.22.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:05:19 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:05:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 2/5] btrfs: export the device allocation_hint property in
 sysfs
Message-ID: <YjoP3lreFX3eA4Ic@localhost.localdomain>
References: <cover.1646589622.git.kreijack@inwind.it>
 <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 07:14:40PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Export the device allocation_hint property via
> /sys/fs/btrfs/<uuid>/devinfo/<devid>/allocation_hint
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/sysfs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 17389a42a3ab..59d92a385a96 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1578,6 +1578,36 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
>  
> +
> +struct allocation_hint_name_t {
> +	const char *name;
> +	const u64 value;
> +} allocation_hint_name[] = {
> +	{ "DATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED },
> +	{ "METADATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED },
> +	{ "DATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY },
> +	{ "METADATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY },
> +};
> +

The ktest robot complained about this, but also we don't need to be this clever,
also it looks better to have the flags first with standard tabbing.

struct allocation_hint_name {
	const u64 val;
	const char *name;
};

static struct allocation_hint_name allocation_hints[] = {
	{ BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED,	"DATA_PREFERRED"	},
	{ BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED,	"METADATA_PREFERRED"	},
	...
};


> +static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
> +					struct kobj_attribute *a, char *buf)
> +{
> +	int i;
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
> +		if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) !=
> +		    allocation_hint_name[i].value)
> +			continue;
> +
> +		return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			allocation_hint_name[i].name);
> +	}
> +	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");

Since we have fs'es that won't use this you should just spit out "NONE".
Thanks,

Josef
