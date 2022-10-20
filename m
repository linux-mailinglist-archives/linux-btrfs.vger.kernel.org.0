Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2866055E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTDUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 23:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJTDUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 23:20:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABDE14C53C;
        Wed, 19 Oct 2022 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666236033;
        bh=a5YRvr8zGdx7PyEQLj9kOmbMoBq9ComvHaoBctFIaH0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=apYgdsImzbqVPXGcJRNzWrFx0/Cau3D3ciA9l7l9wXtwHVzZDcft8lCFF4AhcYiya
         929+HLHV/CvgESsN6DrHM4e0H4yGuDLL2PZtIpZnSqKCJDov/DaxGmz8YzdFdV+TIt
         z5Eymgi5q7yrPuYn+aGFLkCvB2x9PCiOyxReTzeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIMfW-1oqndU1GSq-00EQQ6; Thu, 20
 Oct 2022 05:20:32 +0200
Message-ID: <b39e51c2-1b34-6867-dc14-e73575ca1f6e@gmx.com>
Date:   Thu, 20 Oct 2022 11:20:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20221019052955.30484-1-wqu@suse.com> <Y1AZl3o+iSqNZgMw@magnolia>
 <Y1C6U7KkBwndZiww@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y1C6U7KkBwndZiww@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8WEi8IzWcVujcpcF84Q2nvyMkLIUjpw0a7jaJZKvSC64C8vF8Sy
 Ao1HfP7+2G/Ttsue96r50PZ21HVBs+xSK/tpSRm0PxIC4Q5OJKepZFVJ2AQkXLmGdIY+dsS
 vDUPGa1x0TaM5hM61sVGkbgtyqDcLANk85jAw/BP65mrrHx8sw/A4DzYNHwSAKHjeyQF3u3
 yBnKoHocRJuI+LC9ukw8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApOJyOQIlRg=:p5ET6tkC1WADBgRwnH3CVT
 /yef4b/n3+E4qrSmrMBE0k8TdsjFclvBuaePkCrKJkB1BbCAvE4NWCrgvmRhyzLOnacbr3zju
 K+2jel2m39YVwMmMZ7xLSoUkLEpuNFkY54ijapir1EXG+Ao6DfxxPEhIMQztHeUsUwaB696q4
 bcw3ChZ3iGdTwoDiCCzOrTDMabRIqGJiyA50J0G8wLBzQHcO3vw9CCOUi1gJS8e6MwUFfT72m
 YZVehjxFM7bM9kUwk618uwZrWuFwacXuFt03iAXjaeymNaD+z3HCF4QlRqvHYBv4YcC0NJr0O
 AD/7YNd1wOhoA91yfS8t2OPb6QzrLz6v98wqr6zsBv69y30eBEdwzuHP/xqJErKJmSgN/VC3j
 zaEYgve8pAv/XQh0HJ0VlAj/Z+qAH/Y9vdrCBHJjICFvDl0XvmH770qrDIQkbzImDCIiviPgD
 rvgRzcmTq+/yr2iR3t7tCi4Ae6avX495jRZF2Y6cafNeJg7bdWrHWuNeGkqX5APhW/VrVB3BN
 xcE4NjBasWj7VAk1f/j9tr9rP0dJGENCAVAUDJcPuq/2essSp0x/oDnM1r8sDH4Kxh7NIeIHv
 AlDd4KdQjDMadLGXh6bcoFIEComZRJRGWR6l50d84FcDZYgAh5YWA+kPZ5cdGbl8xSbsW277V
 f+9eWVWKYdhvtuR87it9ScZTi76NeOK2pFFNYTfjUnCJPycRSBI6zwH4OBBj7BV1HLaJMl6dT
 xmDNbWQ1s10MgVDCUgT13Fi6ClwVKtEQWTn2aF4L9wZMvMDXv2kk3vPyDmRFpYSJl4LDaYAme
 ippX/6lotexYResR3sEunhUoNhyirqwtK9IMUzHXaelJ1qlzqKeFuM8xf42rBlGKoX+5D5FET
 Ra3HMlDiku1w5HjX1HUyrgdMi/6+pk9JpsAo4VVPJG3S6V9hkwCUSeDNK4hVOLKaXkRF7EnD4
 ACGV/xLAANfSeFCxTpwuK4qijWxdaBX1woD9ZJHsoYE3qZsa2OKXvxrDHdMjQe0/wxvlURkHB
 LK2KNeekFpO3WbKsXAm9sR7lp355aZI3eHmya8QqjhTyqOTkWGMzpu0Q934aN063zV+X+t/HB
 BxtAWnq9/cF8oSASu0/Z6kZ6i24TKxOFcjPLj2cmiGbM0bMov1w+eN6fFJUBSkzfWkPsGLH5M
 /kqJL1bSJMXMt2TQOcVlujlPDipDtldwsNYAmS86vQOwgxGh3ZGr+jSOcwrGIQk0bt12W7g0Y
 3UM0lZoLq1P+so6uQAAdzruwsh/hoDQKKVO7CZoWx+ukFG9Nkt2I7cm7Uj40TueVcHZsAI2dh
 +RwIxfYHRKQKMyS6gER7EISqBApTncET0zohwjw1bYdA2Kb7AYqJz/Ze7Wo7AGlRbxIN6fHlU
 7O8b2zdV7ADhmH+ZgTwF4/zVMuPx24v3pzK/Y9osPTKFG/9hHkxwwpxqxPKGPXuWWdBmO0hN/
 y5PX8rRSq3PjInNpCxU9WilQx7g02QNacwx91j1+wSa35QpdOQ8jSDyscMCZ9EMNkuZIAh9im
 zfjogVlgP0eVuUbmNm4mAo2eGcIKKVMqPbKmfI/n4EpK7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/20 11:02, Theodore Ts'o wrote:
