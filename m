Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9844F9FCB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Apr 2022 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiDHW6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 18:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiDHW6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 18:58:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46352245B3
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649458553;
        bh=cvy99EFYVY6ROTskzUDMmetZ8uOcKEURDXh5BBGuWwE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HPflShXIvD8gSBnL7UBQOzVp79+5J3JPWzFq+URVrEgAMYOKS7dp8LQq3Kyrk1Kid
         46Rsgrg/rlT6oUbSXcRapWGtvtCifkOFPcHRdtby6m/wXKuG5E3530G7zx1hwjg5YB
         eXy2+mHRpbHcRAgdbGZwPv0L5DAOhIuUmvvzMQFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKHm-1ntMKz0Hdc-00yj0g; Sat, 09
 Apr 2022 00:55:53 +0200
Message-ID: <984fd3c3-6898-0c35-9871-fdffee3aa552@gmx.com>
Date:   Sat, 9 Apr 2022 06:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/16] btrfs: introduce btrfs_raid_bio::stripe_sectors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <3a178d6547fc13b561535194f9dff41f9b4fa4d4.1648807440.git.wqu@suse.com>
 <20220408164049.GU15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408164049.GU15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Gm7NQ6WXfNl+KVWkOXNFp22AdSs9kjSd451qh33ACEwajHvw4n
 NYto3y8mgBtOgHJ7LN0lll8JOrZZoA8sxVAiYhOFAxu/LEs+ZsV/l4AIlUNc5EEsmIOxRYo
 FAAMrlH2VKY5lyyE3PKP2DeGvIh6mb9d3MbWj+NzDCmAEe3ySivBz0wLqfkFC+5Wsa8wNME
 nSajeO7ok5C/n1yUq3LXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dbyeM5+mYvU=:r8X3EBEjKcl3VxvrRYIOmL
 qTjwv0koaZRIngfZJTIGysK9Rr1weunHf5oKgnvKLGOh4V+ny3z2JBalUUTbHgRGtC+jOQwEJ
 b7B8DGzTNc2TUsRNBcoezHGO9x7A1XWDxsnbcVWnfPj3uXqgIoVQ7SxP/K8I4BAvffhWCk9Dm
 asPsBpuswdb1GLBnFtjLQj40DaB3GCcyPRykmfvoHCNacAQzpXD1a4rhBnxQwonXNoIbFZ9+W
 pKemghatafB6SBt+/Ggy7KlfSvlmDtS0mp2/nSMr8cHPeoVEngGCJiWn1UCJ+71d9z3wJpFkQ
 8ZSTVHtFRFHzhQfw2yzAi7PMWZ39bbwJ6xq1NsRq5UTWJpeHaLDOac1X0Mo5I0Ef01RFZVhIQ
 G0BTRdKVUah/F7lt9UMFcDvriNu12asTkq6NHO9K39aEKBnUMxF1wiweqcBBHuB560vJ8UKT0
 fgbT68w3uvcZEdlNQKx86kkUFLmA5Ki1/jH/gcVS+y3tDT8/9HCeWsZ1YXL3jiNUVG6j2PCqD
 w/JbxXIAerjZFbiveLN1aLOF1YUU7ql1wcSqYF2WTlhTlDVEy6fyPjyqX1OiUJlHz29G2jmv1
 SyeoqusQ/jlSw+5umsxhTfEb4/GANbWAalp3BHpJjqsKcLmkN4CKZol37FU44+KjmZXUPZvog
 P6c0y+KpfgRH94OMdj2htrS7EPXVkppgGb0j+lloyKnqqxpW2uoRebbE21fV2XDxq8pF6ej+n
 i5sdRlUyuw/oMP81p2wGDKonEd2/1rYJXw3xeuV2IGGtCbupM6eiqwqGUOZaMdPtUc1zGbOPx
 Z649ARwx+BAmmdyxuBTRWyp7PXBpyXKsgjqbrQdgmSjaPUchHRFrmc0Bsf5G+PMDNogx25gwH
 1FM907Rg3Ia4CIZah5/brlPqN7NLn44XlAJDeNCYc9CcMT+P/GvOOyi99XXFFgQN8owHfROXY
 KPpdxkO5XgYWVURUkVk4cMYT/04nfT1Ujnc8Cb2e/SwKr1+Fu2ajDeCj8aAiBBHi0EZqgZWrX
 9AKznimcp15Ui/E/3Zv0iqLJhZW7q5VHU+utbyjtp+7ZbGsHJZ1mFFhW41/9s7NRqxqxL0FCJ
 cBQGIiEc/XpIz0=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/9 00:40, David Sterba wrote:
