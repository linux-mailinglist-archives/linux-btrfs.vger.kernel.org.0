Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2A2FE01E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 04:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbhAUDp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 22:45:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:47937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbhAUAt1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 19:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611190055;
        bh=/LZ73s32K2JWwuwNVVS4TdVWjyTvlNgKdQ+QwvFrFYk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f4x/o7n/sjLY+yU4v7ALrSj9dl4PU6iQ/HNXbbu5BPgiqJGo6KZ4YyZQmbkrFtENJ
         Li7a+dwE9po0pke4Cw1RFbz5hWFzLyHHik1gIxX0sqO4u/dn2Bs5X8omqIgleiNkLw
         GI/o8PXUPiwZv8G6nbOdKoXPFj9RNDEAlYKDa6yI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1lF4e01Gne-00H8vc; Thu, 21
 Jan 2021 01:47:34 +0100
Subject: Re: [PATCH v4 07/18] btrfs: attach private to dummy extent buffer
 pages
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-8-wqu@suse.com>
 <565f8da3-1fb7-d46f-b84c-19e4a784041f@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5bca4f09-2436-ecde-3fba-c6fddc873447@gmx.com>
Date:   Thu, 21 Jan 2021 08:47:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <565f8da3-1fb7-d46f-b84c-19e4a784041f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KskAFnxejba+024BykAk7hVfvtwbHHAFF1k4jGVFrBPHDHeCI3B
 7rMoCP8/UuhJn4hA7Eq1iMcELf+YUW3ig9JbneQtYDG1v4m01sE1BXBglmm2UwrPO3znr+0
 OMlt7aYpRNT8hMQzP8SdFteBgbXg9+iXsV51VMrBoDws/qR4vdUMia+QnfaGkC8lMH5Rfhq
 Ne3q2A74H08NN8hxl8cpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TlPIi+BuHD0=:SS3OqrLENCjXUmuBBKVQw4
 PSWd86xlE/NeS2GaRdCxdwBzmIV8CQ0ZHKcxpNlNUks2lx/Lgkq3YX68JDaVILfWCZdDACP47
 TmeuRZW2iP1M3MKjmfzY3DqWr7t0hoGMEiQc32w1jidIsAp5tKZK4Z4LbcBeegZFLOUZia4Lg
 YFn/T5X+YjyG98QpKioxaRXw8mJjH0D7rGzS21aJr0H2DeXmZ0TC0zhEphjFWjsrZg3pbfA53
 C9PbwVefTVjZwBKiX+RpZKXwXgM0Thvk8AmSGMjS4PQ+CWHo+uHcdyj9ecwxU3sRuq7QoHVPF
 0Vf658MxHvn6xJZ3I2eK37LCFX98gTaPR+urCxSmS01YCGxE72IaeXEzZ+297oZ2Q/iNqgkg5
 nN3tcnc5JKO1/AgFwJFbl3qBk24PR2CkWup4MDmD6Dnk+Ujw6B1rok8U4RnERVOapowwlk6rE
 KhHRNEDKlKAdHhjw4t8/4PsT/gIy3x78oK1vGjt9iBLj6I7RC/IxcuRqT8VqM1gRQbFXrQ73j
 rvmzrKxlg8rTfiHuWnY0FYVYdCaNxSS1Qcr5efU6Do1/ow5Tpzz2bvpFd6ArOt2mKmvEew6QY
 iT6AiZq90tAVfFtznxztPAbdnaalf67gBw39BtdY2If1Sr1DKKiOIwPJwinNiy5UyKJW925/4
 QBtoYkhBotfJoMj+PZzsSCfV0gGkV8cja1iaR0LXagT9nfaSgeSMJl/R/X0MYQ2cYkf7pUWA+
 hPVkhlzm1JaEy6QZAAfcvRURgV248WMKyC6EpZDku2LDVYyytPM/rjquRdG2rRxHl/M1YOvAF
 Zduzz4x/3PnU8p95BkJ7Nz8acXfNWevbLePdUtaVgOsyfzIyaugkaFUk4Diu3Ii+24kZj9bHJ
 S6wWVxBEblONoeiCZrjA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8810:48, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> Even for regular btrfs, there are locations where we allocate dummy
>> extent buffers for temporary usage.
>>
>> Like tree_mod_log_rewind() and get_old_root().
>>
>> Those dummy extent buffers will be handled by the same eb accessors, an=
d
>> if they don't have page::private subpage eb accessors can fail.
>>
>> To address such problems, make __alloc_dummy_extent_buffer() to attach
>> page private for dummy extent buffers too.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> We already know these eb's are fake because they have UNMAPPED set, just
> adjust your subpage helpers to be no-op if UNMAPPED is set.=C2=A0 Thanks=
,

But then the helper behavior would be a mess.

Some accessors, like read/write_extent_buffer() will still do subpage
specific offset calcuation, even it has UNMAPPED bit.

Thus I still prefer to do the same operations, reducing the branches in
accessors.

Thanks,
Qu
>
> Josef