> On Wed, Oct 19, 2022 at 08:36:55AM -0700, Darrick J. Wong wrote:
>> On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
>>> [BACKGROUND]
>>> There is bug report from btrfs mailing list that, hiberation can allow
>>> one to modify the frozen filesystem unexpectedly (using another OS).
>>> (https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991=
e34@bluemole.com/)
>>>
>>> Later btrfs adds the check to make sure the fs is not changed
>>> unexpectedly, to prevent corruption from happening.
>>>
>>> [TESTCASE]
>>> Here the new test case will create a basic filesystem, fill it with
>>> something by using fsstress, then sync the fs, and finally freeze the =
fs.
>>>
>>> Then corrupt the whole fs by overwriting the block device with 0xcd
>>> (default seed from xfs_io pwrite command).
>
> It seems to me that the test case is testing something very different
> from the originally stated concern, and what btrfs is testing.
>
> The original concern is "something else modified the file system",
> which btrfs is testing by checking whether the file system generation
> number is different from the last recorded transaction id.
>
> The test is "something has trashed the file system by filling the
> block device by 0xcd; let's see how quickly the file system notices"
> which is quite different from the scenario described in the link and
> the commit description a05d3c915314 ("btrfs: check superblock to
> ensure the fs was not modified at thaw time").

Yes, you're right.

The problem here is I have no good way to just mount the frozen fs and
update it.

One of the btrfs specific problem is, btrfs will reject fs with the same
fsid.
Thus even if we do a binary copy of the original fs, we can not mount it
to modify, at least not for btrfs.

Any good ideas for this? Maybe relying on btrfs-progs to do the write?

>
>> What /does/ btrfs check, specifically?  Reading this makes me wonder if
>> xfs shouldn't re-read its primary super on thaw to check that nobody ra=
n
>> us over with a backhoe, though that wouldn't help us in the hibernation
>> case.  (Or does it?  Is userspace/systemd finally smart enough to freez=
e
>> filesystems?)
>
>  From looking at the commit described below, it appears to do some
> basic superblock sanity checks, and then it checks to see if the last
> commited transaction has changed from what has been recorded in the
> superblock.
>
> The simple stupid thing I could add in ext4 is to simply make a full
> copy of the ext4 superblock, and if *anything* in that 1k set of bytes
> has changed between the freeze and the thaw, call ext4_error(), and mark
> the file system corrupted.

Yes, for EXT4/XFS it can be a simple memcmp(), but for btrfs we have
multiple devices, and super block for each device has something
different (related to that device).

Thus at least for btrfs, we can not do a full memcmp() level check, but
you get the idea correctly.

>
> We've been talking about changing the default for ext4 to remount the
> file system read-only, and if we did this then the behavior would be
> the same as btrfs.  Or maybe in the specific case of the superblock
> has changed between freeze and thaw, we will always remount the file
> system read-only.
>
>>> For XFS, it will detect the corruption at touch time, return -EUCLEAN.
>>> (Without the cache drop, XFS seems to be very happy using the cache in=
fo
>>> to do the work without any error though.)
>>
>> Yep.
>
> I would suggest not putting this test in generic/NNN, but put it in
> shared, and to let each file system opt-in to this test.  There are a
> whole bunch of file systems such such as jfs, reiserfs, vfat, exfat,
> etc., which could run this test, and depending on the specifics of how
> a file system might behave to determine whether the test "passes" or
> "fails" seems wrong.
>
> After all, what you're really doing is protecting against a specific
> form of "stupid user trick", and other Linux file systems happen to do
> something different when you completely trash the file system by
> overwriting the block device with 0xcd, callign what some other file
> system, whether it be f2fs, exfat, overlayfs, nfs, as a "failure"
> doesn't seem right.
>
> Moving it into shared also means you don't have to add extra checks to
> make sure the test gets skipped if there is no block device to trash
> (for example, if you are testing overlayfs, nfs, tmpfs, etc.)

Thanks for the advice, would move it to shared in next update.

Thanks,
Qu

>
> Cheers,
>
> 					- Ted
