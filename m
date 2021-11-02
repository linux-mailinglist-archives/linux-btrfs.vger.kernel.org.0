Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90E3442BC2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKBKpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 06:45:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:52009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhKBKpX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 06:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635849761;
        bh=5vb2HgqC9BAY0oTv/+k9qP3p8/26rl9Lk+i+Uxj6iHM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ckPUTBsGJtroYiCUrWBjBwU3SuZueFiv44J1lclazkazyObb4ePd2wDS/lb+LzE7Z
         LKzbr0aNau170pE+FpJMKcLN94ltdL+dE+Il8/5gutlx2JUPRDk8G24FqNG92/nxX8
         2qPUewq2uIobz8runtmronoBd0hEwF6ITDJFdXGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5mKP-1mgAHE3nop-017Ams; Tue, 02
 Nov 2021 11:42:41 +0100
Message-ID: <94ccb3c3-f701-3fab-e80a-ac7286f69492@gmx.com>
Date:   Tue, 2 Nov 2021 18:42:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs-progs: fix btrfs_group_profile_str regression
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20211030143658.39136-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211030143658.39136-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2D7Be3+bGsDF34zZlNF3KzHDMsDZb3BUxubU3JPFMLOyZopysHd
 T3EbV+KNk36/dn0IgHwWDaDdfcbaYVMRcKHKw+TCTaZ7v3P5Xgjft5OIkrIFN4AJLR/nKeU
 XHa0KFkw1skKmU+fkbxI70wK4lQ+SZU+gHOIZZf1kgIS9HwTcFxyyZbs/EkfkWuMmY8t7OF
 DgXdWMrzKIbkd2Be+s6og==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OeJ5ymF6AXs=:1Fhpxa3f43nLazCEjLMLRl
 c7BX5ALxZTTRmeTrtLxcRLnIrPpqsxm1rd+OpnAfPf0WbX60rB8nPcAZXqThxvSIN1lknTePo
 RjqinIRdnyzJrfOmHxcYKgRBrRxEptg7IicYbATyeRezeH8Fo8grLgzr5K7h6tvhZ+kMZKhV5
 xuqRcYbwOMveOv9xPc2cOAKh9mskV7aiKtyNxb86U8/aWVe4kgjPAFYLKV0iuoXBZy9kwsigy
 /Rpw0nmNYjaEytNebtY88rV8BGThJgi9qEaErJ5rPDLS3j6dfqeEvbjtzYG4asahMa565fCJl
 xyVTuthQGxxnVUA++B8lfAtToEdvnMshyUu+lj7VlDfN/SqI1X+4lWI5wnCs4glKjcFYAOzWw
 4lvT+44MJ2OGzshatNiysdnLYdm0ah+AWiob3gthHKCPqv3+n3Bcumr/dqyMbguiEBT64f1Mk
 qgSzoHmMUx0wop+dNW6V6J2SVpBFiz+sDyMTTs7mbX0GdogmW/podTzNV3t+Bz3fbkNBajZ1l
 iLdyKSIr3LVB9SfgdlHJxJpGENIWma+yvxBgXwXz3NikTA47lmZuqRw5DcePDsYZtB8BJPPAx
 lnmvnUkyXXwQazX+/IArJfS0OGY3zAiq9rBj8lLcqYpWbHpMmo84Ui9CHE7/1YrEBEp/2cFSv
 GjKVgeS6ZCa4gl/IPJzFZy3OxawQ+Ytw/G6hzRoORkqEwqm6Qp46dIjVuW0c2paelnsWFTX0X
 WlL27wt31+NCWqWfaOJs0ByAbY3nAXqYxRg10rxVjpYz2mX5x0Y73SIovuCbv2COL4ScgLytl
 s7BvXxJl7W58HUWBW73lvSUbDji61pNMj1lZ3810YLM/NP2I5EsFdFEZ67B0nPJq7AiBOvIDB
 JcT+MmaUROt4/GPdmUaahum/Zwu+wcCCfkEpPNYzu3TgJOnyBc5X1eo1vFWJ3lrRRzG/FSuxp
 9F5L2xzm390uwWHg0mgnwEOLjJtLtGOiXY7yPR06srHsKuQUztyD/UiDV2sKvX3xb7JM8W1Yb
 PUsRbclYOayYu7hEfzYwtPhn5+qPzimDtHom1TCzglErGYV42j0vN1jBRqEPfPPQYyfiSKf5z
 3HNmIdOQK+LTXA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/30 22:36, Wang Yugui wrote:
> dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use raid t=
able")
> introduced a regression that raid profile of GlobalReserve will be outpu=
t
> as 'unknown'.
>
>   $ btrfs filesystem df /mnt/test
>   Data, single: total=3D5.02TiB, used=3D4.98TiB
>   System, single: total=3D4.00MiB, used=3D624.00KiB
>   Metadata, single: total=3D11.01GiB, used=3D6.94GiB
>   GlobalReserve, unknown: total=3D512.00MiB, used=3D0.00B
>
> fix it by
> - add the process of BTRFS_BLOCK_GROUP_RESERVED
> - fix the define of BTRFS_BLOCK_GROUP_RESERVED too.

That also unified kernel uapi and progs headers' definition of
BTRFS_BLOCK_GROUP_RESERVED.

>
> Fixes: dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use=
 raid table")
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Revewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> ---
>   common/utils.c        | 2 +-
>   kernel-shared/ctree.h | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/utils.c b/common/utils.c
> index aee0eedc..e8744199 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -1030,7 +1030,7 @@ const char* btrfs_group_profile_str(u64 flag)
>   {
>   	int index;
>
> -	flag &=3D ~BTRFS_BLOCK_GROUP_TYPE_MASK;
> +	flag &=3D ~(BTRFS_BLOCK_GROUP_TYPE_MASK | BTRFS_BLOCK_GROUP_RESERVED);
>   	if (flag & ~BTRFS_BLOCK_GROUP_PROFILE_MASK)
>   		return "unknown";
>
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 563ea50b..99ebc3ad 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -972,7 +972,8 @@ struct btrfs_csum_item {
>   #define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
>   #define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
>   #define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
> -#define BTRFS_BLOCK_GROUP_RESERVED	BTRFS_AVAIL_ALLOC_BIT_SINGLE
> +#define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
> +					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>
>   enum btrfs_raid_types {
>   	BTRFS_RAID_RAID10,
>
