Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF04F9FD0
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Apr 2022 00:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiDHXBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDHXBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 19:01:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5938BF6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649458740;
        bh=B3Kz8LmoUhhRRJc/aUMXEYrfsy/wC9avrH8UbVcxhPA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I9HASuFr61rLSHxN4JHkGcvLiHPn/gippn3uIHF7QeiSVhEfGFW7wfbn+nDHWcsao
         Kq4GFXPRPRML8rlr7nJxkkX1/r867pClQAJVkhsEGWbTjQ0dS1mTQjpDKvrK/65uZN
         SKj7euovkQcgeGCBvqKMyBZ9ySp+zdGAFh9ZmgGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1nZde32Eaq-005VT1; Sat, 09
 Apr 2022 00:59:00 +0200
Message-ID: <adef07e2-a6fe-0be5-1c8a-e57be8af19c6@gmx.com>
Date:   Sat, 9 Apr 2022 06:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 05/16] btrfs: introduce btrfs_raid_bio::bio_sectors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <5737a015d302fb7cb3774deb3115f0e8a26258db.1648807440.git.wqu@suse.com>
 <20220408164647.GV15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408164647.GV15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Go8tMag6LHHE/pIbB91CXd2cymAGly8IGHlAD31o1jfVAxi50L0
 Mh0I029VBneKOBr1CnIHcGWNBQmlW8PLimWuXzJFub0MuVdGuSkuUw8kCUG7enDhKujjlFg
 gf0qRTd67Azx8Z1h5cmxXJ1/ATENDJZUMX6TgHJyqDWc/MDxZgCdlwnE2TnwTNq2eVsMfif
 VZiSq9gAnW1YgGbthbgNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dhNWtz4T0fQ=:05bTNK9q2NJZgdF5TrF3Z0
 TnjH4bfp5j72+Jy2S+z2A4YWPjGpPTLXgi3/76tJWD5prW3XEEMXmb+BG/gmu7ZEDto1kXwX5
 s4UDzCflfkzGZxvKhvKuJZGfYLX7HcvWsc4pp7WlWnpQAXc/QXLHIeDAhWZlUKz9RyoHTAUiS
 cXvgqOGnKMocZgolZYE690DkU7KTRe8cgFDtRHMEczVjWWLGOhPPFJRwt+Jku4MLoQNu0+ILz
 WaZUK/KYhZqxQ7bcieMkLuCGY+Y+jwT7w6nLiB2I/8z2DMARlGuO91B4Iz4lovsgrfwUclwl7
 cmD3SjFD+TirQ0cYIE1QEf5PpNItN1BrogNuP7GuC0IY8qMP40pvawNhbnTdhyrCrw+aKo4Ii
 Sfq7EhfkmRzwJzz45QlWAOglJepfpFc6p68oNIJw4ekGF9ZIDjvGyqDXWHyS0cz+4XNSNtkrs
 1i29/lb7+JHZrdrpMwBx+14MdXqVIPV3CmlHLERAThe8byvogBx2sr10YmP3usLtewYxkNy4J
 qZ1QCz2S0/sDiR+qNP3w7ijGlN695pX3NDPKPQpNMHv/5Ryzy40J88rMLaTc/gZCmG/V2hw/T
 AK9xOsnActkoQbWNEQnW+xWdQiFjGbunuXO5W7SM93hzARY1fSc6jvIl/p3InKRvK9/HjgCtd
 PA3jpwQvNwcs3b35ji1NQOKMjp8CWSHAg7nk/Ru/FbdkCbxQN2WMe2NaOEqfAsiRN9FtVCI9g
 GBfwGXZ4q0+sVYc77kPflfnP1dR4drXURQVlbOXeqXLsXKLcdChyA+A2dKI/nsll4+WzCHUWY
 O2+zYYZ/xslZUOH8jqenaVXRgDKuWUNWtU0CHOtKqAq1QpgI41FhrDLZ4zJWRcQ6Xrgy0nNdp
 /yhEefxCQU24A7F9GFBxvyN+5IJgh8WrFzzdw3YfrPjjyC4fKhMfWKJ8Ebx9OfsxidwlvxYTb
 //cgFYs0Ia+7+n4+J9vqDvwX8kFLgO09/+sCSEMHwy2jACj4J9zu7nKDtwOLeAYVOrPRkIAE9
 fDPyI1DVE204yRYdaB1W7sym/C37aXuggbRHRPLbDdD1w3YZH6BhV1GVo7O8clBaDQFmVbcIg
 84mgs+XV/wEMlI=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/9 00:46, David Sterba wrote:
> On Fri, Apr 01, 2022 at 07:23:20PM +0800, Qu Wenruo wrote:
>> This new member is going to fully replace bio_pages in the future, but
>> for now let's keep them co-exist, until the full switch is done.
>>
>> Currently cache_rbio_pages() and index_rbio_pages() will also populate
>> the new array.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/raid56.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++=
-
>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 8cfe00db79c9..f23fd282d298 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -60,6 +60,7 @@ struct btrfs_stripe_hash_table {
>>   struct sector_ptr {
>>   	struct page *page;
>>   	unsigned int pgoff;
>> +	unsigned int uptodate:1;
>>   } __attribute__ ((__packed__));
>
> Even with packed this does not help as the full in is allocated for the
> single bit and it requires bit operations to set/clear. Up to 4 bools
> fit into one int and using them is better.

I guess I can put pgoff to take at most 31 bits, then can share uptodate
flag with pgoff.

>
>>
>>   enum btrfs_rbio_ops {
>> @@ -175,6 +176,9 @@ struct btrfs_raid_bio {
>>   	 */
>>   	struct page **stripe_pages;
>>
>> +	/* Pointers to the sectors in the bio_list, for faster lookup */
>> +	struct sector_ptr *bio_sectors;
>> +
>>   	/* Pointers to the pages in the bio_list, for faster lookup */
>>   	struct page **bio_pages;
>>
>> @@ -282,6 +286,24 @@ static void cache_rbio_pages(struct btrfs_raid_bio=
 *rbio)
>>   		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
>>   		SetPageUptodate(rbio->stripe_pages[i]);
>>   	}
>> +
>> +	/*
>> +	 * TODO: This work is duplicated with above loop, should remove above
>
> I think I told you several times, please don't write TODO notes. A plain
> comment explaining that the loop is duplicated is understandable by
> itself.

Even it's going to be deleted in later patches?

TODO provides a pretty good highlight in most editors, thus it's way
more easier to be exposed without being forgotten.

Thanks,
Qu

>
>> +	 * loop when the switch is fully done.
>> +	 */
>> +	for (i =3D 0; i < rbio->nr_sectors; i++) {
>> +		/* Some range not covered by bio (partial write), skip it */
>> +		if (!rbio->bio_sectors[i].page)
>> +			continue;
>> +
>> +		ASSERT(rbio->stripe_sectors[i].page);
>> +		memcpy_page(rbio->stripe_sectors[i].page,
>> +			    rbio->stripe_sectors[i].pgoff,
>> +			    rbio->bio_sectors[i].page,
>> +			    rbio->bio_sectors[i].pgoff,
>> +			    rbio->bioc->fs_info->sectorsize);
>> +		rbio->stripe_sectors[i].uptodate =3D 1;
>> +	}
>>   	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
>>   }
>>
