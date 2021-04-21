Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DE367574
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhDUXBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 19:01:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:58527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhDUXBp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 19:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619046065;
        bh=/DdaYP+GXm7gvfnp9Fg+xyyDF4zfNDQu5o+YYIoGS8o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C9Gk73FdQdAbE0ngBW1VIyRX2xU+lCcpb5+kxrUUKIRpV0JOnM/Uw0TmCfn1ZRfwi
         eXuo9MS75y2n1aFU1P96mAMS9/fxaBR4sXuNsa+G/s3kU7/5CQvaG1316fwt8lC3JX
         X+sE6PpyNifzXxHzYXqzTtdCHgadcwY+7yVMNl2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKYx-1lv87b3JPD-00LmEC; Thu, 22
 Apr 2021 01:01:05 +0200
Subject: Re: read time tree block corruption detected
To:     "Gervais, Francois" <FGervais@distech-controls.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
 <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
 <BYAPR01MB42641653D21CE9381EDB7CD6F3489@BYAPR01MB4264.prod.exchangelabs.com>
 <f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
 <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <86123bb4-08d4-5de4-b8cb-b23677062468@gmx.com>
Date:   Thu, 22 Apr 2021 07:01:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M7g6IdIvRanPsyzUPjF3X/eRdoH6o5hVgBNUrhrkfpDhLthgS6Y
 zImSqbSmz1GX3OFDNkTJU+HWj07u2hwbbBpUCduvA24wzVRXVLRKtxRe/dqYWNOjYuexAXf
 R6mZE+HXMqxJ8uSTt1bk/oSPBrER7ROnUV4RruTEMM2h0YyufBX/lLSikK/h9bV5iyXWOX5
 /SatWt+NUB9ZiINHJIUUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Swuy7QkQmLc=:s7YzgHWKJrB9OX7x2Jj062
 BXdEWnqJKUc/lJW/vVadu/S/7SpdJ26a/1K6QQr7QJ0rubEWo4QPiFbnKI09Ic3YYzlyihwy1
 DHrrHb6ocQWsjFHu4svq3uIuSJiaM4E3YQE6gGvpppjdjywP3Nbbk7GN6ZMc7S8yBR5vRWjPT
 NhfogjSYVrn0qII4dGZiXk9G8Zsb/i9y/XCkbff8mtNTRWPqTTQZro4wrZ6np/aRlYi15zSXM
 DjrrvpQ2kPuMdulfX25sXX7dGH4kOuE5evHM1/pn6pehBp3TiHX1XZRHNBOo5rpc/bOW+y+77
 Y1aWKjth8qNzLDbhO3399GviiV+ygo9lGIqk5nfMGNuQWRUy4kGNmxTjiPHuFr5bmbXwIyzoy
 COr1MujtZ72xmbQgL+h6wGFWAP201zqfIGytR67A1BI2IwAwgIesZdyN2S5Or4w/u+7PJUhu3
 SKESXaEfbFYGHZEdVGMz8VW0AXlKBXjhQek/xRKsreOZnIIihGj08TLoxKoS41auJ8RH5jL7L
 UDulnUmPhRWIOTiMLghvt+UQuywa957F9Ne2Ahfwv3olhbdLYbCg21gAXb1qxt9TT41nYxAYa
 L5P5aFZxT/gkWrHixdfQPxXMREw/j2heEhK9ZO3M7LG1TMK5yk2+N9AExCr3A3jDUn1FIxQDp
 BqKMqPI/e99vuAtJXoczi/CJ4rYKPgEgs3FyTfU+jkkvIkmW8P4ay9XtrcR2X4fKJm7oaPMcH
 AjBe6XBWnuy0K5V2I4gTDfMIalI5pYGMKY3MR/OUiasrpsi7bwLaPHPwJ+ladklBFtS1aPew+
 vEa4w6iKd4uqQh+bE5zsMrhpi3plGaOmMKJje3UKJyiEP+JYyBCJyM/mQmxxpjTnj5nRAin0o
 uc4/13WEWtrRI3vjprNb1/e2dzFNtmzwekM6PRAHsoPvc0tcGR25s9St+0J2muP7EVyfGWGZf
 bYhY5mceQr2VUVUAQKpprBoyJ388+WtV8UWue95qWLBks9J/Ff9v7P3JuGWQ3RQMF2EdBLU/2
 y2rAbtAfwEKNjdDxBXJuBSPG6J+M1PmUScB/4YJdepNU1iO0ulkcc/W1Hx3GrLUf0dFoK8veY
 mja9EP3U4dbjglmmAiF3BIiOzbX47YCiSpZRCq7TGk2BLBz0SVx7XY5dIw4LPBmpnCUq28/fm
 peAHjmy4YpqCVRqivjoiNwBqlt4oDjpHaLWGTYYorjx4RKT3k9yCeP4qq5yEJp/bcxK7+uoYW
 oUibNu1MSkugwENw/
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/21 =E4=B8=8B=E5=8D=8810:17, Gervais, Francois wrote:
>>> Would detecting it at runtime with a newer kernel have helped in any w=
ay with
>>> the corruption?
>>
>> Yes, newer kernel will reject the write, so such damaged metadata won't
>> reach disk.
>>
>> But that's just more graceful than corrupted fs.
>> It will still cause error like transaction aborted.
>>
>> [...]
>>
>>> Could power loss be the cause of this issue?
>>
>> It shouldn't.
>> The log tree can only be exposed by power loss, but it's not designed t=
o
>> have such corrupted data on-disk.
>>
>> This normally means some code is wrong when generating log tree.
>
> Alright, for the next step, I feel the best is that we try to reproduce =
and
> get more information as of the events that caused state.
>
> A few questions ,if you want, before we start.
>
> - Anything you would recommend as of configuration of the device?

You can test using dm-logwrites, which really logs every writes and
replay it.
By using dm-logwrites, you can emulate powerloss for each write operation.

>    - Should we run a newer kernel than our current v5.4?

Definitely. In fact my fuzzy memory points me to some fix, but I can't
remember exactly which fix.

>    - Any debug you think would be useful to enable or add?
>

Tree-checker, which is already enabled by default (in fact no way to
disable) in newer kernels.

Thanks,
Qu
