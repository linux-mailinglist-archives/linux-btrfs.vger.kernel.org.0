Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD91568DB
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 06:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgBIFBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 00:01:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:48489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgBIFBw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 00:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581224508;
        bh=D48mnwLSzWEw7UoPf0MeY/h0UyNyha05VGm8J+SwhPs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ieE3UkjOnZms+CxJJo43/5IA58mVKg9jV1HnDuVM/y0ZzDhY3svaxY/FamW71dEBF
         lXXXkny/WegpbjUHAobY/mDhPipA/4f09lCfGxjjSVN4aFczOHjk6bGa20W3NekUP/
         B6cAI7VSn1sJ13gmvE5uCtgCgk6tFS5V6E4M14tc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1j5ifl2IkI-00UM2G; Sun, 09
 Feb 2020 06:01:48 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
 <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
 <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
 <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
 <fac62b70-feec-6c0d-5ef3-6682e79b2886@gmx.com>
 <CA+M2ft9oNdHahsekM+01013RE-BDc126RNwPEELtpvBME9o8Lg@mail.gmail.com>
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
Message-ID: <0bfe4a2a-abea-c000-19cf-be2798d8f1bf@gmx.com>
Date:   Sun, 9 Feb 2020 13:01:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9oNdHahsekM+01013RE-BDc126RNwPEELtpvBME9o8Lg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lQn6kOqEhpfimo2dNtNs2vgu18F6lPKb3"
X-Provags-ID: V03:K1:u/i4sgSUH9Esyt+EpfRlmYnLcK4YRWSR8WXmTDUd9EAMmr9EMhD
 sCIu0U1jrmiprkjYtW9CaFCLSe1fUcx5GI2M/WCe4jXge2Xd1yOZa0xFmMxCD3ugiUflQUf
 xv2qWJNgnXNy4IcTavXcN5tOwqmK5Lxi22dO+BGVdD+ekajvGsi+w11VBIm7UewLsj91iPX
 bRAfLolpaQIw3bYnVXaZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vHEtM7kM65o=:e41VDa3QZwhAGznCl3MLiC
 89n3NJ0dHxX33oqTIGHIx+JpvETlrGlhpE6VJIfelGewm8hqIMB+XtOQk34ihQDKAMwD+7vKu
 MyaqAOgHKN8a3Ofcb4R0mJUHFoT7x6WaM+7rDtqoVk5kRQ0sqdASjDssNIhDZgRnLxlQMtCh2
 B2YtxDbHDu09EF7mYXw86m9Q4o8RGXg6q8UrAx8jeaRw+xuN7i2/RNlZ8vKag65Ye7ZK6++37
 jRsh3O4wB/c1x22uzH6A9FxO+hu3biptERu25dVUEPNAEOHs2QP648lnqBcjSP1K1ltCJ3nHl
 dnn2mPoepUBsBfq+lxdJ4iKzKCkw3uVTzx3W7P4/f0ebmZLm0XY6vpjcbLG9lLaWd3lsd4+7C
 XrFpam0GBFDBSpjfFcQxUi2d0yCBiHRI3z9tWc5unACfH/rDnN3M9xAvRElHyvHAf/RMUBvFu
 yvMtDfZpTVunC2FOfQhBiHcrJ9uKIQMtONTbwvT3KeforCkuoerR3DYXl2Wh0B6XzVXaduL2r
 kvLWAvbWMM2//IEOfqwIvGzOKM8iakZe75O6L2uOgrpjvTHhKl1t8/z+2HD0vmxCBK1dxVBn5
 Cun0Q6rQV6IIkKBlisIZ6Pex0F41bV4DfZ8Zy6xspvyeNx7mJO3H+ew0DO15uR+eZ//rq6rZY
 9UyFUlsXeF35rkD2MSh36T2l+TYO7RTpe7msFWuRH+jd6Vdhpaagws8ugwEKmYTByTHv6l45R
 tzol8fkzoiUtIHAKPf5KL7X5yrZ2B+apCVMPbDb18EUHmrmPBJWd+eT946Zk866BRSaWPrOzu
 H4oBJkX5Lf6aU6k0XQm5llNrauHIS5ngr7gNst0Ll+OIHYhGtHnt08BvRwVGv1zKkUcwFupY2
 zSnnfY0W7i5+Yku9IR5wvdAjyI69WymoG4LVkhVT6xlQdEKCoJHhZVu28K6NIwvo3SAzkZpu0
 czzbVATZt2cfKIbc4jB1hmLXceubjBeJM3XP9xB053S0X/YMf4X8bWhhpvDQB4Ejyn9eevIog
 Wd4iNS7N/CA6bpGGjs0HrP4WQzNFEEN8KeY3IkqDJZsO8peHqTSfiPC4LfzCmVR6hsi7Jd2aJ
 91dXRAasX1j2vosoCXYZSR2dpjRNflpHS1mF0G4QzlmmA8w7JYvVn4tQOy7rrx97C2u/tpDYg
 ij+UvhzR/XDCaa1x224Cty37DhgTjtrdaMWtox3z/fqXS+muqRUMJXX9iq/nkSSLSgMwPoFO8
 LUkqRAdqZnZS8cxLRzJRe6eM55ITxz3p3pVorI0ReSEaQLgkMsmnTxpnb1nB56Fd2nVlVreli
 Cf8BDnRA9ow42Xh3AbcPxcmaw/0pCgeomH6PzQ2wrnQAfwcHH/LHlccPpY4DAzo3fFi0zdC+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lQn6kOqEhpfimo2dNtNs2vgu18F6lPKb3
