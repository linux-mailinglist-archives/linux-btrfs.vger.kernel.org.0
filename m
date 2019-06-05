Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0647335979
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfFEJNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 05:13:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:35767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJNo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 05:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559726018;
        bh=OTpejbnu+PktZ38TiKfYn95uJTKCEN2xYLC/k0SoP24=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FEZX4yKZK5tQYjryCEo7XoosGOkuqiY8gKqjbfocQD1ZXecLBP7yyMQDtqhDgPXpi
         JDrCyZNa5excd694ge0RK9/aVS1slrMdHMFBgdLEEh5iQ0umktizJgr4foHJd+Li/x
         E8g0x4tRXyYnX1fXTFZfb0Rw5FbQnNGsxgt6cyMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M6RiN-1gea9S1I2V-00yPRZ; Wed, 05
 Jun 2019 11:13:38 +0200
Subject: Re: [PATCH 2/4] btrfs: Always trim all unallocated space in
 btrfs_trim_free_extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-3-nborisov@suse.com>
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
Message-ID: <065ac952-c620-23ad-2b3b-902c319ad14c@gmx.com>
Date:   Wed, 5 Jun 2019 17:13:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603100602.19362-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0xe0a56Rm7XNecBIwfJrfIOvIBHZR6uM1A5YU+oXdGv477TEPS
 E4sT7qAwjgl+dKYDui3+CvhD1aDU4jwa5SfKl7Rtdr0xTvUU0mp0VsdqNq0L/7otg05mBoc
 +KzMHo/QAfNaUx/glwlXAKWfmJMS7V4D6cJDcOBCVKiFqQQZOfbUNxoCvhPPSBKgm3nmbCk
 lufv9lXjyYk03SLBNwLHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BSrqpD6Zv7s=:Nuen/7VdhOCnb2+N+UM+HH
 4EeJOH6P2Wjjk0Z/w1zbH92Cfrsqjd1+WnjOfGflZzDeI7gIYgl7tXhtuzK347ekNrhFRnn+m
 8bNXqg+OgQYY4SnCmtKjtSHP4vIqhDatC5Fh6jWlFhSKI7NiNnAzgU+R5Kk36i/ZNol4UUK8h
 WLKyi6ExzL5HkjRLKPm9pJ3h88lM2aXkvEFQONcq4JA4bXdXzBOGJr6hCaqWCrB9K2iwxPiO6
 ieYAdmNpdDUTXqVCk0gDKmymqbnEhcUddFjmK0XzhD89OWJ+cz2Zd9GpnxTfj8vJ+Tdqs4E77
 koZ5WOyoVFGuhsTU8rq7m4dOU+PqnYBxnFDPJUoRNNtynG2i1pbraf6+7gthYVewqYdsBRl64
 O8dWu1aPiuoqIbqsMJjZXx0NO4bRd9bmvy9lSshILEwTVXXGkjVlpRzDLxCyfZQOh5jBt7bUN
 y6OQ39xMJPSV+Y1+AiU8U0VaEVyD9x7+0Wrjobj6mQH5Ew2yKhOWnGirqHoimfOHP6vXVjCMc
 xjA9N3BU1UP/9XbFG0tCn8bcbyTqmveEnzb2SPcQgFR+6oSF37Q149B7Nl6pK3p20bt3Wxo9o
 waWXkkjXdDOcs1I7Rx7pjwshiWLnBF061ib4VqiKneIy2LFy4HQ/DqYu/J8EtGnhr6wufZKBf
 PMM+MUnCI/mzmsIL6FswXqgEk+qtaFqwqBHYjBQo43XWnUssGwT1vsIJGl78aun1sd8g1lNyT
 zlAPnAhu3RLsVNR+F8r57SwLru4s0XPaqq/nv4dxU8nJZtj1fTduJyJsMAPG7Wyqw+VKBnguP
 NjObEya3iGc9qWb5YiqpRwKhzMNG7owkqLPKGhcjaZcRgXvedu36aEWQn3YnQP2RQ1YU+WzDh
 SaFmHsk54h1ZTJulDNPxvX2ad87SHwlpqdaMSlLquuorzKa3t40cIFcwIj4ZxMu5zf3N06nYZ
 wZK5rsn2uVjP8gG31tjbiMcaVwG3TKgmp35EjUu8sP/DPvmLsGERu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/3 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
> This patch removes support for range parameters of FITRIM ioctl when
> trimming unallocated space on devices. This is necessary since ranges
> passed from user space are generally interpreted as logical addresses,
> whereas btrfs_trim_free_extents used to interpret them as device
> physical extents. This could result in counter-intuitive behavior for
> users so it's best to remove that support altogether.
>
> Additionally, the existing range support had a bug where if an offset
> was passed to FITRIM which overflows u64 e.g. -1 (parsed as u64
> 18446744073709551615) then wrong data was fed into btrfs_issue_discard,
> which in turn leads to wrap-around when aligning the passed range and
> results in wrong regions being discarded which leads to data corruption.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reveiwed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/extent-tree.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 96628eb4b389..d8c5febf7636 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -11145,13 +11145,11 @@ int btrfs_error_unpin_extent_range(struct btrf=
s_fs_info *fs_info,
>   * it while performing the free space search since we have already
>   * held back allocations.
>   */
> -static int btrfs_trim_free_extents(struct btrfs_device *device,
> -				   struct fstrim_range *range, u64 *trimmed)
> +static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *tr=
immed)
>  {
> -	u64 start, len =3D 0, end =3D 0;
> +	u64 start =3D SZ_1M, len =3D 0, end =3D 0;
>  	int ret;
>
> -	start =3D max_t(u64, range->start, SZ_1M);
>  	*trimmed =3D 0;
>
>  	/* Discard not supported =3D nothing to do. */
> @@ -11194,22 +11192,6 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device,
>  			break;
>  		}
>
> -		/* Keep going until we satisfy minlen or reach end of space */
> -		if (len < range->minlen) {
> -			mutex_unlock(&fs_info->chunk_mutex);
> -			start +=3D len;
> -			continue;
> -		}
> -
> -		/* If we are out of the passed range break */
> -		if (start > range->start + range->len - 1) {
> -			mutex_unlock(&fs_info->chunk_mutex);
> -			break;
> -		}
> -
> -		start =3D max(range->start, start);
> -		len =3D min(range->len, len);
> -
>  		ret =3D btrfs_issue_discard(device->bdev, start, len,
>  					  &bytes);
>  		if (!ret)
> @@ -11224,10 +11206,6 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device,
>  		start +=3D len;
>  		*trimmed +=3D bytes;
>
> -		/* We've trimmed enough */
> -		if (*trimmed >=3D range->len)
> -			break;
> -
>  		if (fatal_signal_pending(current)) {
>  			ret =3D -ERESTARTSYS;
>  			break;
> @@ -11311,7 +11289,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info,=
 struct fstrim_range *range)
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	devices =3D &fs_info->fs_devices->devices;
>  	list_for_each_entry(device, devices, dev_list) {
> -		ret =3D btrfs_trim_free_extents(device, range, &group_trimmed);
> +		ret =3D btrfs_trim_free_extents(device, &group_trimmed);
>  		if (ret) {
>  			dev_failed++;
>  			dev_ret =3D ret;
>
