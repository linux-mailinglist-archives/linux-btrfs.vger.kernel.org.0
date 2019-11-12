Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62787F8FCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfKLMmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:42:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:32925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfKLMmF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573562440;
        bh=ZwokcC3A+N0MXi0JdC3FLEKiOdRbdXFD4fcjt6OBq0g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ceAN9nrg0pGjSqqamXqOb0EvVZzuhLu7yshAJaIxC1qJpoe8eppHWOjtprL30bqdq
         E424cOliQGPr7LvKSikk6okEhTgawko4RO2fk1xnRHskbktxTvUTmpva3yhS2Ev9cB
         SbOzrEP7s+o0CkA/3sGWFAMsxLFYRNticv1+KbAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1iYvKB1osy-004Tre; Tue, 12
 Nov 2019 13:40:40 +0100
Subject: Re: [PATCH 0/5] remove BUG_ON()s in btrfs_close_one_device()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191112122416.30672-1-jthumshirn@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aa11c13a-1714-308e-9d79-ba8db3182439@gmx.com>
Date:   Tue, 12 Nov 2019 20:40:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112122416.30672-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IS9niETzmjIEKupgqwpIsr6wNYKiQkpE/Vm1YRx5OxYKM2sDmII
 wGnojG3yg7EhTKJxzj5gEXgCweKyCttAKRMoLFm+BARGd0Jm0OzSIQFBALuCGsrHKu8WGju
 CXd94tgACGB4zunix9YI8mpEgkZR13PrY8p6TE5X/TEk9S8BS0frwP5T8h98CP//8OEadhr
 AQDSOoGXpKBa3gyTEIY3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O6O4ycE1b5w=:oysZaC54URKh8ee+EddXnZ
 s1TGNFP27guyjIj3hChx/XO4aMISXrHmnDMv+xJrxRSDCZ4uEpIha8fvvmUTGDvPTQZII2CAD
 zdUL/+35wJWlVvccgo0PH7tghGIOS3ObpQ/c4bOHollcuquYKD0SwKuVfY9LELh1nv6KMsN8A
 eBoJiUMIEEYKXjLaklNEoMdq+KETJx8cWgst42spPSuzA/bKMHTgWbsaArA1w2yXN1DddU3nI
 0nVLgyIEzh0bPTvDTRmPhcUwVG9lRtyU5jacHVUFNB3duoPK/+R84KmTnN3HAHDs0zZ6q2Tba
 EsEpwZExVQ/dTFlirDqbkbWhOFYkZPTMrZ7Y/IcwXborQ12gsdBPDvqjgss7Gj481X46J4knr
 ZIvwQbxUj4ZJnztsEqFDd8cgTEsTbK6agHNyShmK06qaBJzoIukMbUrr6BmB3Lt2OI0jnS/6D
 SgDcEorHaCRFwAK+KbxA0OD9/RTRkItgXCAmHrWB782vCTOW1GLLD4zZcTihLo2Wf1eDOv2Oz
 Tahd+2KlQHtoRYAAr2p8sl8P1Zln/NuBI0ZQBdgRKCDDXp5D5zpilNJZzduMEJrMMhlXI8S6p
 SFL7XKA/i2P0PLvd5GkifYl6T3xbvyQsIOykLFXZjkPYA75p5bg/+yGUc8nWzzl+6Q54V/HdC
 bAisTA6QYu/todS9k2NbB9m2e6e8vHTn5DuaDzb5z3V/DwJOCzL+A5mPtdIJUt0emzuKUkWeS
 wkfd9V6tMeOKnCOq9y01A2l2sRqfTSt30y5SQBouNGXeh76DKgpAqRvMZaOxsNAIth8B55n8e
 hkgnWPmXgFpBEA5ELblVkuQDA97phqfQAmyKv99Lb3kAoe77rNqVFP2eSOR/lM1waXuxbBV2q
 yF16I6uaDb041TJLYCX8aQ+N+8jU/tepE4Dk1y7Prfacs4ZIFHUGFoBh7bGuZldGAh+zrIjSV
 uOOLm6xbE01fPVoax455Ai3vF29/ARH1plNVZqISvNU1zwjFmT+8x/70red5JH/yQasApCozB
 zZHg6Nl6uPIB5Ls/mZy+wHL00X+yfJjrJFqHTmRY7dOyHjYkdX/Ri5g1gOHn7Oh2qRwIU09SO
 Kn/1FojpEWkVyTF5DR6jiAwgRWqN/cOd/1/GxV0MjUZXYd+eHgIyOSrGZnGYoG1YneUKB6sJ4
 wImyZrsG16arhEiMtRSQsfEEwyCO4Tj/xCRH7+na7hTIkrRISRQCprvyCOU4YvUlYeU3oGeLx
 0gOBp4ZqNdNJh2ZrtipwCQUfKdJJeni1OvcrOvriYlM7UCu3KJ74p2f9ENrk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/12 =E4=B8=8B=E5=8D=888:24, Johannes Thumshirn wrote:
> This series attempts to remove the BUG_ON()s in btrfs_close_one_device()=
.
> Therefore some reorganization of btrfs_close_one_device() and
> close_fs_devices() was needed.
>
> Forthermore a new BUG_ON() had to be temporarily introduced but is remov=
ed
> again in the last patch of theis series.
>
> Although it is generally legal to return -ENOMEM on umount(2), the error
> handling up until close_ctree() as neither close_ctree() nor btrfs_put_s=
uper()
> would be able to handle the error.
>
> This series has passed fstests without any deviation from the baseline a=
nd
> also the new error handling was tested via error injection using this sn=
ippet:
>

Good patchset, but for error injection we have more formal way to do that.

ALLOW_ERROR_INJECTION() macro along with BPF to override function return
value.

There is even a more generic script to do that:
https://github.com/adam900710/btrfs-profiler/blob/master/inject.py

Such tool allow us to only inject error when certain call sites are met,
so it can be pretty handful.

Thanks,
Qu

> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7c55169c0613..c58802c9c39c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1069,6 +1069,9 @@ static int btrfs_close_one_device(struct btrfs_dev=
ice *device)
>
>  	new_device =3D btrfs_alloc_device(NULL, &device->devid,
>  					device->uuid);
> +	btrfs_free_device(new_device);
> +	pr_err("%s() INJECTING -ENOMEM\n", __func__);
> +	new_device =3D ERR_PTR(-ENOMEM);
>  	if (IS_ERR(new_device))
>  		return PTR_ERR(new_device);
>
>
> Johannes Thumshirn (5):
>   btrfs: decrement number of open devices after closing the device not
>     before
>   btrfs: handle device allocation failure in btrfs_close_one_device()
>   btrfs: handle allocation failure in strdup
>   btrfs: handle error return of close_fs_devices()
>   btrfs: remove final BUG_ON() in close_fs_devices()
>
>  fs/btrfs/volumes.c | 68 ++++++++++++++++++++++++++++++++++++++---------=
-------
>  1 file changed, 48 insertions(+), 20 deletions(-)
>
