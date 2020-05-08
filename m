Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84E1CA2F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEHFra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 01:47:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:39765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgEHFra (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 01:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588916846;
        bh=4TuDPIdxPdkLb3F2coiZGgKeHaqiFQ27mYmWFJ6N7qg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aX7Phy/iV0gv79q0D8SvLwUJxqThwKin/wI1nOIYsFjqi6qbh9zh9bkRQl8AtnuqE
         KmMP/V4almVxcIRIM9m47/5msAXNL2j6y8loZhiEpQv/XHssgEulA1ibnKS01cqncT
         sxyY7WfS+Zeym7ZhE1pfGiA6d6T5wiz9vyPdONJk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1j6IFZ1dsu-00znDW; Fri, 08
 May 2020 07:47:26 +0200
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
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
 <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
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
Message-ID: <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com>
Date:   Fri, 8 May 2020 13:47:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJZKE14nqFBoteG0VZsaqaaxkSlBi18DF"
X-Provags-ID: V03:K1:JD5MUbGefzvECcuPuPv50QJljwHLjnYPOznEPTk+ZLmO3d9+dp4
 54fgBie4kDSwNn9vwxBi8rbSy7vJSLtYwwbAuSzYf/V+14+4omWFdcVFJLIMWtzWMqQg84T
 modN3fGMxo/iyZzN+uD1jkJ8pJZOmae1fg2036FpBOFcCx9Xhh9sGMXydqOwJVLotaqA60k
 wtylnv+Gt7gC3734lKKuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0a4yLmUCmo=:tcN3HhD/UrZIpptGbsw1tN
 +R5QXr6NNHR3cMXh8Itj6sJSl5E1HIMS/Je+H/evHjHE8NqVc2fZ54fgMhwRnL7gfr+Heg25U
 gDwywaF0vEjP0azK0shls/bngm6ruNluZDRhq4+wiThvvwdmBrP42zHRwUkhCNKbPxNRc5rM2
 Cwj8TPYSVy62sCSTRBNqnoElx0mz/AHlbvEZYHVE/4MipG3tdu//hO0WUg14u01yC0qMaai+6
 0GqnRbRI2eu+aqNMEUNVSq4B38F3NNBbA5M+4mY9WppBO9zu+yYSJinvn2rTBptqR890SOUsE
 b+tABlhI6tGxtVHOGTUCrLvMCGo9LOJrlCHtDje2XdFnv9Mp5aLpSIMaGasJiL0XJS0Ef7EWi
 x0vl0RJqbTewXxUcz0IEaaDVmByBGvTaguOj+fSg108Un9LzkdrAsrXokUAXMOqNoicuqFC1b
 grwXfF3+qBIXafdx9kPZ3ItneLGw7RFSmUB5cgoo7WZh+LOBkVtEdZyRZpDovwYmwqr39xBld
 RJ42Vl7qQ1GQMD1uRoKBkbobr9YZJh/e6rvVhdnDcjs7YuJsG2I5KDxiK6K19Dc+V2wGSsrbE
 07PPH4mHkBFtQJ9RMuU7HWY85TV2hI1ubC7kgIEe+E1lU3WwNEF/p11nkIIeraEJHfZmlLsoi
 xP6iKQriL3IwOiHV7UEn5LSZDXRNdv+n7xI0G05PyeSH3Pu9TH7KKfxp+a0XQij6IDCjNqku3
 ChpHKQzFlaBX1I1xDmu5EgKXIZ+XnbcxENmZeFkTdbMg8TV8GQUL+IOjaUKDwi+r28k+JMkg9
 K0/zZ5ndMzy1tDBL1yqLdzIdFfACROHzsozvnaeke3Dw2l2RwHKEZMXr7TH/YQjPlK4NhmWj6
 d6YHPNhzR38IfS7qKzNqs5AQD8j3CklUx+3eY0EzEEhCAoo2e1BG5ywFSTJUbdFQFIbGfmsLf
 hzNlSBbHJly1bhh7B6yeCGfbujaMMW3i4GEzv0mq0hDJ5t70+YBzMFg740Sg4tMj+deYrSQ8f
 hCylpuTD0XeVSxHC5WTXwYOZINgVGBp0gQkjpCIwSE5hHVMOfYX7+y2A+ZlgvqttFqhYyVgVx
 Vovw53fSqomzPJ3OPCoSrjq4QNCP5ez/maSsCewwhWgws2VbQ7TNpHFr88uBK12lL2ZFrwd1s
 N4HdqJ+25OAN/GrjB4JqnsC8398STtInx83Yuj4MpWWMaQbYF4uBv4gwaj8gZ25v5CdyJ5OuM
 GmciRB4zIIP4mU2sa
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJZKE14nqFBoteG0VZsaqaaxkSlBi18DF
Content-Type: multipart/mixed; boundary="vRuIhU4HnbnSrohFfjAdt0LmClo6cvPx4"

--vRuIhU4HnbnSrohFfjAdt0LmClo6cvPx4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
> If this is saying there's no extra space for metadata, is that why
> adding more files often makes the system hang for 30-90s? Is there
> anything I should do about that?

I'm not sure about the hang though.

It would be nice to give more info to diagnosis.
The output of 'btrfs fi usage' is useful for space usage problem.

But the common idea is, to keep at 1~2 Gi unallocated (not avaiable
space in vanilla df command) space for btrfs.

Thanks,
Qu

>=20
> Thank you so much for all of your help. I love how flexible BTRFS is
> but when things go wrong it's very hard for me to troubleshoot.
>=20
> On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
>>> Something went wrong:
>>>
>>> Reinitialize checksum tree
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>>> btrfs(+0x6dd94)[0x55a933af7d94]
>>> btrfs(+0x71b94)[0x55a933afbb94]
>>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>> btrfs(+0x360b2)[0x55a933ac00b2]
>>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>> btrfs(main+0x98)[0x55a933a9fe88]
>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b=
3]
>>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>> Aborted
>>
>> This means no space for extra metadata...
>>
>> Anyway the csum tree problem shouldn't be a big thing, you could leave=

