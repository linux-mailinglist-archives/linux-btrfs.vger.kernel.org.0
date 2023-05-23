Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FD70E9BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjEWXrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEWXrH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 19:47:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13DE5;
        Tue, 23 May 2023 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684885609; i=quwenruo.btrfs@gmx.com;
        bh=G5KYpYlhk54UdipAJmScaweDhH+/gdyeRHgOiknZjUQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=CrbgTiI0G4EPNCJxzqkfBpo8hCPCB/NLgftRZuVWXO2H3wHmxzNHPUVCRQwaSYaEI
         ggldQt5MeQJ5IAC0FzIdRqtFr7jrpyfZR35h36QUf4Z9U4wI46PBYUIIksmbb4a7jV
         8Em4ZgFVhxGUEUm74E5yGBVjuG7LBFHZULOzp5WDUsfQD/RLr7nFBReLxppxl2CLM3
         3gmKYl9E07pCleUr3qRaxlB+HvipRc9AhrnOuPV9/aZn+ZKbQH3jmaBILVtu8liLP+
         z6F9AXkVZnQXxX1M68RncZMXpKlFUc/gt4bFaeG4mKGSX+eldGyGAh0QI587z3zqWb
         yG5w41GeAg+/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1qT02X2CAn-00q827; Wed, 24
 May 2023 01:46:49 +0200
Message-ID: <bad56f93-6ffb-9505-92ce-67ab9e006e9c@gmx.com>
Date:   Wed, 24 May 2023 07:46:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     dsterba@suse.cz
Cc:     pengfuyuan <pengfuyuan@kylinos.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
 <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
 <20230523193212.GA32559@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
In-Reply-To: <20230523193212.GA32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DgMyOImvudi1PbtRThkgj+ZEJ5NXP9dfruqq4fQIRCTPkJO7Bpi
 EX+dY80O32/2avLx/UbeJDQEo+8zq9riUh1+EVgMYBhAWoNLZmqB5VRdSgWkRQ+qVU1vmkT
 Y8YXYh39R9E9EgKfE7LqWoWcTaWIHkkmVZtuDuESZTgCDHNxFtOoRhHRXS4cnXUY/rOhB1p
 8ajKcUZPqF7lIgmCh0fCQ==
UI-OutboundReport: notjunk:1;M01:P0:DFsZE+dmdzw=;aN94W2nKPekbw2KAOiVnxdvC/zJ
 Ehz0ZKZLBTPuuDYFellfLQjLzFmha3cgv5H7q/IDxFwgHd0dgVTkPmnctfx1K9bUfGo0z/XXs
 Y5rThG6jbZ+bawAJ+Gjc9uUE1T88Qb6zD1vXcMHm/qVTS6216C0UzSymKPma2p3DTpQnR8voC
 Y0juwTloifDOModvx1wIlgtAnb4xskXfAUCbcGXiAJA/t/6kGceXk2p2TQOsSE9b2BHRbts6R
 tEyOoiN+tZSD2mw8HAziZXO2SObgm4Za+cj0I9QJ5ki40y2BP1i7wei+RbMwFbsnNfAd8JqCT
 7nW4FzR1RSmNQxOW3sekPEu2cLg89dR8SD7F6+2xJpM68HDHbCATRLsUj7WhR17AZFczV1oyy
 Abx72D+V57zc5c5CO8bOP8rh8YlzU07qQRL8JFH/39ORnyeBshBrwbuqZQX+BgzPmA33R+VHe
 8aa55b6wLh3FMLb2/YazAubsQZm9YzO2eAalU8ELCwdIMNJ6BgXZVDzHhhIxvHAUbjXBtX5EF
 R/ImlQh4L8pt3FpNjbUoXJI9RwgOWyWYK0i+RNHej1lL7V8vNlLmVA2y7A2YJzHo/3QYkn0bb
 +HoUjmd3eGVf5Io6XHzVMt5VRSP2teZLmYZXaZROTh4DYazQ3jT2wyPH7gGLf0VTgaufC1bHO
 nXnAYz6MtSS4gOd4TWT/xcNXEly6Ql1EW/KzlK7Zj/BAhE6PD/fK2NA4adNv5GPJRSMqP1UNo
 bKbQeLD3Rf16bbUiIPgr7/2jiaizxvUwJxRMkIPkqmp+Dm5KLbR3pKXhHfaR6Oa3gS3rYmLAw
 v57clo9qiGiF+P35jmiLcuIJaKLT8R8C5wG7YGfK/fThbeiMPyWJyA+39tnAHu3ybrgp19F3h
 40d/SdB55mf9YdBGO9o5EbgUsPF19Q1Pcf99EfC5VcnD5PvalDKUZqebFcBPlJlAdIPwO+fNF
 9hmoW3DVOOGeCnZUEuMqYQlhv0g=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/24 03:32, David Sterba wrote:
> On Tue, May 23, 2023 at 03:33:22PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/5/23 15:09, pengfuyuan wrote:
>>>
>>> When compiling on a mips 64-bit machine we get these warnings:
>>>
>>>       In file included from ./arch/mips/include/asm/cacheflush.h:13,
>>> 	             from ./include/linux/cacheflush.h:5,
>>> 	             from ./include/linux/highmem.h:8,
>>> 		     from ./include/linux/bvec.h:10,
>>> 		     from ./include/linux/blk_types.h:10,
>>>                        from ./include/linux/blkdev.h:9,
>>> 	             from fs/btrfs/disk-io.c:7:
>>>       fs/btrfs/disk-io.c: In function =E2=80=98csum_tree_block=E2=80=
=99:
>>>       fs/btrfs/disk-io.c:100:34: error: array subscript 1 is above arr=
ay bounds of =E2=80=98struct page *[1]=E2=80=99 [-Werror=3Darray-bounds]
>>>         100 |   kaddr =3D page_address(buf->pages[i]);
>>>             |                        ~~~~~~~~~~^~~
>>>       ./include/linux/mm.h:2135:48: note: in definition of macro =E2=
=80=98page_address=E2=80=99
>>>        2135 | #define page_address(page) lowmem_page_address(page)
>>>             |                                                ^~~~
>>>       cc1: all warnings being treated as errors
>>>
>>> We can check if i overflows to solve the problem. However, this doesn'=
t make
>>> much sense, since i =3D=3D 1 and num_pages =3D=3D 1 doesn't execute th=
e body of the loop.
>>> In addition, i < num_pages can also ensure that buf->pages[i] will not=
 cross
>>> the boundary. Unfortunately, this doesn't help with the problem observ=
ed here:
>>> gcc still complains.
>>
>> So still false alerts, thus this bug should mostly be reported to GCC.
>>
>>>
>>> To fix this, start the loop at index 0 instead of 1. Also, a condition=
al was
>>> added to skip the case where the index is 0, so that the loop iteratio=
ns follow
>>> the desired logic, and it makes all versions of gcc happy.
>>>
>>> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
>>> ---
>>>    fs/btrfs/disk-io.c | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index fbf9006c6234..8b05d556d747 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -96,9 +96,13 @@ static void csum_tree_block(struct extent_buffer *b=
uf, u8 *result)
>>>    	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>>>    			    first_page_part - BTRFS_CSUM_SIZE);
>>>
>>> -	for (i =3D 1; i < num_pages; i++) {
>>> -		kaddr =3D page_address(buf->pages[i]);
>>> -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>>> +	for (i =3D 0; i < num_pages; i++) {
>>> +		struct page *p =3D buf->pages[i];
>>> +
>>> +		if (i !=3D 0) {
>>> +			kaddr =3D page_address(p);
>>> +			crypto_shash_update(shash, kaddr, PAGE_SIZE);
>>
>> Unfortunately this damages the readability.
>>
>> If you really want to starts from page index 0, I don't think doing thi=
s
>> is the correct way.
>>
>> Instead, you may take the chance to merge the first
>> crypto_shahs_update() call, so the overall procedure looks like this:
>>
>> static void csum_tree_block()
>> {
>> 	for (int i =3D 0; i < num_pages; i++) {
>> 		int page_off =3D whatever_to_calculate_the_offset;
>> 		int page_len =3D whatever_to_calculate_the_lengh;
>> 		char *kaddr =3D page_address(buf->pages[i]) + page_off;
>>
>> 		crypto_shash_update(shash, kaddr, page_len);
>> 	}
>> 	memset();
>> 	crypto_shash_final();
>> }
>>
>> Although even with such change, I'm still not sure if it's any better o=
r
>> worse, as most of the calculation can still be bulky.
>
> Yeah I think the calculations would have to be conditional or keeping
> some state. I'd like to keep the structure of the first page and the
> rest.

Yeah, there would be conditional checks, but it turns out to be simpler
like the following:

	int cur =3D BTRFS_CSUM_SIZE;

	for (int i =3D 0; i < num_pages; i++) {
		int range_end =3D min(eb->len, (i + 1) << PAGE_SHIFT);
		int page_len =3D range_end - cur;
		int page_off =3D offset_in_page(cur);

		cypto_shash_update();
		cur =3D range_end;
	}

The only conditional thing is the min() call, but I'm not sure if this
is any more readable though...

Thanks,
Qu


>
> Possible ways is to add extra condition
>
> 	for (i =3D 1; i < num_pages && i < INLINE_EXTENT_BUFFER_PAGES; i++)
>
> which leads to dead code if page size is 64k. It still has to check two
> conditions which is not the best, so could do
>
> 	int num_pages =3D max(num_extent_pages(eb0, INLINE_EXTENT_BUFFER_PAGES)=
;
