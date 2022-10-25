Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2C60CA4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiJYKuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiJYKuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 06:50:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1F33A1D
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666695005;
        bh=o9hS3GC29gJ7UPrNzjjNBQ+t9/SlrSbE4DuLNGp+FXw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=axpLhkGELwCXxj/gNNlu6MTHxLak5fVbequTmHJmrRQwodAkuZNITMfElIMtdEMzW
         EY3ZbP6KROGVJSBf2IqiEG0rqC5F7Gs9uNAEkdj/qgxYgwlc7mc03F951z/C+TW3Kr
         SdhRDUSziKFKug9Na6K3z0cxsMMm62sP3aXKLRaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1pQ8dS1Fxq-00n61g; Tue, 25
 Oct 2022 12:50:04 +0200
Message-ID: <4f9dd222-6e6a-9f6a-d216-df54fdea6033@gmx.com>
Date:   Tue, 25 Oct 2022 18:50:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: btrfs filesystem becomes read only
To:     Abhimanyu Saurot <saurotabhimanyu89@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CALyjvZsgYXkDXKbNhNYrsbVE8rx3nGwy8fAD6gxredq0_ezNoA@mail.gmail.com>
 <CALyjvZu61NNDokqaHxDvMOwXpsdgkd0SrR4+PPb5Nee5BBtprQ@mail.gmail.com>
 <37b27805-a229-6734-72e0-aa7513145e57@gmx.com>
 <CALyjvZsjq_OS=rjo3dW5d-pqfi+v+ofAChoTMKR5bGKDRYGavQ@mail.gmail.com>
 <3f94d330-7ed3-8f1d-ea4e-ece46efd15e5@gmx.com>
 <CALyjvZtfNrwOa=Bdhtiohh+Raa678ZJgCUpkG=P5c-m=oKYxbQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALyjvZtfNrwOa=Bdhtiohh+Raa678ZJgCUpkG=P5c-m=oKYxbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVUxoyNB6m78CDVu+H45+vBG1z3qJZLMUp1UId3YCR0XQffrDw0
 LwlQQOB9ISS6MTxQUjPGQpOjgeENiufAZSCHEdPBoP7G6axd9bt5kDXzTiRiijqj+EyZUEU
 bIN25OZ/ZMfMMSQT1cMSiM6OxwKkYzpSS9OZlvq0C7O1RuC7UxRm9ootq1OQRQr6G47v2Wk
 SyaBEJOe9Me9MB37Oiarw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjkj5giD1HY=:aR9CO+v8yR7nGQaDJwahHf
 D8xSzTpIsGImyeUvJtNH//kuTBmfjSkFcUkPU+NPuVtwMI36VBiwoyXpteyeO9e4Lw2sH8cx0
 KfmE5J/A2vuLrTggaisK1UNxp0sNoKJ3oN5zkskG7wekmZafvemGTZaZWWaTHsX6dZA4Gau2N
 5dc5u8stOuFz4hyEbxkHaL1wVXP6eNEu0z+vyzMXqAens2WmNxv2xu+x0JR0X6raroZO2k3Ej
 T06HZ9gCKtm9TlPsxWmx8M0aLDkYr8ER5y018upp5BgiPXTxxfw4jiJgka5OZUm7INvi1xfdp
 CCIqCc5iLHFfY+wTt+LPhgqcH7JjQnWf6iIeZKNAU5a/lwz3+dvmZXG2Xdts3APp8K9xvc5iu
 tQm11u4TlEk/WGhrb7mimSr6FQcVZbGbm+cEHR9xDJV1jgtQfYBTzv7WXE4BwL4d361cPJIOi
 voWPjRJt70t/SWaGbD9+Cm6P1AgunWJbw4D9t7/vqJZGqcWWCISuIJxW51aNYFqkQfYSgf3Qc
 SnzFNgol9maB9yj4bQeooZE3gBcuG5OyC+bDqluhIknS4ob/zFlibEzf2IGOWMaTQpmEpcfCo
 OWD0mrMDtxFO9ub5494AH/KfszJhXXnbeHb+TSaESdViEX0B59z5E56/OMb8JFYfY5AR0bTrR
 aFJeBRC2Y68s5bNTahHSWqXvUUjB4T73o0GXG8dQhYR1Rn0bLoOVle6VYTlJXNKWffuNi8I5S
 FldEYGooe2CSjsJ1alUhYupZlmEu8puu30/X7rmLEMffY6OCoHj2lyeissU/BzpcdrZurgnE0
 12FxU0fVMqyUBG4GPnpgkDGhDltyOlvUJgbCHiLtzJTefRGNrZRaOZsYGwSmmA+Pb5UwAkw3i
 NzlT4M9C5X6PbtXbvD3SeJYvkavHGzu9TMlySQ6JhYrVMEah7eVB11D+tWqqgPn9QZiCSXuCN
 +U6RQu62yPWQzH7d7pBLYjR6a+mfSHI7eVGjerr+E2ZTm54vSv7RPbBSKT0anIPldHahlYU75
 ZbAFklVNQuh9T+nyDdHGisCO7ou9CfYdyLmks55lj56OMBbJY5Smml7t68DjYTIMKmEDfhO87
 MVcViddJotXfRdoeU3HfMctzoaVbSTVNB11pjVS5Q+xZ3AX0LpeKekyEYXmZ6S9U9ZJJmBvuM
 wl0RPVyYOhKoVXGZBtcKzodxy5PRhQWRspxV0tLrABoPm+0ecgcwFvuTD71PEL4DAUYydbLk6
 4/cjnHYb7DCSNYxMlAxv2CxrsKMSlB45SVmathLR++SjtyqhyMh3/md/A86m5dI1TqUq49UF7
 Kls/ckGcvrdcw3RpwFrcyaZurI54oaShO+1UXUj+oF2jto6AcTiFfI/JWRUuaaOXgc6DbOZoZ
 1oDkj6PGQz6xXNg6qhJe8nwsdbLgqxIQOvohQdieULCBvUyQjlvlHsKBMlV83eqUkyQ54NLR5
 cjCzWLAg88VrA1j2bKrZoJf5Y7gE60y+Zt3dfJSYq/R2R3wwZEw8EzT1RMzk0UITecO0A95ce
 2RU39QWUS++3vFKqsgBamEXmTE+cnmK4Fl58HncqSaQsW
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 18:17, Abhimanyu Saurot wrote:
> Hi Qu,
>
> Thanks  for your response, I shall check what is the latest LTS
> is it possible to upgrade btfs without losing the data ?

