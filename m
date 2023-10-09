Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E367BD1F7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjJIC37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 22:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJIC36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 22:29:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38BA4
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 19:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696818592; x=1697423392; i=quwenruo.btrfs@gmx.com;
 bh=oSwIZCK3HOh/20YbmTNVPNh0H0yr7BW8z8ybLElztjE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=LqlK1Pr7dVJkWZIGnBhjJjvsHvvuWZYfb8sfpXrSdTCjs6jkbn6hQpmmqmVxh9ynbL3CJ3Fv+II
 Qdh80q/6bHrfeHcvAGctyDfdvOLdW8WawV+rMOir11uU275hyumyAO0C6zuKtXdJrampzbRrtr5kB
 v0BdWSGmInJZ3+DtLmn7R170PfexoKFD/S8qvdf81lLb9CDVXtcS8pZ3ygA+HtRvq1NoAzHkNLY9j
 DGGW0of7b6g/fPWzdMNFUdj1xbpzpMY3TImEmaIfw4jiY9g9Xg8mB4BAeDY/hmvwj7jhO4sMdI4Hz
 HFE1TeT/rmCa2Oi1BWUT/+yZRdmvk3r5WeAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b6l-1qx7be3Qib-0084FY; Mon, 09
 Oct 2023 04:29:52 +0200
Message-ID: <1132c019-99c5-4fac-ae34-8059eeb86b9d@gmx.com>
Date:   Mon, 9 Oct 2023 12:59:47 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix stripe length calculation for non-zoned data
 chunk allocation
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20231007051421.19657-1-ce3g8jdj@umail.furryterror.org>
 <20231007051421.19657-2-ce3g8jdj@umail.furryterror.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231007051421.19657-2-ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZAJcbb1RUce0KEDLwBIVTrxFKfxwxD2tZ/97yk+UKIlWO/UJ9h2
 VaJI95uKfUTFFzH516faJ45e4t/HUCRoAmrKabutvNzpL1JzzYRXlnxr58eERwPtvJizmvt
 yyxxL7odOt2aT5S97waeU3xs2B6BQfUq9up7SrOL6Rc4wc+XiBuYSrG6RsY/7EVUJHxvFxG
 PN3UNR0sSSevGna8KSsug==
UI-OutboundReport: notjunk:1;M01:P0:VRKVIsELFtE=;mx8l3CHJeVBVFmcw+y+g5oK3c6N
 UolqVl2kXmM0YuA/wGXE461lIxaLyo0uqMwaRxrGMzVhwcPogJCVZVwKrX50PZlm8DtI8Rxax
 WVYovFM8Pq/3GLiE4EL6LgvhXueq/N4K/aSSetgL9qv/rav2NdZDJLz2aXbWRgStNtkG1fGM5
 6a25jXHx1ZsiSGx9byvNIUKhuWqvf+Ae9m04FEymHV+epU4KeBk/FIlDImfgQnGfcpwdRpSF2
 cxqAaQInF7+OmqV5SYO5a3VUHGICBcTS9yvx+f0eQ2EEQ63V/iLWWSsfYz/nlJvFQAwoRiMiG
 clJkZSRIKMsON+OFhQXuMYiN9xLZo7h1VCVHUHfcg3WfpWg//ZLvDUTPTQEx6bwMBb37emydF
 5rGgs73Ryo1XZtzS3hCHH1HOGXiv3iwn6sLGmtnSR2ifhwkeVEbaSQld/FO56ocfPJPHFJ+ms
 hU4CHRE7rhoEapYPIAQ6yG+vILLM6X0prQmw9NM9QhlypS1EnxCgF0mkHA51QhQO5nilu8O4Q
 yS4pIgK4nGwZUF4Uk1EMoJ7LJiyYzbZaXlrYmu33mLBi4kfcuRT+Zt3CgX6qJ+fTXKTKSDbUr
 2c2hae3I9Ks/Me0J91qHBAoG8bZ/scW0Eozo16qZldMv4COXYfuKelf0oDUS/FPJDA8NAI6xs
 46PPwMoqtk0ww7FkVUPGLH2lGTlkjUN5o+bgzv7YjnlQWGVNFtUPvEijZxwZJn8/4oTe+Culc
 1CThyXusuanpz6Mx588DdtA7dpANXqr+JMffrc84mJBAXnZFd28E55mQezkbcoqlLpfq+PnsA
 EAamk5A0a+yq9aPnSrHL4LMcTOLvv/KhKqI3Klg5qIl8MNxQA/hWYnKApt13QcOPYbeKZH+0b
 DzKPEUNU9nSl5MWJu8vVd0BLhvtZdVCjoieADduE7SniTdUYeSG0lXHE78hGOv5pd9WeLiSt/
 8KTb2Mcct1D6DauCV4zJCvE18Ow=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/7 15:44, Zygo Blaxell wrote:
