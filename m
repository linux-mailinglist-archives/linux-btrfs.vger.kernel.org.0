Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4369A550A62
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiFSLvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiFSLvf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 07:51:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF431209F
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655639492;
        bh=1t5AVtBUyJiU7L2IbzrjQ73yAePj1UFtO7k/eR9G9to=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Wq9N9CQ/08amRKA53qSWVe6tooAmvTDVu0kBdEDikP7g5m6xfYItz3g/Mo4SsCYKD
         9hH3rZIaGRvdonc6hbb3BVoADgFehMI/3Xv8S4P13ASxV93DHl14rEVadix/rh5JFa
         9fHzj5u21vLMyhMZZn6lWf4WgXvURbU6WmF7yLTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1o4HJR46Xb-007RBt; Sun, 19
 Jun 2022 13:51:31 +0200
Message-ID: <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com>
Date:   Sun, 19 Jun 2022 19:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
 <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
 <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
 <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
 <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
In-Reply-To: <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OY/0iVHWQV8A6nMWZoobwDFUVczn2nL9M8Qzm06mbWzhXgtsUI4
 Kmmn+cCP3GR4fGZdkHL/sWT8wrIJ0W0t39eDCgexfvk/q9Lh6xDOqC/MwNY7+oH6JpHqbVr
 0sGDcXdwEXSXJS6y3bLN8y4W/IQg2iqPDM+KE6oLdUyUM2qF8xdAMPiom11PhEFuS20br+Y
 /zoc0g+RJhsbKJ2ubF/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WFubJditPCU=:OgE1fF15FMhPepuwiIPUCt
 HZEA9wB7N14rFFmmcWqSzMeyQB5uVP49PMc4ilOQZqZU/NimlyOtgjHmw/frktaFGJli1cOaI
 xVpDM0WRUuovjYJ8RlOsdwHKxhH50TIciDSJODN2xlt9lLX/sxKZ+X03rNXY7sx+fslCiJYRr
 BrPiRZ+22YgFScJdKkjKttClf8N6f5iXDO49GmLCZtOGr36sdHnrtiAyj0//k0QHNiKYC1rZF
 4ng9IDH3RFv3fWZE1XM+y1/CIoXs7ucTeaLhf0+X6+fdAFtdggazaxPg71Y/ZEnqotLQ9FE39
 8aS/7Ieo1ZXvy/UfTcUROQ9w3i8JEH62hAse5zJxmjzF0XdSMJ2v8SC/GKHnhKhfBL3amdyDX
 HCwv3KBvolJSDwlLZbb4WKkOs+JGRd/MQsrcvtRUFKZb3bHzwzJM0AXyuSOPUvEtyqlF4IuWO
 ojRIgJ+YcltGGrXkNH3IgN48JVy7XJrwbDxe74JroYp6P1tuch1ee0aqCAN6UnxAI2YzIebdq
 w4fMi1u2Bemah/CSVQ6FGbcGb42CrxvZWhjjlGrX6iZImL4mIgCm0gwEY4PMK8CA0W0MhgBcW
 DLfUD/JyBbLp0/aQMYWPqyd2y0BDY1Rhax3xVMejmOF7iHlZW+DHg5+hLQp1lxxJKSGrTkFAW
 TXJGKrwbnyOD/DmtMNmD98kvjqrcTD8YHmDCIkhwLCcpX38PDLlScYyDGS5E1UhpKLPtMub7N
 WXJzwMj01aNPVDEci+F6CvN2Mszi+GI59mIeM8PjvmoEUlQM9Vv2/uPDDAkICJ2Q8zYHKn14+
 l9NIPIPAHIooWZNEywiFwe+aEEwVPfFYNTHdyfMs6bkRj5bge8XYgxKjZOs97B1FkutNpy+D/
 HVPCEnIbPc27+jsT6Pq4G+ZewjR3dhixgp35CThODVyXaDfw7EhIkKhgaPU7ZzWTNmrtTdsH+
 lBEkx5Qo6PfmVatBdfkKE3qegc/iVuC4YxeBZ98pTbTBTharQGerUT27rPcUxa9z8N0aLORFL
 ftOmQ8NvQRNHt4bOFe4JYyZkyE+m/A2VayfJcYrUBRl09gwCp3aTRrgVu+ieH1p/pLkl0o5GF
 X91r70UszSS4dyUZz0DSvz5qlxBaKCOYbK6+mN1ZHKDWC+67l+ylfA8Uw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 19:14, David C. Partridge wrote:
> LUbuntu 22.04 was definitely 5.15 kernel, what alternative distro do you=
 propose I use?

I have no idea why 22.04 doesn't work here.

The upstream commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
skip bad extent tree when reading block group items"), which is already
in v5.15 kernels.

I double checked the current code base, as long as it's error reading
the block group items and rescue=3Dall (implies ibadroots), it should go
fill_dummy_bgs().

For the alternative distros, OpenSUSE tumbleweed, Archlinux, etc. As
they are definitely upstream and v5.15+.

For example, Archlinux 2022.06.01, it goes with 5.18 kernel:

$ file arch/boot/x86_64/vmlinuz-linux
arch/boot/x86_64/vmlinuz-linux: Linux kernel x86 boot executable
bzImage, version 5.18.1-arch1-1 (linux@archlinux) #1 SMP PREEMPT_DYNAMIC
Mon, 30 May 2022 17:53:11 +0000, RO-rootFS, swap_dev 0XA, Normal VGA

If that still doesn't work, let me creating a similar fs with some block
groups items corrupted to see why it doesn't work.

Thanks,
Qu
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 11:41
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger=
.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>
>
> On 2022/6/19 18:29, David C. Partridge wrote:
>> Booted from live USB 22.04 LUbuntu.
>
> Ubuntu kernel version doesn't seem to be that consistent even for its
> LTS releases:
>
> https://ubuntu.com/about/release-cycle#ubuntu-kernel-release-cycle
>
> Please use something rolling released distro/branch instead.
>
> Thanks,
> Qu
>>
>> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=3Dall /dev/sdc1 /m=
nt
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, mi=
ssing codepage or helper program, or other error.
>> root@lubuntu:/home/lubuntu#
>>
>> Content of system journal
>>
>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs w=
ith big metadata feature
>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space ca=
ching is enabled
>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny ex=
tents
>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent trans=
id verify failed on 12554992156672 wanted 130582 found 127355
>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent trans=
id verify failed on 12554992156672 wanted 130582 found 127355
>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to re=
ad block groups: -5
>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree f=
ailed
>>
>> David
>>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: 19 June 2022 03:02
>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vge=
r.kernel.org
>> Subject: Re: Problems with BTRFS formatted disk
>>
>>>> You can try rescue=3Dall mount option, which has the extra handling o=
n
>>>> corrupted extent tree.
>>>
>>>> Although you have to use kernels newer than v5.15 (including v5.15) t=
o
>>>> benefit from the change.
>>>
>>> Unfortunately:
>>> amonra@charon:~$ uname -a
>>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC=
 2022 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Any special reason that you can not even use a liveUSB to boot a newer
>> kernel to do the salvage?
>>
>>
>> Thanks,
>> Qu
>>
>