Content-Type: multipart/mixed; boundary="tQb8Vi34aWEBzUOCcxNmmi62BT0mjTl7P"

--tQb8Vi34aWEBzUOCcxNmmi62BT0mjTl7P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8B=E5=8D=8812:10, John Hendy wrote:
> On Sat, Feb 8, 2020 at 7:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/2/9 =E4=B8=8A=E5=8D=888:51, John Hendy wrote:
>>> On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
>>>>> On phone due to no OS, so apologies if this is in html mode. Indeed=
, I
>>>>> can't mount or boot any longer. I get the error:
>>>>>
>>>>> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown (=
Failed
>>>>> to recover log tree)
>>>>> BTRFS error (device dm-0): open_ctree failed
>>>>
>>>> That can be easily fixed by `btrfs rescue zero-log`.
>>>>
>>>
>>> Whew. This was most helpful and it is wonderful to be booting at
>>> least. I think the outstanding issues are:
>>> - what should I do about `btrfs check --repair seg` faulting?
>>
>> That needs extra debugging. But you can try `btrfs check --repair
>> --mode=3Dlowmem` which sometimes can bring better result than regular =
mode.
>> The trade-off is much slower speed.
>>
>>> - how can I deal with this (probably related to seg fault) ghost file=

>>> that cannot be deleted?
>>
>> Only `btrfs check` can handle it, kernel will only fallback to RO to
>> prevent further corruption.
>>
>>> - I'm not sure if you looked at the post --repair log, but there a to=
n
>>> of these errors that didn't used to be there:
>>>
>>> backpointer mismatch on [13037375488 20480]
>>> ref mismatch on [13037395968 892928] extent item 0, found 1
>>> data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
>>> not found in extent tree
>>> incorrect local backref count on 13037395968 root 263 owner 4257169
>>> offset 0 found 1 wanted 0 back 0x5627f59cadc0
>>
>> All 13037395968 related line is just one problem, it's the original mo=
de
>> doing human-unfriendly output.
>>
>> But the extra transid looks kinda dangerous.
>>
>> I'd recommend to backup important data first before trying to repair.
>>
>>>
>>> Here is the latest btrfs check output after the zero-log operation.
>>> - https://pastebin.com/KWeUnk0y
>>>
>>> I'm hoping once that file is deleted, it's a matter of
>>> --init-csum-tree and perhaps I'm set? Or --init-extent-tree?
>>
>> --init-csum-tree has the least priority, thus it doesn't really matter=
=2E
>>
>> --init-extent-tree would in theory reset your extent tree, but the
>> problem is, the transid mismatch may cause something wrong.
>>
>> So please backup your data before trying any repair.
>> After data backup, please try `btrfs check --repair --mode=3Dlowmem` f=
irst.
>>
>=20
> Current status:
>=20
> - the nvme seems healed! All is well, and a scrub completed
> successfully as well. Currently booted into that.

