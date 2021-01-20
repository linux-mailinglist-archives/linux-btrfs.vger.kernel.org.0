Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F942FCCAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 09:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbhATIZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 03:25:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:43397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbhATIWs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 03:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611130871;
        bh=9n/57xRGFoFzl2uvrfzGCemSbG96WIiippD6zJJlrBA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ib2Rn5WEoZ+fABb2ruYp85NMn0vw7ZjVG29k9ZVXQrSEU5p9TAy+EL99a3V8kCEso
         KhmGzKx92H/WQcLSlRrnhJxvKuDWKfI1oabWAdvpMbat62amg8qCX5TgZI7eLH6Ta5
         AJNR+mqavGcFz4HVWk9EDX/JkESZwEmYbqs8wohg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwXr-1lCpyR1TFR-00BPTa; Wed, 20
 Jan 2021 09:21:10 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
Date:   Wed, 20 Jan 2021 16:21:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyOxKIGX2JrkObxdYRFhpDkvAyfjRyQx6EVe9Xf4XtUReZdXfGU
 HJf5OvLU+wS35y6B2H/od/qDF/cTb/nZWGUMCaQld5VPginwyt/thZlfYXv5ZOjQb7ayers
 8wVuCKI2sYBlPUoxpQxzY4bt8qItr+mYdt2AxiBJxXHiDuxtpbejdjWC6xOybdC9fOrzOpj
 xE+pvCPV+5iOuVW1SBckg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Qn47/PmlWk=:GA3YlZr7Zhxo0SRtMoO3Da
 J7ollTt5IgYyok+e+/n60S0JDcyTpfdgruKwf92fd8FVRLz9F+Ut5kf0iAwsIrfiMv5heO/tG
 dkpGmpggTLC2jfEUD5Jg0MY9pifhibCGqcd42MZH2n0MiK493QF8TUfHBIkeyciPGt0oYi6ZY
 mJGfKdBAA4klCJF4R1jaKJvzTAfEEHCvzxbys5ojzRJHMRHTaJEjxIRN6tc0c8XxBwS4wQ+jr
 6RIx8/+7/lUooOxfDLNaXL4YhCMxwQP+CufBuF4Of8pso64uLtI9mE4jbgwrnzG/gRxCeA3yS
 g/JOcHdqq6p9HCMUsnv7zJlVOJ/V+EPtVDNq9pa2tDNVHW3kMNJcfBbGOSay5a9QnyQo2rE2H
 OcQYazkDdx312BOIXk50gGURaAy/rrt4loPrmHx39ZQOoQy4oEl7Mj2QttBdvZmb0kFCnsyZ1
 AP6ab6G8KD1OA4n3iAa9VX1u0di48AGHRlZcoBGoLSoeyw5/p5QgRQkNCwkpFEJJg34kLNKKS
 cN1mBanAAKHnAy2zIz7w3nyHu+a5LNtZZMfchDyc+39p4l6dFsIFrokcrW0dCqW+LJPmvN+OZ
 noRJidhBQf/BqmWarY2C+sD0oe/mVRBXg4oPw/zKj/jXSHnBTU4sxEaYB9gvVR9eObt6zL5m6
 p7vE0BLcPAMvAWLG1idZQ0IGMix7h7b0MbhK1G1VmgQR5c6CLBA1IhibNBFqIhfbW1LZF+m0q
 o1LZ1SdzselXEmZlNgl1KmXCBGzYYZnRIWK1L5SJ5HaE7JlHflRfVZwGFjRpNGLTy4MhqVcgu
 nckFhB1zWYl/gBDlfUVR9MPBPA2yF+GiPQpwZoNfR9/TttRuv+/ICRepklYv3+33greIzGaaf
 5s/guNPBydLQx+77ai5g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net> wrot=
e:
>>
>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.net> wro=
te:
>>>
>>> The offending system is indeed ARMv7 (specifically a Marvell ARMADA=C2=
=AE
>>> 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
>>> actually ARMv6 (with hardware float support).
>>
>> Using NBD, I have verified that I receive the same error when
>> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
>> [ 3491.339572] BTRFS info (device dm-4): disk space caching is enabled
>> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
>> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, want
>> 26207780683776 have 3395945502747707095
>> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, want
>> 26207780683776 have 3395945502747707095
>> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree root
>> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
>>
>> The Raspberry Pi is running Linux 5.4.83.
>>
>
> Okay, after some more testing, ARM seems to be irrelevant, and 32-bit
> is the key factor. On a whim, I booted up an i686, 5.8.14 kernel in a
> VM, attached the drives via NBD, ran cryptsetup, tried to mount, and=E2=
=80=A6
> I got the exact same error message.
>
My educated guess is on 32bit platforms, we passed incorrect sector into
bio, thus gave us garbage.

Is this bug happening only on the fs, or any other btrfs can also
trigger similar problems on 32bit platforms?

Thanks,
Qu
