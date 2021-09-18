Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541254108F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Sep 2021 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhISAAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Sep 2021 20:00:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:35627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhIRX76 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Sep 2021 19:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632009511;
        bh=Qv/2OjQS3n0Sm7bPzdJ77UJlkWFUyV2u8u7skNmnK1A=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=BzE4AwXGyphGRgXiU6oxxY2w2xhlbZLXXycjP7vyoDouyhpBIgC/lTyh3xmFPsBCj
         1e9XeIuLRnXoeeA+ir/XDOhbvIBfXEih+T2HuXbhARKoD9eZglLwH/VT04UFKhs2ym
         Lg77sIizQflgxVKAubwjJoUA5BIC1aD1UC3B4MrY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1mdVvV2Nap-00FCtW; Sun, 19
 Sep 2021 01:58:31 +0200
Message-ID: <52c5e29d-0ac3-e962-c915-b313d28c05d1@gmx.com>
Date:   Sun, 19 Sep 2021 07:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Select DUP metadata by default on single devices.
In-Reply-To: <9809e10.87861547.17bfad90f99@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+88S5+ZI7ib0HHcQJd/VgZ+tBlLJtVNnwhmY7o0i67BOE82vYj3
 vwvtGTEiz07FGMnnYrxPLy99jQsCZn7cbEGKuCx0Ig3r9IDyG/JHHhBlUFQYXezlbfVzfY3
 Qn4DidKfSeJOnB4lpMKci3P0Hk95sirs687ZFJPVK90m34ArNojVHj+w3kSHtJnvcQhR+z0
 yAfLzpfPWE5yleSwPp1nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRYCvMz63qM=:sjQx07rEZoqSoCWEw4XBm9
 RlmV+6PiVSNESMJeG95vQRZtCT0iVpzVnv/qeX9bIH3KTamM3CrAsuxSGrunBl3TfJ34IRMEm
 kZuYwVIlKXq373wx3zX3BwZse5QgMexyoREqIUVovAgogVu5/hWoQie4sCFlxUNv8TCg3vTAs
 FK6GG+gw/lYh+rMnajkfxfe13BEHB3HN50cNtmExV9cVgufW+Q57X+fj7TQ7c4Q8JaXu7uFDa
 QRVJuNznuUaTaYLfFc0uuU+QuHoPLpJMXF04pAIphPNx/1oHLQQ22YiRaC5VXvCfhPKJ2f8PR
 smj03+w500J8WoQ0K6Zr4Lz8P60kYmUCDLU5A3lBYsjnFIV8A0ODqnq6fXCKhil25+cQzKCJZ
 T8l0ozlO+zr6LMa0lF60Z1//QR7yIQt0jQGAzgn62PlnhOqyQYN9rsJdOt3f/BvtHFPhQKERr
 zsDNWcjy3/W/N3pNg4tgTd7MkcLWpQwpgffD2rWoEuOwdiRSkfR9P9TfcpYNlVWljZ1ltt6dW
 IhE743P9jOAbaEQGDJN0q5UCiP3sOTnvn0m+fb62FBLSnQrEvPvfhDcYH5kz5exz1Qiu4R7bh
 TZwgGNMM/uWa675CsPTvsKctvr2c6QVEZaKkd6u0jxLGVwOKUSSNpRixsM3euvwGjXDpGWfS5
 WhI47O8jjf0bb9KVUyF0mz7zeIZ4BJcu+3AnIHqYUm5jrKj8DDV0pyRM90xMwN3+dNkNFM8/h
 2Kph49cSVMh8IhsN1Qr4IHPTT20LqNu1jfv6Iwh4ZLUqMZfR8mAWdn9Q7oI04xdLa3MwXiDd5
 7hKOcplNc6UPA55d/b3G0kkddkVfkF+gDduUhV3j3VYXUXwZenpTTbLrOVjDCMMMHqMaQIcMF
 F0zIPjvZfk6XbzeuElmX9Q8FsxKkyptUD5eb4oJ/PGf7BYUugXmR22iio3CGqfwo11BcUIxBO
 QuxImZXMkB4yC7tu+8NnTvzTChTweNILIe6fetNHUbKbJEopY3o58g0SkKfuFiv8ZVoOyVUkk
 GWC3QdabpqHJi2r3Amv5kfO9mL7000g2wREvxGiA4muFCJpwVoy14kh37tsmnenAsrVOFmGpr
 WOIw0WskX0ziJI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/19 05:38, Forza wrote:
> Hello everyone,
>
> I'd like to revisit the topic I opened on Github(*) a year ago, where I =
suggested that DUP metadata profile ought to be the default choice when do=
ing mkfs.btrfs on single devices.
>
> Today we have much better write endurance on flash based media so the ad=
ded writes should not matter in the grand scheme of things. Another factor=
 is disk encryption where mkfs.btrfs cannot differentiate a plain SSD from=
 a luks/dm-crypt device. Encryption effectively removes the possibility fo=
r the SSD to dedupe the metadata blocks.
>
> Ultimately, I think it is better to favour defaults that gives most user=
s better fault tolerance, rather than using SINGLE mode for everyone becau=
se of the chance that some have deduplicating hardware (which would potent=
ially negate the benefit of DUP metadata).
>
> One remark against DUP has been that both metadata copies would end up i=
n the same erase block. However, I think that full erase block failures ar=
e in minority of the possible failure modes, at least from what I've seen =
on the mailing list and at #btrfs. It is more common to have single block =
errors, and for those we are protected with DUP metadata.
>
> Zygo made a very good in-depth explanation about several different failu=
re modes in the Github issue.
>
> I would like voice my wish to change the defaults to DUP metadata on all=
 single devices and I hope that the developers now can find consensus to m=
ake this change.

I'm totally into the idea of DUP as default meta.

The idea that *some* SSD does dedupe internally shouldn't be a reason to
prevent us from using DUP at all.

The internal mechanism should not affect how we use the disks,
especially we didn't even have a solid statistics on the percentage of
SSDs doing that.

The initial idea of such exception is already arguable to me at least.


And such exception is already causing damage in the wild, thus I see no
real benefit from SINGLE metadata on SSD.

I hope we can get more developers agree on this.

Thanks,
Qu

>
> * https://github.com/kdave/btrfs-progs/issues/319
>
> Thanks.
>
> ~ Forza
>
