Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792F50EC69
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 01:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiDYXJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 19:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiDYXJQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 19:09:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E6563D4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650927965;
        bh=Pd8U0BXmZZDII6xWrZ3DXDcfv15YzxX2SxKjt/eOT5U=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NC8+TYMvPwZHr+LVK0wQAYhM/WX2wBOAsD59zulrvmYI4lx5j6lu2Yw0bIIBMPEZZ
         HURSrBKJlTEfgVX+NQQyAMM5cHay7DMPyDVbbz6UYXDibHPAUIXETghw4xfVurWnCE
         GNTCK+l1imdmsa1YBLNkg4JQV6PUe/ZLlnU2/lE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1nOowT3VXO-00Xf0V; Tue, 26
 Apr 2022 01:06:04 +0200
Message-ID: <a81220ac-9585-88b0-67eb-14a5a9df2945@gmx.com>
Date:   Tue, 26 Apr 2022 07:06:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and
 sprouted filesystems
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
 <20220425170408.GR18596@twin.jikos.cz>
 <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9nhCgwuLJHGdxL9PeUyeZrKPV45EfwB+M/QrS7lBn8UVr+eqHd2
 MFeE4dAvgvPO6IOGNoIRkGXKUwG7uBqvLG08AgD8nJQAdylaZFj95/7xPRmT9vbfTsCwlJ+
 ilambW3cUUXMQcOVhYLYZaBDuaPDAioBGcNDbnXTuKA6C45RaobsD/quDsMHzKz5NpVyPHD
 sHPufsQSoTG3/LOectaEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hq1xSDUpb4o=:stoF6xOpNFQ9hdxxjeNtYW
 KOpizizKLSHG4cIQX5MuexrRLnQ1EfrNqawUf6Savf/17WZgxBcJcFSGB8T0xRPPuVVpV4Zoa
 QLhr8kQIbmvsIsC1w9bmNlEUw5wZdYpBxPezeCtl21/vb3yuRS05Bb8LJXkGm07UytYK0UQTO
 4IgBXsQFecw+2FnbGtRkdZLJyKJP+CbgR1Th9t/y2GDH4UQkLLIS5xnlh6jsIO4i7+W5XYa9g
 IVf5tBBe+r58vc9qQta4/FJ6gCHn66sxTFgZpnWJ8rRtiRXghpSwKtzJ/djowRXAGI3hguRyL
 Z3LxaWnhAwydXpI9+qDjyJ0HC23wDYCanJCOUN91cdQ5DBOc5Sc0l/F2OuueEOTdZkoAPJKQ9
 nfn+Dj61Br5DEKUe0t9qjL961ue/jo7k1UOzbvJ1J99+5xBrGRG2C9EMTVbW5/3Cd3I5di7HL
 rmVFfWcMLEDjbHI7oYfdwDEBieeskHXjyv0+ZcyECAFKG1Y24YyyDxIlrUYZery1YXDV+I3pE
 USU5DNTIHAmnxIl6uJMQXgw23VZWGu0WrrC2VbiOkTHqWNaPc2KQwd73Puny75xZgJovTYapH
 Opuk+EvF6z6P+BZ7w4D+xpX/Wo1jHDqXs7ysKTaf+BxFns1ZiI0uSqBVDgsXKkBPi8yXhqqnV
 uDcjTuPIUk4Tm0teaggE6dSB+h/9URhW1f1cJ8RfNqb3LSlUtuCPjj0UuUzxocaqUAHLXVHRx
 LFOksANX/5JCVMu6xCIyxDwXTC8ppsECNsNW+cmQOnoIN9vDjrmqm9cF31JcG18go2LhQ5rIH
 VN7yq3wKgJ3qOFjYwtopMbJx/JvDMgB8m2zj2A89xPR8+ToUAR8kFBQmdZQvoL0Se5WHliOZw
 XsDOHCBmsAERKzglMmLLYQE6cChWPcDcMYyp3mL/fd9TA0qkBZ+OcYDgNgAaAukxcOx3SfWNO
 AWK4i0B/4UF4gIPcfrd07W8yr6KUgHnsRlquKGgiwwz+9lhTUjAx1wM/BEg7lQS96ztsDQJvv
 fOrah5H+nXA96bY/NHwo+JyavDbXaqN+UhYD7NHdpYTXcayzbkjQJey25xT+4ZU0BmJZgrdm3
 q2d+5D74jXJVBE=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/26 06:44, Qu Wenruo wrote:
>
>
> On 2022/4/26 01:04, David Sterba wrote:
>> On Sun, Apr 17, 2022 at 03:30:36PM +0800, Qu Wenruo wrote:
>>> Previously we had a bug that btrfs check would report false warning fo=
r
>>> a sprouted filesystem.
>>>
>>> So this patch will add a new test case to make sure neither seed nor
>>> and sprouted filesystem will cause such false warning.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0 .../fsck-tests/057-seed-false-alerts/test.sh=C2=A0 | 51 +++++++=
++++++++++++
>>> =C2=A0 1 file changed, 51 insertions(+)
>>> =C2=A0 create mode 100755 tests/fsck-tests/057-seed-false-alerts/test.=
sh
>>>
>>> diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh
>>> b/tests/fsck-tests/057-seed-false-alerts/test.sh
>>> new file mode 100755
>>> index 000000000000..3a442c1202d0
>>> --- /dev/null
>>> +++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
>>> @@ -0,0 +1,51 @@
>>> +#!/bin/bash
>>> +#
>>> +# Make sure "btrfs check" won't report false alerts on sprouted
>>> filesystems
>>> +#
>>> +
>>> +source "$TEST_TOP/common"
>>> +
>>> +check_prereq btrfs
>>> +check_prereq mkfs.btrfs
>>> +check_prereq btrfstune
>>> +check_global_prereq losetup
>>> +
>>> +setup_loopdevs 2
>>> +prepare_loopdevs
>>> +dev1=3D${loopdevs[1]}
>>> +dev2=3D${loopdevs[2]}
>>> +TEST_DEV=3D$dev1
>>> +
>>> +setup_root_helper
>>> +
>>> +run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f $dev1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^^^^^^^^^^^^^
>>
>> It's $SUDO_HELPER, otherwise it does not work, also please quote all
>> shell variables, everywhere.

Surprise surprise, it's from my vim's context based completion.

It turns out that fsck/056 has the same problem...

Thanks,
Qu

>>
>>> +run_check $SUDO_HELPERS "$TOP/btrfstune" -S1 $dev1
>>> +run_check_mount_test_dev
>>> +run_check $SUDO_HELPERS "$TOP/btrfs" device add -f $dev2 $TEST_MNT
>>> +
>>> +# Here we can not use umount helper, as it uses the seed device to
>>> do the
>>> +# umount. We need to manually unmout using the mount point
>>> +run_check $SUDO_HELPERS umount $TEST_MNT
>>> +
>>> +seed_output=3D$(_mktemp --tmpdir btrfs-progs-seed-check-stdout.XXXXXX=
)
>>
>> This won't work as intended, there's a helper _mktemp_dir that creates =
a
>> temporary directory, otherwise --tmpdir is interpreted as the direcotry
>> name.
>
> My bad, it should be mktemp without the "_" prefix, just like what we
> did in all the run* helpers.
>
> And I'm not expected to create a directory, thus I don't need to
> _mktemp_dir.
>
> Thanks,
> Qu
