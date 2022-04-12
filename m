Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092204FDB76
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353116AbiDLKDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357321AbiDLHkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 03:40:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969524962
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649747705;
        bh=E8wwbUaZBz7wKsmbuE3uMVIetSlhnh1VmTZDGQCeB0I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=l2tPtZKvYtDdLptqHyhFshuDTmXdJTvAfFvkjjraRuxAFYjNCMSvEWETBey9u9Rc8
         CZF3STxL1kzqYR2kKLVz8UTsmJ3k6WF0UBjZrdovIT/IOblNw+5UirVab7cDr5F00L
         SSwMXlauVa5JzAt5D9MGkaPiYKVBlGUnnWgd0VkU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTABT-1nWmj12MD1-00Uesc; Tue, 12
 Apr 2022 09:15:05 +0200
Message-ID: <6d0d9e62-8df2-e54b-0747-998faafe95ba@gmx.com>
Date:   Tue, 12 Apr 2022 15:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 00/16] btrfs: add subpage support for RAID56
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <20220408181643.GZ15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408181643.GZ15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HltjS+5pJ9IYVunfmdCR/7yRj2gFbaV6NFzZmFE6JcUgUI8m8fK
 OR8MQXqNSCwZiJIqWIN0P86oewyDEkBcf7vQ1AlSGX9POImnq5QKIH6xMi85l6tDW9ubl9h
 d293NNNu3PPndXy5IrirxGjTPNAoNFPwtJMS8XEJYpOojWzeh2yo/wtBr0th5MER4U/Jifp
 1GsHCEeKauMqER0YqdavA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3JoANXiLEM=:hvPPxvSw5+AyCeb6NKmlM+
 x5SUVjuvRB/yjfHhSaY3XECdnJGhHtllJ0cJRxKE8wOkQ4+MnF66o0Ni/LYx5nh9I9rhdNleA
 /LuOtSQKS0fcQNfZZoqEwq3msqCUZWmRrPBtp92fQ9rm80+DiDGmlJvj++C20g+N/zep2+nm9
 an2Kf6kYZak5c1CbgZRq1/MLC7iLMH3wb5j9eIH4wlPKEJ0Om+YzXdJGFGw9/jVm/nyVMbgx3
 T/U4PgsUwChNZv9OxuYp3Rb7+vqdoo6udb/w1wzRa7/DTYs8jqll3Om72MGnfq2YaD8A4NffH
 5xoyXyj36sEQxGAgVd4mMRFJV4bQZ/Ae2kJ4Cp0EywU/FxW4PVTT+AyZRi8wUK6V97Cdzml6o
 xlbK6kRKTWqQAxfiyUi9UVk7RTwZ0seo4Xmdgp/obmfIhG7u9VLVu/TEpvKxu1MUcw4TeicTL
 cgI2uuquBL01WpM8Kwd6AORs8vjqErBOXcYeHJJ60Wql+WswgDNIzjnEg58tr73Ta6+W/RGLW
 XmgD+5GGTppLdiwW6awMZd3aDjBaZbVfjOr9O0qr05S5B/jLG2A6oWZTrRkUGZ43ShAcFZVdn
 Z5O751bFd/qcL5S6NRKdlhKBP0airSW0L3HVhpkQ+euhhKbinAFLcxhyct2hgvV10okYyHZg/
 u1wE3aPYmi7iyNeHBFJbCBIuZ5HidrIwW94Vxcpn+opCBDgEcDx4oPGeQQDO/N4bKuC00+BGp
 9s6tG9GOd0W4vhMMSdm74yEonGY8cvICAo/gmtvkYMBF4wh4Fs0q4UBFpTadCZmcYEx9g2I3h
 QW3mTxSnfZgVM5N5kUQKxXhPKJJbYIccpWt7p30bHZi+a9jIxpe2SZbAdqopr+Wmm+rDML2I8
 YGvazaEhHTqyiYhGNCyfdg5TNB75/j2aU6HOsiM1qQZjHam+pAu82URYNYvjmpDPYtMhJrcK5
 lfwk7wrWObSlEJ5iNNbGKtbqBglz6R4J2S+Qq3v+xcVaSUiOUMYzL9IDuaAhij7MGgCh0A11g
 d4iAs1/KY0HeG62z6r7m8PrmfXwYCJKsCC8iO7DCvI0giSH06OB/GR+SjeVy8939B6KFW/M2j
 LaYUGURFDhdD2s=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/9 02:16, David Sterba wrote:
