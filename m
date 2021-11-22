Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81445986C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 00:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhKVXcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 18:32:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:41105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhKVXca (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 18:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637623749;
        bh=O+5lNOPAUrZTgMWbEBWmyDMsJg01k6+2aQchkaxKGBE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TShmSvmfrFS6Von8tJ3DHpZzRojcYivY940sQHWrK7Z+a+HXIWI8X25Gv/c4roert
         S/nLVAV0KhW0oGHxh0odIhUhdt/nQvExQSRzfyCGmMH5d0JP32N1aKwVOpTLufpnQX
         qKFDZYxvtaN8JXPZK/Ex6ygAbBttDICkdCvtmnRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUrx-1mRblV1wKX-00xqZ1; Tue, 23
 Nov 2021 00:29:09 +0100
Message-ID: <e31d5b36-a8f3-05a1-040a-7295c3f64b42@gmx.com>
Date:   Tue, 23 Nov 2021 07:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] btrfs: fail if fstrim_range->start == U64_MAX
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BtcDGy4B5y5Qj8OMHF1R8LLSKJXQ4nnAvM22h9n+DJ6yOMNGyZX
 R53MU3qCRydCA/uGzMRL8ssYpey9x/DCOlZvnddzeUgXNkrp9vmGkkND9zP5HpsrydcNmMW
 QXGyag7bsGqG62Pyr9mBAoyqS4VDglNHEu4jOTVRW0WEBWY6A3OrxqvM+flHDEppF4NB/w2
 XVcWZoqdJGe39RWP4MSsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMqW+GOkKl0=:rsnrLM++6Z4NL2rGbTbgvm
 Ls0OlOygUDJdPJ5cNIF0MxEZyrQjgvup7dgtOovCQOPdrc0+UlCfHj9lCiKPvYanpp4r2Lcv7
 Ut2qKPwvP9l38ZhFuudXirVc5neN9G3+VpbKEJkRwEmmK4B+sPWmbVvg4n0BC7DMd8cTq72PV
 K+j4Je9LiiyHZOEgzCQh0D7gJVGEKSwoRMVZeUGHMklGAO8uUMscGqAnCJQ1uxcrt5FTuQGS4
 HYzJPtgO++RiDRuS9/VWuM4uJYof6qHF0VqOfP9TTjTIwMfgTbCg87OBbF0OsialYUwTI6gYq
 ihjMRy8rpavGvMedwES5p74yycl+NEOm5hYoBlB4jgcmn3Utl1v8H4wMmEpuK3MbJSFxbVxia
 L/K6m38qYnktonlE5OmY4VJk72rKhXZPVX0f5v1z73sgYJEXQb8Q6+DXNEpm6FY/mjMdH7See
 8y3KyYvrA0cPagb9t2d8Xr0AYPRoB0JqJOoA7p+JKYqgTbwp6ABBAzaxTk+AToRPo2QC9Uqy/
 uTS8iaiJpDmvLqIRidJj39KSktP4CpSpTjt2V3kRTprRqIzL37NuEkxccpM5iB7Lf0RCjs+K6
 tTeb7jOCNgSLkMgmR0/onOi+AHK4DGp4O1WfKx6LqoqV9s1Fq4PyWHdyzd5/6M4fjaGI+vCNW
 1TaMs6Uyw7wizt7ymawSnqE2YJdHihj00hw8TsMbbiT0TYpeNUreyPb/95dyLGqPO8k+Z/ZzQ
 9riMOuqEkO8h2xMtw3HG4Umqi2sfRQbsDpsSkl6W7+jVNO8ZNuv55WfngaW27hZr6zLgDffIY
 YC33kXJXCOAB5tDSaBrGVJ2xedGFWtDQBUhXjyKORZwfMtlgxd6bP52UiEye7i08Y9GLcfvys
 hwx+wdmKse/u3TrrP1CFaX4w2mbZuqwQy1kFZAPMwr73lugIa8NdhakZ6NuYBXL8AUhdZ1Xla
 ix19mrBBXhdTbzlxCfb6e2n7o92hVipJws+5hdrxIdhqpTO5Lr0Hv96PR7tUwpgV7L4CvHp9q
 pdzsA5jZ0hSTGUie4yX5OVULJz7Pst5TtdC1ZtzHCSo+PvAlsSP+UohsIpHulL4TRyGJpRs8H
 dJBl1ZB4WJPeTg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/23 06:04, Josef Bacik wrote:
> We've always been failing generic/260 because it's testing things we
> actually don't care about and thus won't fail for.  However we probably
> should fail for fstrim_range->start =3D=3D U64_MAX since we clearly can'=
t
> trim anything past that.  This in combination with an update to
> generic/260 will allow us to pass this test properly.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/extent-tree.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 13a371ea68fc..6b4a132d4b86 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6065,6 +6065,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, s=
truct fstrim_range *range)
>   	int dev_ret =3D 0;
>   	int ret =3D 0;
>
> +	if (range->start =3D=3D U64_MAX)
> +		return -EINVAL;
> +

Isn't the next overflow check would catch anything which length is not
U64_MAX?

And if length is U64_MAX, we just don't need to trim anything, thus can
continue without returing -EINVAL.

THanks,
Qu
>   	/*
>   	 * Check range overflow if range->len is set.
>   	 * The default range->len is U64_MAX.
>
