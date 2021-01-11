Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C02F123B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbhAKMWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 07:22:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:45665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAKMWq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 07:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610367672;
        bh=XMgRd+xWNXbuK9vGOVfxoT99v0OdYTWSidHCSJAnh0w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OBnFbMiGo1f76EMBoreJ8+M5YxJ2FxWqPHsbJE0bvqoKxkkaXiNjy0hKE320PwkD5
         Jptz8Q6Z5yD8VQO9vJAfOI5r84SKq72ae5NXLiB6JpqnYeshNlwHuvTKeLEq+EvO9t
         MtqmRtWn6HJriWsAB9R5TKn+QXkTkEc4F8fn68HE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1jxFkO0lLM-01242f; Mon, 11
 Jan 2021 13:21:12 +0100
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond
 limit
To:     fdmanana@gmail.com
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20201111113152.136729-1-wqu@suse.com>
 <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
 <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com>
 <20201113151946.GY6756@twin.jikos.cz>
 <705e1226-2aaf-0d5f-45ed-03b25457e680@gmx.com>
 <CAL3q7H7_-p1hKvJ9twWq3dd5Qj3QS4ujUaYwsy+H_j6u2uWThw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <69044d74-06d8-0629-aec9-6456849be758@gmx.com>
Date:   Mon, 11 Jan 2021 20:21:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7_-p1hKvJ9twWq3dd5Qj3QS4ujUaYwsy+H_j6u2uWThw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iyPaqwjhKrwTWV7oegwFpPj67UVCsZMyh9YXNvl8PBrj3Ox6F36
 a4/bEDWA008m3RVO9iP+0h+FkPAwuBSK3hAfJzO0yJhopp0Q1U43FJ4fkux5KaJVCzJuz1C
 HJQaQ1s9x6o8Bugoe012DKJvlYeTArs2lX8FKKEJnrpj1bZXT6XRfWrDQXg0FKS91L/5Acj
 JdAqoBM0eCkCeKwr5Fi/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S4674+Z/K48=:lskk4Yl2K4n+FI6ns01bFM
 1PKYRZUq0qtMTCs2OTAgsJDf83dsbL+ph7RJIuDep+0dIbG8Qm9BDifncXB0a0S+FFGPGkMDI
 gXj8HPmHFPKZd7yTRp5QrCq3s0x+QpMpUailIoPbJxMVe5wbQBPumMsut8zgrM4JLS09/PSes
 BoyZ3fPgrV6pYebe5Ty+or8No9zPVc+b26PeqD7Kz4Qc22YMDmJEQnpH9UGm9bZpe4cvGp6c2
 UFgdyGFJh13OIjB8jeMZGtIqW8AODdefFtsStj+RcPX1UhRPxgR0DfgCPTQcGeTAkSSCEecxN
 sDMxbruvMt7/c19ga9zKfsPAFsAQmHNV677kdbXEmICAn34A4JgPnBK/DWSNIwhuxbESgBX+X
 aXe7BdS/Gk+yq7EjaQf8EjmeqjxSP8xdJJGMIKg/zkkoQt6Mo+gy5hZIkElQSkVYR+rpMb48a
 kc6kcZ2cWltSJAvC41VtJpvHkh29RmkwHfXHDgLVEwHFkVnNXWlQWTQH8h+hmvC3tmMb9ZEna
 PVUg/tamCuT4v5b9w9jgSyF5pxNVaRFLZz0pBxQ4uQ1iCnePOb+8+nxzTg2H1CvTFBsg25Wo5
 e1Eu6TXJjBZBsdhqetQZrFkrZKjN9NXQYyLQWX5MByK3rbc9cLwofivxQKmTouInnpUezYu6c
 IilY5Yp8CjUZcwIWc8trdAe7XC385oolmaU4fbQlk+7jroQqyOyEwU7VGK/bwA4Q0D0lw8+HC
 AtyQHet5/i5v/+YYrb/PC6q/gKBbA+vDeaYnzSa4qAPMqOKygJHWORvmQTfstj2bwKOxNx75J
 uRUKL27bl3IMHwRlY0Dz3yxIYtIf5SFxKym6fviir8DvO8GvE4rTLw+d1yn1JvuAOBm+BgXyH
 JUQWycyn4Md7ihzOpIOA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/11 =E4=B8=8B=E5=8D=888:15, Filipe Manana wrote:
> On Sat, Nov 14, 2020 at 12:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/11/13 =E4=B8=8B=E5=8D=8811:19, David Sterba wrote:
>>> On Thu, Nov 12, 2020 at 07:50:22AM +0800, Qu Wenruo wrote:
>>>>>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>>>>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>>>>> +
>>>>>> +# Set the limit to just 512MiB, which is way below the existing us=
age
>>>>>> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
>>>>>
>>>>> $SCRATCH_MNT twice by mistake, though the command still works and th=
e
>>>>> test still reproduces the issue.
>>>>
>>>> Nope, that's the expected behavior.
>>>>
>>>> Btrfs qgroup limit <size> <path>|<qgroupid> <path>
>>>>
>>>> The first path is to determine qgroupid, while the last path is to
>>>> determine the fs.
>>>>
>>>> In this particular case, since we're limit the 0/5 qgroup, it's also =
the
>>>> as the mount point, thus we specific it twice.
>>>
>>> So why didn't you specify 0/5 so it's clear?
>>>
>> Oh no, my brain just shorted, and forgot that it's 0/5 fixed for fs tre=
e.
>>
>> 0/5 is indeed much better.
>
> Any reason this wasn't merged? What happened?

Thanks for the reminder.

Let me just resend with 0/5 to replace the $SCRATCH_MNT.

Thanks,
Qu
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>
>
