Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD14AB3DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiBGFuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBGFX1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 00:23:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A361EC043181
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 21:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644211399;
        bh=2kUCvwE5+OOuxwnK+Sq8u1Sxdoc8OnB8xva56oHEw9U=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=R7rQ/TzSYhURtH+sMc0QbG9XwO+Hj+mQgpEODzAHDxylEvwO7OsJnkYV9gnb6GniZ
         kHSwWeRRmBs4mwp6xiwqJvifdUKzEp9Z0Ob7jln+uvfYH+uPDKozs5Tb2pd0CI+aNo
         PfAfxow6DXajpLyK72jPgUsuS+h0m3f8OHR3ev+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvL5-1nikM60OCT-00Rr3N; Mon, 07
 Feb 2022 06:23:19 +0100
Message-ID: <28799781-fc73-7e18-843e-56a35d74209f@gmx.com>
Date:   Mon, 7 Feb 2022 13:23:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Rylee Randall <ibrokemypie@outlook.com>,
        Benjamin Xiao <ben.r.xiao@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
 <edb0fb57-7505-e552-cffc-b03a825c77e7@gmx.com>
 <SL2P216MB1111994F81CE0006D495511DAC2C9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <SL2P216MB1111994F81CE0006D495511DAC2C9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cwNg6ULAJa4/L4F1OgGZ3nvS5vzd99avb3edCI3e10SBtwvUHFL
 GxjEucgFVgtFYlA/J1Cjs5XV2yXYz8+PvFtzB9aeq3pFGrtRElYwxDRB3DO2BJiZ3drhxdG
 3bhjryXJ9OO2ywHcGvT3Q67yBwg1BlDmtNih/Zwho/kBDGBQNi7UMP5NMjKupfFwbH22RwK
 S9jl0mzZj7kdgMRzbvRXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HlrNVrRKTcY=:mT/mlrNEWfwOxSNWPSSAWH
 LmF4c5Rq/JJutVkErlQJuoflFIhqwkzuAhmqObHXBUhKfFcD8Lu4Fr7KX6SydVaWH98IsHp1p
 G8l8Zz0KtoekunTXEXj2dE4UK7ZiB7NWqivLiEyfUEeBpeZyFItBdNrOoRhgn/GXveZdA12WJ
 aqt3zD6VBOdwcvsTpR45Qhluj4bD5krKTqA6DKkUIIfpdpTg/weNxfW3pYNEuZYl8CRXAiOnx
 1yj6aQsI1xbLZGVTkPlHm3XmsGs2CqnvTeIEpeekdKa8smxLMoyJnf6ZtMV4ln6xZ5E+8I/yW
 JodsTiHntOLi6LKAFPJpNMsCD4kz/86vXVNAyPKy37uKzWuH9NRQfPmRIIS6CnHPCfghEtWrX
 eI5qllm3RS0NZjxxlWj9B2X4PcaEyb5zYKlGaF2F9NCS0j7dxgmSn3IFuBaTZcwXs3JMJVOwj
 IouHbrHk3VKX/+TBbfcrPulKmCfm22dn7oAGNff8W07wVEO9bdPH+EQXDmGUjjnRvp710DZbd
 LWdbU3Cta2y55jgzP0Mo3VjgZ21TaL1SqwlLoKARnFKYd/+z3pttQ+E86yd48v/xccoOzea2Y
 LrixC1IQXw9rVUhgqiGL/Y6wTIIFi7B7JFevnr2MS0CPngUCN+8KC5S/un9JKd3vBu8bRjHph
 h8ZiANmr103M1B0Hk31poIgCmQfqtVMXgmcO3lMFXQlcHa5q2DiYiW0eCWxEuEBezzMChDbku
 Uzm4tJY2dqu8lRck2pw0n0sKdTZsO1RvuDgcztXfywvNx+pif400enWr6VsWyC3fjdWv7+bfF
 7HinCZKDhDwEs/WocdYRvnO7IOle/5+DfvBdfCtjr+bhmAVsD9rcvk+RqhdbCJOx+tNktxu4S
 130n4qp2FcH1OboMwDKpTJ+VR8em6ij1bYi7wJnf67OtTz3d1RaBJtIbxz08UtWZqX+NQl60S
 JjJpV6DQOjN5EAqBuriczwqA9jymvRXGqQ58m+mtTJ38+ZrY/okcT+tiGjk6yk5Q7+Jqp4xSv
 ehhbdIW7FvkJDbrmRdnhsDQ/yHFFhlXsIlTB8Qde23ypGzSVR9BL7Vg8EUrXjPGm4NTkWbuHj
 I2FIFIrQvQ2noATttTmW2fmxgIsDQw1DOxOXXf18TGreDsGf2SjpdWHys7b0jsltSAhvnX+kV
 B44IyD6GJ+nZONiCujSv1H8fwZ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/7 12:29, Rylee Randall wrote:
> I built a kernel from that branch and tried everything I could think of
> to try to reproduce the issue, but no matter what I tried btrfs-cleaner
> would only show up on iotop briefly every now and then, io did not hang
> and disk performance was as expected.
>
>
> I think the branch resolves the issue, or at least prevents me from
> being able to reproduce.

Just in case, you can still use that diff, it will only populate ftrace
event log buffer, which is much faster than dmesg log buffer.

And since you haven't seen huge IO/CPU usage, the extra debug message
shouldn't cause any observable performance drop.

And in case you observed huge CPU usage from btrfs-cleaner under
whatever load, you can direct grab the trace file, and no need to
rebuild a kernel module (and may fail to reproduce in next try).

Thanks,
Qu

