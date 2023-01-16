Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63566BDD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 13:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjAPM33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 07:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAPM31 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 07:29:27 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74561CF63
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673872164; x=1705408164;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ADcA3a/P3hyUCRvGtXbE4bRKHoAltFYtNO3ZIOOXZnM=;
  b=pkZ780QSd8OCt9l194q9jdunc76m106gGM9UvUWXrBc3Bd7WmYCXtodS
   zJxD4QwKQvHfnBwcNlfOuyXz6/dUImqeAqi1jhIor1vARDxnCLetrz8VT
   rNEpFMhl7chBJcWACLiQVTXVSW9UbHaM0ZMeyWWYylE96YrNVHHgSHAQS
   pXXQ6+qOrQRjfR9+V0tNGkKaZV/maMi6+vKaY46gFxZRQvUX6sFHlwk47
   erPSXKGXBXQWK9/oujtjLGol/6wdsBCHU9KbY1cS/uGw4EbuNxljG6TLQ
   CFcyo9V0dZNKe8NGYHXY7MR78XOiuAghr2l0H9lBVYgWGsWnp0gQfmOVl
   g==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="219255749"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 20:29:24 +0800
IronPort-SDR: hLzHe7i8YkD2xhhxtXYMIjSBAeu518M207ip94ACEFxuVIbqfcs4MDDqmZJ4F48wox5UQneFg9
 VY3lcd0DHg1gQmh8daZa2xTsm+YqOFGA88oQjUsDR3MNuFbsZUGWuRaQaV7bQxU2NHhUhVQE6V
 1jBSSpklkOXGO9tTPhN8STabo84mOnhrjT/vtq6prkQ7k+DKjOqjiCB0FkEUgARxhhDhEml3lx
 HhHD4DZ7y2DN/xJ6LwjV1Pc3Hb+9xwbYoQGk3M3mVFB1x0chgbkVVYHWL/Y+/iWaMNMGd5B5dO
 I0o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 03:47:06 -0800
IronPort-SDR: 3PFXUMYVvBfdzzw24mnXShyqHeAn3WEcGeBFiBfr/D5Hbd0m2LUUJlBUa9oP3AzjLjUWDk2Xqu
 kop0/hHIwOB+g9+oHlgNAyQXqtfvf/xkCDHFk41MHXKcolzGHHgeGBw7oWNAgJpntrUn8y83a+
 legvPXrAuHB5o7t8RsvMh54i482/xkH4FG7FOc4tFcuI4Mg2kJRGrdb5Mj9tI7I8SGBTqTHODU
 UOnEQZ/YhKhU2l61WV6hHBH2vSJmcSLZMop5JQie9qqaPxzkdirrkkS5VjhinZW7KMTqEVBaaO
 P70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 04:29:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwWYJ02XJz1RvTp
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 04:29:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673872163; x=1676464164; bh=ADcA3a/P3hyUCRvGtXbE4bRKHoAltFYtNO3
        ZIOOXZnM=; b=VQOrKZqjGGfZglr+8Y26BtenGwIZFVuQCQovhncF5OkxInqG4qe
        I/kWfTgB7Ld6aoXTJ7/zzKpa1EvmvN3w7JLOk9lI+oJ8m2BDBc+KCwyrD/JjXFiG
        Ay67VjAAYjFAw9AcnGgVnd+CcDBScUMxCbIQXpmHGEUr83Vzb42Fu1Qyv0vJgDCL
        dQ5M5iO8dENJ+IwFqINWj5WbZheISnSXsA8fBjt1RLtu7I3DxdRHCI/gHfk1TbkG
        tCwgiJ1xITQOlCSnIOnc0ZUz96JdQaPYOyjqzAbL9frTDm+gKzyrE/HHAjV9ub2M
        gb8FeZQkVEHIZuWU9t2Hi8Lxf2olrrDFxVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BbVx_75YrGVn for <linux-btrfs@vger.kernel.org>;
        Mon, 16 Jan 2023 04:29:23 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwWYH1pCRz1RvLy;
        Mon, 16 Jan 2023 04:29:23 -0800 (PST)
Message-ID: <f133d036-1601-1d26-19ac-680ee3e8f015@opensource.wdc.com>
Date:   Mon, 16 Jan 2023 21:29:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs-progs: mkfs: check blkid version
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20230116030853.3606361-1-naohiro.aota@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230116030853.3606361-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/23 12:08, Naohiro Aota wrote:
> Prior to libblkid-2.38, it fails to detect zoned mode's superblock location

Prior to version 2.38, libblkid fails to...

> and cause "blkid" to fail to detect btrfs properly. This patch suggets to

resulting in blkid failing to detect btrfs on zoned block devices. This
patch suggest to the user to upgrade libblkid if it detects a version
lower then 2.38.

Would be better :)

> upgrade libblkid if it detects <libblkid-2.38.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  mkfs/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index df091b16760c..e0cb6a8c2bff 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -28,6 +28,7 @@
>  #include <string.h>
>  #include <pthread.h>
>  #include <uuid/uuid.h>
> +#include <blkid/blkid.h>
>  #include "kernel-lib/list.h"
>  #include "kernel-lib/list_sort.h"
>  #include "kernel-lib/rbtree.h"
> @@ -1346,6 +1347,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		exit(1);
>  	}
>  	if (opt_zoned) {
> +		const int blkid_version =  blkid_get_library_version(NULL, NULL);
> +
>  		if (source_dir_set) {
>  			error("the option -r and zoned mode are incompatible");
>  			exit(1);
> @@ -1360,6 +1363,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			error("cannot enable RAID5/6 in zoned mode");
>  			exit(1);
>  		}
> +
> +		if (blkid_version < 2380)
> +			warning("libblkid < 2.38 does not support zoned mode's superblock location, update recommended");
>  	}
>  
>  	if (btrfs_check_nodesize(nodesize, sectorsize, &features))

-- 
Damien Le Moal
Western Digital Research

