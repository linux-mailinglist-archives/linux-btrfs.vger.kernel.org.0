Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365CDC1D9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfI3JA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 05:00:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:36771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfI3JA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569834021;
        bh=xlpiXkqzAu/pz2Y7CnlJy5Crd8lhCZMyZawhjCKnjic=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B8tCFD8bmv8WknRpWi2AMH4tx3KLsjjHz36QvbLIAYVW6+AgKJRT9m/fgs+R4R/sI
         4yb6dM+jIVJpJSuhnzntTNQtup0W+h1lFroat96ZXWoqJwz2+O1FNtfzIFE3o4awBV
         e4eXcyFvM+kUuQuAyUyRfzOF/SN/+8h2DrLCFDSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1iIAOW1ZQy-003OgM; Mon, 30
 Sep 2019 11:00:21 +0200
Subject: Re: [PATCH 2/3] btrfs-progs: check/original: Add check and repair for
 invalid inode generation
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20190924081120.6283-1-wqu@suse.com>
 <20190924081120.6283-3-wqu@suse.com>
 <a621612d-21b7-cc30-ff5a-2502eee5acc4@suse.com>
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
Message-ID: <c7cf2823-91b9-bb09-471c-d43a19a24f05@gmx.com>
Date:   Mon, 30 Sep 2019 17:00:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a621612d-21b7-cc30-ff5a-2502eee5acc4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UrkC6YIsdM4Eil6K1bczFe1THRQ9yzF5Hkai0oDAvaf/HgKI1MY
 hTZchPgeEogUMAbG3w51AtK6V6xvGzE7JlLAh7fSQ/v38RxKe8zOBelLw2VOyysMD3WEy6X
 IyceQSJeUrET5PQy/Fx4bbe4o+RKfvpL11G93/WxPY8zRFlu9QX+OumPLkXfaMwD6A7R+N3
 92a1O7GENOSo1gWS8b83w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SrNHRsz4+A0=:ANPREbJgWv4Ckbj+czeKoi
 UVRR+EupRKR4nqXKtIqyto5Qk5E0lLBnS59hvER/+L2DHjcX488hcQ9FUciTq6a56C+disIWM
 LiSkw/3rsoXgHHeS0XUa26+gaYsw1V4KWjiFYuP/5dk9iFtPmdWWL3WhZjqWkX2l7B9GlaI1r
 h0pzfR7AuSp6L8dBFxHgk139p0FV4bnkee1DeQ8maN9bSCzBiqD/TZrcYA/rmF5+Vr8/SP294
 UFJXTcb2kmKH41etq0KOl245IGaVsC8zyll9lZYNnwvpF71e0UwyI3q1AdTnlFn5/VtWEiJ8r
 7CtdqiwiqGAot2SGrFnk8TjEmxicQoVlCjBkQM09NUaxo4qzvInjqags6MkEOPq4CrX+eUCPx
 2thZYjrtCXIT8bggtAyd2GPGWu3B7CV98V6aSil93wWHAMqQCiPxQmE4szZTdXKqSxakgFrkP
 k1YqzUD7Uigb28SAWvoD7qRkHnFG98IUK9Vpm9iinrkqWGAaGlzdK+hqBfb/92oU3ofanhM1W
 HsFWHmqrHoaI/2IGp03TAcCWymuMdkoccEnxh70KzTvm15EmUM1qlDuC3y3JrQlyY1o8QCbN1
 g1d6F6vXQYasGVt2Ylt3kNthmSjtOwuZ5IoBlQlV41W4awGHk3vZ2oYyBvdu3t3EOeybOJI9z
 VuXJmfoigFVI6clxXxjxlorgQtP8ydP3kD0hm6xUaPw+Fo3ZzhtZr1XOdkyLvDioNFelCqVQG
 jsNh5fRs7STMZZoVRv63SPojfkoYssRv2XCFOg/vDOtR+fKY4VyANIhRTFvPQCIGwRIfdkFbC
 cwI8tEMyLW7Yfk9KMDm044KBYjXB1xd22Y+bHSArd9LDJ7v5M6TTYNGvzF8M088q5TcOEyL94
 J/wi78otg6+EWyW1MyjLfNgXMcwsr17vuAYi9FW+2fJbXCnbFlV7oEQ+KSIIEKB348cl69+Zi
 wmxlNjS60cdMjr9wLtN2BhVIvHWwPf234hvXmP9y6W8S3+w1R/W6NH9gtmqWqNu8TJlI+JzEX
 75ROlk/nvdzQATlIcSwKlMuMKWtCmosuC+grEsb/ErW2DklQquQr2xmy/JB7LCRAW0EqTFlbt
 5EJuPUSYobD8VSI50BbUdp3To/8oJtQpHMx/SR5uRO36xE+JJY4qID9g0hplApi8O0Zp0nK0g
 xfbtu/w4Z+NunsOuQ1wRBRpmSvidf4907h3LZ2+CAA2TRy0kfOTxVxQ+ZW6QLbImo4yNDHZYG
 EJ/+vaMTImy9dnuPDM/gY1YEJ7Q0MFrgk2WetQ1jgncl24fk8txkKHqCaPCI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/30 =E4=B8=8B=E5=8D=884:41, Nikolay Borisov wrote:
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
>>   Unlike the original mode context, we don't have anyway to determine i=
f
>
> Perhaps you meant "lowmem mode context" since in lowmem you deduce
> whether it's a log-tree inode or not.

Oh, right.

Would you mind to fix this in commit time, David?