>
> On 7/2/22 14:05, Qu Wenruo wrote:
>>
>>
>> On 2022/2/6 17:26, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/6 15:51, Rylee Randall wrote:
>>>> I am experiencing the same issue on 5.16.7, near the end of a large
>>>> steam game download btrfs-cleaner sits at the top of iotop, and shut
>>>> downs take about ten minutes because of various btrfs hangs.
>>>>
>>>> I compiled 5.15.21 with the mentioned patch and tried to recreate the
>>>> issue and so far have been unable to. I seem to get far faster an dmo=
re
>>>> consistent write speeds from steam, and rather than btrfs-cleaner bei=
ng
>>>> the main source of io usage it is steam. btrfs-cleaner is far down th=
e
>>>> list along with various other btrfs- tasks.
>>>
>>> Thanks for the report, this indeed looks like the bug in v5.15 that it
>>> doesn't defrag a lot of extents is not the root cause.
>>>
>>> Mind to re-check with the following branch?
>>>
>>> https://apac01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fadam900710%2Flinux%2Ftree%2Fautodefrag_fixes&amp;data=3D04%7C0=
1%7C%7C4ca72e2e2774416246b208d9e9e6c2d8%7C84df9e7fe9f640afb435aaaaaaaaaaaa=
%7C1%7C0%7C637797999607143470%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DLQyHFTmN=
G%2FKIQzPT6gt%2BZugspRGTHISPFtwi7zRdqhQ%3D&amp;reserved=3D0
>>>
>>>
>>> It has one extra patch to emulate the older behavior of not using
>>> btrfs_get_em(), which can cause quite some problem for autodefrag.
>>
>>
>> And if anyone is still experiencing the problem even with that branch,
>> there is a diff to do the ultimate debug (thus can slow down the system=
).
>>
>> After applying this diff upon that branch, every auto defrag try will
>> have several lines added to `/sys/kernel/debug/tracing/trace`.
>> (Which can be pretty large).
>>
>> And that trace file would greatly help us to locate which extent is
>> defragged again and again.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> On 4/2/22 12:54, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>>>>> Hello all,
>>>>>>>
>>>>>>> Even after the defrag patches that landed in 5.16.5, I am still
>>>>>>> seeing
>>>>>>> lots of cpu usage and disk writes to my SSD when autodefrag is
>>>>>>> enabled.
>>>>>>> I kinda expected slightly more IO during writes compared to 5.15,
>>>>>>> but
>>>>>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o
>>>>>>> even
>>>>>>> when no programs are actively writing to the disk.
>>>>>>>
>>>>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>>>>> partition. In my case, I was downloading Strange Brigade, which is=
 a
>>>>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>>>>> download, iostat will start reporting disk writes around 300 MB/s,
>>>>>>> even
>>>>>>> though Steam itself reports disk usage of 40-45MB/s. After the
>>>>>>> download
>>>>>>> finishes and nothing else is being written to disk, I still see
>>>>>>> around
>>>>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrf=
s
>>>>>>> cleaner and other btrfs processes writing a lot of data.
>>>>>>>
>>>>>>> I left it running for a while to see if it was just some maintenan=
ce
>>>>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>>>>> reboot, but it actually prevented me from properly rebooting. Afte=
r
>>>>>>> systemd timed out, my system finally shutdown.
>>>>>>>
>>>>>>> Here are my mount options:
>>>>>>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv=
2,subvolid=3D5,subvol=3D/
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Compression, I guess that's the reason.
>>>>>>
>>>>>> =C2=A0From the very beginning, btrfs defrag doesn't handle compress=
ed
>>>>>> extent
>>>>>> well.
>>>>>>
>>>>>> Even if a compressed extent is already at its maximum capacity, btr=
fs
>>>>>> will still try to defrag it.
>>>>>>
>>>>>> I believe the behavior is masked by other problems in older kernels
>>>>>> thus
>>>>>> not that obvious.
>>>>>>
>>>>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>>>>
>>>>> And if possible, please try this diff on v5.15.x, and see if v5.15 i=
s
>>>>> really doing less IO than v5.16.x.
>>>>>
>>>>> The diff will solve a problem in the old code, where autodefrag is
>>>>> almost not working.
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index cc61813213d8..f6f2468d4883 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode,
>>>>> struct
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!newer_than) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D (PAGE_ALIGN(defrag_end) >>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT) -=
 i;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D min(cluster, max_cluster);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D max_cluster;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster =3D (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster =3D min(cluster, max_cluster);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (i + cluster > ra_index) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
a_index =3D max(i, ra_index);
>>>>>
>>>>>>
>>>>>> There are patches to address the compression related problem, but n=
ot
>>>>>> yet merged:
>>>>>>
>>>>>> https://apac01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fpatchwork.kernel.org%2Fproject%2Flinux-btrfs%2Flist%2F%3Fseries%3D609387=
&amp;data=3D04%7C01%7C%7C4ca72e2e2774416246b208d9e9e6c2d8%7C84df9e7fe9f640=
afb435aaaaaaaaaaaa%7C1%7C0%7C637797999607143470%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;sdata=3DFfyqNM8d%2BTXZXq3jE4d5M1OdO9hPeTIk5Ly6yaWWeuM%3D&amp;reserved=3D=
0
>>>>>>
>>>>>>
>>>>>> Mind to test them to see if that's the case?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>> I've disabled autodefrag again for now to save my SSD, but just
>>>>>>> wanted
>>>>>>> to say that there is still an issue. Have the defrag issues been
>>>>>>> fully
>>>>>>> fixed or are there more patches incoming despite what Reddit and
>>>>>>> Phoronix say? XD
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Ben
>>>>>>>
>>>>>>>
