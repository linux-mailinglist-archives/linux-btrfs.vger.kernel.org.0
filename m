Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965584C46A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiBYNhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 08:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiBYNhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 08:37:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41579DF4F
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645796196;
        bh=uJcv0MUo/q0cYjkq2QhHUAoVtGas51qzrwunBjGcTH0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=f/SDeBJ1A54bWZSr4fkT5VdMQpskE7M+soLB5O5Wnf4P+j3BYEUU92RbL1NBrfw5l
         dYP5qs0YxAyZmPU88je2jThsGWdXIzl8qWP24CvwKQiRutCXYhJS9QM0Xa5VbX5a6c
         BcTlpe0ev0j6YmchmJXWUopEHUHGn7fEA0iuuuTQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79yQ-1oHUmF2i9k-017WeY; Fri, 25
 Feb 2022 14:36:36 +0100
Message-ID: <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
Date:   Fri, 25 Feb 2022 21:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Seed device is broken, again.
In-Reply-To: <20220225114729.GE12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGvRu7FPn4dSpOWatyH0s+USUmmAxtWLjmPE81sL8POyfDPWgtq
 13tB/XsSDP57iiI2lqSi+pXz0eANStkTm4OfQoZn9GZ74tdTlUniNwS/ZSVQ2d4+BGO6OhX
 ZVi6rkHJyBQ0SUzrPdi+duEnKQy+NjpapYk01taSxYNK80d7vLZRUmBJ3pYt5S0GZgXbInC
 GIFvJcshfntZsAbL64AkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1rrZ7FMrM9k=:IAntEacGN2/jPp+LLoC+8m
 c/WVX9AQQ9io/is3MhhyeXpDnJ2TAIGZV2V/w70ySUBfMiThQvsteX+WaX/k6UfaBBJLdQcFY
 WmzOkzq4SitvEfL8JVhSeg5achpujfrhHje3dHgtbItSVFNaEg9YaX7T18j42cTJM+xB/RO/8
 hYmq91Sj4vYCQJISCWnXlBYsfBDU13LqI1bLeLc3uzb9JQhzvgyqr5b5VySbqHT3lSc1/2XCe
 B2Rbv7H95PWMjKOSSvnJ+qH9f63OfIQmMRVJJVx8983prQOsK7PUyXgO5lVcGpDfn7CrVLveT
 pKc4DdGp1CaHGy5KhYB5Jl6bqsWUHOo/BxhZbScxdKQC3RhD7wS/vMpKbuJ4DiXRTUvdVWqtX
 9h7dC+yLjxg0GB/7hydx7GtWiFuNFpDklUOWTY9PCk7Xo8jQ9aBjuy2R9rJKp/AQmxuy6cQXP
 nKJXCYJqTWWG9krZy1sZ+QhxSv4slyPaLrIi4K+0d4TqvKuzRrRDUeUTGOPWPR2pViCnVgFz1
 GY06GvKeGvatm3b/NBx8h1aTUb5dIG7F2JOxnhMTdjpgd1L0FiXzfMt7NzWQv0pz9+6/sEb9i
 Nd7boADY0JFVUHq5ZilkBRT66F7ilXcPf4KUQJDHDZ+yddvqcBUKTvfTJuOi6hlIs85n81fYx
 MYJUiwfogEXRU+HVMZcKHXjHaiZkRZzop8jzFrAdPvr+6VGKLkpp7q2/DZzQBaxradZss2RBv
 i2E6TOCbWeEjLafWlrNSC30IGouSQJ09r83/l+K8qraL75/70wywVU3xln5cMFMIJDrF9qUSM
 ZzR1NmemmiYU0jNmO9bowUzVdM2EJ6Mp1LUKCt5sPiaMmJ5oScrNkgjhW29U+wAkPUdelCvTW
 nWu4AJtBSl1v5W3Ou3Oe5/zmf4TBQZBZl1Zzm9sa0833iG4oUh1KhV27aUcFrv31Eofi0Dw8g
 HnFY5SE9TnZa4Hrx/bzeor8TpVzGuyTOfca6XRIDPQmLsQXfZ0ANLVBJu0uWm1VPZ0GP9w+Ke
 d2UsU04UKO+wami/7HefhGCS3/HacOMjUjAm/RlXmDUmEuXCKWLExsyEeDh0e3XFGEHR2zrs1
 KOVdq8SegN+KqQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/25 19:47, David Sterba wrote:
> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>> Hi,
>>
>> The very basic seed device usage is broken again:
>>
>> 	mkfs.btrfs -f $dev1 > /dev/null
>> 	btrfstune -S 1 $dev1
>> 	mount $dev1 $mnt
>> 	btrfs dev add $dev2 $mnt
>> 	umount $mnt
>>
>>
>> I'm not sure how many guys are really using seed device.
>>
>> But I see a lot of weird operations, like calling a definite write
>> operation (device add) on a RO mounted fs.
>
> That's how the seeding device works, in what way would you want to do
> the ro->rw change?

In progs-only, so that in kernel we can make dev add ioctl as a real RW
operation, not adding an exception for dev add.

>
>> Can we make at least the seed sprouting part into btrfs-progs instead?
>
> How? What do you mean? This is an in kernel operation that is done on a
> mounted filesystem, progs can't do that.

Why not?

Progs has the same ability to read-write the fs, I see no reason why we
shouldn't do it in user space.

We're just adding a device, update related trees (which will only be
written to the new device). I see no special reason why it can't be done
in user space.

Furthermore, the ability to add device in user space can be a good
safenet for some ENOSPC space.

>
>> And can seed device even support the upcoming extent-tree-v2?
>
> I should, it operates on the device level.
>
>> Personally speaking I prefer to mark seed device deprecated completely.
>
> If we did that with every feature some developer does not like we'd have
> nothing left you know. Seeding is a documented usecase, as long as it
> works it's fine to have it available.

A documented usecase doesn't mean it can't be deprecated.

Furthermore, a documented use case doesn't validate the use case itself.

So, please tell me when did you use seed device last time?
Or anyone in the mail list, please tell me some real world usecase for
seed devices.

I did remember some planned use case like a way to use seed device as a
VM/container template, but no, it doesn't get much attention.


I'm not asking for deprecate the feature just because I don't like it.

This feature is asking for too many exceptions, from the extra
fs_devices hack (we have in fact two fs_devices, one for rw devices, one
for seed only), to the dev add ioctl.

But the little benefit is not really worthy for the cost.

Thanks,
Qu

>
>> The call trace:
>>
>>    assertion failed: sb_write_started(fs_info->sb), in
>> fs/btrfs/volumes.c:3244
>
> Yeah the asserts now appear and we need to fix the write annotations
> first. I've moved the patches out of misc-next again, it's now only in
> for-next so it does not block testing.
>
