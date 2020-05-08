Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3601CA288
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 07:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgEHFH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 01:07:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:51767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgEHFH4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 01:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588914472;
        bh=kEzCEWG7gGTplrZDe0D2+St0aqDAFs9hXR1gwUxvwoI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EvVPH0WsdQtaOcs2nljs402wgaJTjWOvCkNUhufMTP3bDisg3Pzoe6GnVbJhGpiPQ
         U07g0eVaZjc2uIiJQQsNFy1kLxH8aGV7lSbRQlwCTrqgxZeYKmjfEdprSD58aBSRqg
         uviC2vIpP1ysybn7a6beu88rECjfDd4P0U0OTH2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1ineqp2KE0-00jMvl; Fri, 08
 May 2020 07:07:52 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
 <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
 <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
Date:   Fri, 8 May 2020 13:07:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3w5r1w6cRI4AFhgbttUAShL4GXwKxX6aQ"
X-Provags-ID: V03:K1:76dZ1htIqWMYUH/f075pyAcxdBtLJZ6zLw+1sIiR/bQjMj3zzjd
 43U1QTdepFDJJNqepKCYUDjRgyzESBMsf2FGHb+DmtA+yBOWYCTF7yGzImjiNa2ctT3cpGl
 Kga+0dn70DKQMep+KHx37CAv84wMaCBZj1UoHGnLZwL3FzfkDhFbuAikx30yduKbReI1efR
 xBqiB2asN6JNFoKeiZSkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gV/fgf2bu1o=:cOCFBRbXBPKXErJAh7eIzF
 OZaAIqMddqoTsXOjTNOB37GMZ5fHMwVuzE+z3NqtO2mq98ZlYR51zXPSoiuYl7F0OlqhEP9tv
 260pxRv/1YVODc7mNygqb1S3ESRov8Vu457DoCFgUZOzQ51LRJW6d4gCjzhYsQOBENMnmhv3F
 HeCdYkE6avzPaqA20LbgNJfjToCb814M+JIjYLjg5pyfuL4GgMgifq1nBGmfJqt6heKd8WTEc
 oRzW2tt+fiYB6JDdc0wQXE2YDwz9Vjh55z3yttkevfReh6p7HC4BoGZITlk+xIu+ZtcO0aPCT
 7baQOMj07rfDzNEc39pb4w49ntZbyp+p7TdRWSBYxwrhiUrIPmrpxVuptsVo+aIWLmSiNEc/q
 +VvZElxj3BD1frngiMV5uTtd6WGrwMevEruJilraBD4K6bLioPTMgsgvxtH4yBbPTz/9eqjUP
 LZy+E2zmKv5mgjhOU+5x5mBueRMtqXGwcSZrEtY1RNjVj0C7er+cd+XG9C8Qeep/Gw5jrvu+z
 uYaNufpT/88htT7sZYA/C2PA4d/aJO/HdSSauUb5RyU7lhjWCGCXuDeKPnteuz0E8neBLtYdi
 ZSRLzUaLn7dQpzpMbBNRILd5XN8PRNi7/pY4x1IaqAHb6sCudjveVMvOBj/yNt47eZVZc/Zu2
 tw0y5qdK/zKuz34G2XToDWKZYvk9YRGr2thS6xYevos61ihqRRMI9fnbLiTNQ69pjLGrVoEQy
 Dj42zTUnH3bwWsbQQgzHol7RbUjl0R12T5s+ilPLdTM7XvuK4fKWEqP5vYLwQ5c8i5xUPot5j
 rLcxepohS7h30HOveT4X8o7J2uOn4SROoWLFqfj2GoFNfyJCdKq/N8bmTgzQqmEjjI9dxOxha
 fL6n2C78Zd0WfcPa1DpvIhnBYOffDE/h7U5FgX+DnmqaRt3ZlC/fI9Qt6jKz2VmOz8guKA9Pc
 JqwtVX6SlBuzC13xQl5liGWHSqlGcL8hNjMN9zZYgLb969sKWKL4qIPV4LFheLmEC/FeSYCpR
 K4QjflUKTL5SJ16XLPT9t44h5OYY084FQCkR5+W2NXgIsMccBijE6jMCnFmWs/9Xw1OrQAHXh
 wsD2e4Ew7so1Kg8pBO8NHJNZGHd5Aq8Ba5f4hqjSnVqzgkm/WfsHv4F/Zyh1pgOSBSp9xaq7A
 xpu2xsSHoyjDHNiZamJ3ZQ2o9qYWDbKUXRl30WroLtBPilDSXIVdI+4uGMhB3lLhQB4wgdJxN
 jx7A47J7uMBYRdk0P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3w5r1w6cRI4AFhgbttUAShL4GXwKxX6aQ
Content-Type: multipart/mixed; boundary="rr1Phw6W1WEiajpqF0whc78V8b9upHif5"

--rr1Phw6W1WEiajpqF0whc78V8b9upHif5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
> Something went wrong:
>=20
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x6dd94)[0x55a933af7d94]
> btrfs(+0x71b94)[0x55a933afbb94]
> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> btrfs(+0x360b2)[0x55a933ac00b2]
> btrfs(+0x46a3e)[0x55a933ad0a3e]
> btrfs(main+0x98)[0x55a933a9fe88]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b3]=

