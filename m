Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC361EC9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfGHMu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 08:50:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:40795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbfGHMu4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 08:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562590231;
        bh=O2EitYuIoFPwt0FdfGbnlZIHVYWIvGuo0K608nhwpqs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ap9jRhnmStGP/7b/vWGRGfsUY2uSEwXQ6xfQ7MO0jA34RYZhv52LBx46TdszKMewz
         SwHIDhOk+k8nnKbPW1hmLELPEHsmnFwIhWKtPgNgd6w2Ad7hWpo7eorWrtSPZbAKFY
         BgwWky+bz8XCA1msEYAyzGNduXAKqBYNxMH+P3xo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MATlG-1hdHJ61M7e-00BgIX; Mon, 08
 Jul 2019 14:50:31 +0200
Subject: Re: [PATCH v2 2/2] btrfs-progs: Avoid unnecessary block group item
 COW if the content hasn't changed
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190708073352.6095-1-wqu@suse.com>
 <20190708073352.6095-3-wqu@suse.com>
 <ab1626ad-ccfe-e913-91e2-47e1710cfd83@suse.com>
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
Message-ID: <3221b824-4758-81d2-edb1-9bbc2fdc0775@gmx.com>
Date:   Mon, 8 Jul 2019 20:50:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ab1626ad-ccfe-e913-91e2-47e1710cfd83@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9tuGoyqTqURjObBS3OqFE/hSHgWq3xXtZ1X9QDkVk+T/vLGX5zT
 PfCLmZlTczvS8OgkAwUin0xrR+/dHvHoWVBithKsIuKPN4qg/9ckyu39u56xWBvGHdQecPY
 zwQYOs9WvKnUoOaAz3S9k+nADtDvlNKQ2nCm6Apfk5M951Vm6hFL1gDGhgXHRt/1dMvbxae
 NsHyVL8jdUMM3aCiVcuUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxwdDpNf+fU=:udMZberxl0tVTkJPpm/Qoq
 qhrQ3/z9bysV/Z5FJMzVE+BHP9KmzQLvWabnNqACLBwo1p0wX1WcHXJ7ocaVGGTYpJtq1pRe+
 jaKbg2yYEcaaALucdfRmbdXa9Nf52DTvIRkNGZxmTjSpl/KJD4YhZ+atNPsOJ/Xcp6naw37NA
 teNU8XxyrRXxBW1e0heQkI2hN3rNvxxgHb2Fm3Qttns2HyGL/e2PkSGGJdtBvgxcC00/oEuCd
 WDCNpWxrcZmKiCukCwatAxbhMSoNx7Lbe3eDzTy2VO1LDSelc5fwijh8LxwdGQ4EMv4SHQ/Yy
 Yl8LD8p591+Jq59VBK8iJezPBxCAwnUcrWnF7qHKHuvG4Jzu6aW/ThYbhYZySI+Al3b27ViKW
 VdWiJ4F0nvN47Lg5xvI8dVjAfOhG6vtnFyrXc0PN5C23WjRo2pf3s/kOE9B8sGWy51eh1CosB
 LiB774rlTKUyOwEWaDtBFliDiaBvpNGmxkixv0ewyiupqRO2bCNC2nPy9nais9AQ/V11wgulz
 R0UwxTMYjv729ucln4+QDBjf3aQCp0KuFYgn84X2EvJc14sQt8py5ZcrBqJ4soeRyzJ/sY4DN
 vxi5w5DnD/LMpjMouG9jX4tq82yQknknTVDk6BtQ9J9EcrOg3z+KOyzis8B624PafoK/MpZf2
 a2ZKUPdEF7J7+2Eh1Mq4xPvkZ+WDRjLxRzCqqfY289969d3Du56ffP0JDifZ/HY0liD3YHbEV
 ypafA53c7N+KeYOr6u7x7oQmzqO/ExPQq6blNc2wdxALRe2WPCfV0WRLHEfiIjGps1fIlwnYs
 GfSfT11CJ9WUsQSPKlUc7nfTuDbeWCKUpu4ShUdCGh2hO3KMtY4FrE+gykrQ2FVFAdx66g/Rg
 jWjtKRWcYm7M7Ji9hhJiaYnU9Il2WQ7co8z1p3cQ/F+sTP7588RjxVeM+9/m8vRyXfcIl7RnL
 V6AXmCw+PKDfGKTGtadqAWJMa1xYAwr059atFi4ZxBwy6cfI07putFpaF/EdvXideID9M2F83
 4Sc5/plRjCek1kqwhskK5RhcFdjJwqsAgQ23tqaiTL9s3wtK0/TR23yxcuvo5m8h12zeZWMTo
 VtAL79tBpQrYg9e6ZW2VgwjuvyGYa/o87RB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/8 =E4=B8=8B=E5=8D=886:43, Nikolay Borisov wrote:
