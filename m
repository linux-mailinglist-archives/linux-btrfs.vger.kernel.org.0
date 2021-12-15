Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B241B4766CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 00:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhLOX6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 18:58:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:35973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhLOX6q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 18:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639612723;
        bh=nqiNSlnh8u2JLOxjMAm8dgK5E+w9WSTut4sS6lur1jI=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=h+5zkWBaeATqVgGZTJAGDK5aBmhgBgvlFoaHbm5C5knJh9r/y7X8I7UU/Cw1qTWAZ
         h/MHYyLI1TeBmfU8MP2zTIcx5VzILbfFxNQyQUldAz+fgLsPCDiRH6mu5gB0JbDyOq
         nDVq4B/SewYS47qEfNAN3sreARtbrX9hwcDXfKpo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1mPgrX2L13-00alaW; Thu, 16
 Dec 2021 00:58:43 +0100
Message-ID: <1010d177-a983-d95f-1927-690114805b8f@gmx.com>
Date:   Thu, 16 Dec 2021 07:58:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: unable to use all spaces
In-Reply-To: <20211215155059.GB28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nHrwyL6R+OuxQ0jIwA7TuONTy3DK+T57cPpGeLOedwZdfY1A8EF
 nvtpcxxpJAllc5iHB72UjmedMScwuKbW7+KHT3M0laJhNFiFpOibrmlzidjs/u2xnyx/NrN
 HcvtsW5yGqaskaaT7lgUu5lNGPpFgDi4ydpm7/irK/YTcyyMQb8D38f5Bylu+QEFSrpGM/r
 iroBakJy2EtgLq9vzFqEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gQZ7W+AOB4=:mlD9LTZ7T4BUcTQBhvPi69
 eCis/bpt0mxGkKWTMwWb/QyYFVU2o7OE6UJ2pumJy4yMjxgDejP2kO66+kJplIpGpKbLkAvlM
 pLxtkOv6u/EtdeC1apxb9vE8FMr2BBasOFutvQnBLP1s/CFS1lcakgKqyjSqMbzZEw6Uuju99
 FHINLMplflCxgbMBHUughkspSi0wbcpdKftcmpoiz7UEz5lcQhBzvOy3NTbs2UBFQ6smN8UKx
 jRihrv/vFAuAHquUzbqStaOEXZrwAIzgZ1vB/h5ClBTYRZ6aUK+YhVLpJ/w9yicUEMc12VTOz
 b+jRb+TVXFLqsT6Ckx8S00soc1UXhcb9bO+sHJx1g4u8thfe6zHFFn1ECZ762c0TvQBIMHfd7
 jonSObr78Htn59O+HCAgMX/54WfvPAM2BEpwvpyv1tVdi8LZGK9unXRycBnx+f1FFZ/Ibl/Ju
 Ry5cxrcQLg+NxCJN0jmfjewPyKn4OWsDh69+RcMhrBEtPdYYyzgvluGqMJ+Pf7N/u+J8fb0WJ
 5m7j5luZarR/UcfLq5e8LAYY8Zqb+wAtPFN56eAO8vQKRjxM3d632sXBPsb7CEFN9BMI1kIQN
 ibVDVRKW8c6YNfZ00vMP7VIXzKYAWFcRff0+y/22J2wCYuM7pPcVQMET5+edHGBa0swbICjPf
 0mNtqm9JYRdmK6GO5ZXJucemvylYBtHIx6fMmzAg744qHDHVdO+SrSzqmts0O+CMe/YXjW8hR
 mcKYHmsKvZVZl9qq7/7wa3T2+YzeCHukf+oggK+lDu7tWaE5GbCCvcDw87VGa6KP8brGDYIhn
 9zZSgkomEN0FR7zkx9rzOgiCiUwcC18aNetnPmjVYMY4jigx3N3qAmMeD2gzc07qzjcTQ1Bwr
 tyjMK18yhhJM4q4aDdVLnFpGEZd+AEVPCY4ANXnNCQmsJUeICNOAkGXz3A+tTtrPw82VBIFiz
 kHUG8dwaJ/J4lXMk+mVAy4vk/+hdAttJSIpSsydVR4w67e880vKwwxVe44XTAJ77k8IRt8HDM
 UJf8+wdxhyrfOHVIX+r/QGU9bddoRxT/dh8uLy4Y3/9TBYEIg9/FMbv3rKnxYrSZJTuaIhQIr
 abE0xyNz0H7oSk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/15 23:50, David Sterba wrote:
> On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
>> Hello,
>> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
>> It looks like I'm unable to fill the disk full.
>> E.g. btrfs fi usage /disk1/
>> Free (estimated): 128.95GiB (min: 128.95GiB)
>>
>> It still has 100+GB available
>> But I'm unable to put more files.
>
> We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> to see if eg. the metadata space is not exhausted or if the remaining
> 128G account for the unusable space in the zones (this is also in the
> 'fi df' output).

A little off-topic, but IMHO we should really make our 'fi usage' and
vanilla 'df' to take metadata and unallocated space into consideration.

The vanilla 'df' command reporting more space than what we can really
use is already causing new btrfs users problems.

We can keep teaching users, but there are still tools relying completely
on vanilla 'df' output to reserve their space usage.

Thus it's not really something can be purely solved by education.

My purpose is to make vanilla 'df' output to take metadata/unallocated
space into consideration.

Unfortunately I don't have solid plan yet.
But maybe we can start by returning 0 available space when no more
unallocated space.

Maybe later we can have more comprehensive available space calculation.

(Other fses like ext4/xfs already does similar behavior by
under-reporting available space)

Thanks,
Qu
>
>> Do you know if there are any mkfs/mount options that I can use to
>> reach maximum capacity? like mkfs.ext4 -m 0 -O ^has_journal -T
>> largefile4
>
> There are no such options and the space should be used at the full range
> with respect to the chunk allocations.
