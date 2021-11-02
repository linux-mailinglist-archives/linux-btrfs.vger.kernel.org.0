Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD06B44398A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Nov 2021 00:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhKBXX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 19:23:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:40833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhKBXX2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 19:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635895245;
        bh=4/U9OMdy8WTqovXUKcA6zxxXKSVgONehCNcsOX+bDjM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fVJDGECh6hF3frCEa6IoJSMihAcVTO0jOg5CcDOC8ah2VeaMej98bkSpLTxNn7oCZ
         857t+LT+leRXxgCyhyM1rdj37L/QsA1CqhfQmGOd1wCVC4eLLTnyQ3YvxIVl7PWpbw
         GkZFnUZcuZ8mJn9fHIZ9qnUCzUk8BIat1qkml2kQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1mdDYb1j17-014PhE; Wed, 03
 Nov 2021 00:20:45 +0100
Message-ID: <c37394bf-d6aa-bd0c-7c1d-892733d8def7@gmx.com>
Date:   Wed, 3 Nov 2021 07:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs: clear free space cache when nospace_cache mount
 option is specified
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
References: <20211102084242.30581-1-wqu@suse.com>
 <YYE4Ybw4lZH6jJqw@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YYE4Ybw4lZH6jJqw@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qu6WXWVBoy0vqAiXJEycrkUR3UtKFp2+u4Ge4LliZCuTAwBYCL6
 +7gv+HHDP5P6PA2IJVpv9kUJ8iELHWVbpeDqCO251LqnSI2RpTCCVouQS0QUCb6XxhALQzw
 80kx8iJ5qFfQ8unPCee+hEtTAmqhNdlQlvJh3JaGaKoGaDGy3FmGvn7u9lxHOH1HYQri+aU
 LmiSAd20tWR6l9eh9V7UQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:scO1IoLoexI=:+1tX1tk77XoNSSUBDhLdX6
 FWx8MXXoNGjhYY/kqrArgyhpt2sK3kiArLHlGelSRpZCQO8/N//H/nUShV4mvKe6UWReKl04G
 YkHOsmAH9KN2+x/BG2rhbGKf1Rtp6KdVZQpzt9cZ+e+EDLz85ypm+zudiooWCrytyHieyLI5w
 sXpugAhHHHwU8uwCdmsayFslwGnT7A1G6JiqXhS9mDFcF50YNCdTbXKeDgJUd62uPp63fLk9q
 z9Z9r9+6HYsjYSxDeP545qPDSqf0ewsHiIx8mg14f0HQ//G8hSGjXndkaTt4mYgKWATYAn0nk
 OImYCZT3Mu85feamUekQvLeWW02ueuQ9eORAirh3nwiZfxCJtfxifVR7USLT54z+n/fbcSUYC
 xqZJCrA+4mChUFbJsuL/TYKJJ51W6RaWFA7fHLIXgX3rJvhzHCQI4DdR7QNucc/7JqfZ72vb5
 6WvnTGtBpZnnNX2FrpLCZmtYbxLQ/Rd3ERly2LF6BYtrJB45QwGuT+Jbx5RqwQMlxC3OcQtno
 zfV/GpQ++nqbm/rgNxWep3iuxEVKC30LKFRPEPsIiEBW0ODq9rGSI9axC5GX5GCj/He7vRUhK
 COC0Z25nEqPwMvIs4A2LtTlP7I8MCSTONY3PMPtTUPUmZihms+BO2BKpzh5tVyUltj4WMtSB9
 1JxGw730r5Whx0P86Ju7SBHcIxZSUSAmVWf0BoypXwV7sTDswbNHVFcPpdjKf+2esAebDwUU4
 yL230SE1JJwTscrNOJtZVu8mjaOd6VTy78GkAC4kSh6Y/5hHqQPjm6ho+tY59WDcz9dfdTmVH
 j8wkosMGN3uUZ/+kW84sR+fRpga7hsXwyWfxtIwFpNTojVLAaZC2+iG9wCVvz0prx4KE6CS2Q
 w4mEcWpC/nw4L1dly+OVuT9WkkI7ru2uUtYuDHV/TM0G9t0cXtsfHa9QtC08IbPAjR1vf0E/9
 OxxZwzjsllOMyzXLWC1w6OwezM/IJlIgI+dCMjLTdBZbNOp0tv2FGfZQoOmigiiyBaT+yryHF
 j35mG8uWvJ0PymF8K2d2Xes056AtCgVbzrni6WXzGmp1WUeJwd8pKHKnJgWV9n7+8vCAcn6Q0
 3D9bv7efyB9Spo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/2 21:08, Josef Bacik wrote:
> On Tue, Nov 02, 2021 at 04:42:42PM +0800, Qu Wenruo wrote:
>> [BUG]
>> With latest btrfs-progs v5.15.x testing branch, fstests/btrfs/215 will
>> fail like the following:
>>
>>    MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>>    MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>>    btrfs/215 0s ... [failed, exit status 1]- output mismatch (see ~/xfs=
tests-dev/results//btrfs/215.out.bad)
>>        --- tests/btrfs/215.out	2020-11-03 15:05:07.920000001 +0800
>>        +++ ~/xfstests-dev/results//btrfs/215.out.bad	2021-11-02 16:31:1=
7.626666667 +0800
>>        @@ -1,2 +1,4 @@
>>         QA output created by 215
>>        -Silence is golden
>>        +mount: /mnt/scratch: wrong fs type, bad option, bad superblock =
on /dev/mapper/test-scratch1, missing codepage or helper program, or other=
 error.
>>        +mount -o nospace_cache /dev/mapper/test-scratch1 /mnt/scratch f=
ailed
>>        +(see ~/xfstests-dev/results//btrfs/215.full for details)
>>        ...
>>        (Run 'diff -u ~/xfstests-dev/tests/btrfs/215.out ~/xfstests-dev/=
results//btrfs/215.out.bad'  to see the entire diff)
>>    Ran: btrfs/215
>>
>> [CAUSE]
>> Currently btrfs doesn't allow mounting with nospace_cache when there is
>> already a v2 cache.
>>
>> The logic looks like this, in btrfs_parse_options():
>>
>> 		case Opt_no_space_cache:
>> 			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
>> 				btrfs_set_opt(info->mount_opt, CLEAR_CACHE);
>> 				btrfs_clear_and_info(info, FREE_SPACE_TREE,
>> 				"disabling and clearing free space tree");
>> 			}
>> 			break;
>>
>> Then at the end of the same function:
>>
>> 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
>> 	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
>> 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
>> 		btrfs_err(info, "cannot disable free space tree");
>> 		ret =3D -EINVAL;
>> 	}
>>
>> Thus causing above mount failure.
>>
>> [FIX]
>> I'm not sure why we don't allow nospace_cache with v2 cache, my
>> assumption is we don't have generation check for v2 cache, thus if we
>> make v2 space cache get out of sync with the on-disk data, it can
>> corrupt the fs.
>>
>> That needs to be properly addressed, but for now, to allow nospace_cach=
e
>> with v2 cache, we can simply force to clear v2 cache when nospace_cache
>> mount option is specified.
>>
>> Since we're here, also remove a unnecessary new line the v2 cache check
>> at the end btrfs_parse_options().
>>
>> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I'd rather we just not allow nospace_cache with the free space tree.  It=
 was an
> option meant for the original space cache, not for the free space tree. =
 I don't
> want to surprise clear the free space tree for an unrelated mount option=
.

OK, then we need to update the test cases to use v2 cache.

While I'm not sure fstests guys won't complain as they may want to run
it on much older kernels.

Thanks,
Qu

> Thanks,
>
> Josef
>