Great, we can just forget that case now.

>=20
> - the ssd is not doing well. I tried to do a backup and got a ton of
> issues with rsync (input/output errors, unable to verify transaction).
> I gave up as it just wasn't working well and would remount ro during
> these operations. Then, I did `btrfs check --repair --mode=3Dlowmem`. I=
t
> didn't seg fault, and did look to fix that spurious file (or at least
> mention it).
>=20
> Here's the current btrfs check output after the --repair --mode=3Dlowme=
m attempt:
> - https://pastebin.com/fHCHqrk7

The problems are more serious than your NVME one.

Transid error in csum tree

Transid error itself already means metadata COW is broken, which also
comes with extent tree corruption.
Trim or v5.2 bug can all lead to similar problem.

Your current best way to salvage data would be btrfs-restore.
Since csum tree is corrupted, a tons of data read will fail anyway.

For repair, you may try --init-csum-tree tree first.
As you have nothing to lose, you may also try --init-extent-tree.
Or maybe even both.

Thanks,
Qu

>=20
> If there are any suggestions on salvaging this, I would love to try.
> For now, I still have my original nvme drive working as an OS again
> and discard options are off everywhere. I can report back if this
> continues to work.
>=20
> Of interest to the list, I ran into these threads which you may already=
 know of:
> - https://linustechtips.com/main/topic/1066931-linux-51-kernel-hit-by-s=
sd-trim-bug-which-causes-massive-data-loss/
> (dm-crypt + Samsung SSD + 5.1 kernel =3D data loss). From googling, 5.1=

