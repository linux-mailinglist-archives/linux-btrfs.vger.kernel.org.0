Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A1485B2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiAEV5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 16:57:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43853 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244642AbiAEV5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 16:57:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B2B65C015B;
        Wed,  5 Jan 2022 16:57:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jan 2022 16:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=EBUWN10mGHzAphvy3N2ZUUhFoJ3
        LJRdu1afnym469CU=; b=Wtz4W+QZE/yCj/Y3cgY9Vo4Izaaa63xZPcRkhyGItwc
        +Fq8AJyeYIIeC5O+g/TEvvhe4qgkjPZv1v8Ra9xDuYjCMq7Q0+pl19popdYky66V
        ApThTHR7W5kiPEpeDic4yeIT8hgWTZY/91VbwMXGmDtCrsc1K+wCdGtQ2JLpkVfX
        ke6OK/ui+cYZhqtuJU6fzZ+i3BJcqYa6dUF3QQIriSOKpAD7XCzngVHMGRg7eW8x
        jHufWhucZfSZRjBB6E2H+vECG/ZGRsM5WzekjbIJlUTD9bu4c1NNDOmcxPtD1Qa6
        WHbkg0Ge+R3KBq5fQVGj4zpFkGbiTNeBAvVecZP7Tzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EBUWN1
        0mGHzAphvy3N2ZUUhFoJ3LJRdu1afnym469CU=; b=Yb4vOieD8MfjmWz+7AuWNO
        Qw5TFmIv97LpHEy1sPGf8nNUTdBzExrOCiOl/9g++WPjTnCouLafRYgZWRePF8zO
        EndvxeSUNrQUrJwp9ZZIj+GFHjJKjI1sN4pz9O12FTNyUNgXWpLqb1EMkx3nnBFQ
        7fmhZYagHNydSpypKitOZ08LAPJrAM6KZHdS90qOgbi7V1oXSGKCyEO68mfM5A6K
        nGqzYZ3C3rl2tNhE/BfIXXoySipDfDwmPsB8wAcE1ze0lu0Kjb5pWIIhDRkGDach
        P0OwHTbYmDJWvmi/Lm2q+/HStZTPSELuMWGqRWbufRb/CAe4Wfrp8PBtONgZzosg
        ==
X-ME-Sender: <xms:PBTWYdW3Cz88JCq4JPrzvEn-UcduyU9AZtQW1yvJ3vsMlxmvvlM4Iw>
    <xme:PBTWYdm_eNV32olFIROJyTDyP7SZfsOAttVBnDVQKp8WamE-uR4oVeCvAronewcSA
    YSBHTnTNg4LnB_N1tw>
X-ME-Received: <xmr:PBTWYZb9MmId7wrtcyYR-NZijNK4e7PpMdSi8ROf6fhv0hYpzcHdXUXat8dIyoFK8zt0NQegkhfGKjHHoUaY_hce6NNscA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    ffvddugfevfefgjeeivdfhkeeigffhueejteejgeffudfftdehveeuueevtdeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:PBTWYQUptr4G0b_XiLBsHEwJZIcSITcYwx2WDR5oar9nWObwEnN5fA>
    <xmx:PBTWYXm5ST9V7GFpchuTuY7o5l9LOnuyWxQwua1SOi6VSdiO-5WRGQ>
    <xmx:PBTWYddKeZnc1DJ0etBHfnD7dTmDFy_XzJBFqCRkTgfqLDEuhgGpTw>
    <xmx:PRTWYVa8WvEtjYY9JDR_hG7GH-eIsDitd2YIZY59MIAzEiw8CTIRpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:57:15 -0500 (EST)
Date:   Wed, 5 Jan 2022 13:57:14 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 2/6] btrfs: export the device allocation_hint property in
 sysfs
Message-ID: <YdYUOtfuNRczGMNT@zen>
References: <cover.1639766364.git.kreijack@inwind.it>
 <9a3c5371722ab7d10e2eb974c53d07eba53400a5.1639766364.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3c5371722ab7d10e2eb974c53d07eba53400a5.1639766364.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 07:47:18PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Eport the device allocation_hint property via
> /sys/fs/btrfs/<uuid>/devinfo/<devid>/allocation_hint
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/sysfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index beb7f72d50b8..a8d918700d2b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1575,6 +1575,17 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
>  
> +static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
> +					struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",
> +		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK );

I think I lightly prefer the string based interface like what was
discussed on V8, but this is fine as well, especially with the progs
change in mind to add the extra usability.

> +}
> +BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
> +
>  /*
>   * Information about one device.
>   *
> @@ -1588,6 +1599,7 @@ static struct attribute *devid_attrs[] = {
>  	BTRFS_ATTR_PTR(devid, replace_target),
>  	BTRFS_ATTR_PTR(devid, scrub_speed_max),
>  	BTRFS_ATTR_PTR(devid, writeable),
> +	BTRFS_ATTR_PTR(devid, allocation_hint),
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(devid);
> -- 
> 2.34.1
> 
