Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20D31E3D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 02:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBRBZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 20:25:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:38937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBRBZp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 20:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613611451;
        bh=uJKVrDCNC3Ou+zmPXSUmidana0VXD1mAN+MoYJZ00v0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Wp7SmiD4b60JLMYlOp+oxhw9hFor8eMkUcLbHtBAYc+xA79kk6aERFgcEkc5/5DEg
         pV7SzhQU2HjvXnaDl/3hW978FrKKwTF/SqlAu1SXBL3twpM0io/vexwKo0rQdCYsxs
         ILhGgbFOejpx/nBT7GXbxt+fUy3Y+LvwAfoNnBD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1lkmwH0kFj-00bJT7; Thu, 18
 Feb 2021 02:24:10 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
 <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
Message-ID: <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
Date:   Thu, 18 Feb 2021 09:24:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
Content-Type: multipart/mixed;
 boundary="------------17310917CF7DEDD9A2734AAE"
Content-Language: en-US
X-Provags-ID: V03:K1:tDO2ADfiylVXdqHGeLDTFetVXkuqdeKY9gJng1gtTCbGMiUGrwB
 KCiQDFIeqRnJoX65GGCC2bDaOcr3sBlkQzIhW1EClPTcg7N/XeXlDTaOk/y+fZ+rQdeshfC
 YIuAeR/QjlUK99OaRmhgWeWn2UK0fvGMzxWjdzPXZIKGCEhOJa2J3+wdsiKHtNVeCdSvdhN
 9nF6zC+8234AZHQmDHsdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0d0eRYOEfl8=:T9j8xc0LxYwgJopxgZM2u/
 SuoJtTqm1Mf2R4KAWHpTZUzUE7RKirgNcSSNJoDJzjUZLNNpvOHnryW15QmEN9RXa3D1FURi5
 r7wlDEkQvgHj2EESVewh5dmYb6BpAtat6S9h0f5GCWx6Vo/O89aa+9f3vlgbmggT4AxqoXLnf
 TagzSp2bCQL3LxtBjlv3Ovdx2tw5p0WgDYuywqtPDbMgngp/v+Y5NDH4KPzpUSgMLkp2CJ6VK
 CsBu31q58WqMBf3ztIpkzEnAdeQa3dLRBjspqoVhSQsBI1K4toZthYTkXARXF58vJPxb21mYC
 KFLsul6kjquuIszwY8L6QbmaHx7VxOmMk67SoduhEVWzENSsN4TekaOl+P+U/WBKXB2mU0v8j
 Z+dv0HsUOHxyOOYinPrrKtVlyhiHr2vUi7puKROqoIkRt5nuFL2suZfcZxW3RICwpF6gDs4T9
 2ehUKP80mO/u1m/igpqzhhXDCJGOxHxPP+Vnp3rL6TtMWTihm7N1XCddI9BpZ9vHXdgrptRBu
 ec4bChLJ6jfO1ioDhXPCG8BcoH9gDxtNeFF0egMy1qk3Jb0WypufZjB2vUX6wvY/BR2qP8E4j
 9RClU2RyyPa+pGekSCWJf4/myHhtpwEpXb50dh8/o+43e+osT3J1ZiKCrtX6axhZcRNlBaLvf
 /eKbvfdW1y5hw2+3GB5jjmuePFJ/z71aNLUeVqHiSJK4ChbdEfdokYBwZ9PUau1LlwRYswy7V
 KCsrPbN4jUMPz1fkWO8F97xEqDFlClifCfwd+BJQwBlwjjU2UKOJuRifmGOatL3D72IEJbrTk
 5UJdOOLtWmI5XCbEfNHzvdjXu49c/2nYsJYk6BTtqaWZBS26SjzThjmRWDSAIK/7OduEpv0b4
 7htKQyDrDRGhq09ei9ZA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------17310917CF7DEDD9A2734AAE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/2/11 =E4=B8=8A=E5=8D=887:47, Qu Wenruo wrote:
>
>
> On 2021/2/11 =E4=B8=8A=E5=8D=886:17, Erik Jensen wrote:
>> On Tue, Feb 9, 2021 at 9:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> [...]
>>>
>>> Unfortunately I didn't get much useful info from the trace events.
>>> As a lot of the values doesn't even make sense to me....
>>>
>>> But the chunk tree dump proves to be more useful.
>>>
>>> Firstly, the offending tree block doesn't even occur in chunk chunk
>>> ranges.
>>>
>>> The offending tree block is 26207780683776, but the tree dump doesn't
>>> have any range there.
>>>
>>> The highest chunk is at 5958289850368 + 4294967296, still one digit
>>> lower than the expected value.
>>>
>>> I'm surprised we didn't even get any error for that, thus it may
>>> indicate our chunk mapping is incorrect too.
>>>
>>> Would you please try the following diff on the 32bit system and report
>>> back the dmesg?
>>>
>>> The diff adds the following debug output:
>>> - when we try to read one tree block
>>> - when a bio is mapped to read device
>>> - when a new chunk is added to chunk tree
>>>
>>> Thanks,
>>> Qu
>>
>> Okay, here's the dmesg output from attempting to mount the filesystem:
>> https://gist.github.com/rkjnsn/914651efdca53c83199029de6bb61e20
>>
>> I captured this on my 32-bit x86 VM, as it's much faster to rebuild
>> the kernel there than on my ARM board, and it fails with the same
>> error.
>>
>
> This is indeed much better.
>
> The involved things are:
>
> [=C2=A0=C2=A0 84.463147] read_one_chunk: chunk start=3D26207148048384 le=
n=3D1073741824
> num_stripes=3D2 type=3D0x14
> [=C2=A0=C2=A0 84.463148] read_one_chunk:=C2=A0=C2=A0=C2=A0 stripe 0 phy=
=3D6477927415808 devid=3D5
> [=C2=A0=C2=A0 84.463149] read_one_chunk:=C2=A0=C2=A0=C2=A0 stripe 1 phy=
=3D6477927415808 devid=3D4
>
> Above is the chunk for the offending tree block.
>
> [=C2=A0=C2=A0 84.463724] read_extent_buffer_pages: eb->start=3D262077806=
83776 mirror=3D0
> [=C2=A0=C2=A0 84.463731] submit_stripe_bio: rw 0 0x1000, phy=3D211873570=
8160
> sector=3D4138155680 dev_id=3D3 size=3D16384
> [=C2=A0=C2=A0 84.470793] BTRFS error (device dm-4): bad tree block start=
, want
> 26207780683776 have 3395945502747707095
>
> But when the metadata read happens, the physical address and dev id is
> completely insane.
>
> The chunk doesn't have dev 3 in it at all, but we still get the wrong
> mapping.
>
> Furthermore, that physical and devid belongs to chunk 8614760677376,
> which is raid5 data chunk.
>
> So there is definitely something wrong in btrfs chunk mapping on 32bit.
>
> I'll craft a newer debug diff for you after I pinned down which can be
> wrong.

Sorry for the delay, mostly due to lunar new year vocation.

Here is the new diff, it should be applied upon previous diff.

This new diff would add extra debug info inside __btrfs_map_block().

BTW, you only need to rebuild btrfs module to test it, hopes this saves
you some time.

Although if I could got a small enough image to reproduce locally, it
would be the best case...

Thanks,
Qu
>
> Thanks,
> Qu

--------------17310917CF7DEDD9A2734AAE
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3ZvbHVtZXMuYyBiL2ZzL2J0cmZzL3ZvbHVtZXMuYwpp
bmRleCBiOGZhYjQ0Mzk0ZjUuLjk1YjQ4MTVkYzA0YiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMv
dm9sdW1lcy5jCisrKyBiL2ZzL2J0cmZzL3ZvbHVtZXMuYwpAQCAtNjIzMCw2ICs2MjMwLDgg
QEAgc3RhdGljIGludCBfX2J0cmZzX21hcF9ibG9jayhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywKIAogCW1hcCA9IGVtLT5tYXBfbG9va3VwOwogCisJcHJfaW5mbygiJXM6IGxv
Z2ljYWw9JWxsdSBjaHVuayBzdGFydD0lbGx1IGxlbj0lbGx1IHR5cGU9MHglbGx4XG4iLCBf
X2Z1bmNfXywKKwkJbG9naWNhbCwgZW0tPnN0YXJ0LCBlbS0+bGVuLCBtYXAtPnR5cGUpOwog
CSpsZW5ndGggPSBnZW9tLmxlbjsKIAlzdHJpcGVfbGVuID0gZ2VvbS5zdHJpcGVfbGVuOwog
CXN0cmlwZV9uciA9IGdlb20uc3RyaXBlX25yOwpAQCAtNjM3Miw2ICs2Mzc0LDkgQEAgc3Rh
dGljIGludCBfX2J0cmZzX21hcF9ibG9jayhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywKIAkJYmJpby0+c3RyaXBlc1tpXS5waHlzaWNhbCA9IG1hcC0+c3RyaXBlc1tzdHJpcGVf
aW5kZXhdLnBoeXNpY2FsICsKIAkJCXN0cmlwZV9vZmZzZXQgKyBzdHJpcGVfbnIgKiBtYXAt
PnN0cmlwZV9sZW47CiAJCWJiaW8tPnN0cmlwZXNbaV0uZGV2ID0gbWFwLT5zdHJpcGVzW3N0
cmlwZV9pbmRleF0uZGV2OworCQlwcl9pbmZvKCIlczogc3RyaXBlWyVkXSBkZXZpZD0lbGx1
IHBoeT0lbGx1XG4iLCBfX2Z1bmNfXywgaSwKKwkJCQliYmlvLT5zdHJpcGVzW2ldLmRldi0+
ZGV2aWQsCisJCQkJYmJpby0+c3RyaXBlc1tpXS5waHlzaWNhbCk7CiAJCXN0cmlwZV9pbmRl
eCsrOwogCX0KIAo=
--------------17310917CF7DEDD9A2734AAE--