> would have been ~May 2019 for arch linux, so well within this drive's
> life
> - also, the arch wiki
> (https://wiki.archlinux.org/index.php/Solid_state_drive#Continuous_TRIM=
)
> says certain drives have trim errors and certain features are
> blacklisted in the kernel
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/ata/libata-core.c#n4522).
> My Samsung 850 SSD is in that list. I'm guessing some bad symptoms
> occurred to earn it a spot on that list...
>=20
> Current mount options to sanity check:
> /dev/mapper/luks-dc2c470e-ec77-43df-bbe8-110c678785c2 on / type btrfs
> (rw,relatime,compress=3Dlzo,ssd,space_cache,subvolid=3D256,subvol=3D/ar=
ch
>=20
> I will also do my best not to be extra rigorous about power loss as wel=
l.
>=20
> Fingers crossed this was all about trim/discard.
>=20
> Many thanks to Chris and Qu for the help. As you can imagine these
> situations are awful and one can feel quite powerless. Really
> appreciate the coaching and persistence.
>=20
> Best regards,
> John
>=20
>=20
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> John
>>>
>>>> At least, btrfs check --repair didn't make things worse.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> John
>>>>>
>>>>> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
>>>>> <mailto:jw.hendy@gmail.com>> wrote:
>>>>>
>>>>>     This is not going so hot. Updates:
>>>>>
>>>>>     booted from arch install, pre repair btrfs check:
>>>>>     - https://pastebin.com/6vNaSdf2
>>>>>
>>>>>     btrfs check --mode=3Dlowmem as requested by Chris:
>>>>>     - https://pastebin.com/uSwSTVVY
>>>>>
>>>>>     Then I did btrfs check --repair, which seg faulted at the end. =
I've
>>>>>     typed them off of pictures I took:
>>>>>
>>>>>     Starting repair.
>>>>>     Opening filesystem to check...
>>>>>     Checking filesystem on /dev/mapper/ssd
>>>>>     [1/7] checking root items
>>>>>     Fixed 0 roots.
>>>>>     [2/7] checking extents
>>>>>     parent transid verify failed on 20271138064 wanted 68719924810 =
found
>>>>>     448074
>>>>>     parent transid verify failed on 20271138064 wanted 68719924810 =
found
>>>>>     448074
>>>>>     Ignoring transid failure
>>>>>     # ... repeated the previous two lines maybe hundreds of times
>>>>>     # ended with this:
>>>>>     ref mismatch on [12797435904 268505088] extent item 1, found 41=
2
>>>>>     [1] 1814 segmentation fault (core dumped) btrfs check --repair
>>>>>     /dev/mapper/ssd
>>>>>
>>>>>     This was with btrfs-progs 5.4 (the install USB is maybe a month=
 old).
>>>>>
>>>>>     Here is the output of btrfs check after the --repair attempt:
>>>>>     - https://pastebin.com/6MYRNdga
>>>>>
>>>>>     I rebooted to write this email given the seg fault, as I wanted=
 to
>>>>>     make sure that I should still follow-up --repair with
>>>>>     --init-csum-tree. I had pictures of the --repair output, but Fi=
refox
>>>>>     just wouldn't load imgur.com <http://imgur.com> for me to post =
the
>>>>>     pics and was acting
>>>>>     really weird. In suspiciously checking dmesg, things have gone =
ro on
>>>>>     me :(  Here is the dmesg from this session:
>>>>>     - https://pastebin.com/a2z7xczy
>>>>>
>>>>>     The gist is:
>>>>>
>>>>>     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: root=
=3D7
>>>>>     block=3D172703744 slot=3D0, csum end range (12980568064) goes b=
eyond the
>>>>>     start range (12980297728) of the next csum item
>>>>>     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 450=
983
>>>>>     total ptrs 34 free space 29 owner 7
>>>>>     [   40.997942]     item 0 key (18446744073709551606 128 1297906=
0736)
>>>>>     itemoff 14811 itemsize 1472
>>>>>     [   40.997944]     item 1 key (18446744073709551606 128 1298029=
7728)
>>>>>     itemoff 13895 itemsize 916
>>>>>     [   40.997945]     item 2 key (18446744073709551606 128 1298123=
5712)
>>>>>     itemoff 13811 itemsize 84
>>>>>     # ... there's maybe 30 of these item n key lines in total
>>>>>     [   40.997984] BTRFS error (device dm-0): block=3D172703744 wri=
te time
>>>>>     tree block corruption detected
>>>>>     [   41.016793] BTRFS: error (device dm-0) in
>>>>>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error whi=
le
>>>>>     writing out transaction)
>>>>>     [   41.016799] BTRFS info (device dm-0): forced readonly
>>>>>     [   41.016802] BTRFS warning (device dm-0): Skipping commit of =
aborted
>>>>>     transaction.
>>>>>     [   41.016804] BTRFS: error (device dm-0) in cleanup_transactio=
n:1890:
>>>>>     errno=3D-5 IO failure
>>>>>     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO en=
try
>>>>>     [   41.023473] BTRFS warning (device dm-0): Skipping commit of =
aborted
>>>>>     transaction.
>>>>>     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO en=
try
>>>>>     [   44.509418] systemd-journald[416]:
>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journa=
l:
>>>>>     Journal file corrupted, rotating.
>>>>>     [   44.509440] systemd-journald[416]: Failed to rotate
>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journa=
l:
>>>>>     Read-only file system
>>>>>     [   44.509450] systemd-journald[416]: Failed to rotate
>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.jou=
rnal:
>>>>>     Read-only file system
>>>>>     [   44.509540] systemd-journald[416]: Failed to write entry (23=
 items,
>>>>>     705 bytes) despite vacuuming, ignoring: Bad message
>>>>>     # ... then a bunch of these failed journal attempts (of note:
>>>>>     /var/log/journal was one of the bad inodes from btrfs check
>>>>>     previously)
>>>>>
>>>>>     Kindly let me know what you would recommend. I'm sadly back to =
an
>>>>>     unusable system vs. a complaining/worrisome one. This is simila=
r to
>>>>>     the behavior I had with the m2.sata nvme drive in my original
>>>>>     experience. After trying all of --repair, --init-csum-tree, and=

