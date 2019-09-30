Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3BC208E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfI3MYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 08:24:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:41275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfI3MYu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 08:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569846282;
        bh=8tgkeyKVopiee/V/+OU4OaDyS5Nri7kt50/fANeW6TU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QHEYeaxQBlx83DlcL0TRO9xyVDW97JeLWNt2xdQ1yATmeX5jJCzj3Gogftjo5U3rQ
         cFeYjV0hcYbvn+Ty56fl9JqcbP7xDhqQ6IdE1qKbELspZfiWjmC1e+krX+s3Npp1HV
         j8l5qC06OdTohZNt7/zbZ61iCYsPptcUHNALXnZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1igIzE2Tvo-00RXBM; Mon, 30
 Sep 2019 14:24:42 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Add check and repair for
 invalid inode generation
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Charles Wright <charles.v.wright@gmail.com>
References: <20190924081120.6283-1-wqu@suse.com>
 <20190924081120.6283-2-wqu@suse.com>
 <373ac9c6-ecdc-7688-5c28-791131b67f92@suse.com>
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
Message-ID: <a73fe243-3be4-9576-6b5e-8b867aa16060@gmx.com>
Date:   Mon, 30 Sep 2019 20:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <373ac9c6-ecdc-7688-5c28-791131b67f92@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RU2EFA4jSHsP054IcRqy7BgqYlXnQ85xWxgTWFiDyvENyd1vLlC
 lY7jk0N9wL7FW6eviOWbciFZ9HiuKci6YQPUyhcAZiZKoXXKs8fdYQraUaUOjTQ0DE8Q4NK
 obEh27GaBynXCUzRmSJ3SjJxA2dks9COcoLHhrmkMvUhcg31Ic5ZGZQXTG0WPcbV95aCEKB
 SrRYtcwloEclK3VBB0F/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KBFl0zq9n5w=:/11Cibvjwl0MUXGQplv1ft
 QPoyetTYDxcxtVGNYcvZgMKZr0rxGW4DHGQt0UjC6rRKeJb5a0PSau2WXtHgDNymFZpkvkMgi
 zJ9fg3tyFgi4WeQSTK0GS4wcnHBp3LDN7RHC+nPiVqqq46XtWZGpjx8JqZS3ztzgI4KyOTNuf
 QeYUkysoV4LXeucvSeCwfQghnW5LqjaQ/affsxyzo/OAsznPUWgThtmq3C1+aFxfhZGImHjGg
 /s9iOwjR6ofqzyRn3JJ4HMuzqyh/br5EOnod0vYj/7KyNM3Zzle2eJ3yi+y0KCQuOTmCfHgYl
 5618vuTYqNHpgySgC8gTuf5ZfXRnioaz0HlkUY0y72qlv3Fq01ZZSFZxDAH3sfneRZ+2FfmGZ
 43o0+bN+BalmrLomsbwJyRvrHb6S9NkP7rOSnazZ/n7ujvcKI9N2Ehv2EFkiN8/OsjkGZ9xbU
 hnTdHBtBDxk68R5ws3kfcpKXPUSXV1SOomcARItaykcjaezH4LDCfhxQPU6Hq4SAu1UCBxxqI
 eJASWRVrkccCl8n5eNZ4r7OIrk72uyNLhmKV10fiTqTPCH+W0RfskWGd52CHJrtQ3KjTk90+k
 UgjSN4EwAkjZl503pbyq7IhCoYQNL+gURlFPycVxnNQguBBCI5movrxbMvJdgSYixvmTPs8bp
 xBYo2sUZbXVC+E7i9pEw35+ygGHdydAdlS9daI46ibihIY5Ub5RQ3Y5fzghhT/oE5cvnhUyJ+
 apaR6Uag9fmqda7crv365adeGOT9iG20zbfzlDN5k1qe+PlMJ0DJCu6aEl8siulXLFQIe5YsS
 UxiPoVNTgeBAgVNEpbNHwIeu2KZeb560h7xNsNhWZPQqx/+g2ufQrGStLhg/e3TK4RcaY9T0I
 FOBeR6zCAo3eOhwsKgrN8yt9YCG2Fm6CULfP28ii4LxJ0plcE5Eqd6/EA6tSjk3znXi5KbrRB
 QJm3SOkEaVe7yYv8W5p0dRN53bUI8JTXqODo1pnPn/mq1E2EUnMcxxQOyXOnS6zjWEBok83D8
 8kcawjOOxW2uS6SJqiccql5/BYkSui1NJo/tVMr51jjzv5apcCvdJEQbjaoEFQuHbST0EcEi6
 onbUz4LvdU8MwLfcpgKr0LEQUeKox00a89lGK5KN9UbkNqfMEuN3yynOE/z5A/ybXluUFrp4v
 SRpFTrOwGlDaqYRKuTHSrXlPeh1Gt5EH4xWhWaEgkPDyoNCy5Vv58QYPvTPCk8b/qNrX0StVi
 R1qC0J//vV+xtGyDGLk5vsi+0HQYR0u5TznGqGaG1wDYcrIq1yKyvDYkc65U=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/30 =E4=B8=8B=E5=8D=887:36, Nikolay Borisov wrote:
