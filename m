Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6634016E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhIFHWA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 03:22:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:40641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233040AbhIFHV7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 03:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630912852;
        bh=bDmaJmJBvDtKnpfXMUHW0dOckF+GOt7Ib/WsYAd36Oo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c/dmbzDqEbI8AF3qH4v2yikOXWTmkFujrbSHgmIvc9Ru6dr6zxLG0T0EGl3Epa9sm
         AM6Kv+CR+WklbOw0c0/mt60V8ELkZXFbbaSDPkfYv7iEXLqvx7BWUOG/AUZLHH+vIY
         S5gEWDoeOijC3jWlSj+NZnTOwz5UMk3C9+6aCcsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1miVrJ3J26-00oGdV; Mon, 06
 Sep 2021 09:20:52 +0200
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected
 csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
To:     ahipp0 <ahipp0@pm.me>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
 <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
 <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me>
 <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
 <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
 <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
 <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me>
 <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com>
 <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me>
 <7de2d71d-5c75-8215-d5c9-35b4c4f092ca@gmx.com>
 <C5tOxTE7_J1eoIcALQiUE09PG9c3gVTon54gyKHZRgDJlTI0QOVoff0zeu2REq4iHD2cWwsVmIbMTmxnBUW3Uv4_grN69kCgSRAXcWusVsY=@pm.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4b0164c3-04af-fd70-df20-a728d05d453c@gmx.com>
Date:   Mon, 6 Sep 2021 15:20:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <C5tOxTE7_J1eoIcALQiUE09PG9c3gVTon54gyKHZRgDJlTI0QOVoff0zeu2REq4iHD2cWwsVmIbMTmxnBUW3Uv4_grN69kCgSRAXcWusVsY=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Un4x37S1+RwXpj5+nc/GbAEX+3UlpU1ViSWUYknxZCdA39bq8Wx
 RZj0ARQjfPClQsJmh38bLeHVySJk1yqfYhf5YUY7B9I4/MNwAr73fZEJXfPvwYvoXqJ37QZ
 ydtX0HUkre7pnvcmTFQz2RBGzR7Ux9taRg9PIZIe5nqNDjM51KoMATKVJRCCNUq3bddBPkA
 L4tLmH/PqsVdwwwlHioMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kB/1Z9fTMxA=:RybvO+vvBdNrUIpk1bnED/
 /Nfpl+kkwfSsXDdzX6JP8S+k8K0nzQojJ6NsdbZy2JPpryyW1AmU2Uti+M/M6q0qP+cd2U/28
 cIQCVd24vUc2PZhLeGpmGFYUvYn2fXtXmWaqZSRlbjVLg4euS0x5oudiAOq/juhMQ2p2Xuz72
 TJHomWJ6DIfMEGna3QtiWz1r4zHftnaKOlR2TUYLiZCX66lHgvpKbwq6QVOQD4h83NaINxhNT
 6WCg5WjdXNeVT8dQa5PZS208QGG0VFD33nseu9lP37WhtXQNzpFdKf7oCwm60l+PDc6XNLbyG
 JYbnk0WjaNpLHwR9Fb14VEBXaTDYp10qI8LENnXovG/rwV5twhhvGh5rQXkxXWRJ98dKBWNoh
 3z8Qx3K5eJFUqwpDBeyNPNwvt8uZOE/C1vzOcSpnLZkkGQYdgyWcgpVVhY1A6R8WXn+GdShyS
 HkL8A59nQz5nQ4rUd6jxbFrDupup4SfK7VEh1MqQdudcQzePG85H1PpRA7y/Vn5NLLZg7xfKD
 VDUZxtPWhR21TcVXKEsS3f4l6m6YZ3HKGaggByDLQ0zd/J5cLBZcKyP3TGqW7wo1J/IKl7ir3
 q5m1XBM4luYwcnbYS/Ymhc9nic2DRoGjv0xb+TxTznGpHBR3XnpLOFH154BmP4kaCpqT4m7uC
 2pAiNKo70Pm4CnvU0LlIFmAagY2cW6VO/RMKePPOax4FjtCGlGUKE2du3gCHqDN01+Po0g//H
 0MCkNoe8Uz6veKw2WH9q7odRtlgWl6CB4Rgr5Oo5Z8xgfY+l4k9G/o9qXuCOpaTuVCQdV8v2n
 MI57dr/OlAMi6HI87Lc8L+HShpe1sT9VJ6uGh07rrXZN+eulX9wO4yFcirEE8PJeaJtJMmY2b
 p3qoMqgtpeeu+FicRkgkESGTAshemZoo3MO8yqqVny7DtxpHQuR5URkFDr/tkh9bJR7fvTk9+
 oIjdMB3oIQbFx7fD7FerGzS0+zT3tcHxUzNQv0qHRX8uZSuyEKwopACgSNI29Tu+Bby6r4zOs
 F8av79HEv7JpY3MR5Gx6EaG1TQm63osL3cWilY1PS1vBt+TkcazazlVC4de+eg4CbVhY/9pwU
 NbkCHQTI+H70+R1hZg00U/0diqgi8VmoBp4yjrurtIpAjs1HXstkE6KoA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8B=E5=8D=883:00, ahipp0 wrote:
[...]
>> Nope, the original corruption looks like some bug in btrfs code,
>> DUP/RAID1 won't help to prevent it at all.
>
> Oh, even RAID1 wouldn't have helped?

If btrfs module determines to write some corrupted metadata back to
disk, both copy will contain the corruption, thus RAID1 won't help.

RAID can only help if the real problem is disks (either missing device,
or really rotten bits).
>
>> But v5.11 kernel (and newer) can prevent such problem, with their
>> boosted sanity check.
>
> That's great!
>
>>> Would it be generally advisable to use it going forward?
>> You can use the fs without any problem.
>
> Nice!
>
> Is it generally advisable to use DUP profile for metadata and system goi=
ng forward?

As a generic idea, have more duplication for metadata is always good,
even if you're using a SSD.

Thus DUP/RAID1/RAID10 is always recommended for metadata.

Thanks,
Qu

>
>>
>
>> Thanks,
>>
>
>> Qu
