Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F88B1E19
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfIMNCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 09:02:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:35571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387749AbfIMNCv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568379764;
        bh=BGIpDRNnYkMpl/UaqRaUqQZZzuYYiZ6KGSoCQIragzw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K06dRrZ8bUySkaMDXTHvK63hRbHTR21Oy/Hvt+ytXMCkhbqt4TnOtNwV0zGFtYCD0
         tMkZUSQpOZzxIM2fYBIkHA3CpkFrinobsMujV79McjSNbS265wWzc7BKqY/1pX45jD
         w917ItEed07JEDVcD0Ydq0tR2cDb5YMEFc0aLWiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MZfZi-1hpaiD0c2w-00LRy4; Fri, 13
 Sep 2019 15:02:44 +0200
Subject: Re: [PATCH 1/2] btrfs: qgroup: Fix the wrong target io_tree when
 freeing reserved data space
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20190913015127.14953-1-wqu@suse.com>
 <43d19cea-562f-8bec-6604-6d1e7ac5c45f@suse.com>
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
Message-ID: <becabe21-8f80-d7fb-77fe-9b25db11c9db@gmx.com>
Date:   Fri, 13 Sep 2019 21:02:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <43d19cea-562f-8bec-6604-6d1e7ac5c45f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pmaGI4L93aKurT+9PGOdwcyr1rMWmmZKyeK7+2nWYpHPuX89FKv
 YVMb6JySbBP+CqGqDqwIyuYjuh7woevW2KujaafPvASBBKGzUUh6b6zl0B4lnw+kPSwXjeb
 1UyYSFXExOnMszEWfEQuBKSSS33iWqwVSeXU7cHHl89lvGcDz1k3b72x3MRZeqNLeujPu62
 O1cENI8BHp60veE1UqFVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RbPSdRHxhUI=:TI5RC6svboWhyZn7t4RHn/
 P5iKpTX/uRDrXXGFQGSgq2lhIb0IR9XBHx5QrlqDp9niINt00YEivj+IFixvLdcVNk9ejRcMj
 iUclPyxCvGxLR8Np0VD/0dFcBaGx9Qe6dUfJ8q8k6wLg8ncLE8E+KuTQK/dRBdUiFXipcxjUH
 9ebDnKbogc8lHho4fqeQAOLdD2K10NJDPsQcx1NWGOaqTwvOPqnTZEktIdzLXxSmx3BvTykSW
 uLc0Ubro6IVFBKMw9Oian+ZGIK67NFvxFer6M03QL7QvaOrsSd2Ep/4nH3sFxLA4kHFx9EOku
 VZ6VMV2l3oyi120hPPhJv1yEX6xDCcSl9NILytZVSwu6wew1OjltBg9kEDZwb0fRUTWRnK4iV
 aXXfz8TH2GrPraFYFxfBfhaUphqtxsh1h9bIA0m8Ir0v/nsETSUllWrpXsfeIVG7uskB/ozBG
 8lGvQnM5TSO8h/UIV1yDuwqMioRBAzusi1Hsp5pN77Y+4QwtgMJJabsousOQGjZUJDY4ce6JU
 fMu8cNIOVAHkyvB3Osk+jY9DWm+NE+EP1bch1qc5nUrkKxY255+pwwXbqtxZwfn5Y9buu2qWn
 HFyYdTcn5uYuk55fXCGblFTI6CfX8cH+fOkF1JQhZ5YUbdbQPRKY+1vwnev9VKfhRHLtRy9U4
 kpmE4OioBoN+XvEstsPZBhG0/HaO9mkrc5Ce5/TOivDyTDXWm6+l653mn7zEtj36flhrkqx94
 0tWMO59D/GehJ9uSyG90GhECP7rfnjfkMSC4ck0MvNEkVLlJS+YlkGqrQe+qbdtBebhUVQ3IK
 6/lw5oFSQkbShiUih5d0YEx6F+OYbkdBvst2uyBOMpUyOhOU171wOumbLU5dZ7pdQwpw8D1Vr
 XfXpqdD6yRxdDoUa/y9t+6RkRHbODu7hWy7SD3LrFBvm2VSmfsOFNaA68cO3AT3aaKuzAG91r
 Agi14t5jL1uwFRHQiXSRbSVvr5OOnP2KoP1R2Qcxp7yJNwnZbruEiJsWGUSXMjr1f8aQSMdLV
 LPNRGZx2s5vbNvES65lkwY4byqAxULzVQvhD32KzQhWFEo07gJDqMah2wb6evPKSs1hkLDc3r
 TIytNemgqvfiloOIAkupb6XK2yZnwSkukVww3zJj5S9vy/m4VnC9ZBREL9S70pdm7F8+vSEt8
 mya0LnpUzxIfeXbrl3ItRRLBVHwS718dZcE5W9CCyoC5TQDh9kKoOJHuraMavxqokZ8XtTLLS
 grPXzygrqGp1a5NWhC9r+Xyg12nLz+Mg3ZYldVHk96aeMsY4WtXm1nltprTI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/13 =E4=B8=8B=E5=8D=888:57, Nikolay Borisov wrote:
