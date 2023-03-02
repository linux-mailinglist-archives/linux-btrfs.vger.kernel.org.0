Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09A6A7BB9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 08:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCBHRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 02:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCBHRl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 02:17:41 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3C42BC2;
        Wed,  1 Mar 2023 23:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677741457; x=1709277457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKjKVeOoQlubgjMcNjyaX/+L337Vay5aAn11Xd+BExk=;
  b=SLlSwyDhE8yH8QRBFPBWQQsHj5KAHZk6Dll9VEK0HhhkFpZQf0G3BlFo
   6mYlsKwkxWGFacExIbl67+E7FeKrMnMr91pygWaKJAuSrpWxDU6C8y/1M
   7g9tbwEgTSJkM9FabGamta06RzrqsGgadeMkrRtk0VvfM2OaRgfyuu0BF
   +PE3IoojXlNyfBhSAamS5N4XIX8wHlJ3tUPp8W0sqs855mcNSDo2q+8Iy
   2JrFqcpUlY5zlLS/IQOzRKUDwcQ+l7Tmh3zhP3u5oWUsDNS7OSicBcKNb
   OhnbqGkhFmZ8Qao3JEv3FupjOXSskaK0HR2xgOtNl6GL3gF6oUjkM8cju
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673884800"; 
   d="scan'208";a="224604802"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 15:17:36 +0800
IronPort-SDR: E8H9TgEP8OLBi1m97xx7ck97ykJG5onhVWv4dyQd+P6buuBT8cc8uSoAKYT5HVK94REcuLcGBJ
 AF3eXo2oAGPU9HkgIJSltXmCTv4O1d8Ui30Y59WVzmYv7UYXFWO2vHwN6mI8UMbjOjjkxoAt9k
 remwkbi7l0YphWB8oimglRJqVXYI2dE75a+hdkTq0cq5aY9q2FRJ+5yR+t5eOyr44I7yRTW/ne
 tNhSImIULh9vgNaRwSOh9PD2w2Rmi7uWhTzkqweUP+Vwm+Bf4UTHyslRA/g27OB9IMYuo6CrCJ
 Go0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 22:28:41 -0800
IronPort-SDR: Mv/yvxUbfu8g4rVFIdMypBlwFLW1KNkwPsBygXjSo8x6tQyM5xhjHmZJrAC5NKTsxsyAWRD/GP
 1srGy3qLUHiKp7GdwnOv7iduA2RCzqrva04NhqlBUouJE24ZAorFEP0ChVtC+zjdXfws7Iojcz
 gowvfUCMAfP1+XE/Pc3hcs/Qhgn+jFfcYheg7K0GwyjGBhASlt+i+9qETaUrDnWTX6ZldIt0r7
 Xp6bhuMC4CC+zeKwJ6c9+fGhK4yob4Y6J9SEDePrRTItItBxOb6i05/yzUPRP0hInvDO0qvTAg
 XpM=
WDCIronportException: Internal
Received: from 5cg217420n.ad.shared (HELO naota-xeon) ([10.225.50.90])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 23:17:36 -0800
Date:   Thu, 2 Mar 2023 16:17:34 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: don't clear superblock for zoned scratch
 pools
Message-ID: <20230302071057.6yc3t4ybwvexjqld@naota-xeon>
References: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 12:27:17AM -0800, Johannes Thumshirn wrote:
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
> 
> On zoned devices this won't work as a plain dd will end up creating
> unaligned write errors failing all subsequent actions on the device.
> 
> For zoned devices it is enough to simply reset the first two zones of the
> device to achieve the same result.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 654730b21ead..739abbdbfc8c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
>  		            exit 1
>  		        fi
>  		fi
> -		# to help better debug when something fails, we remove
> -		# traces of previous btrfs FS on the dev.
> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		# To help better debug when something fails, we remove
> +		# traces of previous btrfs FS on the dev. For zoned devices we
> +		# can't use dd as it'll lead to unaligned writes so simply
> +		# reset the first two zones.
> +		if [ "`_zone_type "$i"`" = "none" ]; then
> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		else
> +			blkzone reset -c 2 $i

We can use "$BLKZONE_PROG reset ..." to honor common/config.

With that,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> +		fi
>  	done
>  }
>  
> -- 
> 2.39.1
> 