>
>>   this inode belongs to log tree.
>>   So we use super_generation + 1 as upper limit, just like what we did
>>   in kernel tree checker.
>>
>> - Check if the inode generation is larger than the upper limit
>>
>> - Repair by resetting inode generation to current transaction
>>   generation
>>   The difference is, in original mode, we have a common trans handle fo=
r
>>   all repair and reset path for each repair.
>>
>> Reported-by: Charles Wright <charles.v.wright@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I tested that code with the image provided and it does work as expected
> as well as it's fairly obvious what's happening. So:
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>

Thanks for the review and test.

Thanks,
Qu
>
>> ---
>>  check/main.c          | 50 ++++++++++++++++++++++++++++++++++++++++++-
>>  check/mode-original.h |  1 +
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index c2d0f394..018707c8 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -604,6 +604,8 @@ static void print_inode_error(struct btrfs_root *ro=
ot, struct inode_record *rec)
>>  	if (errors & I_ERR_INVALID_IMODE)
>>  		fprintf(stderr, ", invalid inode mode bit 0%o",
>>  			rec->imode & ~07777);
>> +	if (errors & I_ERR_INVALID_GEN)
>> +		fprintf(stderr, ", invalid inode generation");
>>  	fprintf(stderr, "\n");
>>
>>  	/* Print the holes if needed */
>> @@ -857,6 +859,7 @@ static int process_inode_item(struct extent_buffer =
*eb,
>>  {
>>  	struct inode_record *rec;
>>  	struct btrfs_inode_item *item;
>> +	u64 gen_uplimit;
>>  	u64 flags;
>>
>>  	rec =3D active_node->current;
>> @@ -879,6 +882,13 @@ static int process_inode_item(struct extent_buffer=
 *eb,
>>  	if (S_ISLNK(rec->imode) &&
>>  	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
>>  		rec->errors |=3D I_ERR_ODD_INODE_FLAGS;
>> +	/*
>> +	 * We don't have accurate root info to determine the correct
>> +	 * inode generation uplimit, use super_generation + 1 anyway
>> +	 */
>> +	gen_uplimit =3D btrfs_super_generation(global_info->super_copy) + 1;
>> +	if (btrfs_inode_generation(eb, item) > gen_uplimit)
>> +		rec->errors |=3D I_ERR_INVALID_GEN;
>>  	maybe_free_inode_rec(&active_node->inode_cache, rec);
>>  	return 0;
>>  }
>> @@ -2774,6 +2784,41 @@ static int repair_imode_original(struct btrfs_tr=
ans_handle *trans,
>>  	return ret;
>>  }
>>
>> +static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
>> +				     struct btrfs_root *root,
>> +				     struct btrfs_path *path,
>> +				     struct inode_record *rec)
>> +{
>> +	struct btrfs_inode_item *ii;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
>> +	key.objectid =3D rec->ino;
>> +	key.offset =3D 0;
>> +	key.type =3D BTRFS_INODE_ITEM_KEY;
>> +
>> +	ret =3D btrfs_search_slot(trans, root, &key, path, 0, 1);
>> +	if (ret > 0) {
>> +		ret =3D -ENOENT;
>> +		error("no inode item found for ino %llu", rec->ino);
>> +		return ret;
>> +	}
>> +	if (ret < 0) {
>> +		errno =3D -ret;
>> +		error("failed to search inode item for ino %llu: %m", rec->ino);
>> +		return ret;
>> +	}
>> +	ii =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +			    struct btrfs_inode_item);
>> +	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
>> +	btrfs_mark_buffer_dirty(path->nodes[0]);
>> +	btrfs_release_path(path);
>> +	printf("resetting inode generation to %llu for ino %llu\n",
>> +		trans->transid, rec->ino);
>> +	rec->errors &=3D ~I_ERR_INVALID_GEN;
>> +	return 0;
>> +}
>> +
>>  static int try_repair_inode(struct btrfs_root *root, struct inode_reco=
rd *rec)
>>  {
>>  	struct btrfs_trans_handle *trans;
>> @@ -2794,7 +2839,8 @@ static int try_repair_inode(struct btrfs_root *ro=
ot, struct inode_record *rec)
>>  			     I_ERR_FILE_NBYTES_WRONG |
>>  			     I_ERR_INLINE_RAM_BYTES_WRONG |
>>  			     I_ERR_MISMATCH_DIR_HASH |
>> -			     I_ERR_UNALIGNED_EXTENT_REC)))
>> +			     I_ERR_UNALIGNED_EXTENT_REC |
>> +			     I_ERR_INVALID_GEN)))
>>  		return rec->errors;
>>
>>  	/*
>> @@ -2829,6 +2875,8 @@ static int try_repair_inode(struct btrfs_root *ro=
ot, struct inode_record *rec)
>>  		ret =3D repair_unaligned_extent_recs(trans, root, &path, rec);
>>  	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
>>  		ret =3D repair_imode_original(trans, root, &path, rec);
>> +	if (!ret && rec->errors & I_ERR_INVALID_GEN)
>> +		ret =3D repair_inode_gen_original(trans, root, &path, rec);
>>  	btrfs_commit_transaction(trans, root);
>>  	btrfs_release_path(&path);
>>  	return ret;
>> diff --git a/check/mode-original.h b/check/mode-original.h
>> index 78d6bb30..b075a95c 100644
>> --- a/check/mode-original.h
>> +++ b/check/mode-original.h
>> @@ -185,6 +185,7 @@ struct unaligned_extent_rec_t {
>>  #define I_ERR_INLINE_RAM_BYTES_WRONG	(1 << 17)
>>  #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
>>  #define I_ERR_INVALID_IMODE		(1 << 19)
>> +#define I_ERR_INVALID_GEN		(1 << 20)
>>
>>  struct inode_record {
>>  	struct list_head backrefs;
>>