>>>>>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
>>>>>     password at boot, I just saw a bunch of [FAILED] in the text sp=
lash
>>>>>     output. Hoping to not repeat that with this drive.
>>>>>
>>>>>     Thanks,
>>>>>     John
>>>>>
>>>>>
>>>>>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>     >
>>>>>     >
>>>>>     >
>>>>>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
>>>>>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gm=
x.com
>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>     > >>
>>>>>     > >>
>>>>>     > >>
>>>>>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>>>>>     > >>> Greetings,
>>>>>     > >>>
>>>>>     > >>> I'm resending, as this isn't showing in the archives. Per=
haps
>>>>>     it was
>>>>>     > >>> the attachments, which I've converted to pastebin links.
>>>>>     > >>>
>>>>>     > >>> As an update, I'm now running off of a different drive (s=
sd,
>>>>>     not the
>>>>>     > >>> nvme) and I got the error again! I'm now inclined to thin=
k
>>>>>     this might
>>>>>     > >>> not be hardware after all, but something related to my se=
tup
>>>>>     or a bug
>>>>>     > >>> with chromium.
>>>>>     > >>>
>>>>>     > >>> After a reboot, chromium wouldn't start for me and demsg =
showed
>>>>>     > >>> similar parent transid/csum errors to my original post be=
low.
>>>>>     I used
>>>>>     > >>> btrfs-inspect-internal to find the inode traced to
>>>>>     > >>> ~/.config/chromium/History. I deleted that, and got a new=
 set of
>>>>>     > >>> errors tracing to ~/.config/chromium/Cookies. After I del=
eted
>>>>>     that and
>>>>>     > >>> tried starting chromium, I found that my btrfs /home/jwhe=
ndy
>>>>>     pool was
>>>>>     > >>> mounted ro just like the original problem below.
>>>>>     > >>>
>>>>>     > >>> dmesg after trying to start chromium:
>>>>>     > >>> - https://pastebin.com/CsCEQMJa
>>>>>     > >>
>>>>>     > >> So far, it's only transid bug in your csum tree.
>>>>>     > >>
>>>>>     > >> And two backref mismatch in data backref.
>>>>>     > >>
>>>>>     > >> In theory, you can fix your problem by `btrfs check --repa=
ir
>>>>>     > >> --init-csum-tree`.
>>>>>     > >>
>>>>>     > >
>>>>>     > > Now that I might be narrowing in on offending files, I'll w=
ait
>>>>>     to see
>>>>>     > > what you think from my last response to Chris. I did try th=
e above
>>>>>     > > when I first ran into this:
>>>>>     > > -
>>>>>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazh=
yB95aha_D4WU_n15M59QrimrRg@mail.gmail.com/
>>>>>     >
>>>>>     > That RO is caused by the missing data backref.
>>>>>     >
>>>>>     > Which can be fixed by btrfs check --repair.
>>>>>     >
>>>>>     > Then you should be able to delete offending files them. (Or t=
he whole
>>>>>     > chromium cache, and switch to firefox if you wish :P )
>>>>>     >
>>>>>     > But also please keep in mind that, the transid mismatch looks=