> btrfs(_start+0x2e)[0x55a933a9fa0e]
> Aborted

This means no space for extra metadata...

Anyway the csum tree problem shouldn't be a big thing, you could leave
it and call it a day.

BTW, as long as btrfs check reports no extra problem for the inode
generation, it should be pretty safe to use the fs.

Thanks,
Qu
>=20
> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
> available. I'll let that try overnight?
>=20
> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
>>> Thank you for helping. The end result of the scan was:
>>>
>>>
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>
>> Good news is, your fs is still mostly fine.
>>
>>> [5/7] checking only csums items (without verifying data)
>>> there are no extents for csum range 0-69632
>>> csum exists for 0-69632 but there is no extent record
>>> ...
>>> ...
>>> there are no extents for csum range 946692096-946827264
>>> csum exists for 946692096-946827264 but there is no extent record
>>> there are no extents for csum range 946831360-947912704
>>> csum exists for 946831360-947912704 but there is no extent record
>>> ERROR: errors found in csum tree
>>
>> Only extent tree is corrupted.
>>
>> Normally btrfs check --init-csum-tree should be able to handle it.
>>
>> But still, please be sure you're using the latest btrfs-progs to fix i=
t.
>>
>> Thanks,
>> Qu
>>
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 44157956026368 bytes used, error(s) found
>>> total csum bytes: 42038602716
>>> total tree bytes: 49688616960
>>> total fs tree bytes: 1256427520
>>> total extent tree bytes: 1709105152
>>> btree space waste bytes: 3172727316
>>> file data blocks allocated: 261625653436416
>>>  referenced 47477768499200
>>>
>>> What do I need to do to fix all of this?
>>>
>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
>>>>> Well, the repair doesn't look terribly successful.
>>>>>
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>
>>>> This means there are more problems, not only the hash name mismatch.=

>>>>
>>>> This means the fs is already corrupted, the name hash is just one
>>>> unrelated symptom.
>>>>
>>>> The only good news is, btrfs-progs abort the transaction, thus no
>>>> further damage to the fs.
>>>>
>>>> Please run a plain btrfs-check to show what's the problem first.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
>>>>> Ignoring transid failure
>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
>>>>> parent level=3D1
>>>>>                                             child level=3D4
>>>>> ERROR: failed to zero log tree: -17
>>>>> ERROR: attempt to start transaction over already running one
>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len 4=
096
>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len 4=
096
>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len 4=
096
>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len 4=
096
>>>>>
>>>>> What is going on?
>>>>>
>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.c=
om> wrote:
>>>>>>
>>>>>> Chris, I had used the correct mountpoint in the command. I just ed=
ited
>>>>>> it in the email to be /mountpoint for consistency.
>>>>>>
>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>
>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I looked up this error and it basically says ask a developer to
>>>>>>>> determine if it's a false error or not. I just started getting s=
ome
>>>>>>>> slow response times, and looked at the dmesg log to find a ton o=
f
>>>>>>>> these errors.
>>>>>>>>
>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>> [192088.449823] BTRFS error (device sdh): block=3D20351094083584=
0 read
>>>>>>>> time tree block corruption detected
>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>> [192088.462773] BTRFS error (device sdh): block=3D20351094083584=
0 read
>>>>>>>> time tree block corruption detected
>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>> [192088.468457] BTRFS error (device sdh): block=3D20351094083584=
0 read
>>>>>>>> time tree block corruption detected
>>>>>>>>
>>>>>>>> btrfs device stats, however, doesn't show any errors.
>>>>>>>>
>>>>>>>> Is there anything I should do about this, or should I just conti=
nue
>>>>>>>> using my array as normal?
>>>>>>>
>>>>>>> This is caused by older kernel underflow inode generation.
>>>>>>>
>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
>>>>>>>
>>>>>>> Or you can go safer, by manually locating the inode using its ino=
de
>>>>>>> number (1311670), and copy it to some new location using previous=

>>>>>>> working kernel, then delete the old file, copy the new one back t=
o fix it.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>> Thank you!
>>>>>>>>
>>>>>>>
>>>>
>>


--rr1Phw6W1WEiajpqF0whc78V8b9upHif5--

--3w5r1w6cRI4AFhgbttUAShL4GXwKxX6aQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl606SQACgkQwj2R86El
/qh5mQf+N1DNK0k1HCs78FybnzD5KTxx/mwc+4KWXRyUE34drS/Mr+qenCINhupm
Lb1GB9YP9hkENpMfzZYKLebjlopGe7IZD7T0aEhShTPtzbtmlXXL/ulKZGf8HZyL
fYLs6Yj1icGfvee4U82vS3I514swnPUHjz1pS0hQoKuj7bL+ye5PH1voGGkADT0j
eO13PK+/++yOrZ4+FL8LOlaSw73Fp6sSjICzZev8/lsDbu2DnO/6MTyBNqoBkhqj
7zV4Q8psyDiKvaoCCESAkzVuGsZL97AYk4pX2CChXI2Bu1di38TGCR9+hYHUFqNF
BGf0IyUTVUemU4k9t8XYUosxaQ+ETw==
=fVlu
-----END PGP SIGNATURE-----

--3w5r1w6cRI4AFhgbttUAShL4GXwKxX6aQ--
