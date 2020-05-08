Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC31C9F75
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 02:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEHALL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 20:11:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:40449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEHALK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 20:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588896665;
        bh=PvkyoPITd2rt2fnFe8RejPDgqXIzPgBKaBPb7vRrFA8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N9IdFB3FiyV/MINEmBdPZUUdfidfCdSKI2Wxo3ACTw5O/U2cpSu1d9ACvmldCWwB2
         WhDswAoSXkD+3z+F6tvcbHuuKVAuJ72hD8ZzuH559YDYe6rR15FVPSBWEUcdXr79nJ
         hb0y5w4FkT54b+15PL4HIwq4WNTS5H/O3mTjhy+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXyP-1jdEXv1Trz-00Z39o; Fri, 08
 May 2020 02:11:05 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
 <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
Date:   Fri, 8 May 2020 08:11:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oYkFMUc5cKzMZXLlHxPcevKoEcg7xiECX"
X-Provags-ID: V03:K1:xt4fItCwlqtOS3TkwCcwe6F6GWmnnqdPKDC4ZoNKCFdAmA2AoLc
 NqX7raP9fU8+4EH0w/Zb4jop21fF5m130FdIv7LeHfmTQg5iRit4mp7d/SHaYdlnHHggKFo
 lmGvjIkPSkD4BYMdB70eg338VTnPtHJSgtCD36FqWKecFktzpPo49Eg8txpZgxBv8LMEv6w
 YCnPyF6l3mxN1ZJNDesXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9Dkf6SMBNw=:n2ZglMaYAlUZPpSTDFBlc4
 UFcbfZsb5wpyu+Cl5Do3mKpBsOO3/2PW2Q6M/otkNWhll6Q5bkXlYGTKQgBsJYk+YRnUnJE46
 JL7hw703ajDnuD/hgQRc8s9bUIG36MDI9tqwaGXMHKzX8fTNRULhcSumRlwNawlzT9Bq3UXr6
 MUk8L8qjuFRJjymyxJeLzXtjGop0F7pWFvwDZweUAq3K+TxS4l/jmQ7vi36ZTpVuyR3tUDYgS
 SmoAX+bbpDoR8Yol0VV+aPHiUhZNQSbDi5SHHcv4sVXObtQ+PTX1d8l66zxgWuKQWkKeZHiBd
 THTevVP/VfLYxNXRwucj0LB9mh1Ptn3s1/Eo09EaB7eulJ75OS4THrGpNMRZjR+gN2rxrNwBI
 JxgIijgz4zoxQIMwPW1B90VqTstLEEgvM40BdaAivs+deoeYnf3sGdXhU9SsfDPmXkGE8DwU6
 o1AkBeuGyADbsCSuhzfRrbJwKoSF55fgbNA+cAPqYiXRDTx0AspuRRWEQTEC0AZsy2ibkdHNC
 mi7eDCEh1f30R7dptSzQ8iGezQYQWwBHvqSfM/yFACkkGp3e1m1jERY7gKHOrCoqH4aTn35sX
 Ylm2bSKtPf8vxuZPZlbBzhPKsNk+Pyvdlv4OYi7UZJXxV5Uz2d9AiAKxUPpGFy9MoCcSckAz0
 5mZ6ZxsDn0nCHN4NmBuJxbwToeduv46ejbSr2tjvX63zXmuj7yj3VBXX5xu23mgHFFMh2elMv
 s6vnwXEqy8w1vQ38RrM7TOw+Muaj5RlmFtpKRCul9XOovr9N5XYuGWxJ1IgqOptuCm+0b5owD
 BYvQ9la53cxcJb5yhrUvU02HKyj/6DOhXGx4KpQgjuBQggrqv5oVbUo7yiluVIiZLBUWLoLKx
 6bSC6EGTj7f9m6CLfFdTxqh1c+ICL0X59/ggnmdeM+9KhE+UuzskqZbaMUwt+5sgyHnegrLBE
 d3JQuJedinOYLt6BbdZCrpVvYe4sl11o160E24Kmt5ROdXI6MBRN8orhzFphItcla20uB5/XU
 xGAr0xook6630Tmu0E4QS1ziynSkiPvI2I4DCVnmQdKBtMG29urCwZ6GVgrQiL/rIuNkXfaII
 sM02j7cq7BHX2egm682ljD2tq7glG/F1kMpxnpZvQAV3jw9f1zxoGTefC+4rOKZo9V9W7qWyg
 AXNMh5ifUtSX2JedWAIAS8pycU+YnTeADoJzSadXPEjgOCT6zdNvJzBjS9zr+OTEVpF/7cwCN
 54kgAw3YvKc1yVJ8E
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oYkFMUc5cKzMZXLlHxPcevKoEcg7xiECX
Content-Type: multipart/mixed; boundary="quuvJjy97V4btNkOvuDuRi92P4iXJmws4"

