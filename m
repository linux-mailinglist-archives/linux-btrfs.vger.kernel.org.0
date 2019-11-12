Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17983F8FD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKLMnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:43:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:59357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfKLMnO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573562515;
        bh=8gSq4Hf0Q2BntII+T3h2Rbbbcq2YVYB6HDMCTRS6CcM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kWXU6OKgEjDYVRO12AVWfPiVdMmV6nroIQJOFUPHa6CL67Vkgt1xi32aILb+0bRQ1
         T7Rpxaxx79x+XuAz+nElRl99HL3AFIHC4dk46D6hRmEYF9LIrCdPLoa4Qh2LDHbOkR
         CkUABkL7jUjk7oVKPEMhZihGHcqcuQXMXCQ7SVjM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mdeb5-1hvRn13P97-00ZiHg; Tue, 12
 Nov 2019 13:41:55 +0100
Subject: Re: [PATCH 5/5] btrfs: remove final BUG_ON() in close_fs_devices()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191112122416.30672-1-jthumshirn@suse.de>
 <20191112122416.30672-6-jthumshirn@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f474ee05-5343-3a52-5e79-d4199828a8ee@gmx.com>
Date:   Tue, 12 Nov 2019 20:41:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112122416.30672-6-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ePeim3t0mO00F67LM4KrGrnJAloz+CN09CoFE2ix6sH8WLyL6P
 LwCqUt+4TJLVi/5I8EYLO3623lqV0PNUm1L6fwulndHXWT5+ShO7RZFOswn+WsjbWykFfMZ
 DwoHK9RwV8WGEsB5l8bwnPhbC9nkdzgH0DoHhLqbLwWWbVSX21yEJlhiR9tq41NgkMMH+l3
 SFsRMWGHh7/jtpcm1+gWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jAaZ99ruRKg=:JOygaF+KHsKxkPd0odFmqJ
 bLCP135bhSJj4iL79QUGFlZtm3WUYMVXXRGVk32lTC84/OCHKxoKq53IlKw9UwVUlpE1PxKQk
 PdXZU8TGbP41FwGm7Btz7O+axOO/26D/wV28Zyx1GjL33DoVMOgrC03vVYpU/GKD0IrqT5WhP
 chcg7OAJz5L7cCED9FGoEW/s/PngNVrwZPAuxgH1GUmkCuZqu7YF0jiR1s1kOJIIElkbt//vF
 rM/2IHyxJAHd0XnbImmQxnTrwlXOMBFfq8dLVqZ7dVyWLPrqzyWLgTojPL7zDWirxGHW3/WuR
 K+H+oKkXxhw3mhxfj4bLAYzVSlbbFVpeTenDJWCBX85+EfNECNGF8zg/0C2XbfXqklCRHZzjE
 x5jq3zfIJhjaCLJxlzCtB6abMGOdKkQT9AaKD8W//yWbTQM49ofyYXY50vODYv9wIq/ikawOl
 drBrLSod+sP6KplHG14TYtRIe9Zmp2I4Lf+ZMtR92N+XG5qn2dbECC29sJ2by5bhIWZwEHYiy
 MRoTWpIOwsEZsqyVyecpxqIYJkpCt4yo4+6f1Z9H9qHY267Io6Eg+OaflZ7mxhm4eSb3FyoSL
 tJYaWOFKw8742WVQK0b/QGB3uml4kTy/XXEAxyhvvPZVZfHcRBaxYL57Wgu7Daha9ZxJv/zOw
 9U1lLzfP4pxGkSUBuTDFHcw6jN+zcm1W5WZbXyYRsTsUHXsNfNqasoBDFOQI7BkFcm1CDNlkd
 MJmedGc6J/9GhB3A/6AOC3i7h+yl2q8oijbiEuV5aWPCzHu3mVA7K6Xm/9B10VG5DgL5QeMDp
 RQt3scJjIYJ0IJIOJfS+Ysszmm9R//h02P6RXbMxgwzezymP7t/C45ZVSYk2dF8pE4px87Pxo
 8pf2IGPzogXDIYnEikoHipeaiIPOB8/zKVKoCG4H9jlerHwXVkPTNHnlmbX6i1fjiios/kHfb
 bt52VItK/QHSEKKWPLdVigwlIqSkvx0rSKqhCD1lg6NdP5Hbr7SuA+8lGUi3Oadtf/cZ8hSd4
 ddBkysWTkrYLGVW0Dg68970G5qNMw9EnRGP5izzrAMH4jIkFSU0VM+oTD9vRLXwv7cOuuvMel
 GY3IJnZxADe6M3vIY0uy2SWjdU2cX2eRpX1WkkxM6QYPOwujeGdFXtI1zecBMChnIplhSjPZ3
 o4K11yBugxrJOfH03aL3ELdZb4EWbor7zJUXvX8zt9382EzwsZc3UIsSP5YNTAKrPbDFTOdEF
 G8yMkgyyxEP+Jj3yESwuks51e/9TmJEn8hmmby6p9fSdAbBsTHEimQHqxHyk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/12 =E4=B8=8B=E5=8D=888:24, Johannes Thumshirn wrote:
> Now that the preparation work is done, remove the temporary BUG_ON() in
> close_fs_devices() and return an error instead.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/volumes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index be1fd935edf7..844333b96075 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1128,7 +1128,12 @@ static int close_fs_devices(struct btrfs_fs_devic=
es *fs_devices)
>  	mutex_lock(&fs_devices->device_list_mutex);
>  	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) =
{
>  		ret =3D btrfs_close_one_device(device);
> -		BUG_ON(ret); /* -ENOMEM */
> +		if (ret) {
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			return ret;
> +		}
> +		fs_devices->opened--;
> +		fs_devices->seeding--;

This seeding-- doesn't look safe to me.

=46rom what I see, fs_devices->seeding seems to be bool value (0 or 1).

Wouldn't this seeding-- underflow?

Thanks,
Qu

>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>
>
