Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395322AB857
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 13:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKIMfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 07:35:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:52225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIMfF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 07:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604925301;
        bh=hnSBLWMbLhAg4iY3emd2owDAx6sz8hHHfcpYFck3yUI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WJDRgUmP0WBKjRfXISGfAtLb58iZ4StKjPua4qQ6qa7t7V3KW2IujiuMzHssmX1zd
         vNysP9YJ+KUw3mTgC/V1f41mPr5wNGtPmKGT25/YFYF6a4v37z+Nv9vKH5XgilYMrE
         V3rSQd8/iFYJCJJyfUwdlsxz8MEN/qxaVuYtIu60=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1knOlL4BEB-00Xs9C; Mon, 09
 Nov 2020 13:35:01 +0100
Subject: Re: [PATCH 2/2] btrfs: use more straightforward disk_bytenr to
 replace icsum for check_data_csum()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201109115410.605880-1-wqu@suse.com>
 <20201109115410.605880-3-wqu@suse.com>
 <bb177936-c2e7-2b1d-387c-13128527667b@suse.com>
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
Message-ID: <eeb31f7c-9535-6950-4914-65d6de6d8e75@gmx.com>
Date:   Mon, 9 Nov 2020 20:34:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bb177936-c2e7-2b1d-387c-13128527667b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlUXZMruaP5KNlENI6RWIVilAkpypXEUi0DQejQohcX8dgrrhlb
 M6l6OIpPr28XekOo3GCik1wxaMAVy7z4SxgBoLphhK4Y1MGFxYqYD0jd4Ua7y5aHpAoe8AP
 XWTWS1pBsYUbWPvNU/TqIbOA+szhiWeV5j6MbFC+8y+d5CmtMKmHKSO9bAFHRjgaMzEUy4/
 oZpcsA+Vk2jRG6QMKyQ+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bqxcr9cByT0=:GVc+TsZIJnEHmg0UFVy6oT
 2JeVlYbXxqd0Uw9nYuVlnSXshFqna2H0kF1OC1VB/nFUa78NNCzFF6BzzpM5455QNxb3nn2ro
 zMz08O5+8iXPYHZBWms6El/lzJCi7jHE2hf5QbbKXHcxzVMx8WV1OqMKVf5UbdVWz4jz3DATG
 77F7t7mWIbR5Z6HCa+0LOOoXmAre3lzzS4G6wQk0W4OIh+avihdmfgeFvweB4FiDmEyldA/dS
 0OzE2BEUqLePCHAKcGM2CNexyCYumEubmM8WBKda/z6VeuEg/9x9Wqcsg2GFrP8VMFCee8HGn
 UZC7C9Gv0nmLl1huAIg76ihRZ2dS+Ov9GCE2lNzVyZKOSvJ5iZTKpUCvXowS0hy5x3S2kUGR9
 DEik8puwhNQ3atWuNuNzl81VZpRV2Pr/vLzyeE7TH4CwrXoOjlB46LowSLtVhnn02UsGppx9Z
 LrV0b63B2DOeGKui4DyKehRhKafSR05H5MsKZl4iklDZTALzEZGPf7y5cI5+7rC/t9daQDhu+
 qtxuGHLs7WJnqlf8CXpGptun0zULsj6o776fyF7LPkaJ9MEoNWODmR8Hh+PAz57Nde/tv+dzx
 xhhXsZ4M3nX8m80DD9gpz4vb6aFlysdaOXWJ2HDnp8dPdar4LGp7SZcWiQr56ks9GWSLeg7RZ
 l0jiY/lwLdtPC7dqpvLsXl0gQdzVxx+EBnHDOSeaaeSw1tHhlgP+qjdLNcx7jRQU8aMckIbvZ
 uj3FmhPZh8NmDHO6ToBQoQVQnlE/DSpOKjAWxd7UnxU3mPp/oqhS5PcdmeYzjTuh2VipNk3n0
 mVcbiGNfGc8nYeSVvLYwXQ7R9FJQvHFvMPHPsuhqLBWENnOj0bE/oeJONt1x+y+ANZHeyg+4H
 7iccwnulqqdgSpRHANYg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/9 =E4=B8=8B=E5=8D=888:19, Nikolay Borisov wrote:
>
>
> On 9.11.20 =D0=B3. 13:54 =D1=87., Qu Wenruo wrote:
>> Parameter @icsum for check_data_csum() is a little hard to understand.
>> It is the offset in sectors compared to io_bio->logical.
>
> This second sentence is confusing because io_bio->logical is used for re=
pair/dio bios and not buffered whilst  icsum is calculated independently o=
f io_bio->logical so I'd suggest you remove it.

