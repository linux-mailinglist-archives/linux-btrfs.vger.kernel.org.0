Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9499C3491AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 13:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCYMOA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 08:14:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhCYMNc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 08:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616674411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MM6HuxbqW4GkltDWjuTlSq++GLESMN+4TUbr/xBScqg=;
        b=iZPZjtda7rDvHd06SrPaDWf+vssB3HHLWryFOFPC+05HO1OTSA9ivgTB8/t555Ibkf0Zxr
        OE9fnrTh+jjvq3EJXVDkoMzenV+u3c04TRlM5z4j3IbCZwJ+RT7Y/H/f+KjsGzVjNIQNbf
        6+Gu5/JL+tyrk9goRYEfIZE+cJgxXZ0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41296AC16;
        Thu, 25 Mar 2021 12:13:31 +0000 (UTC)
Subject: Re: [PATCH] fstests: don't relay on /proc/partitions for device size
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20210325112337.35102-1-johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b3cdb9e6-4d30-e9cb-0e49-4d3a0964c807@suse.com>
Date:   Thu, 25 Mar 2021 14:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210325112337.35102-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.03.21 г. 13:23, Johannes Thumshirn wrote:
> Non-partitionable devices, like zoned block devices, aren't showing up in in
> /proc/partitions and therefore we cannot relay on it to get a device's
> size.
> 
> Use sysfs' size attribute to get the block device size.
> 
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 1c814b9aabf1..c99fff824087 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3778,7 +3778,7 @@ _get_available_space()
>  # return device size in kb
>  _get_device_size()
>  {
> -	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'
> +	echo $(($(cat /sys/block/`_short_dev $1`/size) >> 1))
>  }

How about simply using 'blockdev --getsz'

>  
>  # Make sure we actually have dmesg checking set up.
> 
