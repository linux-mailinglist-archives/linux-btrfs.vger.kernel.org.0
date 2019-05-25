Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E952A264
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 May 2019 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEYCbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 May 2019 22:31:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:52149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfEYCbN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 22:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558751466;
        bh=nBCNtJ5tA1azQhucSuYUGGC5716gNeXXK0XBvb/v9Ek=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k2OM0GtLBJTVP/mZQHBAU9r4JX4DLQvvlRdo2c90hxpYNAW3uK9bMmTngWc2KlTXg
         1bBmyAicvrIlVNG5AfCLJ4K02m1oKcX0l2KT0NPBqVRQjCUK7EgoPhy+RljG+7q26/
         LUZu8MTBkqHjueRSTFCP1x56CBunW2V+vKPXp3YE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MMTZa-1hYE583BfS-008HwJ; Sat, 25
 May 2019 04:31:06 +0200
Subject: Re: [PATCH v4 01/15] btrfs: Honour FITRIM range constraints during
 free space trim
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190327122418.24027-1-nborisov@suse.com>
 <20190327122418.24027-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <13ab6ca2-0e5a-3538-4bbd-753db45ed9e2@gmx.com>
Date:   Sat, 25 May 2019 10:30:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190327122418.24027-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K1RVw7qD9mrA4E83QMC0tugkJ9R6H4nevrS7UpQYZnWdAGynFU2
 Eqd0n99VghH4YHKRs/SogfEKWKxlSpf5z72ZiTwFXwaCIf2EruoSWTm9nZTZoiVJUUR/T1W
 6IaJxSaGrkca2UZOaicDdnX9ycc5kyGDB2moqHVmu/iwCh0HL3GWRa5A930Qlh/GLC/uprz
 fMVs9U4u9Ocw7WlKNocEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s7jYcMJ5H1w=:UNGLhZgrbqlWWgrVNM+MVn
 kwtSh6708z4a43h0yDkV2wzmo9WdNdlaDNpYIOniQLrqFycFaxRhLxTizoX/Z6wW2DWgSELo/
 8vY2vHBG/s0EasL/NuThqCxNLicdVTWUoVeJQ4zyqiupMOZ+F+qp5ED2UvPh2GBa9XrAPdRVj
 6eq2zTUdC66YwwnfkV7mgnr4gXPtjTw/pZhersh3HaJWkfvsinKWw1a7O+rgYwaDTaUUQiJQi
 i6dELNzxCMdUJfwVJLggmGBPucyrr9kZYa6d7by7RVQ2N4kd/M6Tt1xuUW0i739y7o87x6FD8
 kHEu734sDLfMTSpKfnvXRjj2cs0lCQz1kTJhvPzy9F5Sh6kYjJ3wP6jPxHHBQYWC9Tfwg9ZNH
 vrnv/95EIAVtAtT8UqpirBKP4n02faPMph9nznwDmDpDdOmgpeOCkiZ7zmM7FKsV8Ys0ODKd3
 +TknujVZDG5thdabTd0X7RK6jgodJg3M/IaBWeT6zwwsC8f53nLsYHYbXSDZ3st+BR/rhNs2q
 v0z2mJLR5QooDcir/nJmiCbYNRN1eC4pTwbN9E1Gk5+LBDxJfQ/Bb6t1iES1mA+fFGeiiD5v8
 KMFSIkCCD0wgl4rQXSXbQfTVLLsAwQk23AA4g1aLxJ85EVb4cz43RKTkMo8tdYRzjdew3SLJf
 8WCWpd0iSX8ouUTpLT9h2yuEBihoFpxl+X5FHyeMY4ikAakCFzp4ildO7F359357NAcCwSkv2
 SjP9f8eRZnNoMDKxbUg1rLPJEKtKqFD7D75K3Sz5h5EmEPQzBnHqEFbzmC+IGF0c1UwN3IMGu
 Xrt6H7tNFWj7/AdJRGsqrN296+CD2UnSIDNV0I9ZlH70CK68fG5fVH78aHKKSCamW/vGzZo2f
 XGT5iF7LVXby9veSoyLATCPWK211lwwMLUpMwOqA6JflvUk/+NrW3ZSmLa//r971HYrzGog3o
 /sU7zqCZMD04qvq3FUO6ghIHp4X3o8TbH8XQthYSfHwym05xQGC54
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/3/27 =E4=B8=8B=E5=8D=888:24, Nikolay Borisov wrote:
> Up until know trimming the freespace was done irrespective of what the
> arguments of the FITRIM ioctl were.