>>>>>     happen in
>>>>>     > your csum tree, which means your csum tree is no longer relia=
ble, and
>>>>>     > may cause -EIO reading unrelated files.
>>>>>     >
>>>>>     > Thus it's recommended to re-fill the csum tree by --init-csum=
-tree.
>>>>>     >
>>>>>     > It can be done altogether by --repair --init-csum-tree, but t=
o be
>>>>>     safe,
>>>>>     > please run --repair only first, then make sure btrfs check re=
ports no
>>>>>     > error after that. Then go --init-csum-tree.
>>>>>     >
>>>>>     > >
>>>>>     > >> But I'm more interesting in how this happened.
>>>>>     > >
>>>>>     > > Me too :)
>>>>>     > >
>>>>>     > >> Have your every experienced any power loss for your NVME d=
rive?
>>>>>     > >> I'm not say btrfs is unsafe against power loss, all fs sho=
uld
>>>>>     be safe
>>>>>     > >> against power loss, I'm just curious about if mount time l=
og
>>>>>     replay is
>>>>>     > >> involved, or just regular internal log replay.
>>>>>     > >>
>>>>>     > >> From your smartctl, the drive experienced 61 unsafe shutdo=
wn
>>>>>     with 2144
>>>>>     > >> power cycles.
>>>>>     > >
>>>>>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every tim=
e I get
>>>>>     > > caught off gaurd by low battery and instant power-off, I ki=
ck myself
>>>>>     > > and mean to set up a script to force poweroff before that
>>>>>     happens. So,
>>>>>     > > indeed, I've lost power a ton. Surprised it was 61 times, b=
ut maybe
>>>>>     > > not over ~2 years. And actually, I mis-stated the age. I ha=
ven't
>>>>>     > > *booted* from this drive in almost 2yrs. It's a corporate l=
aptop,
>>>>>     > > issued every 3, so the ssd drive is more like 5 years old.
>>>>>     > >
>>>>>     > >> Not sure if it's related.
>>>>>     > >>
>>>>>     > >> Another interesting point is, did you remember what's the
>>>>>     oldest kernel
>>>>>     > >> running on this fs? v5.4 or v5.5?
>>>>>     > >
>>>>>     > > Hard to say, but arch linux maintains a package archive. Th=
e nvme
>>>>>     > > drive is from ~May 2018. The archives only go back to Jan 2=
019
>>>>>     and the
>>>>>     > > kernel/btrfs-progs was at 4.20 then:
>>>>>     > > - https://archive.archlinux.org/packages/l/linux/
>>>>>     >
>>>>>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), wh=
ich could
>>>>>     > cause metadata corruption. And the symptom is transid error, =
which
>>>>>     also
>>>>>     > matches your problem.
>>>>>     >
>>>>>     > Thanks,
>>>>>     > Qu
>>>>>     >
>>>>>     > >
>>>>>     > > Searching my Amazon orders, the SSD was in the 2015 time fr=
ame,
>>>>>     so the
>>>>>     > > kernel version would have been even older.
>>>>>     > >
>>>>>     > > Thanks for your input,
>>>>>     > > John
>>>>>     > >
>>>>>     > >>
>>>>>     > >> Thanks,
>>>>>     > >> Qu
>>>>>     > >>>
>>>>>     > >>> Thanks for any pointers, as it would now seem that my pur=
chase
>>>>>     of a
>>>>>     > >>> new m2.sata may not buy my way out of this problem! While=
 I didn't
>>>>>     > >>> want to reinstall, at least new hardware is a simple fix.=
 Now I'm