>> it and call it a day.
>>
>> BTW, as long as btrfs check reports no extra problem for the inode
>> generation, it should be pretty safe to use the fs.
>>
>> Thanks,
>> Qu
>>>
>>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
>>> available. I'll let that try overnight?
>>>
>>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
>>>>> Thank you for helping. The end result of the scan was:
>>>>>
>>>>>
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> [4/7] checking fs roots
>>>>
>>>> Good news is, your fs is still mostly fine.
>>>>
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> there are no extents for csum range 0-69632
>>>>> csum exists for 0-69632 but there is no extent record
>>>>> ...
>>>>> ...
>>>>> there are no extents for csum range 946692096-946827264
>>>>> csum exists for 946692096-946827264 but there is no extent record
>>>>> there are no extents for csum range 946831360-947912704
>>>>> csum exists for 946831360-947912704 but there is no extent record
>>>>> ERROR: errors found in csum tree
>>>>
>>>> Only extent tree is corrupted.
>>>>
>>>> Normally btrfs check --init-csum-tree should be able to handle it.
>>>>
>>>> But still, please be sure you're using the latest btrfs-progs to fix=
 it.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 44157956026368 bytes used, error(s) found
>>>>> total csum bytes: 42038602716
>>>>> total tree bytes: 49688616960
>>>>> total fs tree bytes: 1256427520
>>>>> total extent tree bytes: 1709105152
>>>>> btree space waste bytes: 3172727316
>>>>> file data blocks allocated: 261625653436416
>>>>>  referenced 47477768499200
>>>>>
>>>>> What do I need to do to fix all of this?
>>>>>
>>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
>>>>>>> Well, the repair doesn't look terribly successful.
>>>>>>>
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>
>>>>>> This means there are more problems, not only the hash name mismatc=
h.
>>>>>>
>>>>>> This means the fs is already corrupted, the name hash is just one
>>>>>> unrelated symptom.
>>>>>>
>>>>>> The only good news is, btrfs-progs abort the transaction, thus no
>>>>>> further damage to the fs.
>>>>>>
>>>>>> Please run a plain btrfs-check to show what's the problem first.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> parent transid verify failed on 218620880703488 wanted 6875841 fo=
und 6876224
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D=
84
>>>>>>> parent level=3D1
>>>>>>>                                             child level=3D4
>>>>>>> ERROR: failed to zero log tree: -17
>>>>>>> ERROR: attempt to start transaction over already running one
>>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
>>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len=
 4096
>>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len=
 4096
>>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len=
 4096
>>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len=
 4096
>>>>>>>
>>>>>>> What is going on?
>>>>>>>
>>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail=
=2Ecom> wrote:
>>>>>>>>
>>>>>>>> Chris, I had used the correct mountpoint in the command. I just =
edited
>>>>>>>> it in the email to be /mountpoint for consistency.
>>>>>>>>
>>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>>>
>>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> I looked up this error and it basically says ask a developer t=
o
>>>>>>>>>> determine if it's a false error or not. I just started getting=
 some
>>>>>>>>>> slow response times, and looked at the dmesg log to find a ton=
 of
>>>>>>>>>> these errors.
>>>>>>>>>>
>>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
>>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
>>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835=
840 read
>>>>>>>>>> time tree block corruption detected
>>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
>>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
>>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835=
840 read
>>>>>>>>>> time tree block corruption detected
>>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: roo=
t=3D5
>>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode =
generation:
>>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835=
840 read
>>>>>>>>>> time tree block corruption detected
>>>>>>>>>>
>>>>>>>>>> btrfs device stats, however, doesn't show any errors.
>>>>>>>>>>
>>>>>>>>>> Is there anything I should do about this, or should I just con=
tinue
>>>>>>>>>> using my array as normal?
>>>>>>>>>
>>>>>>>>> This is caused by older kernel underflow inode generation.
>>>>>>>>>
>>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
>>>>>>>>>
>>>>>>>>> Or you can go safer, by manually locating the inode using its i=
node
>>>>>>>>> number (1311670), and copy it to some new location using previo=
us
>>>>>>>>> working kernel, then delete the old file, copy the new one back=
 to fix it.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thank you!
>>>>>>>>>>
>>>>>>>>>
>>>>>>
>>>>
>>


--vRuIhU4HnbnSrohFfjAdt0LmClo6cvPx4--

--lJZKE14nqFBoteG0VZsaqaaxkSlBi18DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl608moACgkQwj2R86El
/qgd9gf/cnU8aviBUng+wJrF8kTSJ+wruI04JIphYVrNE8CASq264Ny/B7WMHvUD
uSIFuBzJc6mhLZoKb1gOrzlx+Mowy7AtQkdX6raXYvqwd0bXY0efmN08A4f3w2fP
DVSbdieYmfAdi0smYxNmoEHktY+sok8LXAGgEnKqZzbNl5GIdV96Xw9bDCTA42Cv
Mj+oIdhcWMgWtAxzAVx1vicU3CTsa3QrmzeK3wBMcxR1F5Y8Wya7hmwBzUSlRPLc
f+CCT4/SFeashKQdi22ffDQ+IVszTLXsinjtVICbqMwt6RwLhtWerh8R+1ZzEwAe
x+i7eu6xTl8FgDewFUy+n30cyFiVxg==
=1RBO
-----END PGP SIGNATURE-----

--lJZKE14nqFBoteG0VZsaqaaxkSlBi18DF--