Since commit 6ba9fc8e628b ("btrfs: Ensure btrfs_trim_fs can trim the
whole filesystem"), btrfs in fact follows the range parameter.

It interpreter the range parameter as *btrfs logical address* range, so
it will find any block group in that range, and trim the free space in
that range.

> For example fstrim's -o/-l arguments
> will be entirely ignored. Fix it by correctly handling those paramter.

The fix is in fact causing several problems:
- Trim out of range
  # mkfs.btrfs -f /dev/test/scratch1 # A 5G LV
  # mount /dev/test/scratch1 /mnt/btrfs
  # fstrim -v -o1152921504338411520 -l10m /mnt/btrfs
  fstrim: /mnt/btrfs: FITRIM ioctl failed: Input/output error
  # dmesg
  [ 1253.984230] attempt to access beyond end of device
  [ 1253.984233] dm-4: rw=3D2051, want=3D2251799813181440, limit=3D1048576=
0
  [ 1253.984240] BTRFS warning (device dm-4): failed to trim 1
device(s), last error -5

  At least we need to verify the range before using it.

- Cross level interpretation of range.
  We have chosen to interpreter the range as btrfs logical address
  already. Then it shouldn't be interpreted as physical address any
  more.
  In the context of multi-device btrfs context, we need devid to locate
  a physical range, and the fstrim range doesn't follow it at all.

  I understand always trimming the unallocated space is not a good idea,
  but it's even worse to interpret the fstrim range into two different
  meanings.

I still prefer the old behavior, or even a step furthermore, even ignore
the range->minlen as it makes no sense at the context of device physical
address.

Thanks,
Qu

> This requires breaking if the found freespace extent is after the end
> of the passed range as well as completing trim after trimming
> fstrim_range::len bytes.
>
> Fixes: 499f377f49f0 ("btrfs: iterate over unused chunk space in FITRIM")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b0c86a817a99..dcda3c4de240 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -11309,9 +11309,9 @@ int btrfs_error_unpin_extent_range(struct btrfs_=
fs_info *fs_info,
>   * held back allocations.
>   */
>  static int btrfs_trim_free_extents(struct btrfs_device *device,
> -				   u64 minlen, u64 *trimmed)
> +				   struct fstrim_range *range, u64 *trimmed)
>  {
> -	u64 start =3D 0, len =3D 0;
> +	u64 start =3D range->start, len =3D 0;
>  	int ret;
>
>  	*trimmed =3D 0;
> @@ -11354,8 +11354,8 @@ static int btrfs_trim_free_extents(struct btrfs_=
device *device,
>  		if (!trans)
>  			up_read(&fs_info->commit_root_sem);
>
> -		ret =3D find_free_dev_extent_start(trans, device, minlen, start,
> -						 &start, &len);
> +		ret =3D find_free_dev_extent_start(trans, device, range->minlen,
> +						 start, &start, &len);
>  		if (trans) {
>  			up_read(&fs_info->commit_root_sem);
>  			btrfs_put_transaction(trans);
> @@ -11368,6 +11368,16 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device,
>  			break;
>  		}
>
> +		/* If we are out of the passed range break */
> +		if (start > range->start + range->len - 1) {
> +			mutex_unlock(&fs_info->chunk_mutex);
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		start =3D max(range->start, start);
> +		len =3D min(range->len, len);
> +
>  		ret =3D btrfs_issue_discard(device->bdev, start, len, &bytes);
>  		mutex_unlock(&fs_info->chunk_mutex);
>
> @@ -11377,6 +11387,10 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device,
>  		start +=3D len;
>  		*trimmed +=3D bytes;
>
> +		/* We've trimmed enough */
> +		if (*trimmed >=3D range->len)
> +			break;
> +
>  		if (fatal_signal_pending(current)) {
>  			ret =3D -ERESTARTSYS;
>  			break;
> @@ -11460,8 +11474,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info,=
 struct fstrim_range *range)
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	devices =3D &fs_info->fs_devices->devices;
>  	list_for_each_entry(device, devices, dev_list) {
> -		ret =3D btrfs_trim_free_extents(device, range->minlen,
> -					      &group_trimmed);
> +		ret =3D btrfs_trim_free_extents(device, range, &group_trimmed);
>  		if (ret) {
>  			dev_failed++;
>  			dev_ret =3D ret;
>
