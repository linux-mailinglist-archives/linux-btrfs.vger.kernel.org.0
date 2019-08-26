Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3439D000
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfHZNDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 09:03:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:56237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfHZNDe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 09:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566824607;
        bh=cleWSdrCFltiZZ5GfYtOQDshRn7r+FuQyx6F5SNveHs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HGrNJgsSsLUse+zsSWh0RVvUs2T8ruWc1Jb8hK4TVboUFNYJrTNGtP4qnxD4GsLbB
         mlysYjxrE48p0HfBLsz2kwfdP5bmHn0NUWrWqPcEZKTFNupjbtJSxb26krC3ZMf50j
         wDN1I4B24NsSW5A6eAZsFdV8ptkeKHvUzssnOvns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1iYHYL1snD-00ph6j; Mon, 26
 Aug 2019 15:03:27 +0200
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190826123728.2854-1-nborisov@suse.com>
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
Message-ID: <c758a9fe-e63c-52a8-2518-fd0a5128c1b9@gmx.com>
Date:   Mon, 26 Aug 2019 21:03:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826123728.2854-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gOEtnVVRROlnuL+hWosCF7jzm1uYMQiJAINlG5KPd8YOhBWhgS8
 9GiMuz6I+bQEmiyg7tgPlq0eGjoC1Yesx2dfHhDkj4vCYiHcpjhqQq3wx6E77ThVnGhUw1R
 Kn7q1QguhxSHTGj+WmkdjVOjPWr9WRqTDbgaK5cC5LFhP2lDqDI+jswofem5CPblqgcOug8
 KN8UsNKkC+Fv+ysCSRqbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aAfAsZ887ZU=:SjIspWs/iIeYLHFqqzuu0E
 10817MyNaStN7MKb8GLWNHCN60dLrCsN4zs9q69wlAll/z/gECBy0IZb6jEk3Je6IUlUfEgEF
 wGUt8K7PNAqd0WQAk/tPWYKTTElUNWfTNPmccFqN8Mon9BkFsN+un5/02++UWUa37hX3Ylc+0
 cnorUU3+rxjxcg8mPxPxPpDEcOl0nbtKShN6UvlvXlVBeuwW7Y1SjshnpzKY5UmECCEOeS6gC
 RXb645jB1Gn+2YT54foY5p/+5Uvgozl8ziCmdRdLHGqN2njMNYOSDJnob1YgA6tfFL4FaZ80e
 7/aqjZH3W2zHn0Vj1grvAUVrw/d9mmCXcQi4Ke80OEDRR2mVEi0Z0gTPSoTxk+QpH54JPqgX2
 +TPDWJo6G3Z6j5io5GTIQKHxXZPRFJlwcRZDEkH2LX3mJhNZDEJNCg/qMw9IuJBA1m1wj3XAN
 J805dIWnNJQcA4lYTVsbJfbCZDpGwc5/66QwGfhzaNm69YrAbPH5foVqPU5sXg8vOX1+nLGya
 DKopZhDnKIxG5Lzfpd8CGP8DjwNKsbhb6XcPhhMsT3t5qJXylQI4geMrBmBRlVALeS13ruMGr
 rE+v161EgcGERt60ORSEwgtlo9/wgYoSnMzDt6TBlsJ+OrIFvU6eTzrcSaGMr0BJ0B+sxjANB
 RcOBWe02VKozq1ySEXqJBzgsvykNI5ftpzeqRnx1j6VXsDeKBHt4pGsAR9+CekkGyBmXwg6KY
 vixlLfi/dOBNAaFy+QEaGOu78rIMadgvm7J3cKuZ3SFCvwJYyUle4r0mDVUL2Z2n0Fzpwq6Fq
 Pm1ek306c6++IOXeB6thjuZXdZ47lgTCKy8KXo3kyM8dyfv88UDtGtBLXyzqN8k+qPsO/L+47
 nPaqDbr46APzaKgWBXT2Ulqsg8OsCuI/Do12SS1N8RQPRkl+wXC8lTfJILbYRFRXg/LtaMoJh
 rynGfm/iFSA7RW2Sm9W79NgZG5q7ZxWv4oj5oj3Zp264IatA7ogt+EZ0SQ2Y78iHTEfPJ13Er
 uKKmL/IH+x2o5Fki4/Bn90GnsJFwrHW59DTvZecbQ346/Dk9CB++swDH6o8HoWhUC05OcDPj1
 KdIPZgybJQgeKPwJnZ/nBHCA1oN6cdo8XSsaQYMY7c0eGNnx7kt8E6X7FIL0C2yuRIwOYTOWF
 2U6lE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/26 =E4=B8=8B=E5=8D=888:37, Nikolay Borisov wrote:
> Support for asynchronous snapshot creation was originally added in
> 72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
> ceph's backend needs. However, since Ceph has deprecated support for
> btrfs

Any reference for that?

=46rom what I have read, btrfs is still supported, although only
recommended for testing/development.
=46rom ceph filesystem recommendations:

We used to recommend btrfs for testing, development, and any
non-critical deployments becuase it has the most promising set of
features. However, we now plan to avoid using a kernel file system
entirely with the new BlueStore backend. btrfs is still supported and
has a comparatively compelling set of features, but be mindful of its
stability and support status in your Linux distribution.

(Anyway, still better than the not recommended ext4).

Thanks,
Qu

> there is no longer need for that support in btrfs. Additionally,
> this was never supported by btrfs-progs, the official userspace tools.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ioctl.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c343f72a84d5..a412bd2036bb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1837,8 +1837,12 @@ static noinline int btrfs_ioctl_snap_create_v2(st=
ruct file *file,
>  		goto free_args;
>  	}
>
> -	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
> +	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
> +		pr_warn("BTRFS: async snapshot creation is deprecated and will"
> +			" be removed in kernel 5.7\n");
> +
>  		ptr =3D &transid;
> +	}
>  	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
>  		readonly =3D true;
>  	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
> @@ -4214,6 +4218,10 @@ static noinline long btrfs_ioctl_start_sync(struc=
t btrfs_root *root,
>  	u64 transid;
>  	int ret;
>
> +
> +	pr_warn("BTRFS: START_SYNC ioctl is deprecated and will be removed in =
"
> +		"kernel 5.7\n");
> +
>  	trans =3D btrfs_attach_transaction_barrier(root);
>  	if (IS_ERR(trans)) {
>  		if (PTR_ERR(trans) !=3D -ENOENT)
> @@ -4241,6 +4249,9 @@ static noinline long btrfs_ioctl_wait_sync(struct =
btrfs_fs_info *fs_info,
>  {
>  	u64 transid;
>
> +	pr_warn("BTRFS: WAIT_SYNC ioctl is deprecated and will be removed in "
> +		"kernel 5.7\n");
> +
>  	if (argp) {
>  		if (copy_from_user(&transid, argp, sizeof(transid)))
>  			return -EFAULT;
>
