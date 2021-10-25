Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B343944A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhJYK60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 06:58:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:46645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhJYK6M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 06:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635159349;
        bh=U6gnXsXKQWonLikzFCN7yZORwNAzAKCggxYMsQBTIDQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=RaECGsvYuS14FSsipUfHRrSSs9lXKpsTO/ceH2XqYo+UrMu3+jWq8w8rNjg6f7Wo+
         QGUfhtRdgvM8elwMthgWaBQbvI2Fp/JYkhkCpcuz+PtgnXkk4oQ6boBr8PZUCzVNdR
         7rqBc1Qqnv0EFlhSsiYgC0RGqv7imzI6eWyZFFQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrhQ6-1mzlmi3XDY-00ngAL; Mon, 25
 Oct 2021 12:55:49 +0200
Message-ID: <69109d24-efa7-b9d1-e1df-c79b3989e7bf@gmx.com>
Date:   Mon, 25 Oct 2021 18:55:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Mia <9speysdx24@kr33.de>, linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
In-Reply-To: <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vk3lyw2qZJ8eIaiXrc5KPge/GRChDtIic7EKDWO8rI/CSUhHvLv
 hHsmqBTQQKKbjKJ3whAP9yI+jlBp1vNqvJyxCVw7R0lgeQl4aGCJh/jlqoi5A+kjlpNB6S2
 uVPUMVOEFp0q0Hy1wKvFfpPogvBdvDUn8JjydVRRaXCUzIFcbnmHVVfGUpxwczC8XyL81ut
 Rw+sSugX+2F2OWio8AErA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NPYhgmYAefQ=:0ly0+nPU9X6Y2TISonSWhM
 cTrYdHlYFSkwTRvnwIoN+88p7xPrUTb3g+PjULGQaQTQywwQNpbxpuFSfBcVNgDM1lrQeIivl
 +6j7DA8dc5MwEADCwn61xZGJBfWzKJSR1PviEpl0rGotJlfUMGW0k+5tH1v//rsJswI4zIYkB
 7Y9yTw7ZdUjNwTM0yarXmF0uB1SMk8ayiooQeSZr9mFF9U7M4RYmjf5Zidy9gZFCWVaRiCW9F
 B1RqCjDofWXF+Shz9hC08dNACEfpd4XZkfw0Jqf/e3Z3tmS4KIerxoX4TFo6ZHk6l26DSA106
 n54Q/BDV4lWDJUApwITtctHOFvHauNIXWDkbEinS9zljFWsUkrc1KCv83x5ArZ0x6kMrDzmZz
 KkpqrWJtfkNQlNTcdLa/zAPW3BosEpbQNeqP9thJs3+drEGnL0oF4AL39Ichcq9kZK0Gq8c3r
 z9yBxJxeKFbXBrVWSdmaeMnF6SPTjYFVwKGUTL5++oO/gL88O+icA3O6R1weD7gZVufWsYFES
 PJ5J9eiiL8vD2iQBoDdNFKa30ykr/cowXVllfOPBf3XO1kmocCNPB+tERTK9UuEzklxTTSHw7
 OcC9ussILj+gS+UaI6GNadvGOfbOFsFguVGcHG81IqGmivB7+et/SXj1C3lB6ps8j+ULtDk8X
 QrjHCAuhE6gT1pqpR6y+eeNAga4BD0VW98q19g6jLDwjTw0srF7Hh7VhHq9M1sFpKMRU+X3kX
 4ikFb7Ar0ezFDuiPcIdbVmOctvqlmYVpW9bMkddbNVjZr4HYJjmXg7ZokDwEjxlOyuxZ2Ya4K
 FGWaq6n1oa16nPSt5RQwLX/0JDZXhgYsvObg/g/rKxxygEBqmrmoenE3OlKMdjUGeWjGkzPRg
 KnP//WB61ZIOwINbncQR7wY/mZxT5xWpWLeZxSxjyhGlBpovNSW6aCgb0FImc7hHlLhmIWiVa
 yf7mY/cZiuankrDMshBMt4b3GJR8CcaNKnNPiqgFMDYEqXGPeDvcnXet+LuTYoXOdamxOJP85
 MQHSeiK2PuhkpLuo++JCCRklEeHY7vpiQA9Cws0OH1f7l5RmBBNn28T+X23vvyM+aCE0HxJHu
 4a/oU42cB6GKYE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/25 18:53, Qu Wenruo wrote:
>
>
> On 2021/10/25 16:46, Mia wrote:
>> Hello,
>> I need support since my root filesystem just went readonly :(
>>
>> [641955.981560] BTRFS error (device sda3): tree block 342685007872 owne=
r
>> 7 already locked by pid=3D8099, extent tree corruption detected
>
> This line explains itself.
>
> Your extent tree is no corrupted, thus it allocated a new tree block

I missed the "w" for the word "now"...

> which is in fact already hold by other tree.
>
> This means your metadata is no longer protected properly by COW.
>
> "btrfs check" is highly recommended to expose the root cause.
>
>>
>> root@rx1 ~ # btrfs fi show
>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB used =
199.08GiB path /dev/sda3
>>
>> root@rx1 ~ # btrfs fi df /
>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>> System, single: total=3D32.00MiB, used=3D48.00KiB
>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>
>> root@rx1 ~ # btrfs --version
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :(
>> btrfs-progs v4.20.1
>>
>>
>> root@rx1 ~ # uname -a
>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) x86_64
>> GNU/Linux
>
> This is a little old for btrfs, but I don't think that's the cause.
>
> Thanks,
> Qu
>
>>
>> Hope someone can help.
>> Regrads
>> Mia
>>
