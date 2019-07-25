Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA374A08
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfGYJfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:35:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:46531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387908AbfGYJfE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564047296;
        bh=Fy45tWyphEfOThduIATejngbqOnUf040YQ0l0dttZ5A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FEV5EiLFsvmO3HCBI8HFjqKFGiA3lLlkSUFFfEQOTPkE0IRzqbo2fzE/nPSs0KQgu
         +kwB6MYg9w5euDchG6TlQW3IvYUZ22iXn7WRYjERUUQ92qbPJg6YF8XLz2+IFm7PgW
         3QwUNM47evsv6boihth7xa4R15YS5MxKEsCEfWn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1ieyoA0zeb-00tSiJ; Thu, 25
 Jul 2019 11:34:56 +0200
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com>
 <6dbec951-751d-cd48-d20c-bc558cf213e0@suse.com>
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
Message-ID: <cc79b487-92ed-fd27-edc5-4a4b60fd7db4@gmx.com>
Date:   Thu, 25 Jul 2019 17:34:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6dbec951-751d-cd48-d20c-bc558cf213e0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6pdtyOALiUZCe3GWbS0fniEW7w+DB8ua+raxTA3iDnukwoQ0jEa
 oS7foYlEND+ZW2o4O8ywDHMuQJiPx7u0cnXlQ0Kj50uKZevA8LscFbVvOqTbr3W9JH4wTQz
 vS7VpdorLolSELbTu2cGSyvJRwxspbkXM4sV9/1dkbdhrzgn+bHSljSwmMo+11ugyEWXf+f
 /ANYvDW4fplZgJ/42n4oQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlHte/Hejnk=:AQwlSBSrUm84CB5ZtDi/HS
 p4tYhfodVm5uGg4Q1AaKtwfGJToHaiVmdogwP3C1eHzEW+MPbrMYkSgEAQe/mi6UZ3D30NHSz
 or00fbbADsrsash+xtSZ/vMArON107okRZ6epmJULwYidSIjAstOJElL0BNQFBAUF2I7mRKml
 mYua+RwDxw9x90rq8ofT16Vavj530Cz/YjqNesOFJZTocRHVvBCkkk7Bm49BxWFR0IuBbBJVn
 nsAyOlo6rBjPRX1k5M/UWzz/pO0RdTO/Hu/d2Q+1pq14l1eA+qa19qVZ+PUM1Y9K+ljbfYVzY
 iuM6pyfMW6s1CMYVdDMM9H6yRREJQ5h1cLhGrO8WMpbUVMOknuyY9CkiR6mvAKzYNYeYYOCsu
 pwoD20Pypr1ybTvPxAWgoaLL7WYiost40jmCWxcueDR8lB9W98LG4wOlZUz+Uf+EkMSmnD0ar
 9SRUoSQU8aDrN20MCTkQURhLbtZPYA/oizqLob6qV/NAn61XilKdZOsCSuPMmVPykfn2lJbQZ
 O08TGZV2qkpSqEhcIx9ynVkn56alnhV+rAKND+LLB6J6E1laoz5Cc7aLN3OQD3SePb5q470CC
 3L4A7wbpKTD45CVuFdRR/3LEwVxOE2Jc8XJu14dFgGn51Lue3d4xqXABnF+A+kvH55lOOEllU
 cW4jfExEb2eCJZoXyb37diM4xnIJoYlnWWwDHpHvjtWp47kzZ3oyLIQds4JmQi612UgoblSit
 l+pECGA1pTgDav8mbsgQowDYfDJxpb8bCA/4VE2t1UEPHxvo/6aEK/v7FkGeQ+NDCbGzs1oP5
 mi+xPs38StQTF2IDbJO5lRZUWKsHm4YG6j+OB0O4M6DcSppooHKJThk60M83ihhgBcjkm8Jrd
 B/dxqDNntVgt4F0EMLrNUBfNufCiCHZYMsDQKW0ggPFNpH80buCsLFEM9w8GUjIy0r1xrxrGr
 UkZ0Xjdss+E/zYMhR38S1LrzeARGVx7wHtADDUR5qt713Ehe+g55jvXTKCbIuWrw0LJ08q1l7
 E0rb7ssKTeN+CITkKgdLW8jtqqO8erA6yBYrqZuDYCVoE5uOI9lk/vr3oe5x39EiqATH5KOq2
 k/KnY7uVKZ/PE+emZm30gNUmqEIP0/LWPOX
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/25 =E4=B8=8B=E5=8D=885:26, Nikolay Borisov wrote:
>
>
> On 25.07.19 =D0=B3. 9:12 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> With crafted image, btrfs will panic at btree operations:
>>   kernel BUG at fs/btrfs/ctree.c:3894!
>>   invalid opcode: 0000 [#1] SMP PTI
>>   CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>>   RIP: 0010:__push_leaf_left+0x6b6/0x6e0
>>   Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 00 48 8b bd =
78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f> 0b 0f =
0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
>>   RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
>>   RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 0000000000000000
>>   RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b3814000
>>   RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4128b948
>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000240
>>   R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4ab8f0af0
>>   FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000) knlGS:0000000000=
000000
>>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 00000000000206f0
>>   Call Trace:
>>   ? _cond_resched+0x1a/0x50
>>   push_leaf_left+0x179/0x190
>>   btrfs_del_items+0x316/0x470
>>   btrfs_del_csums+0x215/0x3a0
>>   __btrfs_free_extent.isra.72+0x5a7/0xbe0
>>   __btrfs_run_delayed_refs+0x539/0x1120
>>   btrfs_run_delayed_refs+0xdb/0x1b0
>>   btrfs_commit_transaction+0x52/0x950
>>   ? start_transaction+0x94/0x450
>>   transaction_kthread+0x163/0x190
>>   kthread+0x105/0x140
>>   ? btrfs_cleanup_transaction+0x560/0x560
>>   ? kthread_destroy_worker+0x50/0x50
>>   ret_from_fork+0x35/0x40
>>   Modules linked in:
>>   ---[ end trace c2425e6e89b5558f ]---
>>
>> [CAUSE]
>> The offending csum tree looks like this:
>> checksum tree key (CSUM_TREE ROOT_ITEM 0)
>> node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>>         ...
>>         key (EXTENT_CSUM EXTENT_CSUM 85975040) block 29630464 gen 17
>>         key (EXTENT_CSUM EXTENT_CSUM 89911296) block 29642752 gen 17 <<=
<
>>         key (EXTENT_CSUM EXTENT_CSUM 92274688) block 29646848 gen 17
>>         ...
>>
>> leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
>>         item 0 key (EXTENT_CSUM EXTENT_CSUM 85975040) itemoff 3987 item=
size 8
>>                 range start 85975040 end 85983232 length 8192
>>         ...
>> leaf 29642752 items 0 free space 3995 generation 17 owner 0
>>                     ^ empty leaf            invalid owner ^
>>
>> leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
>>         item 0 key (EXTENT_CSUM EXTENT_CSUM 92274688) itemoff 627 items=
ize 3368
>>                 range start 92274688 end 95723520 length 3448832
>>
>> So we have a corrupted csum tree where one tree leaf is completely
>> empty, causing unbalanced btree, thus leading to unexpected btree
>> balance error.
>>
>> [FIX]
>> For this particular case, we handle it in two directions to catch it:
>> - Check if the tree block is empty through btrfs_verify_level_key()
>>   So that invalid tree blocks won't be read out through
>>   btrfs_search_slot() and its variants.
>>
>> - Check 0 tree owner in tree checker
>>   NO tree is using 0 as its tree owner, detect it and reject at tree
>>   block read time.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D202821
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c      | 8 ++++++++
>>  fs/btrfs/tree-checker.c | 6 ++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index deb74a8c191a..a843c21f3060 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -414,6 +414,14 @@ int btrfs_verify_level_key(struct extent_buffer *e=
b, int level,
>>
>>  	if (!first_key)
>>  		return 0;
>> +	/* We have @first_key, so this @eb must have at least one item */
>> +	if (btrfs_header_nritems(eb) =3D=3D 0) {
>> +		btrfs_err(fs_info,
>> +		"invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >0",
>> +			  eb->start);
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		return -EUCLEAN;
>> +	}
>
> Shouldn't this check be before !first_key, e.g. we always want to verify
> that a particular node has at least 1 item ?

Nope, it's possible that we have case like read csum tree root.

In that case, we don't have first key, and csum tree can be empty.

Thanks,
Qu
>
>>
>>  	/*
>>  	 * For live tree block (new tree blocks in current transaction),
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 96fce4bef4e7..a4c7f7ed8490 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -888,6 +888,12 @@ static int check_leaf(struct extent_buffer *leaf, =
bool check_item_data)
>>  				    owner);
>>  			return -EUCLEAN;
>>  		}
>> +		/* Unknown tree */
>> +		if (owner =3D=3D 0) {
>> +			generic_err(leaf, 0,
>> +				"invalid owner, root 0 is not defined");
>> +			return -EUCLEAN;
>> +		}
>>  		return 0;
>>  	}
>>
>>