> Commit f6fca3917b4d "btrfs: store chunk size in space-info struct"
> broke data chunk allocations on non-zoned multi-device filesystems when
> using default chunk_size.  Commit 5da431b71d4b "btrfs: fix the max chunk
> size and stripe length calculation" partially fixed that, and this patch
> completes the fix for that case.
>
> After commit f6fca3917b4d and 5da431b71d4b, the sequence of events for
> a data chunk allocation on a non-zoned filesystem is:
>
>          1.  btrfs_create_chunk calls init_alloc_chunk_ctl, which copies
>          space_info->chunk_size (default 10 GiB) to ctl->max_stripe_len
>          unmodified.  Before f6fca3917b4d, ctl->max_stripe_len value was
>          1 GiB for non-zoned data chunks and not configurable.
>
>          2.  btrfs_create_chunk calls gather_device_info which consumes
>          and produces more fields of chunk_ctl.
>
>          3.  gather_device_info multiplies ctl->max_stripe_len by
>          ctl->dev_stripes (which is 1 in all cases except dup)
>          and calls find_free_dev_extent with that number as num_bytes.
>
>          4.  find_free_dev_extent locates the first dev_extent hole on
>          a device which is at least as large as num_bytes.  With default
>          max_chunk_size from f6fca3917b4d, it finds the first hole which=
 is
