Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE583248B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 03:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhBYB6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 20:58:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:56007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235086AbhBYB6i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614218219;
        bh=8i5ZkxTzF5DAhqoLBaaKNnMx6xXuW6YMYtvXcXCcmgs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A7yqxb7epdQxUuF1HyDNmLwqlV0GYCj0BTHy4FiJcm3k3rTGRMXJ/JsT1lL97Lt34
         kecx4wNYTopwG/5lO9nsQjc+/IH30/4vTVnG2Bup7Gkexw+1E8y4XmirjxuaEGoyOH
         cp/Ebdis2qOQPfY0R6E4pP+V1bdP5LI4S37+T7xE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1lMLfg49ME-00S6PT; Thu, 25
 Feb 2021 02:56:59 +0100
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
To:     Eric Sandeen <sandeen@sandeen.net>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
Date:   Thu, 25 Feb 2021 09:56:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0HF/OqFc0vleYKIojFsRDo8+e0Be+WcwaKFveyEl3SMDFUs6bse
 kpnAsyalEokIxfKA/JXW5aZN8go/XKVf9HzPwuM8qojQ1Trf65pteCWC53qnwsM1lWqRh/n
 03bKopNpj8fmkJTQl26GSuDpsBRB3Hybk9zk2sRfgwZM0n0+q4+il4aUPOoFzIbhjNcYZIc
 TRxOEeR6N/ntRTOumHEoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xNvIRA9Y6Zw=:l9GZMedmiQof741feFd4OI
 ylOT0b+jgAY3lTzp8SHVIi2Dz7EYB7rJ3mmFu0RuYMcgL4WTB076n10eiaiUvwLK3yH9lsU3G
 gipd9BnfPbQuMEtpAvlm6yDGw+WN34cHOiFPdyXkHiJq6fT8Nwf+WRQYHpmWweECg0trrxev9
 fGPjtCIgka0z6UxcEWgxgqDskYI9ouhI2mXQNcG2LDZ0X5YUzK8Qb4ErrRsvNPRB+wjTQDwpH
 VTBLaR7SI7xhMVbnshcyiOs9myGPTaUHxA60NunxCDFZv5YxErr4iC+4ybQ3/77aIYp72WwLm
 w++uI8pjhnzNgl/RvJGbVr2tjs3W9vgbBiWKKCodTOtZoyLa8vqgyXCOdWfcm19vqAGhQ+yC0
 3avfa+StyDV5KWssWYWp3lTRKH6eFI6qebnLU033ek70pTmNlpinqOblLoUqTlU/HhwGpo0yO
 kubESbezSr20mn7hACM5pyhg46xvnTB0suyVtQ+MtrJlSWFCRIjbpyUIWWMdwECYqPaKO+GNv
 LhlyOCOnZP9hUM0mgJCbXr7QwrlZmTE5vwr+2umQuVPDld4/v5X7YAjukbE9GNCziO9wJxwxM
 MgL2wwIfJfiMJcp85wanV3AjuCN2mqCJc7pYvhDIUvJm2RZbYrJXcS07jpjC2lopHJhENOAD2
 lcLIj4Lw11xUeGhTJKLBziMj6d+sXeoSxMFXeLIRk2kS748IcToxpEg+PnVaSAicgZGB4hQJE
 EYt3r+9Vm8rpiJidzARoMZg6xpYyptoDUi4ucsIMg4iN9mEKhZICc3W+hKrZKB4OMEMG8h3jA
 TxFGKOHZPUDIY0DktnE3NmUZ4eYbFHVr3v6m/TcBuGVdqocoqQLpa58i8iURA+BBpOeRgvBGp
 gaeoy3s9uVH/XZyctTKQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/25 =E4=B8=8A=E5=8D=889:46, Eric Sandeen wrote:
> On 2/24/21 7:16 PM, Anand Jain wrote:
>> On 25/02/2021 05:39, Eric Sandeen wrote:
>>> On 2/24/21 10:12 AM, Eric Sandeen wrote:
>>>> Last week I was curious to just see how btrfs is faring with RAID5 in
>>>> xfstests, so I set it up for a quick run with devices configured as:
>>>
>>> Whoops this was supposed to cc: fstests, not fsdevel, sorry.
>>>
>>> -Eric
>>>
>>>> TEST_DEV=3D/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
>>>> SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6=
"
>>>>
>>>> and fired off ./check -g auto
>>>>
>>>> Every test after btrfs/124 fails, because that test btrfs/124 does th=
is:
>>>>
>>>> # un-scan the btrfs devices
>>>> _btrfs_forget_or_module_reload
>>>>
>>>> and nothing re-scans devices after that, so every attempt to mount TE=
ST_DEV
>>>> will fail:
>>>>
>>>>> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"
>>>>
>>>> Other btrfs tests seeme to have the same problem.
>>>>
>>>> If xfstest coverage on multi-device btrfs volumes is desired, it migh=
t be
>>>> a good idea for someone who understands the btrfs framework in xfstes=
ts
>>>> to fix this.
>>
>> Eric,
>>
>>  =C2=A0All our multi-device test-cases under tests/btrfs used the
>>  =C2=A0SCRATCH_DEV_POOL. Unless I am missing something, any idea if
>>  =C2=A0TEST_DEV can be made optional for test cases that don't need TES=
T_DEV?
>>  =C2=A0OR I don't understand how TEST_DEV is useful in some of these
>>  =C2=A0test-cases under tests/btrfs.
>
> Those are the tests specifically designed to poke at multi-dev btrfs, ri=
ght.
>
> TEST_DEV is more designed to "age" - it is used for more non-destructive=
 tests.
>
> The point is that many tests /d/o run using TEST_DEV, and if a multi-dev=
 TEST_DEV
> can't be used, you are getting no coverage from those tests on that type=
 of
> btrfs configuration. And if a multi-dev TEST_DEV breaks the test run, no=
body's
> going to test that way.

The problem is, TEST_DEV should not be included in SCRATCH_DEV_POOL.

Just try assiging TEST_DEV and SCRATCH_DEV the same, that's what exactly
you're doing.

If you want to test aging on multiple-btrfs, it's not a problem at all,
just mkfs.btrfs on the array, and put one device into TEST_DEV and call
it a day.

>
> There are ~300 tests that run on TEST_DEV, and restricting its functiona=
lity
> to a single-device btrfs filesytem misses coverage.
>
> # grep require_test tests/generic/??? | wc -l
> 299

Nope, it's the tester's response to setup TEST_DEV.

As mentioned, just setup TEST_DEV *properly*, you can test it without
any problem even for multi-device btrfs.


>
> tl;dr: a btrfs test which renders a legitimate btrfs TEST_DEV inoperable=
 is
> a flaw in that btrfs test, IMHO.

The root problem is, TEST_DEV should never be included into
SCRACTH_DEV_POOL nor SCRATCH_DEV.

And obviously, putting the same device into both TEST_DEV and
SCRATCH_DEV pool is the problem.

Thanks,
Qu

>
> -Eric
>
>> Thanks, Anand
>>
>>>>
>>>> Thanks,
>>>> -Eric
>>>>
>>
