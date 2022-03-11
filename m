Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE54D5B9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiCKG3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 01:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCKG3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 01:29:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6DB527C7
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646980121;
        bh=/aZgVhSgXWjJ1a3V776bguOZ5U0ExIamI0oP+esi8/c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ljhB2OAFDtYe4UBvyf2E+58RqG9Ddg+1qoHcV4HlSN2ZZJv8elox0uCotSRllpPTJ
         2sl4+C0uxB0tpJTOxBLgauX06QrEF53HfMz5zEz54N1qnzCIzRnTidPltcMauIH/xy
         iQ/G/LEvnhL2JiGXRcQFiG3qavgqn2mdxCd5xZsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6v3-1nuiup2y3X-00pdo1; Fri, 11
 Mar 2022 07:28:41 +0100
Message-ID: <4aa2fb3a-b200-cc6a-5aef-d263fef9f2ba@gmx.com>
Date:   Fri, 11 Mar 2022 14:28:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/3] btrfs: make nodesize >= PAGE_SIZE case to reuse
 the non-subpage routine
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220113052210.23614-1-wqu@suse.com>
 <20220113052210.23614-3-wqu@suse.com> <20220310191348.GC12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220310191348.GC12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrVvxV3do8grsFOvhrYO7szw8gT16ckrmMqWi95WTpeUrKDN9FL
 DhqBbBi7IHZiobzHJgNyL+YkccyTXu2fIqmyerEoS68QBD7QUEvcaHIIElLb/Gv+aNN9eG8
 NwNVPVSGyyAoH8SfdZa2dErcv4ieQdPf+aeroSVIoMo9kkBdUYvC107+ZzQla44QD/2FoNF
 zAtfTfXtOjXZitop30lMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SGHZ+37v0ps=:1R8/pmsR9fokWBniyIySoh
 6uC43Uy1F7wRpY2M2u7O1gYZ/MMaMG+XiAreoizd/znsJQSGPUBFy1xIJHn1r+mhyn/qeUcs0
 k4RPaHL9YVTfUtl704Xb+MJn5ypf2kSLovmiwU848UcRTJ61G2flvN/H/t76X+jG+dn7Rr5Y9
 JFukaLnKFSsh0lhIizrCBtLY/5+RP9T19DwqT+FEPxj7WCpGIJ7GCZXVrdRRgtiRE34gafDXu
 SAyNV3LKw1e7sL4BpB33mjzDEWE+GyKkHNc4IAxM9xBK5IDqOvaykGw6/m41R8OZyNSVM0iMv
 K226b+mh5WzcqDhRePhExkjCg02s+4eBddMj6GWkgT98MP+kbkugwVZz/y9Tw7nj8xLD3fnYl
 RYs/3u/UbOe5U2mpTkgRjspe53/lv+XXGHGNVzRFmtr/u8R7kPXSmi+24Z85zwAQO7UpccMPl
 C7ZeHI/rH4oPmh/Fuy7d35lZ29XfJAbXnB19RIY16p48CCB5Tyeo0jGw3NWrgPeAoolK3oa66
 K1F5zpQUjC9pFLhKNlUOhyLnlWh11Lz/btFn7DisQSf5oGqaGYYfWWlhnRsLrls7NcWKCQUXC
 9fgKZyKN5iUhtmOjAkHzrZq+fxslCEyIdOyz0cNpaNN64+4s1spl11UNHFHTN7hxc9L3x8I5H
 3GLeD4oUj5MSdgpXkx3P5rBzDh55NqqF42mr/aaHFWZRsXClDMBU1LFvMpMogYvAQcgR/p/Nm
 JERir+1YmIMj9AYwQekdRcCx0HuF7B/nQnczy5Ua5pbb69fWk7rIZWDWE7DbnKhNUBFtpE43v
 YK7z3qELqTKoWSegF0KhhyGO6NH2zJa+f+eAnv1d8dP8HdFqqFDlZypZX9C4x0tT4UQ2wK8Fw
 aXLTI3/jiuNscI9qELShEYM0WfLREeTeGrgBZ+qaX0SNovYgggcuBZpTpu8A/3xRE5qR1EfB7
 /Lu+6CI0xq6nF7YYpglDEkAf9Mk4XefY8ECgiPklkHKEHQvVEoyLj1wh7utnWeijZMothIORT
 u9u/Bm0P2qdCGZtqCTc0RB+lQB528DG+bRxigITgcIsRpXKmaHPg7b9ihELI5RiysQb+OjYrM
 QlHenRUMXsLLGo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/11 03:13, David Sterba wrote:
> On Thu, Jan 13, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -4,6 +4,7 @@
>>   #define BTRFS_SUBPAGE_H
>>
>>   #include <linux/spinlock.h>
>> +#include "btrfs_inode.h"
>>
>>   /*
>>    * Extra info for subpapge bitmap.
>> @@ -74,6 +75,30 @@ enum btrfs_subpage_type {
>>   	BTRFS_SUBPAGE_DATA,
>>   };
>>
>> +static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_inf=
o,
>> +				    struct page *page)
>
> This is static inline and increases the size of the module by 3K, it
> does not need to be inline as it's not in any perf critical code.

I thought the compiler is able to un-inline such functions if it doesn't
believe the inline is useful.

But it looks I'm wrong, as I can no longer find the kernel config.

Thanks,
Qu
>
>> +{
>> +	if (fs_info->sectorsize >=3D PAGE_SIZE)
>> +		return false;
>
> Eventually the function can be split into two, making the check above
> inline and the rest a normal function. >
>> +
>> +	/*
>> +	 * Only data pages (either through DIO or compression) can have no
>> +	 * mapping. And if page->mapping->host is data inode, it's subpage.
>> +	 * As we have ruled our sectorsize >=3D PAGE_SIZE case already.
>> +	 */
>> +	if (!page->mapping || !page->mapping->host ||
>> +	    is_data_inode(page->mapping->host))
>> +		return true;
>> +
>> +	/*
>> +	 * Now the only remaining case is metadata, which we only go subpage
>> +	 * routine if nodesize < PAGE_SIZE.
>> +	 */
>> +	if (fs_info->nodesize < PAGE_SIZE)
>> +		return true;
>> +	return false;
>> +}
>> +
>>   void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,=
 u32 sectorsize);
>>   int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>>   			 struct page *page, enum btrfs_subpage_type type);
