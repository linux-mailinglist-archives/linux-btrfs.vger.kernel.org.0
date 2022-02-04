Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77934A9854
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357520AbiBDLVO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:21:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:54611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241309AbiBDLVO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 06:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643973667;
        bh=dEJBHvb97egE+17dh7adCTMQnndZB8V4i8Cmp/d4+Vs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R1p3BGuCvNGdQJlEwiy+6gB3H46iMPchR1yPKcvM7OBb3jXYOZ2iI0WfJuyaK1ZKH
         3lMfhA6qgGUliRS0IPJ2acK5QFHTXI+IGdI3rchcsRtWHK1KZSw9VOE2jMQlJ8XwMR
         KgqaxlRj1ii//HXj3iPD5KGKWjKEpi4kKYBDDjMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1mXqWR2ao5-00iPrG; Fri, 04
 Feb 2022 12:21:07 +0100
Message-ID: <c4a8ab03-792c-2d95-4f92-a7ba7b5b0f31@gmx.com>
Date:   Fri, 4 Feb 2022 19:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>,
        Qu Wenruo <wqu@suse.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
 <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com>
 <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
 <4fdf158c-203e-6def-27e1-8a003775693c@suse.com>
 <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yXwxD0r/YL52NnO1Dxqp4IYyJb+LeiatSC1MYJ+oRM4KwxpZzv+
 63MADRo8C7p+cbfyiaBvUKXuLZJ+5/abe8QB/AJS9uMHe88yWpyjvgR7ujFuY0bDXKmMeyr
 zF0J7eD3V6uzOD/KFCXLT1EKMwgnrIG6Zp7E10wAuQ3WBp0BcGcKJpDdiQw+v2p3QmH9nI5
 N7zA5E9PMskixt2MpYEaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0831PF8wGo=:z4iat/mR4PbWj9J79SDwlD
 SdbwD9zwjbZNzPE4sQH1UwWnAsq/YYysOOR9R+UHZlxHKdfQ7snbbJEAg9IVQBSc9u+/QIsMw
 HLQrs72guQ6OZ6ox5BDqyc+/VBYG1rWNZ6JACK+ZF8FJfmjIlkp7qsihUpgXoPWM+4tsIBTgy
 E2X+/jxYtREMLYpcZUdmfI9a96pypg7e+KfZoFQ+kO8/f5ulL7YWzx3pXS3M+49Yedfc7NmXB
 Iq0AGgky3Q5qAFNltw9PnJ13UrL9/lX0s77kUGP/N/Fay1cw+A+G2zUIMiUe+yN6HEw+jSO2w
 +toaIigiIkEWD8eJca01UDgqJiSYJrEc/66mjqixM46tTR5PSYU9AzsMo1WwLxjqDORpwJk9D
 hg1NOsUqiXcGJdBbjBisG3sgAflKcLvvFLh+pddwDPSzyiRlsNUcDoG/NdUUNt/BmHfj288L8
 RlVC6nS/JK+pmoJWvIvpNnRM1IAC2Zm/HnxK20Z5dlzXS8XilunCPqnduEAbcL+Xfy+3XBD+J
 HRB3ofLnwWyKdlp1Ybo269uxbgW3lW5+TM4WmLkhlwuMxWE37IOrv9T+STUy1I/wVSx/pKCsJ
 fK3E8Aqo0r7Tcyf87XaMBKrjrZX7PT3u24QSctw/5Wo60/+VRxgbjP+/ZcMgMIwB0vpnPMzVa
 ztmjtgh6qBrYT0TQ1I0S9XHKkJQpS+N/dUK/AV+Vj9ozE+S0xDe62BhduvhdPYa05KR4wcTQH
 vmo0FKLhv5nzSdHRE2QLF/z5NU/NZ3bZKfxGhSfn6rpsDt+OCA8rS8AMaUq4WEoH/pfgPtaZY
 ldwQr+vGhyRI+mqQ5oab1GWQhe6J2pCR2z948m3CDbXKW929hrB/boHm0OyE55bdFWxo5fPKN
 GN2EbsmDQGVcv9jyQs+hA2ZDvgva/bWjag8WH7B2lql2/XYHFJgGl8S970wocFVpKBhF2HqKN
 Rfhdx+/hzzGeYL3+AX9ih+vOWpRCCLoLtTDxGUOSGjwQVy6gWMutfZ3DPDRrk1hh2g1nk2rDA
 F9d0b8m0T9xsD6t32AGqlf+B2vB+Ho5KqWxd+DoZM2HE+RJ2L8mMJfpzKSASXzMLfSxxN/7N/
 W+itbcnqUmJx7juSeFmxLqkkKdXd7YOgoPRUFZmEAUspaFTqFkbMTufQ5WHQd6Jdw/i/8f2hI
 y1PtLX/sqKXX/uVUKqQYKBNgGF
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 19:05, Fran=C3=A7ois-Xavier Thomas wrote:
>> But one thing to mention is, the color scheme is little weird to me.
>
> Good point, here's a custom graph with just the write rate, that
> should be easier to read than the default graph with everything:
> https://i.imgur.com/vlRPOFr.png

This is indeed way better.

Although now the legend only shows write MB/s, but I still see some pink
lines.

Does the pink line still belongs to the sda write MB/s?
Or it's just the read MB/s?

And if possible, read MB/s would also help.
>
> Waiting for your next update then. In the mean time are there other
> statistics I should collect that would make this easier to debug?

Other debug data can be too large and slow down the system, like ftrace
event for each cluster.

Another thing which can greatly help is sorting the IO by its METADATA fla=
g.
(E.g. providing metadata/data read/write MB/s separately)

But unfortunately I don't have any idea to monitor it without using eBPF..=
.

Thanks,
Qu
>
> Thanks,
> Fran=C3=A7ois-Xavier
