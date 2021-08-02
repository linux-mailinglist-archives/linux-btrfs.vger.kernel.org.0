Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42003DD1A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhHBIDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 04:03:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:58619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhHBIDs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Aug 2021 04:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627891417;
        bh=9u5KgZJe7NXW94yupvRjpwolLHLVqd8jfxZy+6X24Tw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=krAJCSL04bKXsmU3jAHez664W7YDqHpIv4rNHKKqCsKJ+LVEeeRzfiae2qdjDkBPp
         4qwrMPOQ3hrmz/x52e+W2UXmEx3vYA60jUIDu37b6W8oNa56b9dPFOIHnch5twkOAw
         Js2Zjtno3fVacKTQlvuZLgxcSlk4X0KslffdKeiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9T7-1mIxNh1i1x-00987b; Mon, 02
 Aug 2021 10:03:36 +0200
Subject: Re: [PATCH 2/2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210802065447.178726-1-wqu@suse.com>
 <20210802065447.178726-3-wqu@suse.com>
 <594df624-3895-8787-9058-a00dba01c0cc@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5e516629-05f1-7750-1f0d-34cd73e8b52f@gmx.com>
Date:   Mon, 2 Aug 2021 16:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <594df624-3895-8787-9058-a00dba01c0cc@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6scM6STLFx6nBOOdTSOKep/2rFB8RVl8u+rroojE4Wj5lDQn3LC
 gzsUua9wnReaMyMNjHdKUlqjbqbWKXcKWf8wqjWr/JP+MvVsqw6y0PJcGDMPuupxQiN9Qu3
 cRNuzbmO5sVKWWcMLe9Ro8o28pZ/cKz2gLULxYAVRkvGGZiV/hBlXBb/cG4pGH+CEdmQ1yY
 AfUhvO0iWJjwcpC9j+zqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3TiWseMSH4=:QO+LqNuIAEzujmVAURLvNu
 BcrcyjvJyRiCd7K8PKlMbtF+nomkoLDTSkwBK2NPjUzlR2IQ60pT8Y/HCd5v0/iKEBzxUWb9o
 3MQT5pcYDCpmAujVKzz8WkPkEIrHYnC8TPujUxlev3+VR5McECmYCjEbO/aaXaRYAdtzIWO+d
 KdULxdxLkIrB4g/tVH2ubmqsC9HMWZ1jWIO/xhHabLf5NB8r0YxRE0IV50T9dUQTE9S3DRf03
 xsdf4BCEpNsIgnmjbUKzdMlv+d+x9nCZgUUWh8kNkhBaRTf/XJ/ctn/yb1aYfgjxBuhdc9bWK
 97CvZzJt0s+i5zNEwRT27+EdyBuqcAHvoabEhQkxco/KKYUFlRcT1F3VQD4XcWIplB7LezZGu
 Nymw2HqgCKYWkDDwxxMfoRcjGmwFKwFL3Au/MdZfr9fzJW7tgsadsS1cvEge2y/JgaDdSq4iB
 nj9l9/L+6o7GW0IMnKOx9nHpTxfoEdCVCks81BB152KOW7H9Y611Gm52HklcueOEgwBFgzRTu
 F8EQW+OMMIGJR1Cm+wbZi+IM8nCpPdhGdkgjGXaOIXQspoLl76jShv7Kiwq38PxvTLwaFh3y3
 18wcCjs45ZwWjBl/X/+81NZlA7KTn9EyHFx/ExviBeH72GBOm+8hF1fGRzPisMm2V5W3c+aNP
 XpteqVlcmjLwDYZwJ1lO/CvNC282YlsBPHSkVGscq/aUMXT2MVlIgdOSRj/BEeXtCnvsdal3y
 edVAEH7rXR0A+IwNxRadYJqpE+bOwELyUcLwEaZ8HzYEIbHmjCKbfaYr4114iza+VIHKvJbL5
 SUEIp6nbDYukQTr64xYgX0P4mkjCAyWSOX+N5x1d7TXGpVTYDSWVod1Qjfssxp/Tdg7gKode2
 52Y3qhVQIzuBSIP1QIGciHv1GBs4t5y+V1cBBadIN2ZmwxADAv2uLJvDdCVAWKhcj6ikwm5ch
 vqcIyyqeimlEHCXdtow4kyQyHv8zDuxzlRc4SvAyAY9k7eZqpPj9gBLhLyhTTfSxuP2Ei4oJK
 5fqsq24/qTad5LjxbikeD/DhFrUMqRtqg/KSnmb7ad0Purz5Sz0LriEBKutQJpbJSWSO5odev
 KnCiBKYeEKHxyFeTrEpgmRNcJPl+3Q5k28TwIKUlxd9sJcTEV3p3hkV5g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/2 =E4=B8=8B=E5=8D=883:53, Nikolay Borisov wrote:
>
>
> On 2.08.21 =D0=B3. 9:54, Qu Wenruo wrote:
>> The BUG_ON() in btrfs_csum_one_bio() means we're trying to submit a bio
>> while we don't have ordered extent for it at all.
>>
>> Normally this won't happen and is indeed a code logical error.
>>
>> But previous fix has already shown another possibility that, some call
>> sites don't handle error properly and submit the write bio after its
>> ordered extent has already been cleaned up.
>>
>> This patch will add an extra safe net by replacing the BUG_ON() to
>> proper error handling.
>>
>> And even if some day we hit a regression that we're submitting bio
>> without an ordered extent, we will return error and the pages will be
>> marked Error, and being caught properly.
>
> Would this hamper debugability? I.e it will result in some writes
> failing with an error, right?

Yes, it will make such corner case way more silent than before.

But IMHO the existing BUG_ON() is also overkilled.

Maybe converting it to WARN_ON() would be a good middle land?

Thanks,
Qu

>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/file-item.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 2673c6ba7a4e..25205b9dad69 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -665,7 +665,19 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode=
 *inode, struct bio *bio,
>>
>>   		if (!ordered) {
>>   			ordered =3D btrfs_lookup_ordered_extent(inode, offset);
>> -			BUG_ON(!ordered); /* Logic error */
>> +			/*
>> +			 * No ordered extent mostly means the OE has been
>> +			 * removed (mostly for error handling). Normally for
>> +			 * such case we should not flush_write_bio(), but
>> +			 * end_write_bio().
>> +			 *
>> +			 * But an extra safe net will never hurt. Just error
>> +			 * out.
>> +			 */
>> +			if (unlikely(!ordered)) {
>> +				kvfree(sums);
>> +				return BLK_STS_IOERR;
>> +			}
>>   		}
>>
>>   		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info,
>>