>
>
> On 13.09.19 =D0=B3. 4:51 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> Under the follow case with qgroup enabled, if some error happened after
>> we have reserved delalloc space, then in error handling path, we could
>> cause qgroup data space leakage:
>>
>> From btrfs_truncate_block() in inode.c:
>>
>> 	ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved,
>> 					   block_start, blocksize);
>> 	if (ret)
>> 		goto out;
>>
>> again:
>> 	page =3D find_or_create_page(mapping, index, mask);
>> 	if (!page) {
>> 		btrfs_delalloc_release_space(inode, data_reserved,
>> 					     block_start, blocksize, true);
>> 		btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, true);
>> 		ret =3D -ENOMEM;
>> 		goto out;
>> 	}
>>
>> [CAUSE]
>> In above case, btrfs_delalloc_reserve_space() will call
>> btrfs_qgroup_reserve_data() and mark the io_tree range with
>> EXTENT_QGROUP_RESERVED flag.
>>
>> In the error handling path, btrfs_delalloc_release_space() calls
>> btrfs_qgroup_free_data() which should clear EXTENT_QGROUP_RESERVED flag
>> and reduce the reserved data space accroding to the cleared range.
>>
>> However due to a completion bug, btrfs_qgroup_free_data() will clear
>> EXTENT_QGROUP_RESERVED flag in BTRFS_I(inode)->io_failure_tree, other
>> than the correct BTRFS_I(inode)->io_tree.
>
> This is a bit confusing because the error is actually in
> qgroup_free_reserved_data, which is called from
> __btrfs_qgroup_release_data. But in the latter function there is also a
> call to clear_record_extent_bits with the correct tree. Just fix the
> function name by using qgroup_free_reserved_data.

Right, I ignored some caller here, as the caller chain is not only
dependent on btrfs_qgroup_free_data() but also on the parameter.
E.g. only when reserved is non-null we go qgroup_free_reserved_data().

>
>> Since io_failure_tree is never marked with that flag,
>> btrfs_qgroup_free_data() will not free any data reserved space at all,
>> causing a leakage.
>>
>> All of such error handling cases can only be triggered some errors not
>
> I take it you meant:
>
> This error handling can only be triggered by errors outside of qgroup
> e.g. EDQUOT can't triger the bug?

Right.

I'll change it too something like "such leakage can only be triggered by
errors outside of qgroup."

Thanks,
Qu

>
> The first part of the sentence is hard to parse.
>
>> from qgroup, so regular EDQUOT error won't trigger the bug.
>> Normally we need error injection to trigger such bug.
>>
>> [FIX]
>> Fix the wrong target io_tree.
>>
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflo=
w by only freeing reserved ranges")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/qgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 2891b57b9e1e..64bdc3e3652d 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3492,7 +3492,7 @@ static int qgroup_free_reserved_data(struct inode=
 *inode,
>>  		 * EXTENT_QGROUP_RESERVED, we won't double free.
>>  		 * So not need to rush.
>>  		 */
>> -		ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_failure_tree,
>> +		ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_tree,
>>  				free_start, free_start + free_len - 1,
>>  				EXTENT_QGROUP_RESERVED, &changeset);
>>  		if (ret < 0)
>>
