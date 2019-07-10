Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45265645F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGJMCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 08:02:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:34819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMCR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 08:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562760131;
        bh=RBA/QxnZuEXTKuwqMSD2MqKSs73sO3DHY3y8y9CrMrU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Couy/amFiWfJ88Lc/NDaABLZ31wHxRFOH0QGFIsTioVNfxXEdRMY1Zh3rAYskD35h
         jpU7514ULCceWaBYaEwP/Y1EJN6uWcZTEH5Duy50a4ittYktedd1ADDzBReDh8laki
         4G5ToTQnm7J1kF93NOrZCK3SgCD/A7Bj4pk1QMsg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42jQ-1hlBIX3XRA-0003a4; Wed, 10
 Jul 2019 14:02:10 +0200
Subject: Re: [PATCH 5/5] btrfs: ctree: Checking key orders before merged tree
 blocks
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-6-wqu@suse.com>
 <ba828afc-46b9-b48f-1b05-e5bd3b78af6e@suse.com>
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
Message-ID: <3547c87e-5da0-d4d5-0c37-9e4957a2d390@gmx.com>
Date:   Wed, 10 Jul 2019 20:02:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ba828afc-46b9-b48f-1b05-e5bd3b78af6e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AnYDSAMpzV8dwf9UiufS5nNIdOt5fFnyBORimoFLzyIwqKowlp8
 hTIisyWO9PoE7wXFjc/NkWM4jo0DsgkU4Fg+tJlJ18MddhLXEgMk1jsaCQJRV4JRFXV51sd
 p/2RpnTOaBBc80ea7viZGiJs5H5eY9N32mcoW9oZ2IonpF3Da/I06NuEaPUtmP3ayAsIWkN
 5OTcG3OGMbaTJyv4MQ2tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1s5uNmqocA=:QJnqLdbvfSsAQ7RSjXS2xM
 GIiDVIQ8mxOjuiN05KAwaJX4mJ9zHBk6XGkR/cJx16cfsQWovuGZ522iU/knx+XLwsVRqIss7
 Sg/sD5mdnMjjZi1X8Utnowu6uMyNTpGS3US//ml31vn2Ng/bW36wCKxo4R/up+BthAIbKDvba
 ws5E76Mj26dDYSo3Q58pZHf7kiGemnKkfcmKvdSHhJjL78mLCrKdb4YRphrZ8EvZJ4F+ja+5U
 qBIMzf3EBzFYxRc0tWJMeIhNRu5k3RwkI/Nuu7DBzNf3iNk83rdgdD5d4aruT+3OqDVS9Q9t5
 J9jqb59OCv8+Y1sTvSUZBgeDkw46GH5FKhiPzqsQLNL1cpGSQazT4/Q4mBaw1S7VModM1UIf0
 UOW32WO2f54TkA6VF1X2CT6KrkbDwB04mTYvZdoRfjLQ2nFYKFSiLPrrF86ePt0JveLAesZAD
 MVeiSh3lqza2cgo8JtvEOUAtM1QS3i51fbHOLClW2OanxrJr4Q6/Lu5AMZWrXQmy7MXyHfhyN
 /KygmkACrUurjKSLeva2V0j2wT2vs1FajJK4v7XKgaC1MIO7nqyYwsS7n2q6tVl6GTeev6XA8
 1oR4YLl79Z0zxw+90P7SMAUK6tSj9owOvjAH49+yADzuTn0mvbgUCnaUYsTfI7y+/em4nJJOy
 KSQKQWmchzPXAyRcFLMvD9pOAAAqhlR499K5ZaoTmqX2/GdTLfrgtW4gGc3CGbsb5din30lwN
 M5iOwlroUW530vf1JI84Jp6TGGOmVU6dLCsvLPWxpOte9dYux9BAlVEyNeJoQ0/x7QHEV5gz3
 qp0tmvENrlSdGZ7GUr+o75YJiZOwN3n5MLMtBELRwkLEpFn1+eOXz6Sy0+RO6dxcKZrQKAC//
 cMUM+Vk1W++E/Q0NJa/+PmTxCrqMWCbygpVzs9Yv2gK8yfWyBM30DyMI6GPwUdKTL7cGNXRFF
 onxCCXJg1L8JC+7MvljULaXLrLwuAu+YC5aIzqQPYZAsAs7Ag2T/nJnzBbSFMsM0jKfOggrbM
 ALraXNgUF0MI+k0Nbrk7b02zcAa66vv74xqw+LTWDpR9nrULEeWaIarjWRrGfWgz1hfUrfWLd
 qpJlgqUD77qGK46C2h5MxZjaXonodu0vbA4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/10 =E4=B8=8B=E5=8D=887:19, Nikolay Borisov wrote:
>
>
[...]
>> +static int check_cross_tree_key_order(struct extent_buffer *left,
>> +				      struct extent_buffer *right)
>> +{
>> +	struct btrfs_key left_last;
>> +	struct btrfs_key right_first;
>> +	int level =3D btrfs_header_level(left);
>> +	int nr_left =3D btrfs_header_nritems(left);
>> +	int nr_right =3D btrfs_header_nritems(right);
>> +
>> +	/* No key to check in one of the tree blocks */
>> +	if (!nr_left || !nr_right)
>> +		return 0;
>> +	if (level) {
>> +		btrfs_node_key_to_cpu(left, &left_last, nr_left - 1);
>> +		btrfs_node_key_to_cpu(right, &right_first, 0);
>> +	} else {
>> +		btrfs_item_key_to_cpu(left, &left_last, nr_left - 1);
>> +		btrfs_item_key_to_cpu(right, &right_first, 0);
>> +	}
>> +	if (btrfs_comp_cpu_keys(&left_last, &right_first) >=3D 0) {
>> +		btrfs_crit(left->fs_info,
>> +"bad key order cross tree blocks, left last (%llu %u %llu) right first=
 (%llu %u %llu",
>> +			   left_last.objectid, left_last.type,
>> +			   left_last.offset, right_first.objectid,
>> +			   right_first.type, right_first.offset);
>> +		return -EUCLEAN;
>> +	}
>> +	return 0;
>> +}
>> +
>
> nit: I wonder if it will make it a bit easier to reason about the code
> if that function is renamed to valid_cross_block_key_order and make it
> return true or false, then it's callers will do if
> (!valid_cross_block_key_ordered) {
> return -EUCLEAN
> }

I'm always uncertain what's the correct schema for check function.

Sometimes we have bool check_whatever() sometimes we have bool
is_whatever(), and sometimes we have int check_whatever().

If we have a good guidance for btrfs, it will be a no-brain choice.

>
> I guess it won't be much different than it is now.
>
>>  /*
>>   * try to push data from one node into the next node left in the
>>   * tree.
>> @@ -3263,6 +3309,10 @@ static int push_node_left(struct btrfs_trans_han=
dle *trans,
>>  	} else
>>  		push_items =3D min(src_nritems - 8, push_items);
>>
>> +	/* dst is the left eb src is the middle eb */
> nit: missing ',' between 'eb' and 'src'. But this is very minor.

I'd prefer the rename the parameter of push_node_left() directly in
another patch so that we won't need this comment at all.

@dst @src?! That makes no sense compared to @left and @right.

Thanks,
Qu

>
>
>> +	ret =3D check_cross_tree_key_order(dst, src);
>> +	if (ret < 0)
>> +		return ret;
>>  	ret =3D tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
>>  	if (ret) {
>>  		btrfs_abort_transaction(trans, ret);
>> @@ -3331,6 +3381,10 @@ static int balance_node_right(struct btrfs_trans=
_handle *trans,
>>  	if (max_push < push_items)
>>  		push_items =3D max_push;
>>
>> +	/* dst is the right eb, src is the middle eb */
>> +	ret =3D check_cross_tree_key_order(src, dst);
>> +	if (ret < 0)
>> +		return ret;
>>  	ret =3D tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
>>  	BUG_ON(ret < 0);
>>  	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
>> @@ -3810,6 +3864,12 @@ static int push_leaf_right(struct btrfs_trans_ha=
ndle *trans, struct btrfs_root
>>  	if (left_nritems =3D=3D 0)
>>  		goto out_unlock;
>>
>> +	ret =3D check_cross_tree_key_order(left, right);
>> +	if (ret < 0) {
>> +		btrfs_tree_unlock(right);
>> +		free_extent_buffer(right);
>> +		return ret;
>> +	}
>>  	if (path->slots[0] =3D=3D left_nritems && !empty) {
>>  		/* Key greater than all keys in the leaf, right neighbor has
>>  		 * enough room for it and we're not emptying our leaf to delete
>> @@ -4048,6 +4108,9 @@ static int push_leaf_left(struct btrfs_trans_hand=
le *trans, struct btrfs_root
>>  		goto out;
>>  	}
>>
>> +	ret =3D check_cross_tree_key_order(left, right);
>> +	if (ret < 0)
>> +		goto out;
>>  	return __push_leaf_left(path, min_data_size,
>>  			       empty, left, free_space, right_nritems,
>>  			       max_slot);
>>