>
>
> On 24.09.19 =D0=B3. 11:11 =D1=87., Qu Wenruo wrote:
>> There are at least two bug reports of kernel tree-checker complaining
>> about invalid inode generation.
>>
>> All offending inodes seem to be caused by old kernel around 2014, with
>> inode generation overflow.
>>
>> So add such check and repair ability to lowmem mode check first.
>>
>> This involves:
>> - Calculate the inode generation upper limit
>>   If it's an inode from log tree, then the upper limit is
>>   super_generation + 1, otherwise it's super_generation.
>>
>> - Check if the inode generation is larger than the upper limit
>>
>> - Repair by resetting inode generation to current transaction
>>   generation
>>
>> Reported-by: Charles Wright <charles.v.wright@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
>
> There is one small nit with the assert once rectified you can add:
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
>> ---
>>  check/mode-lowmem.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 5f7f101d..7af29ba9 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -2472,6 +2472,59 @@ static bool has_orphan_item(struct btrfs_root *r=
oot, u64 ino)
>>  	return false;
>>  }
>>
>> +static int repair_inode_gen_lowmem(struct btrfs_root *root,
>> +				   struct btrfs_path *path)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_inode_item *ii;
>> +	struct btrfs_key key;
>> +	u64 transid;
>> +	int ret;
>> +
>> +	trans =3D btrfs_start_transaction(root, 1);
>> +	if (IS_ERR(trans)) {
>> +		ret =3D PTR_ERR(trans);
>> +		errno =3D -ret;
>> +		error("failed to start transaction for inode gen repair: %m");
>> +		return ret;
>> +	}
>> +	transid =3D trans->transid;
>
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	ASSERT(key.type =3D=3D BTRFS_INODE_ITEM_KEY);
>
> nit: This function's sole caller, check_inode_item, is guaranteed to be
> called with a path pointing to BTRFS_INODE_ITEM_KEY thanks to the logic
> in the 'for' loop in process_one_leaf. This renders the assert
> redundant. At the very least I think it should be moved to
> check_inode_item.

Yes, the ASSERT() doesn't make much sense by itself.

However I still believe it won't be a problem.

It's compiler's job to remove such dead ASSERT(), but for human reader,
I still believe this ASSERT() could still make sense, especially when
the caller or callee can get more and more complex.

Thanks,
Qu

>
>> +
>> +	btrfs_release_path(path);
>> +
>> +	ret =3D btrfs_search_slot(trans, root, &key, path, 0, 1);
>> +	if (ret > 0) {
>> +		ret =3D -ENOENT;
>> +		error("no inode item found for ino %llu", key.objectid);
>> +		goto error;
>> +	}
>> +	if (ret < 0) {
>> +		errno =3D -ret;
>> +		error("failed to find inode item for ino %llu: %m",
>> +		      key.objectid);
>> +		goto error;
>> +	}
>> +	ii =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +			    struct btrfs_inode_item);
>> +	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
>> +	btrfs_mark_buffer_dirty(path->nodes[0]);
>> +	ret =3D btrfs_commit_transaction(trans, root);
>> +	if (ret < 0) {
>> +		errno =3D -ret;
>> +		error("failed to commit transaction: %m");
>> +		goto error;
>> +	}
>> +	printf("reseting inode generation to %llu for ino %llu\n",
>> +		transid, key.objectid);
>> +	return ret;
>> +
>> +error:
>> +	btrfs_abort_transaction(trans, ret);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Check INODE_ITEM and related ITEMs (the same inode number)
>>   * 1. check link count
>> @@ -2487,6 +2540,7 @@ static int check_inode_item(struct btrfs_root *ro=
ot, struct btrfs_path *path)
>>  	struct btrfs_inode_item *ii;
>>  	struct btrfs_key key;
>>  	struct btrfs_key last_key;
>> +	struct btrfs_super_block *super =3D root->fs_info->super_copy;
>>  	u64 inode_id;
>>  	u32 mode;
>>  	u64 flags;
>> @@ -2497,6 +2551,8 @@ static int check_inode_item(struct btrfs_root *ro=
ot, struct btrfs_path *path)
>>  	u64 refs =3D 0;
>>  	u64 extent_end =3D 0;
>>  	u64 extent_size =3D 0;
>> +	u64 generation;
>> +	u64 gen_uplimit;
>>  	unsigned int dir;
>>  	unsigned int nodatasum;
>>  	bool is_orphan =3D false;
>> @@ -2527,6 +2583,7 @@ static int check_inode_item(struct btrfs_root *ro=
ot, struct btrfs_path *path)
>>  	flags =3D btrfs_inode_flags(node, ii);
>>  	dir =3D imode_to_type(mode) =3D=3D BTRFS_FT_DIR;
>>  	nlink =3D btrfs_inode_nlink(node, ii);
>> +	generation =3D btrfs_inode_generation(node, ii);
>>  	nodatasum =3D btrfs_inode_flags(node, ii) & BTRFS_INODE_NODATASUM;
>>
>>  	if (!is_valid_imode(mode)) {
>> @@ -2540,6 +2597,25 @@ static int check_inode_item(struct btrfs_root *r=
oot, struct btrfs_path *path)
>>  		}
>>  	}
>>
>> +	if (btrfs_super_log_root(super) !=3D 0 &&
>> +	    root->objectid =3D=3D BTRFS_TREE_LOG_OBJECTID)
>> +		gen_uplimit =3D btrfs_super_generation(super) + 1;
>> +	else
>> +		gen_uplimit =3D btrfs_super_generation(super);
>> +
>> +	if (generation > gen_uplimit) {
>> +		error(
>> +	"invalid inode generation for ino %llu, have %llu expect [0, %llu)",
>> +		      inode_id, generation, gen_uplimit);
>> +		if (repair) {
>> +			ret =3D repair_inode_gen_lowmem(root, path);
>> +			if (ret < 0)
>> +				err |=3D INVALID_GENERATION;
>> +		} else {
>> +			err |=3D INVALID_GENERATION;
>> +		}
>> +
>> +	}
>>  	if (S_ISLNK(mode) &&
>>  	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND)) {
>>  		err |=3D INODE_FLAGS_ERROR;
>>
