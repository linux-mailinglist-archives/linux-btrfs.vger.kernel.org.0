Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C819D0B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfHZNfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 09:35:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:49857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfHZNfF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 09:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566826497;
        bh=QvTkBiMlg+sEVBTtQGND2fRDcvlyTPEEiSLu75/lCZk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DAIG3jYOTFapDHvM/NAnB5cx2j1VIvz+eelq9dSRMNdQCGenMMWh8tZ/n1qhFt+Qm
         AM+BcrH4f8BEz6Ff28psaWEOF2l9UxFyjNznEmuiHEFGY69sX1FsGeXbpN3kqCfZ45
         6bKDSqVKjZeCAmT6l7a6ISXPr+jOVraUPf89bvvc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDIo-1iSTE9036W-00i8td; Mon, 26
 Aug 2019 15:34:57 +0200
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190826123728.2854-1-nborisov@suse.com>
 <c758a9fe-e63c-52a8-2518-fd0a5128c1b9@gmx.com>
 <93d47492-8a82-d3f0-e421-1697f9d13f26@suse.com>
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
Message-ID: <9328a1a7-3250-5bbf-0d30-903b89549d2c@gmx.com>
Date:   Mon, 26 Aug 2019 21:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <93d47492-8a82-d3f0-e421-1697f9d13f26@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1IEIbDou6oWxssruoGFv6XosC3H4prK6q8YNerzbm962JZrlRmO
 R5Tfjd+vb5WwtFSXxz9mua5V5VRD94o8IpxAnalddiIbfcroNuUriFnwf2lOpfWugR/fNiQ
 Wks9XU4IRjpzkzDV30EAXMtfYf+csT5GWXQx2oWADhM66kRUEtceJuo88Zl6ICAbKlnd+cc
 BMFpeEZ5dtoK16SiHI0sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmnZiz+eRFU=:M8NXiKjlZqEZ6dD6hJg8Nm
 QHsG74nWtX9KHJy/wrXUyOQ8jpW1YUIxjumrl3/Szxv5pcHdvjWIyU3V88zyYx5xaKBxfT2Im
 05O14c9G7gCFAOTXAtOvGBnANd1YM0OWHMzSBsXc2KXHzowDEmV8LaJutkuB4ooAiLPFVgClI
 qismgoj1UQ8ExKGuDJC1zkfPLCPWGuUML8+Hfg98CxGcrz5IMBYVggFSDQ0AXMHqn5Tyh6bZp
 rNUj3xP153l+7Fv04TusHWAUmn8RQq+HGsPK03c29vglRRIMTGQDSIQ/YcFtnoAiG/kQm1+/J
 o5Zu9PTf/m3BcegTCn9SC2+K8S5T8/O8YROqcvHqe673TYhaFzD/Cfh3R/T4v4GaARuiXm8OM
 BskZZT0bWkZPSeCB/+7JW9Xe7IScKCDmNTibWwwiKPAMOUWx4U0wuhR0PSMdTTDyfK92DTlxB
 gzFeY+n4CPLpTJ1trVo84EvUgapUiukekNxO7MXYkgoddlMgsY3gugoEbqznzPq+g8R16CcDQ
 87hQBPC8ONGMjH6ag1FElpuy9zbR2bFz2DjTHhUPml79XOAC/0hr7SJrcSECACl1AiF4Mxsmp
 H1oZ6euuuVJbWTCqwM9fVqdT14047VrgOFho94hGvd/CNekMXyRxSPUQ36Vs+p5rHW8vBBf13
 b3J3mX3zZcZ2tYjaR28eh50+0KIHBkGtnAmkHI+1lZ5r0IjXEeAQwEc7lU9y8AkjPChEsvFs9
 6xnM2ODovPptWzJXahz6RdT1IkBJ8h4CNZ0iTXzQKbxA4wfNm/e5qEgf+e6IevyUElmNjdJr1
 VyIatHe0BL61p/7KLNfnQh70huFjR7+yhQBKb8zyuNDzcFB+Flz6CmvGaztR/oKat748t/n6P
 K1aKN2uJgafb6XUnT7NUSXNyZuQqek4TwUbQuS+2psgxL1RKboOXqAPRHX8H+Ixh8lGAzvC70
 RevjViYsBNdu2KHXRO2rKwrcOkVIJKP7c91s+xOFN5nlXbn23/sQmuzuf9+7p7F3dD03jBTUb
 YEHZcdnXK2Rjig7HRh5yAblBANH0Wdrb+zPQdfIXf32JL/JpLXvBbXZxnH/JaC2TucZ7U137f
 pWaJGyBAahLeH6EL8QKkRXzo1eRYs7thW12zCdNed7T+1VnydWwoFm4hT1Nb3dPgapW6jXn7b
 KqzI0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/26 =E4=B8=8B=E5=8D=889:08, Nikolay Borisov wrote:
>
>
> On 26.08.19 =D0=B3. 16:03 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/8/26 =E4=B8=8B=E5=8D=888:37, Nikolay Borisov wrote:
>>> Support for asynchronous snapshot creation was originally added in
>>> 72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
>>> ceph's backend needs. However, since Ceph has deprecated support for
>>> btrfs
>>
>> Any reference for that?
>>
>> From what I have read, btrfs is still supported, although only
>> recommended for testing/development.
>> From ceph filesystem recommendations:
>
> The principal author of btrfs (and funnily enough, original implementer
> of the async subvolume) says so himself:
>
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019095.htm=
l:

OK, still that transid mismatch ghost...

Anyway, the patch itself should be OK, so:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> On 06/30/2017 06:48 PM, Sage Weil wrote:
>
>> Ah, crap.  This is what happens when devs don't read their own
>> documetnation.  I recommend against btrfs every time it ever comes
>> up, the downstream distributions all support only xfs, but yes, it
>> looks like the docs never got updated... despite the xfs focus being
>> 5ish years old now.
>
>
>>
>> We used to recommend btrfs for testing, development, and any
>> non-critical deployments becuase it has the most promising set of
>> features. However, we now plan to avoid using a kernel file system
>> entirely with the new BlueStore backend. btrfs is still supported and
>> has a comparatively compelling set of features, but be mindful of its
>> stability and support status in your Linux distribution.
>>
>> (Anyway, still better than the not recommended ext4).
>>
>> Thanks,
>> Qu
>>
>>> there is no longer need for that support in btrfs. Additionally,
>>> this was never supported by btrfs-progs, the official userspace tools.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  fs/btrfs/ioctl.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index c343f72a84d5..a412bd2036bb 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1837,8 +1837,12 @@ static noinline int btrfs_ioctl_snap_create_v2(=
struct file *file,
>>>  		goto free_args;
>>>  	}
>>>
>>> -	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
>>> +	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
>>> +		pr_warn("BTRFS: async snapshot creation is deprecated and will"
>>> +			" be removed in kernel 5.7\n");
>>> +
>>>  		ptr =3D &transid;
>>> +	}
>>>  	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
>>>  		readonly =3D true;
>>>  	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
>>> @@ -4214,6 +4218,10 @@ static noinline long btrfs_ioctl_start_sync(str=
uct btrfs_root *root,
>>>  	u64 transid;
>>>  	int ret;
>>>
>>> +
>>> +	pr_warn("BTRFS: START_SYNC ioctl is deprecated and will be removed i=
n "
>>> +		"kernel 5.7\n");
>>> +
>>>  	trans =3D btrfs_attach_transaction_barrier(root);
>>>  	if (IS_ERR(trans)) {
>>>  		if (PTR_ERR(trans) !=3D -ENOENT)
>>> @@ -4241,6 +4249,9 @@ static noinline long btrfs_ioctl_wait_sync(struc=
t btrfs_fs_info *fs_info,
>>>  {
>>>  	u64 transid;
>>>
>>> +	pr_warn("BTRFS: WAIT_SYNC ioctl is deprecated and will be removed in=
 "
>>> +		"kernel 5.7\n");
>>> +
>>>  	if (argp) {
>>>  		if (copy_from_user(&transid, argp, sizeof(transid)))
>>>  			return -EFAULT;
>>>
>>
