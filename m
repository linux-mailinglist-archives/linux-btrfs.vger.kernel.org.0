Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16328497E35
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 12:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiAXLpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 06:45:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:60729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237863AbiAXLpm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 06:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643024726;
        bh=4Oynzzy0Gb5uTl8b7IrfCY5998fMGw36q//biAe6Ri0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GoQEnAUumE3xb54onrEhOL/gcB3Xz+76eqsernUpLgCvQSD3nY6X1NnJbPdeAj6A2
         hrb0gmYqjGlpk98mMx49w24UF03zZjS3lkBm0IoZMlA8ttDDSvVWfupX2l9lvu0AG1
         YCD8G1hlyOUpOeCUd33hscyxt6V0UZquSww9W65E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1mONvt3O6O-00wZN4; Mon, 24
 Jan 2022 12:45:26 +0100
Message-ID: <d30f1475-d06e-065e-63e1-6253c5ee86a3@gmx.com>
Date:   Mon, 24 Jan 2022 19:45:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: inline deduplication security issues
Content-Language: en-US
To:     Su Yue <l@damenly.su>, Diego Calleja <diegocg@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Andrei Bacs <andrei.bacs@gmail.com>,
        cpu808694@gmail.com, Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Kaveh Razavi <kaveh@ethz.ch>,
        "Bacs, A." <a.bacs@vu.nl>
References: <CAKDzk=-HZardsLFH5c9HYre73NYNszUJqpfsh0YJnnaQToB3BA@mail.gmail.com>
 <1828959.tdWV9SEqCh@arch> <1r0xx5tj.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1r0xx5tj.fsf@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ACFIiK4boYc8Y73IZ5TlkaKfrLKHdobtpNgPEgX0AlZ7xIzzrDv
 JpA9qyC4HRFlsaklb+nS7TzE+EgA+l3AXcpu7ZwjQKMowiWGD/cA1rlNVX84HXhGCs9m8JG
 CuTyuKmQjjt6oXoxnzZHCIrUwO+YyEM0Xm7ef1XE+qkDpR6FZpdyoglMPBKtfOe5BmyKkOq
 ahAgMbUV2nhcM2T/cRC0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNVLjqF9+44=:+9Qlk0g7QI8KAvpTuOspeo
 rqhAZPtW5kQkSOzulYv6mjFgJ30YYDQCJBlGLyGW8c5GvAps+lDTlynaG0JXfYdBO/oy5jTaW
 dWkPxjwfZxZ/C/Y/Nw85LuVXngM1j4EEyg5GbzDrlrERq/08PVQljZe2dNf9robhivJOZ3/eF
 Siu8dMCQ8AEimUj/CfssK7YGSTylI8TLkX/JBJwJttVOt1kuHb2IaqnLq11JHps7fCBIuJNAH
 rmOS07CYWaqbiJUFLwAqebnu/0dOSo03FB584RiCEKGtNMxA+53Nv0r38e6P0Gqo1nrksKHQe
 fCyXe4BJFEiP4ZMT5Us/nZWr1kUdZF3rQL1Jyi+HF9uQIMWBEQOSSSyer45kky2CbtKWcuxz/
 aWt+mRqEsFsvwxMuMWzkMke4xC3F1jPrXenuTYN8DKEC4FbjGqw9dIlp2y86FIYWsQ1lRlIEO
 V1vkYjMr6UToXUGwBj/4OnsjHi7GjP66pngQ8cI5i8mR0l6YuxNJNbMWBNGDlPdBtd53XxoJd
 nJsKHLyaLpNCOHHRhqeb5WGS4HE7M31DK+zRDB5a2vqh29RrBTix8tyC4w94I8cayuQH1iH50
 8X4MBC1WEPAknSNbYRa6g78iDBQ0MxfXACz5/V7fheusiGyDARhbvg6WQzTKZsaQLR+7L+j0F
 hFrwTFbMeQ6zwOqOZGrT2GjEEkRRaSQnSg/QJ4RtIiU83YhVMt4lFhFERHwD3Kutpdm5YWB0w
 UA9/iM915AaYpFhCDkXFy+vxGmQovm1IXdQg5M80/QFWoWeF2W051haJJUtoEvUOwa9s2Ni5a
 g1Yg7HCv91+3UfmTdIH7hnb4/pjodT6U/P+NCTB1XcxwLoPhNIRXeSOL/SPbN6vsy67Mq4VE/
 FL3ulZG1YD9tko+oATFCIr7nnXaVp1oezgnrdmko0vgazGYPvPhsH2mMg30v1GGePxNTS9Tpk
 g5t3MMd0i8fqaFIpADwekRwzYUnRAd6Dks50yuUF+Z/wMBG86leZzxOCXb57sSuSrWEE+IbdH
 3HgeVS94rNHZtD0CQwsyIVjJXEfMTqx1dGsjRrv1Ppp0lph4lpfORrUypGAKQvn1K2PWyXi50
 +qEVQgFkAYaDAo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/24 09:38, Su Yue wrote:
>
> On Sun 23 Jan 2022 at 20:18, Diego Calleja <diegocg@gmail.com> wrote:
>
>> El s=C3=A1bado, 22 de enero de 2022 19:42:47 (CET) Andrei Bacs escribi=
=C3=B3:
>>> We have found security issues with inline deduplication in storage
>>> systems, using ZFS and Btrfs and running examples. See the attached
>>> paper for details.
>>
>> (Not actually a btrfs developer here)
>>
>> I am confused, Btrfs does not support inline deduplication. The inline
>> deduplication implementation used in that paper is pretty old and as
>> far as I
>> know it's not maintained (people seem to be happy with out of band
>> deduplication).
>>
>> You might want to contact the developer on the inline implementation:
>> https://
>> lore.kernel.org/linux-btrfs/20181106064122.6154-1-lufq.fnst@cn.fujitsu.=
com/
>>
>>
> AFAK, Fujitsu has no more plans about btrfs.
> So there is no follow-up version of the inline deduplication feature.

To add more, as one of the original authors, I and my employer have no
interest to push write-time dedupe any more.

Furthermore, the original implementation has one limit, one extent must
be written to disk, before it can be utilized by write-time dedupe.

Thanks,
Qu
>
> --
> Su
>
>> Also, this is a public mailing list, so there is no point in waiting
>> until
>> 23rd of February 2022 to make things public.
>>
>> Kind regards.