>
>
> On 8.07.19 =D0=B3. 10:33 =D1=87., Qu Wenruo wrote:
>> In write_one_cache_group() we always do COW to update BLOCK_GROUP_ITEM.
>> However under a lot of cases, the cache->item is not changed at all.
>>
>> E.g:
>> Transaction 123, block group [1M, 1M + 16M)
>>
>> tree block 1M + 0 get freed
>> tree block 1M + 16K get allocated.
>>
>> Transaction 123 get committed.
>>
>> In this case, used space of block group [1M, 1M + 16M) doesn't changed
>> at all, thus we don't need to do COW to update block group item.
>>
>> This patch will make write_one_cache_group() to do a read-only search
>> first, then do COW if we really need to update block group item.
>>
>> This should reduce the btrfs_write_dirty_block_groups() and
>> btrfs_run_delayed_refs() loop introduced in previous commit.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I'm not sure how effective this is going to be

The effectiveness is indeed low.

For btrfs/013 test case, 64K page size, it reduces total number of
delayed refs by less than 2% (5/300+)

And similar result for total number of dirty block groups.

> and isn't this premature
> optimization, have you done any measurements?

For the optimization part, I'd say it should be pretty safe.
It just really skips unnecessary CoW.

The only downside to me is the extra tree search, thus killing the
"optimization" part.

Thanks,
Qu
>
>
>> ---
>>  extent-tree.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 932af2c644bd..24d3a1ab3f25 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -1533,10 +1533,34 @@ static int write_one_cache_group(struct btrfs_t=
rans_handle *trans,
>>  	unsigned long bi;
>>  	struct extent_buffer *leaf;
>>
>> +	/* Do a read only check to see if we need to update BLOCK_GROUP_ITEM =
*/
>> +	ret =3D btrfs_search_slot(NULL, extent_root, &cache->key, path, 0, 0)=
;
>> +	if (ret < 0)
>> +		goto fail;
>> +	if (ret > 0) {
>> +		ret =3D -ENOENT;
>> +		error("failed to find block group %llu in extent tree",
>> +			cache->key.objectid);
>> +		goto fail;
>> +	}
>> +	leaf =3D path->nodes[0];
>> +	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>> +	ret =3D memcmp_extent_buffer(leaf, &cache->item, bi, sizeof(cache->it=
em));
>> +	btrfs_release_path(path);
>> +	/* No need to update */
>> +	if (ret =3D=3D 0)
>> +		return ret;
>> +
>> +	/* Do the COW to update BLOCK_GROUP_ITEM */
>>  	ret =3D btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1=
);
>>  	if (ret < 0)
>>  		goto fail;
>> -	BUG_ON(ret);
>> +	if (ret > 0) {
>> +		ret =3D -ENOENT;
>> +		error("failed to find block group %llu in extent tree",
>> +			cache->key.objectid);
>> +		goto fail;
>> +	}
>>
>>  	leaf =3D path->nodes[0];
>>  	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>>
