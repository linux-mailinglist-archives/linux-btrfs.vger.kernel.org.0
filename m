Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC114233EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhJEXBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 19:01:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:54163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhJEXBr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Oct 2021 19:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633474791;
        bh=hAVk3gHe+jRBH3ZgtY9vD1DJrb9I5GGYUKe5pQyCS+g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MdAmh20J4kz+Oijb8ZyoX7BWlDAfgTeaOrlYTnvoCb3nG5IpbhZKG4nmGQW223FXI
         jMqs0C3/zpfuCAwd8SGY/7OkJd6eQrp679OsLpoMh9TQkLhC3oAgRhCN0dqzVsAd4z
         ULI5y/ifpySjH6HVvokJ0YGiL9cEVSHX3Z13asQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1n2XGo3Oka-00doVW; Wed, 06
 Oct 2021 00:59:51 +0200
Message-ID: <93c1c300-125a-1436-2a87-94b78a5374e8@gmx.com>
Date:   Wed, 6 Oct 2021 06:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: remove data extents from the free space tree
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <0394a30e2d64f3a418c7f502a967b9add5632577.1633458057.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0394a30e2d64f3a418c7f502a967b9add5632577.1633458057.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qdNUC4r9st5dS7qQTXJDHXCKPMwCZPVn99sjOneXfFQ6UaXrHXV
 qxLXr5ClqYnQRPxYNWdVBqSUTXKZFVwe901CfbXl7cEkqPs+z8uZzk2Zx0NTttL+NhY4wVI
 fU7lokTWzYF4l1PjOq3GvXFM1nYsdaXhY373DTuoH0ThEBz6QJctsbbB+JizoPIgFot5Tiw
 3SgxESJHrPXX7cTy6+ioA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKGd1sdv/eQ=:CUue0rGQIYtLpI+hOfWSu7
 7Vp35ysg3DwcSpraJ6jFZG6qQMm7yANmPMCcxEv1QcPv/ZNl5+Aap9TMdfO1m9LayoUZE/WgS
 +uPcPRS6WDZxU+JvYfMKCdH2Es7t47vVtGa30uCU7CBSdYHF7d5E7RUOLC3N/mmw8Nc07AU9i
 LMYm7Zctw+uGhUqbsdHLlLjxKKlkhlhs8H6wAQ9kKTcEM3JUgyF8wt/a43oINgxTFxlYoF7ZH
 2Gd5ZMgTqatwT31afuZS5RXfZvOY0u+t/I6g7QHsn1+7WapMYt9TDhGK7qvuYMi8CvRQ4DHBO
 o2c/m1jY+og7zH6s3z6nasdT8wbwA+17Ovg+a4phSuHaxJtRhg5Z+/F9bL7cJfqv2UmaXkvGl
 WhYDnH9FbthcYNBp0k1RkFVPLI1OY0fFFmPyKm4V9kLdXmA5zA4t4hpaRbS2gVIeUWEL/JsU7
 P7QYQcXkfWG2eUAtQFhjWN5tG5pZN6wRHRcSKVR1U4/5OXDk0THf0YtMyDhtTZxiuhweq9OrK
 kxvH6jyNNwXe4uxutlvIrGL7syol2rWlHkrckSQhl2934z7Cuy8skpQFBDoYVLl39yQKh76hQ
 P+ZjRnKz7GpTLjSYgSx584UBrraE9acoXUC+wKYcFH/kVLZTfy+HGcXsrLVM2Ty9+Gf8YqXQJ
 MORy0gWDRO+tae5QDccwLXm9N9PMn9Jh7PCdvKvSnMEkFIk2wDfYI/GDyQMom5z18HDqkpDhB
 0daBWnNuLEHUoWrURJYNRIeD9XNPNY9gxPbIm4YeqcbM3kB6cVmngIYpK0f8m7FTxrd+GgzCr
 9wxaLKF7kXu2KHGG5BxUE/NU/7UGtOCndypZ9idptcV3l2A2BmwsmuFj9mdyAOXRCt4lCZhe1
 1vHcWDWJ/qRqvX5CwO9YAlbc02/D5XK99PNE2QVgAgj3njoi1hyYQ2xico1R6Vg98KYc4HMuV
 eY7n0MpombFw3viv+pfXC62574rj93G8/oRt28jGoG5w1L6jdQHyuSwmMHbko3Y0DTxh3RCiV
 Uad/W9DhEB6G5IF9gXpwuaY4u5wvYo19QQLvIg85u2BB10JskQZBn/80gEQpuIFM5qfxSxe0F
 NzQ3eGHFPiKTgQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/6 02:21, Josef Bacik wrote:
> Dave reported a failure of mkfs-test 009 with the free space tree
> enabled by default.  This is because 009 pre-populates the file system
> with a given directory, and for some reason our data allocation path
> isn't the same as in the kernel.

Mind to share the exact difference between btrfs-progs and kernel?

Just hope we don't miss anything.

Thanks,
Qu

>  Fix this by making sure when we
> allocate a data extent we remove the space from the free space tree, and
> with this our mkfs tests now pass.
>
> Issue: #410
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   kernel-shared/extent-tree.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 4b79874d..90733d55 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -3483,6 +3483,12 @@ static int __btrfs_record_file_extent(struct btrf=
s_trans_handle *trans,
>   		} else if (ret !=3D -EEXIST) {
>   			goto fail;
>   		}
> +
> +		ret =3D remove_from_free_space_tree(trans, disk_bytenr,
> +						  num_bytes);
> +		if (ret)
> +			goto fail;
> +
>   		btrfs_run_delayed_refs(trans, -1);
>   		extent_bytenr =3D disk_bytenr;
>   		extent_num_bytes =3D num_bytes;
>