--quuvJjy97V4btNkOvuDuRi92P4iXJmws4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
> Thank you for helping. The end result of the scan was:
>=20
>=20
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots

Good news is, your fs is still mostly fine.

> [5/7] checking only csums items (without verifying data)
> there are no extents for csum range 0-69632
> csum exists for 0-69632 but there is no extent record
> ...
> ...
> there are no extents for csum range 946692096-946827264
> csum exists for 946692096-946827264 but there is no extent record
> there are no extents for csum range 946831360-947912704
> csum exists for 946831360-947912704 but there is no extent record
> ERROR: errors found in csum tree

Only extent tree is corrupted.

Normally btrfs check --init-csum-tree should be able to handle it.

But still, please be sure you're using the latest btrfs-progs to fix it.

Thanks,
Qu

> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 44157956026368 bytes used, error(s) found
> total csum bytes: 42038602716
> total tree bytes: 49688616960
> total fs tree bytes: 1256427520
> total extent tree bytes: 1709105152
> btree space waste bytes: 3172727316
> file data blocks allocated: 261625653436416
>  referenced 47477768499200
>=20
> What do I need to do to fix all of this?
>=20
> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
>>> Well, the repair doesn't look terribly successful.
>>>
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>
>> This means there are more problems, not only the hash name mismatch.
>>
>> This means the fs is already corrupted, the name hash is just one
>> unrelated symptom.
>>
>> The only good news is, btrfs-progs abort the transaction, thus no
>> further damage to the fs.
>>
>> Please run a plain btrfs-check to show what's the problem first.
>>
>> Thanks,
>> Qu
>>
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
>>> parent level=3D1
>>>                                             child level=3D4
>>> ERROR: failed to zero log tree: -17
>>> ERROR: attempt to start transaction over already running one
>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
>>> extent buffer leak: start 225049066086400 len 4096
>>> extent buffer leak: start 225049066086400 len 4096
>>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len 409=
6
>>> extent buffer leak: start 225049066094592 len 4096
>>> extent buffer leak: start 225049066094592 len 4096
>>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len 409=
6
>>> extent buffer leak: start 225049066102784 len 4096
>>> extent buffer leak: start 225049066102784 len 4096
>>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len 409=
6
>>> extent buffer leak: start 225049066131456 len 4096
>>> extent buffer leak: start 225049066131456 len 4096
>>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len 409=
6
>>>
>>> What is going on?
>>>
>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.com=
> wrote:
>>>>
>>>> Chris, I had used the correct mountpoint in the command. I just edit=
ed
>>>> it in the email to be /mountpoint for consistency.
>>>>
>>>> Qu, I'll try the repair. Fingers crossed!
>>>>
>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>
>>>>>
>>>>>
>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I looked up this error and it basically says ask a developer to
>>>>>> determine if it's a false error or not. I just started getting som=
e
>>>>>> slow response times, and looked at the dmesg log to find a ton of
>>>>>> these errors.
>>>>>>
>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835840 =
read
>>>>>> time tree block corruption detected
>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835840 =
read
>>>>>> time tree block corruption detected
>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835840 =
read
>>>>>> time tree block corruption detected
>>>>>>
>>>>>> btrfs device stats, however, doesn't show any errors.
>>>>>>
>>>>>> Is there anything I should do about this, or should I just continu=
e
>>>>>> using my array as normal?
>>>>>
>>>>> This is caused by older kernel underflow inode generation.
>>>>>
>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
>>>>>
>>>>> Or you can go safer, by manually locating the inode using its inode=

>>>>> number (1311670), and copy it to some new location using previous
>>>>> working kernel, then delete the old file, copy the new one back to =
fix it.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Thank you!
>>>>>>
>>>>>
>>


--quuvJjy97V4btNkOvuDuRi92P4iXJmws4--

--oYkFMUc5cKzMZXLlHxPcevKoEcg7xiECX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl60o5UXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjLyQgAlkShTAiEkxCIBaocta3oF13/
65JninZ+GJN0/Jac3nPtatIo1l87CzbEZ9nft4nbHT6Znh9LDRlg6dD2AFdF1wwc
qcE2PauroP49k24bptA2Z5HEqf39UaKVfxlnU8oMNnq+Lu6706jL4/hGRe0xWraB
FwR26aF4D9ktKON2pni6zJFj8AdfR2VRY0JScdUZXxgdzdGuATkDAbLAsVI1IAam
h+m3C9B6U7R90peKOfIbcWDGx4PhSP12gbTRxurApJuCLfSM3CB3m5y7xZujP9oy
dx1E6U4ed7D5bkUNdecSYqE043XyiG/RctUNsdb5AQbBOdmqcvmbwDjC75vYkQ==
=wP/s
-----END PGP SIGNATURE-----

--oYkFMUc5cKzMZXLlHxPcevKoEcg7xiECX--