>>>>>     > >>> worried there is a deeper issue bound to recur :(
>>>>>     > >>>
>>>>>     > >>> Best regards,
>>>>>     > >>> John
>>>>>     > >>>
>>>>>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmai=
l.com
>>>>>     <mailto:jw.hendy@gmail.com>> wrote:
>>>>>     > >>>>
>>>>>     > >>>> Greetings,
>>>>>     > >>>>
>>>>>     > >>>> I've had this issue occur twice, once ~1mo ago and once =
a
>>>>>     couple of
>>>>>     > >>>> weeks ago. Chromium suddenly quit on me, and when trying=
 to
>>>>>     start it
>>>>>     > >>>> again, it complained about a lock file in ~. I tried to =
delete it
>>>>>     > >>>> manually and was informed I was on a read-only fs! I end=
ed up
>>>>>     biting
>>>>>     > >>>> the bullet and re-installing linux due to the number of =
dead end
>>>>>     > >>>> threads and slow response rates on diagnosing these issu=
es,
>>>>>     and the
>>>>>     > >>>> issue occurred again shortly after.
>>>>>     > >>>>
>>>>>     > >>>> $ uname -a
>>>>>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 20=
20
>>>>>     16:38:40
>>>>>     > >>>> +0000 x86_64 GNU/Linux
>>>>>     > >>>>
>>>>>     > >>>> $ btrfs --version
>>>>>     > >>>> btrfs-progs v5.4
>>>>>     > >>>>
>>>>>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would b=
e
>>>>>     mounting a subvol on /
>>>>>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>>>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>>>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>>>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>>>     > >>>>
>>>>>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook =
15.
>>>>>     > >>>> nvme0n1                                       259:5    0=

>>>>>     232.9G  0 disk
>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                             =
      259:6    0
>>>>>      512M  0
>>>>>     > >>>> part  (/boot/efi)
>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                             =
      259:7    0
>>>>>      1G  0 part  (/boot)
>>>>>     > >>>> =E2=94=94=E2=94=80nvme0n1p3                             =
      259:8    0
>>>>>     231.4G  0 part (btrfs)
>>>>>     > >>>>
>>>>>     > >>>> I have the following subvols:
>>>>>     > >>>> arch: used for / when booting arch
>>>>>     > >>>> jwhendy: used for /home/jwhendy on arch
>>>>>     > >>>> vault: shared data between distros on /mnt/vault
>>>>>     > >>>> bionic: root when booting ubuntu bionic
>>>>>     > >>>>
>>>>>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>>>     > >>>>
>>>>>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attach=
ed.
>>>>>     > >>>
>>>>>     > >>> Edit: links now:
>>>>>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
>>>>>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
>>>>>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
>>>>>     > >>>
>>>>>     > >>> btrfs dev stats (not worth a link):
>>>>>     > >>>
>>>>>     > >>> [/dev/mapper/old].write_io_errs    0
>>>>>     > >>> [/dev/mapper/old].read_io_errs     0
>>>>>     > >>> [/dev/mapper/old].flush_io_errs    0
>>>>>     > >>> [/dev/mapper/old].corruption_errs  0
>>>>>     > >>> [/dev/mapper/old].generation_errs  0
>>>>>     > >>>
>>>>>     > >>>
>>>>>     > >>>> If these are of interested, here are reddit threads wher=
e I
>>>>>     posted the
>>>>>     > >>>> issue and was referred here.
>>>>>     > >>>> 1)
>>>>>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_reco=
vering_from_various_errors_root/
>>>>>     > >>>> 2)
>>>>>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrf=
s_root_started_remounting_as_ro/
>>>>>     > >>>>
>>>>>     > >>>> It has been suggested this is a hardware issue. I've alr=
eady
>>>>>     ordered a
>>>>>     > >>>> replacement m2.sata, but for sanity it would be great to=
 know
>>>>>     > >>>> definitively this was the case. If anything stands out a=
bove that
>>>>>     > >>>> could indicate I'm not setup properly re. btrfs, that wo=
uld
>>>>>     also be
>>>>>     > >>>> fantastic so I don't repeat the issue!
>>>>>     > >>>>
>>>>>     > >>>> The only thing I've stumbled on is that I have been moun=
ting with
>>>>>     > >>>> rd.luks.options=3Ddiscard and that manually running fstr=
im is
>>>>>     preferred.
>>>>>     > >>>>
>>>>>     > >>>>
>>>>>     > >>>> Many thanks for any input/suggestions,
>>>>>     > >>>> John
>>>>>     > >>
>>>>>     >
>>>>>
>>>>
>>


--tQb8Vi34aWEBzUOCcxNmmi62BT0mjTl7P--

--lQn6kOqEhpfimo2dNtNs2vgu18F6lPKb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4/kjcACgkQwj2R86El
/qiXrQf/UFFajDibzHJA6dvniiFV2xocw5USCj38g4gW5cmMhVRyxOtwCLLYgFjK
ptqCdrzfW1T2g007hna9P9Yzr5dOADcJSbhLSyd7qB2pNhNJ4EBiTHI7rUQoOJts
osE/ACGwawsewnLffSBqTQNqK4ZGx57zkkgVGZ2F9wlF+l4vF/rbeqo+bjT6yQ6q
G7Asl/2ocnBCewWAa0VsI6aBLWUFtixxC5GqPAplNtGjTxaHzgM6E5dY49H/6mL1
oCWTYZ3exlZh1ARdjhH71FSyr7Mz7auPEfvMlpPZgS6UNGDwhYbN63CWmyE0nBVL
2hv4S7aBXXvCBDMgKMHFUsz7ZnpiRA==
=kSsB
-----END PGP SIGNATURE-----

--lQn6kOqEhpfimo2dNtNs2vgu18F6lPKb3--