Right, I also find the io_bio::logical inconsistency.
What I want to say is (io_bio->bio.bi_iter.bi_sector << 9).
>>
>> Instead of using the calculated value, let's go with disk_bytenr, as th=
e
>> new name is not only straightforward,  but also utilized in a lot of
>> existing code for file items.
>
> Just say that instead of passing in the calculated offset couple of leve=
ls deep you modify the code to instead pass disk_bytenr of currently proce=
ssed biovec and use that to calculate the offset closer to actual users of=
 it. Kind of like what I did below.
>
>>
>> To get the old @icsum value, we simply use
>> (disk_bytenr - (io_bio->bio.bi_iter.bi_sector << 9)) >>
>> fs_info->sectorsize_bits;
>>
>> This patch would separate file offset with disk_bytenr completely, to
>> reduce the confusion.
>
> I find this description somewhat confusing, what you are doing is just m=
oving the sector offset calculation closer to where it's being used, rathe=
r than calculating it in the top level endio handler and passing it severa=
l levels down to where it's actually used - in the csum verification funct=
ion. So where is file offset involved?

Well, you see the parameter @start and @end of btrfs_verify_data_csum()
right?

That's why we want to distinguish the file offset from on-disk bytenr.

>
> Otherwise the code LGTM apart from some minor nits below.
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 14 ++++++++------
>>  fs/btrfs/inode.c     | 35 ++++++++++++++++++++++++++---------
>>  2 files changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index bd5a22bfee68..f8b5d3d4e5b0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>>  	struct btrfs_io_bio *io_bio =3D btrfs_io_bio(bio);
>>  	struct extent_io_tree *tree, *failure_tree;
>>  	struct processed_extent processed =3D { 0 };
>> -	u64 offset =3D 0;
>> +	u64 disk_bytenr =3D (bio->bi_iter.bi_sector << 9);
>
> needless parentheses.
>
>>  	u64 start;
>>  	u64 end;
>>  	u64 len;
>
> <snip>
>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index c54e0ed0b938..eff987931f0d 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2843,19 +2843,27 @@ void btrfs_writepage_endio_finish_ordered(struc=
t page *page, u64 start,
>>   * The length of such check is always one sector size.
>>   */
>
> It's not evident from the hunk but you should also modify the parameter =
description of this function since we no longer have 'icsum'
>
>>  static int check_data_csum(struct inode *inode, struct btrfs_io_bio *i=
o_bio,
>> -			   int icsum, struct page *page, int pgoff)
>> +			   u64 disk_bytenr, struct page *page, int pgoff)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>  	char *kaddr;
>>  	u32 len =3D fs_info->sectorsize;
>>  	const u32 csum_size =3D fs_info->csum_size;
>> +	u64 bio_disk_bytenr =3D (io_bio->bio.bi_iter.bi_sector << 9);
>
> Again, extra parentheses, they don't bring anything in this particular e=
xpression.
>
>> +	int offset_sectors;
>>  	u8 *csum_expected;
>>  	u8 csum[BTRFS_CSUM_SIZE];
>>
>>  	ASSERT(pgoff + len <=3D PAGE_SIZE);
>>
>> -	csum_expected =3D ((u8 *)io_bio->csum) + icsum * csum_size;
>> +	/* Our disk_bytenr should be inside the io_bio */
>> +	ASSERT(bio_disk_bytenr <=3D disk_bytenr &&
>> +	       disk_bytenr < bio_disk_bytenr + io_bio->bio.bi_iter.bi_size);
>
> nit: in_range(disk_bytenr, bio_disk_bytenr, io_bio->bio.bi_iter.bi_size)=
;
>
> IMO the assert is redundant since it's obvious disk_bytenr will always b=
e within range, but perhahps it's needed for your future subpage work so I=
'm not going to insist on removing it.

The "bio_disk_bytenr <=3D disk_bytenr" is obvious and I'm fine to remove
it, but the later "disk_bytenr < bio_disk_bytenr +
io_bio->bio.bi_iter.bi_size" is a completely valid check.

This is even more important since we use disk_bytenr to calculate where
the expected csum is.
If disk_bytenr goes beyond bio range, it will cause memory access out of
boudary.

In fact, this assert() has already caught cases in my later patches
where I forgot bv_len can go beyond current page.

Thanks,
Qu
>
>> +
>> +	offset_sectors =3D (disk_bytenr - bio_disk_bytenr) >>
>> +			 fs_info->sectorsize_bits;
>> +	csum_expected =3D ((u8 *)io_bio->csum) + offset_sectors * csum_size;
>>
>>  	kaddr =3D kmap_atomic(page);
>>  	shash->tfm =3D fs_info->csum_shash;
>> @@ -2883,8 +2891,13 @@ static int check_data_csum(struct inode *inode, =
struct btrfs_io_bio *io_bio,
>
> <snip>
>
