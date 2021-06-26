Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1C3B504F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 23:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFZVr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 17:47:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:52941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFZVr3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 17:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624743904;
        bh=sA0s19y/chRlYaT3npkOMwKS1popPXPHwXik+qF8iHA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PPmSss7pd0WuKPUdaEQjGevOkTGfwsoKPsjz5zN/vACEwCv7FmSf56J8oMBPuWXZf
         /fRMQIY17l/LQgh6RJ2OXOnCgODUSOUrT1rg4y9wEL0/k72hRTjoT0kQnDKKaKJY95
         MnZ8CA/LlAUpJHtu9Wbw7lbD3QMdpVoUcebCYjvc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1lD07D3AKG-016RGp; Sat, 26
 Jun 2021 23:45:04 +0200
Subject: Re: [PATCH] btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210626150344.25860-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ec29b7c7-a5ff-0557-47d8-6d1f1814a0a2@gmx.com>
Date:   Sun, 27 Jun 2021 05:45:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210626150344.25860-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3Upck6kOEtqMhvz+usAq5Y2wnWsjcnAMoZYQ+cCxVZTtmEMb4p
 2gdw2N4q+U5KSvZkZC35kWlyTpGOhNU16PLoAfbeGvx58G8GVhqyYaMu7BUyu3wHG/xM6CS
 VOluRS2m6mzQmSFhrm+UUdczRMzgPKs8GMposTZcCelos+H8lQ2CcFmcScEwaA+KQdULsqY
 nGHNZ6KR32qeAeL9/8UXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jk5nLVHKQpA=:tAD95yiNxIpVEhlCQkpVBj
 uomVnWa+L5UHjfKb1+BEaewWdrXM9KMzyw8Ebu9ODaFk0++PUbmil9U0SNwo+LvH42HTbke7K
 hOTyFIr5olaPqKe6zQbATQ4Aaq+JwMrPkGOyc4GHji+IKOc/rLnTi9Hv8g6CwbTRB36DyQqoX
 sgUX52s2ACT8xEzTsdm0TW83KTS7euBeDd5zP5S6HcY9/b56/++RCPJzu5m7jf+pxM0X6ArHv
 /ULh96O6uUipGttbZRu1gRqv/xakGOsEtUX6tNr8w7gvIQDICoduQnw0VF/2oYpTB2aLFwY2k
 bwqkRtJ6D6sx2GR28b7zJ6OXl6L/+Y/b8OisoiqkrW/4IzAlLYegDt1HXu5AtggO0T+bfQIb9
 QDg6vXnpyunJ6A/BHLrII9WdW10nEvv5AutsRukP/NwB3bk4MvgBO9cVa0wASAsxFFdQCi1p1
 vvk6L4+i9E++PIUadqEI8GkURIVX5NbJDfB39cP0/gvUatpbRqLcQcV8bh8hepqzeiAqBcF4b
 ZWjsdJx+8BIhzxfVepSJpbeUlHNdoKMx/iLLJ2IjZwoUwPYVnL+ktH5tQ58+sPx79yXc7j8b2
 JwHQyQBN6exI+YLrVbEYCJbyiBfXR//zBsEswJbVkIN0dHC7xX8jX5FLZnhoATnjhTqwoVnaL
 kbDzSe853j9JfPOCJ9ufyesIBq+TWlUOtJ++7M3rPMsOPEoTTHOo5lW4af0/yX67379LgZaXR
 UYGr0xnJhW8a98Y3ynAvQXSBkgao54uZGSjoVTpXH3DarUnfxRe+Y8PUjiIaCxY7srXOf9vVE
 lcRSfkBmPkeXMyn68PT8G6qW+L2cafhEj7T868Tun9J+wkWiRKjqzrkva0r05Jr5kBdvbiRpA
 utUeJDl4KgmmsK/7snkeuhJ/uoZJEfMDCwmYO9iTXBI7t+CgonlY0X08r5noiS+fVb1sM1+JN
 XI4BuA51PpM7VW6nnPtK7uNaPHqtR5LKs8GciqZv+8KStNGwdERbOhIQ3FE7dHVDuzS4njA7I
 VDc/2KG+VsQGcHcAw3M/maZ5xpP9EOeYWNmpAwQpyurXECTDBubc6lawRoj2ixeg04Alswc3G
 p8Z/xT4hSK1HTE2FtvKbsfQfATO2ahlqmvPmbUgCRilVwbowQW9r6f05g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/26 =E4=B8=8B=E5=8D=8811:03, Sidong Yang wrote:
> In btrfs_sb_io(), blk_zone_report is used for getting information about
> zones. But it is not freed if code goes in usual path. This patch frees
> the variable just after it used.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/zoned.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 2a6892b3..75eade84 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -543,6 +543,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, =
int rw)
>   	zones =3D (struct blk_zone *)(rep + 1);
>
>   	ret =3D sb_log_location(fd, zones, rw, &mapped);
> +	free(rep);
>   	/*
>   	 * Special case: no superblock found in the zones. This case happens
>   	 * when initializing a file-system.
>