> On Fri, Apr 01, 2022 at 07:23:19PM +0800, Qu Wenruo wrote:
>> The new member is an array of sector_ptr pointers, they will represent
>> all sectors inside a full stripe (including P/Q).
>>
>> They co-operate with btrfs_raid_bio::stripe_pages:
>>
>> stripe_pages:   | Page 0, range [0, 64K)   | Page 1 ...
>> stripe_sectors: |  |  | ...             |  |
>>                    |  |                    \- sector 15, page 0, pgoff=
=3D60K
>>                    |  \- sector 1, page 0, pgoff=3D4K
>>                    \---- sector 0, page 0, pfoff=3D0
>>
>> With such structure, we can represent subpage sectors without using
>> extra pages.
>>
>> Here we introduce a new helper, index_stripe_sectors(), to update
>> stripe_sectors[] to point to correct page and pgoff.
>>
>> So every time rbio::stripe_pages[] pointer gets updated, the new helper
>> should be called.
>>
>> The following functions have to call the new helper:
>>
>> - steal_rbio()
>> - alloc_rbio_pages()
>> - alloc_rbio_parity_pages()
>> - alloc_rbio_essential_pages()
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/raid56.c | 62 +++++++++++++++++++++++++++++++++++++++++-----=
-
>>   1 file changed, 54 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 1bad7d3a0331..8cfe00db79c9 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -52,6 +52,16 @@ struct btrfs_stripe_hash_table {
>>   	struct btrfs_stripe_hash table[];
>>   };
>>
>> +/*
>> + * A bvec like structure to present a sector inside a page.
>> + *
>> + * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
>> + */
>> +struct sector_ptr {
>> +	struct page *page;
>> +	unsigned int pgoff;
>> +} __attribute__ ((__packed__));
>
> Packed does not make much sense here, it's an in-memory structure and
> there are no savings, besides that packed structures may force unaligned
> access.

Not exactly.

The packed is for the later 1 bit flag, without packed it will take
another hundred of bytes for the very basic 3 disks RAID5.

Thanks,
Qu
>
>> +
>>   enum btrfs_rbio_ops {
>>   	BTRFS_RBIO_WRITE,
>>   	BTRFS_RBIO_READ_REBUILD,
>> @@ -154,25 +164,27 @@ struct btrfs_raid_bio {
>>
>>   	atomic_t error;
>>   	/*
>> -	 * these are two arrays of pointers.  We allocate the
>> +	 * These are two arrays of pointers.  We allocate the
>
> Please don't fix comments that you don't move or change, this is
> unrelated change.
>
>>   	 * rbio big enough to hold them both and setup their
>>   	 * locations when the rbio is allocated
>>   	 */
>>
>> -	/* pointers to pages that we allocated for
>> +	/*
>> +	 * Pointers to pages that we allocated for
>
> Same
>
>>   	 * reading/writing stripes directly from the disk (including P/Q)
>>   	 */
>>   	struct page **stripe_pages;
>>
>> -	/*
>> -	 * pointers to the pages in the bio_list.  Stored
>> -	 * here for faster lookup
>> -	 */
>> +	/* Pointers to the pages in the bio_list, for faster lookup */
>>   	struct page **bio_pages;
>>
>>   	/*
>> -	 * bitmap to record which horizontal stripe has data
>> +	 * For subpage support, we need to map each sector to above
>> +	 * stripe_pages.
>>   	 */
>> +	struct sector_ptr *stripe_sectors;
>> +
>> +	/* Bitmap to record which horizontal stripe has data */
>
> So this one got moved and it's fine to update.
>
>>   	unsigned long *dbitmap;
>>
>>   	/* allocated with real_stripes-many pointers for finish_*() calls */