>          longer than 10 GiB, or the largest hole if that hole is shorter
>          than 10 GiB.  This is different from the pre-f6fca3917b4d
>          behavior, where num_bytes is 1 GiB, and find_free_dev_extent
>          may choose a different hole.
>
>          5.  gather_device_info repeats step 4 with all devices to find
>          the first or largest dev_extent hole that can be allocated on
>          each device.
>
>          6.  gather_device_info sorts the device list by the hole size
>          on each device, using total unallocated space on each device to
>          break ties, then returns to btrfs_create_chunk with the list.
>
>          7.  btrfs_create_chunk calls decide_stripe_size_regular.
>
>          8.  decide_stripe_size_regular finds the largest stripe_len tha=
t
>          fits across the first nr_devs device dev_extent holes that were
>          found by gather_device_info (and satisfies other constraints
>          on stripe_len that are not relevant here).
>
>          9.  decide_stripe_size_regular caps the length of the stripe it
>          computed at 1 GiB.  This cap appeared in 5da431b71d4b to correc=
t
>          one of the other regressions introduced in f6fca3917b4d.
>
>          10.  btrfs_create_chunk creates a new chunk with the above
>          computed size and number of devices.
>
> At step 4, gather_device_info() has found a location where stripe up to
> 10 GiB in length could be allocated on several devices, and selected
> which devices should have a dev_extent allocated on them, but at step
> 9, only 1 GiB of the space that was found on each device can be used.
> This mismatch causes new suboptimal chunk allocation cases that did not
> occur in pre-f6fca3917b4d kernels.
>
> Consider a filesystem using raid1 profile with 3 devices.  After some
> balances, device 1 has 10x 1 GiB unallocated space, while devices 2
> and 3 have 1x 10 GiB unallocated space, i.e. the same total amount of
> space, but distributed across different numbers of dev_extent holes.
> For visualization, let's ignore all the chunks that were allocated befor=
e
> this point, and focus on the remaining holes:
>
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10x 1 GiB u=
nallocated)
>          Device 2:  [__________] (10 GiB contig unallocated)
>          Device 3:  [__________] (10 GiB contig unallocated)
>
> Before f6fca3917b4d, the allocator would fill these optimally by
> allocating chunks with dev_extents on devices 1 and 2 ([12]), 1 and 3
> ([13]), or 2 and 3 ([23]):
>
>          [after 0 chunk allocations]
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>          Device 2:  [__________] (10 GiB)
>          Device 3:  [__________] (10 GiB)
>
>          [after 1 chunk allocation]
>          Device 1:  [12] [_] [_] [_] [_] [_] [_] [_] [_] [_]
>          Device 2:  [12] [_________] (9 GiB)
>          Device 3:  [__________] (10 GiB)
>
>          [after 2 chunk allocations]
>          Device 1:  [12] [13] [_] [_] [_] [_] [_] [_] [_] [_] (8 GiB)
>          Device 2:  [12] [_________] (9 GiB)
>          Device 3:  [13] [_________] (9 GiB)
>
>          [after 3 chunk allocations]
>          Device 1:  [12] [13] [12] [_] [_] [_] [_] [_] [_] [_] (7 GiB)
>          Device 2:  [12] [12] [________] (8 GiB)
>          Device 3:  [13] [_________] (9 GiB)
>
>          [...]
>
>          [after 12 chunk allocations]
>          Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [_] [_] (2 G=
iB)
>          Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [__] (2 GiB)
>          Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [__] (2 GiB)
>
>          [after 13 chunk allocations]
>          Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [_] (1 =
GiB)
>          Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [_] (1 =
GiB)
>          Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [__] (2 GiB)
>
>          [after 14 chunk allocations]
>          Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [13] (f=
ull)
>          Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [_] (1 =
GiB)
>          Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [13] [_] (1 =
GiB)
>
>          [after 15 chunk allocations]
>          Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [13] (f=
ull)
>          Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [23] (f=
ull)
>          Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [13] [23] (f=
ull)
>
> This allocates all of the space with no waste.  The sorting function use=
d
> by gather_device_info considers free space holes above 1 GiB in length
> to be equal to 1 GiB, so once find_free_dev_extent locates a sufficientl=
y
> long hole on each device, all the holes appear equal in the sort, and th=
e
> comparison falls back to sorting devices by total free space.  This keep=
s
> usable space on each device equal so they can all be filled completely.
>
> After f6fca3917b4d, the allocator prefers the devices with larger holes
> over the devices with more free space, so it makes bad allocation choice=
s:
>
>          [after 1 chunk allocation]
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>          Device 2:  [23] [_________] (9 GiB)
>          Device 3:  [23] [_________] (9 GiB)
>
>          [after 2 chunk allocations]
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>          Device 2:  [23] [23] [________] (8 GiB)
>          Device 3:  [23] [23] [________] (8 GiB)
>
>          [after 3 chunk allocations]
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>          Device 2:  [23] [23] [23] [_______] (7 GiB)
>          Device 3:  [23] [23] [23] [_______] (7 GiB)
>
>          [...]
>
>          [after 9 chunk allocations]
>          Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>          Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 =
GiB)
>          Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 =
GiB)
>
>          [after 10 chunk allocations]
>          Device 1:  [12] [_] [_] [_] [_] [_] [_] [_] [_] [_] (9 GiB)
>          Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [12] (full)
>          Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 GiB)
>
>          [after 11 chunk allocations]
>          Device 1:  [12] [13] [_] [_] [_] [_] [_] [_] [_] [_] (8 GiB)
>          Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [12] (full)
>          Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [13] (full)
>
> No further allocations are possible, with 8 GiB wasted (4 GiB of data
> space).  The sort in gather_device_info now considers free space in
> holes longer than 1 GiB to be distinct, so it will prefer devices 2 and
> 3 over device 1 until all but 1 GiB is allocated on devices 2 and 3.
> At that point, with only 1 GiB unallocated on every device, the largest
> hole length on each device is equal at 1 GiB, so the sort finally moves
> to ordering the devices with the most free space, but by this time it
> is too late to make use of the free space on device 1.
>
> Note that it's possible to contrive a case where the pre-f6fca3917b4d
> allocator fails the same way, but these cases generally have extensive
> dev_extent fragmentation as a precondition (e.g. many holes of 768M
> in length on one device, and few holes 1 GiB in length on the others).
> With the regression in f6fca3917b4d, bad chunk allocation can occur even
> under optimal conditions, when all dev_extent holes are exact multiples
> of stripe_len in length, as in the example above.
>
> Also note that post-f6fca3917b4d kernels do treat dev_extent holes
> larger than 10 GiB as equal, so the bad behavior won't show up on a
> freshly formatted filesystem; however, as the filesystem ages and fills
> up, and holes ranging from 1 GiB to 10 GiB in size appear, the problem
> can show up as a failure to balance after adding or removing devices,
> or an unexpected shortfall in available space due to unequal allocation.
>
> To fix the regression and make data chunk allocation work
> again, set ctl->max_stripe_len back to the original SZ_1G, or
> space_info->chunk_size if that's smaller (the latter can happen if the
> user set space_info->chunk_size to less than 1 GiB via sysfs, or it's
> a 32 MiB system chunk with a hardcoded chunk_size and stripe_len).
>
> While researching the background of the earler commits, I found that an
> identical fix was already proposed at:
>
>          https://lore.kernel.org/linux-btrfs/de83ac46-a4a3-88d3-85ce-255=
b7abc5249@gmx.com/
>
> The previous review missed one detail:  ctl->max_stripe_len is used
> before decide_stripe_size_regular() is called, when it is too late for
> the changes in that function to have any effect.  ctl->max_stripe_len is
> not used directly by decide_stripe_size_regular(), but the parameter
> does heavily influence the per-device free space data presented to
> the function.

Right, I missed the usage of ctl->max_stripe_len inside
gather_device_info(), thus we should trim it early.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the fix, it indeed explains the recent very unbalanced chunk
allocation.

>
> Fixes: f6fca3917b4d "btrfs: store chunk size in space-info struct"

Just needs some brackets for the commit name, like:

Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")

Thanks,
Qu

> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 669c6ed04b86..0f5a8d2d6712 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5161,7 +5161,7 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	ASSERT(space_info);
>
>   	ctl->max_chunk_size =3D READ_ONCE(space_info->chunk_size);
> -	ctl->max_stripe_size =3D ctl->max_chunk_size;
> +	ctl->max_stripe_size =3D min_t(u64, ctl->max_chunk_size, SZ_1G);
>
>   	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
>   		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK=
);