Sure, upgrading kernel should not cause data loss.

Thanks,
Qu
>
> Regards,
> Abhimayu Saurot
>
> On Tue, Oct 25, 2022 at 10:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2022/10/25 13:50, Abhimanyu Saurot wrote:
>>> Hi Qu,
>>>
>>> Would it be possible to let us know what would be a good kernel match
>>> for this distro ?
>>
>> I'd recommend upstream kernels.
>>
>> Like the latest LTS kernel.
>>
>> Despite that, you may want a much newer btrfs-progs (e.g. v6.0) and run
>> "btrfs check --readonly" with the fs unmounted, to catch any metadata
>> corruption first.
>>
>> Thanks,
>> Qu
>>
>>>
>>> We have 2 more setup with same configuration with difference in amount
>>> of data(less) however no such issue is observed there.
>>>
>>> Regards,
>>> Abhimanyu Saurot
>>>
>>> On Tue, Oct 25, 2022, 01:56 Qu Wenruo <quwenruo.btrfs@gmx.com
>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>
>>>
>>>
>>>      On 2022/10/24 19:11, Abhimanyu Saurot wrote:
>>>       > Hi Team,
>>>       >
>>>       > We have installed btrfs on our backup server having a 1.2 P pa=
rtition
>>>       > formatted using btrfs.
>>>       > This partition stores the  data which is backed up from a diff=
erent
>>>       > folder mounted on the same server.
>>>       > However we see that btrfs filesystem become read only quite
>>>      frequently
>>>       > and we can do anything but reboot the server to recover the
>>>      filesystem
>>>       >
>>>       > We tried to run balance on the filesystem that gives some brea=
thing
>>>       > space however the issue reoccurs.
>>>       >
>>>       > Would it be possible to help us fix the issue ?
>>>       >
>>>       > Details of system:
>>>       > uname -a
>>>       > Linux 3.10.0-1160.el7.x86_64 #1 SMP Tue Aug 18 14:50:17 EDT 20=
20
>>>       > x86_64 x86_64 x86_64 GNU/Linux
>>>
>>>      Heavily backported kernel for RHEL7, I'd say please consult with =
your
>>>      distro vendor instead.
>>>
>>>       >
>>>       > btrfs --version
>>>       > btrfs-progs v4.9.1
>>>       >
>>>       > btrfs fi show
>>>       > Label: none  uuid: b6d915e1-47c6-43ed-9f6e-eed2dc4309f3
>>>       >          Total devices 9 FS bytes used 312.06TiB
>>>       >          devid    1 size 130.96TiB used 34.74TiB path /dev/sda
>>>       >          devid    2 size 130.96TiB used 34.74TiB path /dev/sdb
>>>       >          devid    3 size 130.96TiB used 34.74TiB path /dev/sdc
>>>       >          devid    4 size 130.96TiB used 34.74TiB path /dev/sdd
>>>       >          devid    5 size 130.96TiB used 34.74TiB path /dev/sde
>>>       >          devid    6 size 130.96TiB used 34.74TiB path /dev/sdf
>>>       >          devid    7 size 130.96TiB used 34.74TiB path /dev/sdg
>>>       >          devid    8 size 130.96TiB used 34.74TiB path /dev/sdh
>>>       >          devid    9 size 130.96TiB used 34.74TiB path /dev/sdi
>>>       >
>>>       > btrfs filesystem df -h  /hpc/storage/nlhtc/fs-htc-002
>>>       > Data, RAID0: total=3D311.47TiB, used=3D311.46TiB
>>>       > System, RAID1: total=3D32.00MiB, used=3D12.59MiB
>>>       > Metadata, RAID1: total=3D612.00GiB, used=3D610.29GiB
>>>       > GlobalReserve, single: total=3D512.00MiB, used=3D29.00MiB
>>>       >
>>>       > Regards,
>>>       > Abhimanyu Saurot
>>>
