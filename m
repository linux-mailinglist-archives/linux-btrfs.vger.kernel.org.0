Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419DDE1D42
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406140AbfJWNtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 09:49:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:37703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405956AbfJWNtP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 09:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571838542;
        bh=NINIzwWXj3Y2oUjQp6dMMxqR2JZz3I/xVtBdsLXKllw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fKY4maBp7Q7U0HXUWxjM0h5SutazeogH+Ocr8TUYQrOR6QKBmG0T0HIfJ/sFNvEOO
         yv9iV0P6Mtr82pkp4/8nEHmcsABsj6rtM7E/qSNVg4K8q+hle3qiRxnKxUhpgUzMsM
         SJz0nFesScE4T9vpDavS+EFXZbrqxtQaG2sMSk8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1htfLc2xbY-015FJq; Wed, 23
 Oct 2019 15:49:02 +0200
Subject: Re: [PATCH v2 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191023125648.30840-1-wqu@suse.com>
 <20191023125648.30840-3-wqu@suse.com>
 <93a74f3e-24c8-03b9-021e-368548d42984@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <e916b081-7f09-e631-1b6b-bc00e6388f48@gmx.com>
Date:   Wed, 23 Oct 2019 21:48:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <93a74f3e-24c8-03b9-021e-368548d42984@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yc0ro838CZ1x0SAGQN4vvyWl5fxOT4/hRPWEcoziLD7358jbp3O
 T0BdXGuotlS3fftKEXRjg+dvSUfeph5ZOJZQD8VLhxwzeV9b74aRxb5hlSQmxd/w1a0FNvB
 QxmoWLucP+5Z1aAFhocGVNlwi5AjgGqKG6DiIXjgaYVEQwFu2+v35ngkrQo66EeEklpJrHB
 RriAafX6cIIeA7VaxY7ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hUMPc1FG8x8=:8x3U2/sckE3r/k2+JnQell
 xNpPYrT37xlyR6u0BBlKqBPavzpV7vCItYP2AInudgjJwBpXy+2prxNSIt6xZS8zrvFehT/rN
 m3n0jltVhHzL76z0Q7WLD060wOgUNXrus34C2S5MnztHXSrRD0ZIX+eyEXKjw4EMEG0Q4ByEu
 LNQgmJwAWoCeLxXngdpMwXWDOBeaGIZd4EqRhsUmv6f89z6mbwDax5asotEbY6vf7kF/AOuXA
 HcEQ1HiQpMujo48wy/enU3Rk/XByENPDXCTK7wNZ2QHwPmc9CAjOhpuBrFrEhv9YA4Pxo/ZDs
 MZOypPVz5lJw2LRJL3VPo+BYkV4SRY0DpKu6zi+ISNgPOzIaqKshuguFAaxlmEg2XpVKztXqw
 HYJWSzjvMtEwCukfjNx5FRBJeA1OXKFBn6S/mRvy4/FXNj6UjyiQxGi0WqNgmY9QEDGSsictX
 zT9uRGZKT6WSPWo4AFj8YpaPZXBy8hWqEhufkJKbjhlXA49WP9jHXxa/9Ao0jBJklgGhlbQmr
 0tIe6c0FLX2o3Tv2rg5mZTKGQl/vEjDZQE6Fj7U6HT1wUvgLzQIF9hq4I1UzsXc1L1ZyWeshf
 gEa7aD0jGQg7U+CfWLHRbQYf4FbOwYetjVTpJYDlnJb4Da5bZFFtIEG8O6HDouWMgsXoTBH0Q
 aJJ1SFi4mPoySr0txNm0ScAhbraLukC7+nLi/my47+PKEBrYh1Wdz2Qr2uXQmS7DnBlxFeNmn
 J7PNySdpU2bCQRZ418TpM1QfUCsXA4DewPFU59GwBaODtZ1F5Z5OnnKKKLJMaPFwP940jkx4D
 kB5mB596y5iI33uyvk2bw7iGYvW7zPwnP62Q4uo4VIRiUMIeXj/1PWX5v8Zz1IJj7s6lEBbte
 F6mNyHvPbhIsmjiGBNqQ0RGT70MErIMmC+BpWutHBN9Jps5Vs+oVSut7NyE30fzFbycr3rApL
 6N4T1cxBicLEv8fYj56YEryxxWxzSpNhSBKIvmZTghCK0UrXkX3qgaGGUGVIqvVmS8Osfd8WP
 2qhTkj2RvwVmIVEcZ87NYbYeYFhEYOryrWdcJTpQJP/XTMNo7NGJIZY5al2QjI017ZGPULP62
 6V6W+KUUqt0JKItxuCPFWSHCnHYaaWDhdEb/vZ9VaAbJTekgaKChSSIB4fvwXRLffTx9b1mQi
 dMwSMkM6G1ZaQCJ4ZCeJl+qDfC1+jC1Q45eczM10hU6M5j8fNB4stU9h95YMZY3doh2lzJX26
 1GqSk8OY9jR2xS1I4ysyddTTC1Vlnd6OiRa9bd53L7v4P9dU6yaz6N4sn918=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/23 =E4=B8=8B=E5=8D=889:37, Nikolay Borisov wrote:
>
>
> On 23.10.19 =D0=B3. 15:56 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> When deleting large files (which cross block group boundary) with disca=
rd
>> mount option, we find some btrfs_discard_extent() calls only trimmed pa=
rt
>> of its space, not the whole range:
>>
>>   btrfs_discard_extent: type=3D0x1 start=3D19626196992 len=3D2144530432=
 trimmed=3D1073741824 ratio=3D50%
>>
>> type:		bbio->map_type, in above case, it's SINGLE DATA.
>> start:		Logical address of this trim
>> len:		Logical length of this trim
>> trimmed:	Physically trimmed bytes
>> ratio:		trimmed / len
>>
>> Thus leading some unused space not discarded.
>>
>> [CAUSE]
>> When discard mount option is specified, after a transaction is fully
>> committed (super block written to disk), we begin to cleanup pinned
>> extents in the following call chain:
>>
>> btrfs_commit_transaction()
>> |- write_all_supers()
>> |- btrfs_finish_extent_commit()
>>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>>    |- btrfs_discard_extent()
>>
>> However pinned extents are recorded in an extent_io_tree, which can
>> merge adjacent extent states.
>>
>> When a large file get deleted and it has adjacent file extents across
>> block group boundary, we will get a large merged range.
>>
>> Then when we pass the large range into btrfs_discard_extent(),
>> btrfs_discard_extent() will just trim the first part, without trimming
>> the remaining part.
>>
>> Furthermore, this bug is not that reliably observed, as if the whole
>> block group is empty, there will be another trim for that block group.
>>
>> So the most obvious way to find this missing trim needs to delete large
>> extents at block group boundary without empting involved block groups.
>>
>> [FIX]
>> - Allow __btrfs_map_block_for_discard() to modify @length parameter
>>   btrfs_map_block() uses its @length paramter to notify the caller how
>>   many bytes are mapped in current call.
>>   With __btrfs_map_block_for_discard() also modifing the @length,
>>   btrfs_discard_extent() now understands if it needs to do next trim.
>>
>> - Call btrfs_map_block() in a loop until we hit the range end
>>   Since we now know how many bytes are mapped each time, we can iterate
>>   through each block group boundary and issue correct trim for each
>>   range.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent-tree.c | 40 ++++++++++++++++++++++++++++++----------
>>  fs/btrfs/volumes.c     |  6 ++++--
>>  2 files changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 49cb26fa7c63..45df45fa775b 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -1306,8 +1306,10 @@ static int btrfs_issue_discard(struct block_devi=
ce *bdev, u64 start, u64 len,
>>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>  			 u64 num_bytes, u64 *actual_bytes)
>>  {
>> -	int ret;
>> +	int ret =3D 0;
>>  	u64 discarded_bytes =3D 0;
>> +	u64 end =3D bytenr + num_bytes;
>> +	u64 cur =3D bytenr;
>>  	struct btrfs_bio *bbio =3D NULL;
>>
>>
>> @@ -1316,15 +1318,22 @@ int btrfs_discard_extent(struct btrfs_fs_info *=
fs_info, u64 bytenr,
>>  	 * associated to its stripes that don't go away while we are discardi=
ng.
>>  	 */
>>  	btrfs_bio_counter_inc_blocked(fs_info);
>> -	/* Tell the block device(s) that the sectors can be discarded */
>> -	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, bytenr, &num_byte=
s,
>> -			      &bbio, 0);
>> -	/* Error condition is -ENOMEM */
>> -	if (!ret) {
>> -		struct btrfs_bio_stripe *stripe =3D bbio->stripes;
>> +	while (cur < end) {
>> +		struct btrfs_bio_stripe *stripe;
>>  		int i;
>>
>> +		/* Tell the block device(s) that the sectors can be discarded */
>> +		ret =3D btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
>> +				      &num_bytes, &bbio, 0);
>> +		/*
>> +		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
>> +		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
>> +		 * thus we can't continue anyway.
>> +		 */
>> +		if (ret < 0)
>> +			goto out;
>>
>> +		stripe =3D bbio->stripes;
>>  		for (i =3D 0; i < bbio->num_stripes; i++, stripe++) {
>>  			u64 bytes;
>>  			struct request_queue *req_q;
>> @@ -1341,10 +1350,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *=
fs_info, u64 bytenr,
>>  						  stripe->physical,
>>  						  stripe->length,
>>  						  &bytes);
>> -			if (!ret)
>> +			if (!ret) {
>>  				discarded_bytes +=3D bytes;
>> -			else if (ret !=3D -EOPNOTSUPP)
>> -				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how th=
at could happen JDM */
>> +			} else if (ret !=3D -EOPNOTSUPP) {
>> +				/*
>> +				 * Logic errors or -ENOMEM, or -EIO but I don't
>> +				 * know how that could happen JDM
>> +				 *
>> +				 * Ans since there are two loops, explicitly
>> +				 * goto out to avoid confusion.
>> +				 */
>> +				btrfs_put_bbio(bbio);
>> +				goto out;
>> +			}
>>
>>  			/*
>>  			 * Just in case we get back EOPNOTSUPP for some reason,
>> @@ -1354,7 +1372,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
_info, u64 bytenr,
>>  			ret =3D 0;
>>  		}
>>  		btrfs_put_bbio(bbio);
>> +		cur +=3D num_bytes;
>
> Shouldn't  you keep the number of bytes requested to discard and deduct
> from the actual amount being discarded.
>
> Say you want to discard 1G but for whatever reason this has to be done
> in, say, 1 chunk of 750mb and a second chunk of 250 mb. On the first go
> you will discard 750mb and add them to cur, numbytes at this point are
> 750mb then you call btrfs_map_block with num_bytes being 750mb whereas
> they should have been 250mb. And if the code manages to map the 2nd
> 750mb it could potentially trim more than requested and corrupt data.

Oh! Great find!

That's indeed a problem! So every time before we call btrfs_map_block()
we should adjust @num_bytes to @end - @cur.

Thanks for catching this big bug!
Qu
>
>>  	}
>> +out:
>>  	btrfs_bio_counter_dec(fs_info);
>>
>>  	if (actual_bytes)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a6db11e821a5..f66bd0d03f44 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
>>   * replace.
>>   */
>>  static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info=
,
>> -					 u64 logical, u64 length,
>> +					 u64 logical, u64 *length_ret,
>>  					 struct btrfs_bio **bbio_ret)
>>  {
>>  	struct extent_map *em;
>>  	struct map_lookup *map;
>>  	struct btrfs_bio *bbio;
>> +	u64 length =3D *length_ret;
>>  	u64 offset;
>>  	u64 stripe_nr;
>>  	u64 stripe_nr_end;
>> @@ -5617,6 +5618,7 @@ static int __btrfs_map_block_for_discard(struct b=
trfs_fs_info *fs_info,
>>
>>  	offset =3D logical - em->start;
>>  	length =3D min_t(u64, em->start + em->len - logical, length);
>> +	*length_ret =3D length;
>>
>>  	stripe_len =3D map->stripe_len;
>>  	/*
>> @@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_info=
 *fs_info,
>>
>>  	if (op =3D=3D BTRFS_MAP_DISCARD)
>>  		return __btrfs_map_block_for_discard(fs_info, logical,
>> -						     *length, bbio_ret);
>> +						     length, bbio_ret);
>>
>>  	ret =3D btrfs_get_io_geometry(fs_info, op, logical, *length, &geom);
>>  	if (ret < 0)
>>