> On Fri, Apr 01, 2022 at 07:23:15PM +0800, Qu Wenruo wrote:
>> The branch can be fetched from github, based on a slightly older
>> misc-next branch:
>> https://github.com/adam900710/linux/tree/subpage_raid56
>>
>> [DESIGN]
>> To make RAID56 code to support subpage, we need to make every sector of
>> a RAID56 full stripe (including P/Q) to be addressable.
>>
>> Previously we use page pointer directly for things like stripe_pages:
>>
>> Full stripe is 64K * 3, 2 data stripes, one P stripe (RAID5)
>>
>> stripe_pages:   | 0 | 1 | 2 |  .. | 46 | 47 |
>>
>> Those 48 pages all points to a page we allocated.
>>
>>
>> The new subpage support will introduce a sector layer, based on the old
>> stripe_pages[] array:
>>
>> The same 64K * 3, RAID5 layout, but 64K page size and 4K sector size:
>>
>> stripe_sectors: | 0 | 1 | .. |15 |16 |  ...  |31 |32 | ..    |47 |
>> stripe_pages:   |      Page 0    |     Page 1    |    Page 2     |
>>
>> Each stripe_ptr of stripe_sectors[] will include:
>>
>> - One page pointer
>>    Points back the page inside stripe_pages[].
>>
>> - One pgoff member
>>    To indicate the offset inside the page
>>
>> - One uptodate member
>>    To indicate if the sector is uptodate, replacing the old PageUptodat=
e
>>    flag.
>>    As introducing btrfs_subpage structure to stripe_pages[] looks a
>>    little overkilled, as we only care Uptodate flag.
>>
>> The same applies to bio_sectors[] array, which is going to completely
>> replace the old bio_pages[] array.
>>
>> [SIDE EFFECT]
>> Despite the obvious new ability for subpage to utilize btrfs RAID56
>> profiles, it will cause more memory usage for real btrfs_raid_bio
>> structure.
>>
>> We allocate extra memory based on the stripe size and number of stripes=
,
>> and update the pointer arrays to utilize the extra memory.
>>
>> To compare, we use a pretty standard setup, 3 disks raid5, 4K page size
>> on x86_64:
>>
>>   Before: 1176
>>   After:  2032 (+72.8%)
>>
>> The reason for such a big bump is:
>>
>> - Extra size for sector_ptr.
>>    Instead of just a page pointer, now it's twice the size of a pointer
>>    (a page pointer + 2 * unsigned int)
>>
>>    This means although we replace bio_pages[] with bio_sectors[], we ar=
e
>>    still enlarging the size.
>>
>> - A completely new array for stripe_sectors[]
>>    And the array itself is also twice the size of the old stripe_pages[=
].
>>
>> There is some attempt to reduce the size of btrfs_raid_bio itself, but
>> the big impact still comes from the new sector_ptr arrays.
>>
>> I have tried my best to reduce the size, by compacting the sector_ptr
>> structure.
>> Without exotic macros, I don't have any better ideas on reducing the
>> real size of btrfs_raid_bio.
>>
>> [TESTS]
>> Full fstests are run on both x86_64 and aarch64.
>> No new regressions found.
>> (In fact several regressions found during development, all fixed).
>>
>> [PATCHSET LAYOUT]
>> The patchset layout puts several things into consideration:
>>
>> - Every patch can be tested independently on x86_64
>>    No more tons of unused helpers then a big switch.
>>    Every change can be verified on x86_64.
>>
>> - More temporary sanity checks than previous code
>>    For example, when rbio_add_io_page() is converted to be subpage
>>    compatible, extra ASSERT() is added to ensure no subpage range
>>    can even be added.
>>
>>    Such temporary checks are removed in the last enablement patch.
>>    This is to make testing on x86_64 more comprehensive.
>>
>> - Mostly small change in each patch
>>    The only exception is the conversion for rbio_add_io_page().
>>    But the most change in that patch comes from variable renaming.
>>    The overall line changed in each patch should still be small enough
>>    for review.
>>
>> Qu Wenruo (16):
>>    btrfs: open-code rbio_nr_pages()
>>    btrfs: make btrfs_raid_bio more compact
>>    btrfs: introduce new cached members for btrfs_raid_bio
>>    btrfs: introduce btrfs_raid_bio::stripe_sectors
>>    btrfs: introduce btrfs_raid_bio::bio_sectors
>>    btrfs: make rbio_add_io_page() subpage compatible
>>    btrfs: make finish_parity_scrub() subpage compatible
>>    btrfs: make __raid_recover_endio_io() subpage compatibable
>>    btrfs: make finish_rmw() subpage compatible
>>    btrfs: open-code rbio_stripe_page_index()
>>    btrfs: make raid56_add_scrub_pages() subpage compatible
>>    btrfs: remove btrfs_raid_bio::bio_pages array
>>    btrfs: make set_bio_pages_uptodate() subpage compatible
>>    btrfs: make steal_rbio() subpage compatible
>>    btrfs: make alloc_rbio_essential_pages() subpage compatible
>>    btrfs: enable subpage support for RAID56
>
> This patchset is relatively independent so I picked it now, it's in a
> topic branch, rebased on misc-next ie. on top of the bio cleanups from
> Christoph. I'll move it to misc-next after some quick testing.

Thanks a lot.

Although the last time (one hour ago), I didn't see a branch with
similar name.

And I'm adding just one new patch to address the u64 division problem
(it's going to shrink the width for stripe_len, and use right shift to
replace various division).

Since I can't find the branch, all your modification may not be preserved.=
..

Thanks,
Qu
