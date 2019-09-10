Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF7AE25E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfIJCgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 22:36:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:43965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfIJCgE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 22:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568082937;
        bh=bNvUQKINinpk+SeusSLHVmPsZF2O183vXTTiAbklgoI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WeMHgwZhaYv3hvTeJvTMnzqX+nbYJ+e9DBHAaeNtmPSthiZLYPe09f5UsUHQeq+rb
         sHTyH5sQOjxohaEEYGbR7HSRNRxrlhHmrnFDHt1t191aeUs9M+EJjFr8hYAn0d0Kte
         D1Q0bxXTKiV9qODxD02+5zxs9OiBXIBj1Pp/snII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1iKw9H0pX6-00vRTS; Tue, 10
 Sep 2019 04:35:37 +0200
Subject: Re: [PATCH v2 4/6] btrfs-progs: check/lowmem: Repair bad imode early
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-5-wqu@suse.com>
 <b009d821-ed65-014f-bc17-2f141dfc5147@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <e4aa1307-dba0-7a71-9fae-5bebe59b3a81@gmx.com>
Date:   Tue, 10 Sep 2019 10:35:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <b009d821-ed65-014f-bc17-2f141dfc5147@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w/r7jN0C7dYESJG+ScgFY4rt2rE3In2JJfOXNY0hkFnoqU7QJHl
 Ywldad/NjcjvFgnrXeYxd9wBs14bYbZj6i7AB6d16gdLCRkwrwE/yZ1SKIZ1xTZki5Uzftr
 9DldR5teKC8Wt22dJ3ZBemkr7D8DFbaNq4mIHoDWk8fMcYok+Ik+6Y154N3kOd/cehVpZ8N
 8OMQVEWCld8fzT3EVI8Kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJ/3SeYvbnw=:K9g7pji6tZik1L4uK51pcn
 k0CSwKLUOzk362Ibh0OymeoZ8YqU+ZuaT+QkOQFbZYF0bO0ZM53yi698Fyf7uUDFYFRkFTnpi
 Ug+dP2cxF1C+sjQjKIvZHU2vq01nqg5e2sCPfD3u4Mqa2N0TMjzwYCucItH5xom17RFRLu8t8
 bpTsBQttX4eHgplwPmdhmFND1k8rIKaDHH7fY7QYqXPGvcjfEAunWiEQ9Iw01zD+IGSRi8MJi
 PcYYZ5jr8cOpJXwOt4bGAPrpAQfrMDfh2lPWArpxnURzkPMlIv6Jli0qIlfPJW9zHncoKhsUA
 aIIHabPV2l3R0tep8z1JkRqAXLrwqEq9VW/RHwAnmfCQnxG3+zuFBV9npoW76jI7bW6aQPOLw
 awEZJCmHFkPDFsbs4U2bmW0l0RZj+GRQnSexWFqhclwBGPBcn1dcsJbpzFG/DFRJczfANMz5L
 0unzR5pE99h2yCia/CqkQHAFKR0ked0UExJa013VCc3o3C8Z0EV8gHllLnBbd3vGR3EsJ2w6l
 5quxQVjuvp7gW3BVueP3+OSkEjPyjkK7HvaO970VWyYjRkqYvykfCO6uU6TPCTqYq5V+NkA5C
 d6MQhjs6XglqCe6Vx1yc1EbFqPuW7v8OzU9uk0hsCUMiURtAYR+tNb7ikthPuky/JJvDrDVhh
 1SBbVjn8jTC0V+VS6NWde5c/mMsyyov9KRerZo6xkmCMVxPBe6s529JtFsQAwFTcjQEzpL7fU
 b1BpT6CtDNwyHNcMDUgzinhrjuCxnHNm9Nm1F2Jn0CU0DflVFh1nt+gQza9XrmjT5eiGGO+Pc
 KeWmxWEvoniEsaruq4U2aOueWPHM8T9EP94VvtXW9s9z4CXtD0n9tKD5HTFyCnV56V/2D8PlU
 Yf91tV+djKbt78MfS6GYl1LaCus4cFvQI3WQ7tHYtoKzf994v7hWy80KSdoq/W+tebiao1Wse
 c/hTtm+8LFaadms4zSqZoJfahuIMijwcC7Lz/LpUDTNJVvEcl1hwEtwUt3S2kLZSzR7XiILOa
 UThPqpZ6bxU3JlVA8qedZOk73ZIZ91iklK1HqjR6aP2ryJfeRQYm1I+LLEicOIJxre+a6yMGK
 OhwA3nuiMDCQSfV+tqBCqIaElVaBu5wl6lxadWQcOWCx6hKPmWfseQQDZpTdDMJ5V+GrnlI/h
 LTwMpOIQpnoZCHKJpUhk0LKafHdqjoB3eR3d7Y1waLTdiBpdZ/3a+jwjRltHfK32A8PLBYypq
 Nv+Ndx1V+MHAs+lrn
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/9 =E4=B8=8B=E5=8D=8810:55, Nikolay Borisov wrote:
>
>
> On 5.09.19 =D0=B3. 10:57 =D1=87., Qu Wenruo wrote:
>> For lowmem mode, if we hit a bad inode mode, normally it is reported
>> when we checking the DIR_INDEX/DIR_ITEM of the parent inode.
>>
>> If we didn't repair at that timing, the error will be recorded even we
>> fixed it later.
>>
>> So this patch will check for INODE_ITEM_MISMATCH error type, and if it'=
s
>> really caused by invalid imode, repair it and clear the error.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-lowmem.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 5f7f101daab1..5d0c520217fa 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -1550,6 +1550,35 @@ static int lowmem_delete_corrupted_dir_item(stru=
ct btrfs_root *root,
>>  	return ret;
>>  }
>>
>> +static int try_repair_imode(struct btrfs_root *root, u64 ino)
>> +{
>> +	struct btrfs_inode_item *iitem;
>> +	struct btrfs_path path;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
>> +	key.objectid =3D ino;
>> +	key.type =3D BTRFS_INODE_ITEM_KEY;
>> +	key.offset =3D 0;
>> +	btrfs_init_path(&path);
>> +
>> +	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>> +	if (ret > 0)
>> +		ret =3D -ENOENT;
>> +	if (ret < 0)
>> +		goto out;
>> +	iitem =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
>> +			       struct btrfs_inode_item);
>> +	if (!is_valid_imode(btrfs_inode_mode(path.nodes[0], iitem))) {
>
> INODE_ITEM_MISMATCH is only set if:
>
> 1. The first inode item is not a directory (it should always be)
> 2. There is a mismatch between the filetype in the inode item and in the
> dir/index item pointing to it.
>
> By using this check you could possibly miss case 1 above, if the first
> inode has a valid type e.g. regular whereas it should really be a
> directory.

That's indeed a special rare case.

>
> I'm not entirely sure whether it makes sense to handle this situation,
> since admittedly, it would require a perfect storm to get such a
> corruption.

Let's wait to see if this could happen.
If it happened, we can easily modify the code to handle it anyway.

On the other hand, let's just focus on the real corruption where some
old 2014 kernel screwed up the imode of some inodes.

Thanks,
Qu

>
>
> <snip>
>
