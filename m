Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E738649BF86
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 00:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiAYX3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 18:29:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:53167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234780AbiAYX3g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 18:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643153369;
        bh=AUq1IcR0HBrC2X36s1GtCc+auNv60VQqrXMTMnbTORY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jznmwCYrClSgpfUf5plvyGfICAWfTke5iMfmYS08MGoBQELKMZfnDKt3h1iEAcWfy
         Ap8JrrE/fDo3rx9ADpfLhJ/j50QyajUlet2XLA/L2Zvxk8R0DPPFNEdmCNx3hl7c1y
         fnpA9wUTDaRArhfu/aTcSIm3c2TjHpI7OmHuqp7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRfl-1mfeL32t7B-00bpSG; Wed, 26
 Jan 2022 00:29:29 +0100
Message-ID: <9e8e325e-2a3b-0a6d-7df0-56ff0f526325@gmx.com>
Date:   Wed, 26 Jan 2022 07:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
 <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
 <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
 <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com>
 <CAEwRaO58oCzY4GjU3gCSru3Gq02GvGSdkg5hPwCKMwYcZ+cM2Q@mail.gmail.com>
 <c88c1438-ebcf-a652-1940-4daa4ee53be9@gmx.com>
 <CAEwRaO6ogPZKU3pcKac2kMqpvwDRX4eCUnFj0_OxTndPF2Be_w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEwRaO6ogPZKU3pcKac2kMqpvwDRX4eCUnFj0_OxTndPF2Be_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Z9IA5sjFvYkCri5LGDKGY0A7PZEaEVPjQGzdNAe4dkxrFtw9hs
 557K239hxXDTlhKXvFY81+nXWLmnhcIormtTrfJb/h8RXfzyuC5CoqEQhgG95WPaz5H8g5r
 QpjMyLa+fsbXHPdk2c5yK9Nr0KHM+ccBvFKI16sOSfUrGdbibdggmvPWy0gstr6kMXN/N1t
 BHcNhr0RtmyD99UUSOrxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHqqhMeAPMU=:c2njtjLZk1LzC4yGLclDlO
 60YPxWUdu8uV6S5++Vm9GJ8Tb8bvdHV37NjuRPpSzdqJkhRc8k+5CY5+J7sIhY+xfJh0H/5wv
 TwciT7Ont+xmMmX/KfoSB09vQwmJnLUITXf7mgYqwaklyDG9SlpGLzV3SPlJ6SzSveyoiOOT+
 nkSNYl9o+nLIt+XDIdRi9Jx/K7UpTxuzN/hTDRz2wtsDBANULGBLcsX8Tjj782ZRFvo4VKkMD
 fSr6YYuQdHgr7sr3bH4YIK7KcDG9hNZtqxBrcHEQfRC6zlmuJnctAzFx07POs5W1RQxJHdz/u
 o/IabOb6z60fKyh8FWqBViUFLN6jhdKrwX05kwIv4n6KM6SNLYQgBxviwCZXmSwsV2dN5LrjF
 SbqBOFhZNHaoPzjUeoJpbEWaI/IsBpeqn1g3/HdlXzslk+e9efHsw6/9HyIRo0vJermUUVRUs
 jLqqYBnge+q15QqEDQj4F2ZjgxHyCHj1FiyguD89FBnwqe/NEVBmYOCdqEXen5M0XwOt+e6OI
 CsW0CH8Xq895Yq443C9R0xYgri1U8Sxyi6Iq+l29f1H90T4N6ivFQA/uRCBlHWpgo1ErngW10
 99y2+oVB7nr1gM8b6vDxvDkg4uOpoL2li1C740Q/4xJoroJqtj2y9SJ1vvFjrptVqJRojmVgV
 rdgbT79z63RZDExDkTzBdo1ENzqu1SmJug7mGrB9wEEnqNrNDqlLHvTjqwU8XJLTG8iGqymDO
 IqjkZ+DClwnJyfMnUz5aDSXakQP55iAmhGS6NzNEJMG7Aw4GuM6CVl7u7ZETfMPv9z0+PGWeE
 stH8YxN1yxeeFqec09BYvO2hvfx8+QXADZWxOylkY5UMfJfqu5bnJM+ZSgbxGsX2XdZ1/VpOW
 BQLqfF/ByefvsjNO9LlC/5cG7BwSOuBY6eFaa0aJmyZrN4DOOilzBwToy5XDps1i+isYgQ5aU
 icw8n1QbDbD0wR7yagd6heyz4o+o/CLzSNul5XMG510AHBzOnin43fTXWIhfDfYmsJX6jcpFW
 l3cUy9jpauPtuzvFvMZdjdtYnIE5gso37aKLK74pr9MpR8ToW8CMP6KIKFqQynd6pjgPoOX5z
 PmlD4pJhr7kyFk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 04:00, Fran=C3=A7ois-Xavier Thomas wrote:
> Hi,
>
>>> Mind to test the latest two patches, which still needs the first 6 pat=
ches:
>>
>> Gotcha, I'll test the following stack tomorrow, omitting patch 7 from
>> Filipe (hopefully the filenames are descriptive enough):
>>
>> 1-btrfs-fix-too-long-loop-when-defragging-a-1-byte-file.patch
>> 2-v2-btrfs-defrag-fix-the-wrong-number-of-defragged-sectors.patch
>> 3-btrfs-defrag-properly-update-range--start-for-autodefrag.patch
>> 4-btrfs-fix-deadlock-when-reserving-space-during-defrag.patch
>> 5-btrfs-add-back-missing-dirty-page-rate-limiting-to-defrag.patch
>> 6-btrfs-update-writeback-index-when-starting-defrag.patch
>> 7-btrfs-defrag-don-t-try-to-merge-regular-extents-with-preallocated-ext=
ents.patch
>> 8-RFC-btrfs-defrag-abort-the-whole-cluster-if-there-is-any-hole-in-the-=
range.patch
>
> After testing this one immediately reduces I/O to the 5.15 baseline of
> a few 10s of ops/s,
> so your hypothesis does seem correct.

Awesome! This indeed proves the major IO is from more extensively defrag
behavior.

Looking forward for the v5.15 POC to get the final nail.

THanks,
Qu

>
> Fran=C3=A7ois-Xavier
