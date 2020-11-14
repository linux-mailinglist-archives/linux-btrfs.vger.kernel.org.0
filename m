Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E32B298A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 01:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKNALi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 19:11:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:55509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKNALi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 19:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605312694;
        bh=XnKXzvLuPQi7SL237E3kv57Yk2LTFTsWEFfCBsVdZzw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IX5Mqe+MVXpsklH9sI4g0lf+oJgZ0bAUalP+cJ/kTN54b4lPoIG3djGtXbDWepvlk
         22O3jSpFsx0IfjsVo5dNgl0ECkaqUEsobwEqs3E5fe1W5zTqPXHgoslkDWJWB0qKGT
         V5jl8N5Rg8aqOxqblUJuOu4wYriknKz03Ug3N6Dg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1kerDm0Y6W-007mE4; Sat, 14
 Nov 2020 01:11:34 +0100
Subject: Re: [PATCH v2 09/24] btrfs: extent_io: calculate inline extent buffer
 page size based on page size
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-10-wqu@suse.com>
 <e9046ea1-abf0-3352-8e4f-f454410b7dc8@toxicpanda.com>
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
Message-ID: <9bf18831-b586-f798-f706-eaf0bf3245a7@gmx.com>
Date:   Sat, 14 Nov 2020 08:11:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e9046ea1-abf0-3352-8e4f-f454410b7dc8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nOf+W6DW8sk6LwExxOTXT6oVI6PlNW2pBxIWBFQ2/oibL4m16gW
 3Ql7RgESoXCT0DwGIIqNcUF1b98EHQ5WnQi/CPsEhyOmqP/Sj0i4imFy3H+sGNBLn/PH3pe
 4A4sTRJxVDMU0sYflVX+alzfe0EnEaVq+xTyIMDwm86V7hF7yZZWSEVz9BB/0NMm0VDdLSr
 NaNYV2o47nRYPy6YiWA/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qA4RqGXYTFQ=:sv5/Ke4nXKVrXWgFMXcREq
 P0zJkxOyINBlK1FyiQJuIlAXpI3hivdkViewdPcK4jiF1NKZ2QeP3CKnVP1/CMESPnNNudt10
 4nHw5YEAmHY4z6laOI1xXtToZardm5Nd7M7xqVjjIMlFZ7juCSaeLZAdkGwnIEy6olWgWn826
 gGXWe56/DqRgcebmCpgNAfw01iG9QdbuqHMkeGDEgteg6SyxcN+32gpmTWsPIWDgHqXesdaZO
 HhfzM8w+qK7k8Jv4T/1kjXlTgXp6QHcLkydKDmjmFJFcuvUx+mVYHqjycekyYBa17ul7SJx20
 Y/zChkqFCuvFeHtTA9R5vNm5qwQjrpi64DpdoRwzlpDNpb7w+OXFHbiyo4hk3mxxkUM4ngqhn
 7eX+rH4ULMGbvmORcjXSr5gwYYeQOsBSZ4OrqFUDojr2lcDtGuRM7hpjVo3bvSjMGdpl2hBPv
 DLPput0wMZfkKVx+yLwne4TvCWVnj0MyepCSehYJtHu1vV+CvA/BkistwAwPyRVAdoZoFOBxd
 Mm4fASnf67AI6vnag2u0JV/uK4sx/2sqD9ZHP1z7zt79fLAnXnyPwuc1pf9FWWceweuNH8vIb
 3L3VFe6sHLm9EkGZKwo+eDHbZ0KRLLQlqRixQRgO8BzxERJUi0z9aQhhApkCfJlHd8Nh8NgHN
 fY5e6Qtx1DdGfJhHSiSCZGMqiA5D9lqiDpr6+bfYwK9Rf2Bj17cKWug6ZU/4qhVL5KSixYbek
 D6rqPPUXO42gPNT8eLyBSDPlHVqHJoZkqAxZWjoROoSQ3RaqZF5G6e2U+D1TbUdMtgW22QqP4
 szU94G4vEkTQpsqFUBitbomPGSYe6wV+F3z1MhF0axkDSLESgwkrmK2ZFVvCEN77nTxjrAWFz
 NPFmh/ad0VClZPz4r7Bg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/14 =E4=B8=8A=E5=8D=883:47, Josef Bacik wrote:
> On 11/13/20 7:51 AM, Qu Wenruo wrote:
>> Btrfs only support 64K as max node size, thus for 4K page system, we
>> would have at most 16 pages for one extent buffer.
>>
>> For a system using 64K page size, we would really have just one
>> single page.
>>
>> While we always use 16 pages for extent_buffer::pages[], this means for
>> systems using 64K pages, we are wasting memory for the 15 pages which
>> will never be utilized.
>>
>> So this patch will change how the extent_buffer::pages[] array size is
>> calclulated, now it will be calculated using
>> BTRFS_MAX_METADATA_BLOCKSIZE and PAGE_SIZE.
>>
>> For systems using 4K page size, it will stay 16 pages.
>> For systems using 64K page size, it will be just 1 page.
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 7 +------
>> =C2=A0 fs/btrfs/extent_io.h | 8 +++++---
>> =C2=A0 2 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 37dd103213f9..ca3eb095a298 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5042,12 +5042,7 @@ __alloc_extent_buffer(struct btrfs_fs_info
>> *fs_info, u64 start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&eb->refs, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&eb->io_pages, 0);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Sanity checks, currently the maximum is 64k=
 covered by 16x 4k
>> pages
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > MAX_INLINE_EXTENT_BUFFER_=
SIZE);
>> -=C2=A0=C2=A0=C2=A0 BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
>> +=C2=A0=C2=A0=C2=A0 ASSERT(len <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return eb;
>> =C2=A0 }
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index c76697fc3120..dfdef9c5c379 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -73,9 +73,11 @@ typedef blk_status_t (submit_bio_hook_t)(struct
>> inode *inode, struct bio *bio,
>> =C2=A0 =C2=A0 typedef blk_status_t (extent_submit_bio_start_t)(struct i=
node *inode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bio *bio,=
 u64 bio_offset);
>> -
>> -#define INLINE_EXTENT_BUFFER_PAGES 16
>> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES *
>> PAGE_SIZE)
>> +/*
>> + * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circ=
le
>> + * including "ctree.h".
>> + */
>
> Just a passing thought, maybe we should move that definition into
> btrfs_tree.h.

Indeed, this is much better and solves the ctree.h including loop.

Would be another patch though.

Thanks,
Qu
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
