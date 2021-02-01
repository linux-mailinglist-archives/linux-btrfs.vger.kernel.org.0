Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4537330A05C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBACgt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jan 2021 21:36:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:49221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhBACgj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jan 2021 21:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612146905;
        bh=6I52NL34wovg/cBj28vi1kmTnGUtQxRr/T4nI7yDcrM=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=WqMNN/bZN/Qtq6rXOTMDcS5tAcj+DCRBgbPsBwjDKqLGpKf/nXNhTucjkwbCtrZ4r
         yRSxA6B08aFc6aNSusOSKsX+oOVgE+ksHeda16AgC2SwjiHXk2vrgGbIyoSncejxjc
         xLh//vWw9j9WgS3rnNa3XHVLJMpu7Cr8zToSBnts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybGh-1lthsj1Eyb-00yv1V; Mon, 01
 Feb 2021 03:35:04 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
 <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
 <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com>
Date:   Mon, 1 Feb 2021 10:35:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ylCqoBw52lYlqWhO7qytFUk9XDY/fWNqBw2XOueGjBh6x6HFs5L
 EjElujmRJk9ilXaUGrktiyqUW4pg+58X+dSTj+DFzMJqudR+JRR3jjjYZNk8t3AObyYSfNF
 Ffp+OB7uwYXrMyKlgTZrS7n64RqwEh5Rr9T1UdheS6ER/5jyfjtZs77rmuZZco7AEFJi0ex
 YfTRRQQR8d1j/OzPg6zlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxYRKn3TX34=:Xbd4xuqb4nu9Om9cb3wVKn
 cZoeV/MVj2IGxcNr43BzL44UF9WnyndttI14meaW0nz1FJGC5uNdjJPiJDbQhRDgEW8XaVlQW
 Cly60cpPTSvwVKT1OTq3r/fZ7djbPzVT0MPswetAq2fZPDpBIptwxP72rzRR3DtZRBDTGZN4P
 lD642zRUJ9Q1U0a8BgEXJ9Gso3UjCJOPT83uJu3mU30bHmG8y73ygfkm+A0WJ/9ZvJgmYGcio
 7kfPbcPpCQyuoNUHvUBvAv6GQwFiQwdRXPQKEeFDUnAHRShKKAOC4QJe2JPfc1eGvMWxKI9Sj
 Xv0RYDtmELUheTmVlCBX91DJYaLus3EJ1AdIrLO/fcA+AtBqGOf9iAIgVzlHd8S+HnXMoXcXD
 U6p7Jiad/v6QVLFoodAUzdhG4jz1kAPQBSFP2wkSufjfNNdxu9rFdOtqGkk7y2Nf4Ine814Ia
 HOAq7PiMEdc0UNYXSprKkvDlFm70z6vPDHaXZl0xHn+EjiyOYjuSM2GHi4JrVNIooF19pW4X1
 yu/XOYkbJEIkPK0bTvFSoof1U/uYY19knjA6RtNSINKX/KEhdjNQAL2DFN0BCbg4/s48Fk1Q0
 QaygLItw19VZAG8FjW5BUBHmckQ/EwXu3AdzqLT9P3MsezSTy6ZqTYyej+XEYRmq17cPe137x
 bqm5zcyFjiXd51vpy2volprYfipA9SkCPQc8Mwibjhd36fvyMYZKqyoSPN3lZ9CFtk60T2zPK
 44ApacmYL1zqslQW/2ZfNrrdlLcJKHKTL+/RKuLSkJ/sRASKEVffF0xF+GtNPOEoy/umV6Xv7
 80CJat8/w/Tkrnt3qki9Oi3vT+DmnN/xR0QBcdWnZf6Y/71GxT0At2nQKiReCftuUDgdxvHDC
 SuWOjaYZK6EkcwGb2qDA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/29 =E4=B8=8B=E5=8D=882:39, Erik Jensen wrote:
> On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen <erikjensen@rkjnsn.net> wrot=
e:
>> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen <erikjensen@rkjnsn.net> wro=
te:
>>> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>> On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
>>>>>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.net=
>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> The offending system is indeed ARMv7 (specifically a Marvell ARMA=
DA=C2=AE
>>>>>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
>>>>>>>> actually ARMv6 (with hardware float support).
>>>>>>>
>>>>>>> Using NBD, I have verified that I receive the same error when
>>>>>>> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
>>>>>>> [ 3491.339572] BTRFS info (device dm-4): disk space caching is ena=
bled
>>>>>>> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
>>>>>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, wa=
nt
>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, wa=
nt
>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree ro=
ot
>>>>>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
>>>>>>>
>>>>>>> The Raspberry Pi is running Linux 5.4.83.
>>>>>>>
>>>>>>
>>>>>> Okay, after some more testing, ARM seems to be irrelevant, and 32-b=
it
>>>>>> is the key factor. On a whim, I booted up an i686, 5.8.14 kernel in=
 a
>>>>>> VM, attached the drives via NBD, ran cryptsetup, tried to mount, an=
d=E2=80=A6
>>>>>> I got the exact same error message.
>>>>>>
>>>>> My educated guess is on 32bit platforms, we passed incorrect sector =
into
>>>>> bio, thus gave us garbage.
>>>>
>>>> To prove that, you can use bcc tool to verify it.
>>>> biosnoop can do that:
>>>> https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.txt
>>>>
>>>> Just try mount the fs with biosnoop running.
>>>> With "btrfs ins dump-tree -t chunk <dev>", we can manually calculate =
the
>>>> offset of each read to see if they matches.
>>>> If not match, it would prove my assumption and give us a pretty good
>>>> clue to fix.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Is this bug happening only on the fs, or any other btrfs can also
>>>>> trigger similar problems on 32bit platforms?
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>
>>> I have only observed this error on this file system. Additionally, the
>>> error mounting with the NAS only started after I did a `btrfs replace`
>>> on all five 8TB drives using an x86_64 system. (Ironically, I did this
>>> with the goal of making it faster to use the filesystem on the NAS by
>>> re-encrypting the drives to use a cipher supported by my NAS's crypto
>>> accelerator.)
>>>
>>> Maybe this process of shuffling 40TB around caused some value in the
>>> filesystem to increment to the point that a calculation using it
>>> overflows on 32-bit systems?
>>>
>>> I should be able to try biosnoop later this week, and I'll report back
>>> with the results.
>>
>> Okay, I tried running biosnoop, but I seem to be running into this
>> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was reported
>> for cpudist, but I'm seeing the same error when I try to run
>> biosnoop.)
>>
>> Anything else I can try?
>
> Is it possible to add printks to retrieve the same data?
>
Sorry for the late reply, busying testing subpage patchset. (And
unfortunately no much process).

If bcc is not possible, you can still use ftrace events, but
unfortunately I didn't find good enough one. (In fact, the trace events
for block layer is pretty limited).

You can try to add printk()s in function blk_account_io_done() to
emulate what's done in function trace_req_completion() of biosnoop.

The time delta is not important, we only need the device name, sector
and length.

Thanks,
Qu
