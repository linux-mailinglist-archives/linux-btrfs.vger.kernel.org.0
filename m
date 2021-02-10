Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1893174AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 00:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhBJXsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 18:48:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:42885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhBJXsx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 18:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613000837;
        bh=A/gPBRst4wNlb8aiZJ0k3EFmUR43ytqeaNfHyS0EvY0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZktAztPXd/8XStDQ8l734FYyoRFpofrpAgCucjgRHRWLQ9Oc1kSTy13ixOgc/Nx51
         BmrZsKRaFj39aKhtoKvgq3sErST/g+LCw8v9kfHh0wm8PMOW+pkLOpuM/meVdKK4Fy
         HTv26i28FmNFq1bQFr16rkTw2mOlV6QYNXS+5AMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QF5-1l9AO12OqT-001Tb0; Thu, 11
 Feb 2021 00:47:17 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
Date:   Thu, 11 Feb 2021 07:47:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OyxQJNMr9vG2dxpfwHhX4dQ5mQi93fP51rMtyfKKhndmnx77vjp
 o7MlLODGF/8ObB7XufuTLVnKXlyNNc1SusESkWdc8k+ulWKY3y4HOKnsW6fXnRsrqfrnoDx
 xV0D4IA9xMp9A4fnpeIlV7XxBxcN0geqD2M5F5pM7h4nMUBZz5DA8Sfd0LvtF3D1bsoJtOZ
 8pfhhJcLFSOGagYfrHJNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5qZ29OmWZgE=:cLfQr+to3EEFnvVu9Hx0ei
 HZSj6W5D00fN7XyBFW3yBAclKVIx2CqCrMl0fvQwGJDih//deCp+R1kjUMOhXtCo3yYiNJtxg
 Vt1TzSfkODua99HB+u/5p/AhNC6Ak1wAfVCru7DGI0O3xGXKAouPPxSmyncAA9hQiTL5jeVpY
 CnrbkiRKFQRESK0blJvNN9Lv+1nv8qXl8LZlgo0Zo1jvW55O5VwHHmTPiLlUY6oyYLu1tjK9o
 P6cdqhAAU0JAv2Z8EnQsPLvToWixj9vhkHywOpBWm8NTVn4yqRkIqZHAKCfzG2mT1hNMnIXsf
 sgiempe6+NOeHLF/4DYc6u9S+hv+OTnQrcM9Je5J2pw8mIUJM/COeoD6fsYAMtloI8lCcX1WF
 ByY0BLKSktknyM5TYPDTXtfscNiTxjqoxquQjZxixq5BGzoQLmfjK0D3q9HXcRaIRf17EbYqe
 yGdKeIMLrEidyXWXYagdzpUmEU/jB9v1/fnlQCyI3felMYdyJhg3j3dYGjm9pb9ENjjq40z/9
 Mlvt1hQEz6zGD80DjWs9l88i1sm+6PJh3wn254L4P87yb7ncHlAfP6Pk7RCyZsXMf8BI48Pt4
 E+TPvRLqRct5Lho5fSMyp3uhmouxyfogwAnu1oILck9AXQVUQuW4gtlGCeJlIc1NbmV7ZJT8X
 J1U5RKT4idZCOJI/WbBOrnIOOxOOznQVZpnv+GVnyvWHwS+s1YryWKqMT7XCYt5GdLLPGopNa
 7zu0xCplaDbfx3NFY/CgOxZUNsPaxVREFnwi+znKIk6+Xjc5Yj1/WC+VtJaZHhlY1FYkvlQk8
 KY8PfpvqGC+Yy7aR5or7hfnyjaV2xAI5JCW3G0pWoNfD4VmHrxgdue+e28V0hm9hVdt9Fu/SG
 gO/xV3Selwjot2fAzCJA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/11 =E4=B8=8A=E5=8D=886:17, Erik Jensen wrote:
> On Tue, Feb 9, 2021 at 9:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>>
>> Unfortunately I didn't get much useful info from the trace events.
>> As a lot of the values doesn't even make sense to me....
>>
>> But the chunk tree dump proves to be more useful.
>>
>> Firstly, the offending tree block doesn't even occur in chunk chunk ran=
ges.
>>
>> The offending tree block is 26207780683776, but the tree dump doesn't
>> have any range there.
>>
>> The highest chunk is at 5958289850368 + 4294967296, still one digit
>> lower than the expected value.
>>
>> I'm surprised we didn't even get any error for that, thus it may
>> indicate our chunk mapping is incorrect too.
>>
>> Would you please try the following diff on the 32bit system and report
>> back the dmesg?
>>
>> The diff adds the following debug output:
>> - when we try to read one tree block
>> - when a bio is mapped to read device
>> - when a new chunk is added to chunk tree
>>
>> Thanks,
>> Qu
>
> Okay, here's the dmesg output from attempting to mount the filesystem:
> https://gist.github.com/rkjnsn/914651efdca53c83199029de6bb61e20
>
> I captured this on my 32-bit x86 VM, as it's much faster to rebuild
> the kernel there than on my ARM board, and it fails with the same
> error.
>

This is indeed much better.

The involved things are:

[   84.463147] read_one_chunk: chunk start=3D26207148048384 len=3D10737418=
24
num_stripes=3D2 type=3D0x14
[   84.463148] read_one_chunk:    stripe 0 phy=3D6477927415808 devid=3D5
[   84.463149] read_one_chunk:    stripe 1 phy=3D6477927415808 devid=3D4

Above is the chunk for the offending tree block.

[   84.463724] read_extent_buffer_pages: eb->start=3D26207780683776 mirror=
=3D0
[   84.463731] submit_stripe_bio: rw 0 0x1000, phy=3D2118735708160
sector=3D4138155680 dev_id=3D3 size=3D16384
[   84.470793] BTRFS error (device dm-4): bad tree block start, want
26207780683776 have 3395945502747707095

But when the metadata read happens, the physical address and dev id is
completely insane.

The chunk doesn't have dev 3 in it at all, but we still get the wrong
mapping.

Furthermore, that physical and devid belongs to chunk 8614760677376,
which is raid5 data chunk.

So there is definitely something wrong in btrfs chunk mapping on 32bit.

I'll craft a newer debug diff for you after I pinned down which can be
wrong.

Thanks,
Qu
