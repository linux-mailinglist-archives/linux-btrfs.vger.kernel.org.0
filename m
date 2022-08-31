Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5F5A882E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiHaVh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiHaVh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 17:37:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0240C7F92
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661981871;
        bh=qtDTP5UXox5ZZp20HEw36Ao4fwk+m2LZS6uyR2oLyak=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CLRO1EWlFjLBt+DL15iEWCLfepo2MFCwoLc5sUyWzMeNVREjXXiIl0cVsY1Efa1sb
         8lGjkx8l+Qpuf6mng4fqW4kK470E/VzJI3Fsj5VXmy6VTi8u+zXLB3KIUdZsda7FdI
         x34inPB3dymfck0cSSvZ8QBOf1WC7YSytdEIgLjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1oX4BB3jAB-005J1X; Wed, 31
 Aug 2022 23:37:51 +0200
Message-ID: <e43c89e6-d053-7fe6-639d-cc23b1ccc57c@gmx.com>
Date:   Thu, 1 Sep 2022 05:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@libero.it>
References: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
 <20220831145156.GI13489@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220831145156.GI13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HwPql3PVnDfQa+Y2fE/xq1CCMnymSrgOZXnjlIuVinYljL5EHf1
 PS4OEQ+j4kPuLRQh+TJi9mhNDE7/ASsjLtkcRAp9HF2+Ex0jodkmIm+Vy+xUrpBwdcBUcCC
 fSxa8gYHydwQjbz7MUoxTPZ/Xm3ZNHRKb2SNFvhMdX9gj+cwP83LY/r+fgZAJjBDE8H0be/
 ALK2SX6U02VNEEd4wIEUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlej5fxnNvw=:lkhjdN/Ntv/3y7O8YH4fUE
 ntytPnSbmsddxYsp4CnnLND+YQS2fpMqJ2gAn8+J7YmCT0y0FH4g4NqAsXYE55mVvv6DjH8ic
 Cv3IvIb4xsKYuqEKwvhbAvAaxELZfn+wrg3DgWBCrMZxNuq4rGGTTsDC7H11yaDHIy+eKaY1U
 tjKVc1aCEXZCQBr1or+AQZtADiAxftn5tK/U+m3zyXb3bIWz++NVUSjX8AhFw8y/So6ns0CBV
 kPRd2KgLqsfZxig5UJlc1iCB/0vkxshdP3l/FORiSF6xmSucT2wNa2VyguBep7VoY6iEaLBik
 oIig9GM2d1KfNeU0u+kXL1fc1wOA1CKOXCQfQTEDGFIEx60AIh6DHf8x6ITEgJBI4aX1QM1lJ
 m6X4DD4ZkUvbQBsuAc3EuCekqdZ51sw/cnLbuW2Vyf7YdgSKmK6VHUhRRk2SRSLFdY25kLrLS
 bzPkYvIGfHR+Taeo1RUnqtWvD5MrOJ/aSkH1cv3g22nNR43ygZFbN6dmJkBP+zQoUEwHfGLbZ
 dDv2EaovMKgF7phZm7oCKTs7T9TEvAuFTJ/xFWQOsS0x8jUrZXbTEKSNH2+TouSkV62ZIr1J2
 uPG64hoFiovyfAV0Cs/B2+jDfOY309aUIeucSNEvFTx4dJQajIKugi1SreqfBi34IVT9OLRj+
 167jbRSEwchPgGp+ihXq8sSmCvjBk6eFKYX/C4W6yimq8k/xxv8Uz1rmdZTMo6f/qYRGY6Gqw
 FvKhD+8tue5HAJPWidLRsLkNwvOlYlGJhkfItLYr2oeyIQv5trYkrrqZ6VHTFd/G4Dwo2tgEW
 bkoAIEyQXBxpSByZadXs+comgWKAqxBCu16VG8/uQtYGceGLZ+dVVrDDJDAYqNPWvZyEirrg1
 5mQvdykwC3zLrhmgeDGFTccvljGjxL6SUB4E8tTOAVHCQfSOj7DctHHPiZ9fztMQMcyFFVRhJ
 iK4JthNQqEtM0/ucwsMeyu2W6i94JKffvuw0VtdQrawHQnkiFmgzP+RHRoW0DRQWmxY5i8NZl
 p3FZDwx25WrTh6kXVUxs6pSI8cESfWOtOTKD866tyD4yTZ/y+aLdc/BB2kdVPm97QrxQpURsO
 3U8kuCo9cm53WzOto8NliNoPQB+m/gWKPBxPTh1tg6fWOddLqB5q3Sq7A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 22:51, David Sterba wrote:
> On Wed, Aug 24, 2022 at 08:16:22PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is an incident report that, one user hibernated the system, with
>> one btrfs on removable device still mounted.
>>
>> Then by some incident, the btrfs got mounted and modified by another
>> system/OS, then back to the hibernated system.
>>
>> After resuming from the hibernation, new write happened into the victim=
 btrfs.
>>
>> Now the fs is completely broken, since the underlying btrfs is no longe=
r
>> the same one before the hibernation, and the user lost their data due t=
o
>> various transid mismatch.
>>
>> [REPRODUCER]
>> We can emulate the situation using the following small script:
>>
>>   truncate -s 1G $dev
>>   mkfs.btrfs -f $dev
>>   mount $dev $mnt
>>   fsstress -w -d $mnt -n 500
>>   sync
>>   xfs_freeze -f $mnt
>>   cp $dev $dev.backup
>>
>>   # There is no way to mount the same cloned fs on the same system,
>>   # as the conflicting fsid will be rejected by btrfs.
>>   # Thus here we have to wipe the fs using a different btrfs.
>>   mkfs.btrfs -f $dev.backup
>>
>>   dd if=3D$dev.backup of=3D$dev bs=3D1M
>>   xfs_freeze -u $mnt
>>   fsstress -w -d $mnt -n 20
>>   umount $mnt
>>   btrfs check $dev
>>
>> The final fsck will fail due to some tree blocks has incorrect fsid.
>>
>> This is enough to emulate the problem hit by the unfortunate user.
>>
>> [ENHANCEMENT]
>> Although such case should not be that common, it can still happen from
>> time to time.
>>
>> >From the view of btrfs, we can detect any unexpected super block chang=
e,
>> and if there is any unexpected change, we just mark the fs read-only, a=
nd
>> thaw the fs.
>>
>> By this we can limit the damage to minimal, and I hope no one would los=
e
>> their data by this anymore.
>>
>> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
>> Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e=
3991e34@bluemole.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v3:
>> - Use invalidate_inode_pages2_range() to avoid tricky page alignment
>>    Previously I use truncate_inode_pages_range() with page aligned rang=
e.
>>    But this can be confusing since truncate_inode_pages_ragen() can
>>    fill unaligned range with zero. (thus I intentionally align the
>>    range).
>>
>>    Since we're only interesting dropping the page cache, use
>>    invalidate_inode_pages2_range() should be better.
>>
>> - Export btrfs_validate_super() to do full super block check at thaw
>>    time
>>    This brings all the checks, and since freeze/thaw should be a cold
>>    path, the extra check shouldn't bother us much.
>>
>> - Add an extra comment on why we don't need to hold device_list_mutex.
>
> And the superblock checksum verification? It makes sense to validate the
> individual sb items but after the checksum.

Oh, forgot that validate_super() doesn't do the csum check.

Will add csum check in next version.

Thanks,
Qu
