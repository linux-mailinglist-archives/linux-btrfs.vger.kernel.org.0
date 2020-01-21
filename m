Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107441435A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 03:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgAUC0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 21:26:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:50721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgAUC0Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 21:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579573581;
        bh=LkFrma6ECJh7TxDvY4mCJTC+H1t86NCM3xXUh4Gc0gE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B6iGYECwE/YvtIjD9e5R/6bW6xPwTtrs5QBoIxmRwAGi6Yc3nLAIyMmxB+RouU9Nh
         jk/KRM2WLstwNEqge+A9B0MdFv0jfQ4wsa0fz369CgthwT754tGDEzZKgsbIp+hMh0
         Z+hWYBRfsVRxg9APfDqzUZIb188K8nLPB7rBtKNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1jR88D2Ept-00p6rD; Tue, 21
 Jan 2020 03:26:21 +0100
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
 <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com>
 <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
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
Message-ID: <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com>
Date:   Tue, 21 Jan 2020 10:26:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zlCEmx7Mohiwy1CBphK8UPDB1jYjB3Rnj"
X-Provags-ID: V03:K1:s5gYHTvduKrnTLhBNeVIq4Da0fVaTAoT4+Keo4mWvmBWCQqJq2J
 Muhc+mn/Y0GpsKc/H2Nb6s/z6b1cxdR3be0M9XWvvO1klf7tJVFGJ+HgTOadbY15Xp9ft9q
 Htc3dS42JyNvREVF50cSFIzi+DlUauC3srKuPQXF2DqkDhoWncfTpV5D6pVcJp7nxlv7ubj
 GJapHHNX0aXIbe1FODe7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBW4B3izq5I=:8NEaFoxleBMdQ2u4EsWD9z
 MSnm7xuv+qsgR1XEOr5cprMbR6EGuji+lJoHtsDqxwcPIASrCC5J6r8pUWIPl9uN+EXDMes9P
 X/b+Fyvu9vb+L2RDBA83uJn9TDbI91hJVdYnj/CIFA72HdHzzBwBdcUe/NfAZR/Pbz1RBUFyy
 4/zvzqC2ZWLjM6LkAy8tfmZdq/7zfVJbuv+9KIjWu6AULwIZR2fDNmAX09hOLUyE6Nj/3rVV2
 hcKz1tXtOkEvADaX/ykN9DFW5uKOaHOYxPFAB4rvCUrVQiyV5gwcqKPx44NPTLOuiqCrIcf/h
 LNj9kfW7OIhk9sGitAIxntvmLnmMSpwYjKgWmbpunKDWFgkOoluG/yyeOCzBOjVEyDUbFtiWJ
 78Bfn/CXrzETYg8PuVVNzmV5nof3AQksIrO4rYJf/NiZhtQt7GjAjgNV5RwVT/RqbyRKxpCGV
 ZwRFiR7G4EKK0HIQuPTE3dV+w78yRqjIH3cWToZSGt2pUHq1YiwmTYrSLDgyvE/wDDmkYvFZC
 AsPoMDXo7j5qeaKtJ1Hmjv5CqDxrEl4HnIhIZCA51Xi6lnAH7CnElNRlOCOLrSwrOZqLMaFy/
 vFYZPPQfzfe+uZTJWijorPdQHEvziCZIbzC9DmtL/orzniMbpyCqWdQ03tnRPfXjU6obDYI8U
 sms+IHjk3KDqpoTyqSJLzmWLB3/2cRZlHyDPBIxbN+eQNBm8rcywu0k5ywqhijc9st5mDgH/i
 gbKu8agEr2aUs2RDsMdOhBdxKVUBDCH/u8iKLxItF/Na8tmXlR9qn2exhm0zQoLJhRCaGj5Ju
 MW4BYgkI+7Wfu0zh2ul6eAZiSfDvkoi2/C77muqZyxhqSzOcEHBa2RZ5dabtCyGnVuDTzZlNQ
 NHTUBDeuZEyHXl6GybUNeWZ+Wy/1QlzE3H4hKGeak9yokallDYcKtjGNeVHH2C7w3zk70ly7G
 /8N1BZ7km3Ux/8qHecoaKQfakbw8KOO6INtvhoX5X005kfuBfaDEuYwWZ3k9ywqc+slvDhZIP
 OXwvz2liRkGPOmQw+XsFygWVpw9XTcOlWFcni8FHYQ98b7wH97R9X/EL/0Do2sXSUbBm9pJkt
 ii910awsbA5i7mDPwBkDhEzPJS1OKyy40ju5dHXAj5tgrVnu/L2J8kb8yQPDjZ9W/2XP172zn
 kb+yfoA9Fl8HBsvb0RFCr0ddtxtRfcAv5+XZjyQtdVGYpKVhkyWvaqtmY4r4jJBVarYT05W4y
 qN+yPWr9LkeIySR6Awpg2xys/WzJr0GsK/2brA1P49Mq5Qi/9Wm3dbTtFcNo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zlCEmx7Mohiwy1CBphK8UPDB1jYjB3Rnj
Content-Type: multipart/mixed; boundary="fe8Zo23YPYzd9tQUvFU9RCHcHuTLEq5KK"

--fe8Zo23YPYzd9tQUvFU9RCHcHuTLEq5KK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/21 =E4=B8=8A=E5=8D=8810:06, Robbie Smith wrote:
> On Tue, 21 Jan 2020 at 12:49, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>>
>>
>>
>> On 2020/1/21 =E4=B8=8A=E5=8D=889:39, Robbie Smith wrote:
>>> On Tue, 21 Jan 2020 at 11:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
>>>>> I put my laptop into hibernation mode for a few days so I could boo=
t
>>>>> up into Windows 10 to do some things, and upon waking up BTRFS has
>>>>> borked itself, spitting out errors and locking itself into read-onl=
y
>>>>> mode. Is there any up-to-date information on how to fix it, short o=
f
>>>>> wiping the partition and reinstalling (which is what I ended up
>>>>> resorting to last time after none of the attempts to fix it worked)=
?
>>>>> The error messages in my journal are:
>>>>>
>>>>> BTRFS error (device dm-0): parent transid verify failed on
>>>>> 223458705408 wanted 144360 found 144376
>>>>
>>>> The fs is already corrupted at this point.
>>>>
>>>>> BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 sl=
ot=3D23
>>>>> extent bytenr=3D223451267072 len=3D16384 invalid generation, have 1=
44376
>>>>> expect (0, 144375]
>>>>
>>>> This is one newer tree-checker added in latest kernel.
>>>>
>>>> It can be fixed with btrfs check in this branch:
>>>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>>>
>>>> But that transid error can't be repair, so it doesn't make much sens=
e.
>>>>
>>>>> BTRFS error (device dm-0): block=3D223455346688 read time tree bloc=
k
>>>>> corruption detected
>>>>> BTRFS error (device dm-0): error loading props for ino 1032412 (roo=
t 258): -5
>>>>>
>>>>> The parent transid messages are repeated a few times. There's nothi=
ng
>>>>> fancy about my BTRFS setup: subvolumes are used to emulate my root =
and
>>>>> home partition. No RAID, no compression, though the partition does =
sit
>>>>> beneath a dm-crypt layer using LUKS. Hibernation is done onto a
>>>>> separate swap partion on the same drive.
>>>>
>>>> Please provide the output of "btrfs check" and kernel version.
>>>
>>> Here's the kernel and btrfs information:
>>>
>>>> # uname -a
>>>> Linux rocinante 5.4.10-arch1-1 #1 SMP PREEMPT Thu, 09 Jan 2020 10:14=
:29 +0000 x86_64 GNU/Linux
>>>>
>>>> # btrfs --version
>>>> btrfs-progs v5.4
>>>>
>>>> # btrfs fi df /
>>>> Data, single: total=3D541.01GiB, used=3D538.54GiB
>>>> System, DUP: total=3D8.00MiB, used=3D80.00KiB
>>>> Metadata, DUP: total=3D3.00GiB, used=3D1.56GiB
>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>
>>>> # btrfs fi show
>>>> Label: 'rootfs'  uuid: 25ac1f63-5986-4eb8-920f-ed7a5354c076
>>>>         Total devices 1 FS bytes used 540.11GiB
>>>> devid    1 size 794.25GiB used 547.02GiB path /dev/mapper/cryptroot
>>>
>>> I tried a btrfs check and it failed almost immediately.
>>>
>>>> # btrfs check /dev/mapper/cryptroot
>>>> Opening filesystem to check...
>>>> ERROR: /dev/mapper/cryptroot is currently mounted, use --force if yo=
u really intend to check the filesystem
>>>>
>>>> # btrfs check --force /dev/mapper/cryptroot
>>>> Opening filesystem to check...
>>>> WARNING: filesystem mounted, continuing because of --force
>>>> Checking filesystem on /dev/mapper/cryptroot
>>>> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
>>>> [1/7] checking root items
>>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
>>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
>>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
>>>> Ignoring transid failure
>>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
>>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
>>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
>>>> Ignoring transid failure
>>>> ERROR: child eb corrupted: parent bytenr=3D223602655232 item=3D233 p=
arent level=3D1 child level=3D2
>>>> ERROR: failed to repair root items: Input/output error
>>
>> The corruption looks happened on root tree. Which is mostly ensured to=

>> cause problem for next mount.
>>
>> It's highly recommended to start data salvage.
>>
>>>
>>> I haven't rebooted the laptop, in case this issue makes the laptop
>>> unbootable, but I could try re-running the check from a live USB and
>>> an unmounted filesystem. My Arch Live USB is from June last year, and=

>>> it's got kernel 4.20 and btrfs-progs 4.19.1 on it=E2=80=94will they b=
e new
>>> enough, or should I fetch the latest Arch disk and flash a new one?
>>
>> I don't believe newer btrfs-progs can handle it at all.
>> But you can still consider it as a last try.
>>
>> BTW did you have anything weird in dmesg?
>=20
> dmesg is full of errors from journalctl because the filesystem is
> read-only. Journalctl had paused after resume due to this, and I
> thought I could catch newer messages by running it (isn't it supposed
> to temporarily store logs in volatile storage?), and that made my
> laptop completely die. Every program I had open segfaulted at once,
> and now it's just spooling through dmesg with thousands (if not
> millions) of lines about journalctl being unable to rotate the logs.
> Amazingly enough, I'm still logged in remotely via ssh/mosh, but I
> can't run any commands due to a bus error. I can't even su to root.

Well, when a fs get fully corrupted, everything can happen.

>=20
> I guess I try rebooting it with a Live USB, and running the check
> again, and if that fails, looks like I'll be spending my day
> reinstalling everything. Do I have any better options? The only thing
> that isn't backed up on this machine is my music collection, but
> that's a local lossy copy generated from my lossless library on my
> other machine, so I can recreate it if I need to (I'd rather not=E2=80=94=
if I
> can mount the fs readonly, I might be able to copy that to a separate
> drive).
>=20
> What on Earth could possibly cause BTRFS to fail so badly like this,
> with this specific error? I've been using BTRFS for years without
> problems, except this and the exact same error on the same machine six
> months ago.

Really hard to say, there are at least 3 things related to this problem.

- Btrfs itself
- Hibernation
- Dm-crypt (less possible)

For btrfs, if you have used kernel between version v5.2.0 and v5.2.15,
then it's possible the fs is already corrupted but not detected.

For the hibernation part, Linux is not the best place to utilize it for
the first place.
(My ThinkPad X1 Carbon 6th suffers from hibernation, so I rarely use
suspension/hiberation)

Since linux development is mostly server oriented, such daily consumer
operation may not be that well tested.

Things like Windows updating certain firmware could break the controller
behavior and cause unexpected behavior.

So my personal recommendation is, to avoid hibernation/suspension, use
Windows as little as possible.

Thanks,
Qu

>=20
>>
>>>
>>> In answer to Nikolay's questions, both Windows and Linux share a disk=

>>> but are on separate partitions, and Windows did update itself. I've
>>> had Windows updates occur while Linux is hibernated before, and it ha=
s
>>> no reason to touch a partition it can't read and never mounts.
>>
>> For the cause, I don't believe it's related to Windows, but the
>> hibernation part.
>>
>> Not sure how hibernation would interact with fs, but my guess is it
>> should at least sync the fs.
>>
>> Anyway, if something extra happened, dmesg should have some clue.
>>
>>
>> Another possible cause is, some older (still v5.x) upstream kernel had=

>> some bug, e.g. before v5.2.15/v5.3 there is a bug in btrfs which could=

>> cause part of metadata not synced to disk, causing the same transid
>> corruption.
>>
>> And since you're not rebooting, but only hibernate, the problem remain=
s
>> undetected until today...
>>
>> Thanks,
>> Qu
>>
>>>
>>> Robbie
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> This is the second time in six months this has happened on this
>>>>> laptop. The only other thing I can think of is that the laptop BIOS=

>>>>> reported that the charger wasn't supplying the correct wattage, and=
 I
>>>>> have no idea why it would do that=E2=80=94both laptop and charger a=
re nearly
>>>>> brand-new, less than a year old. The laptop model is a Lenovo Think=
pad
>>>>> T470.
>>>>>
>>>>> I've got backups, but reinstalling is a nuisance and I really don't=

>>>>> want to spend a couple of days getting the laptop working again. I
>>>>> don't have a conveniently large drive lying around to mirror this o=
ne
>>>>> onto.
>>>>>
>>>>> Robbie
>>>>>
>>>>
>>


--fe8Zo23YPYzd9tQUvFU9RCHcHuTLEq5KK--

--zlCEmx7Mohiwy1CBphK8UPDB1jYjB3Rnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mYUkACgkQwj2R86El
/qhe3Qf+KjYZDLI9mEiRUlS8wh0I52F1cZBbSnUGoSbE3LKD8yAefpF2K3tt+P48
zBR26gitPdwDuoTxPmQ96LqhR4uKtId0mnr9IFLm1KRYnGOVrvsy1rEjJIpMwFFB
lZlo9ojRuaXTknovxzm7otfVg90dGTxcZSYYnXrDFwu4txdby9rqe0gm3CTMr128
XH9slG57FSqLe84rvatvIoIOgpLfyINeup0Qp0CkIMFfYLpr3DJ8uHer++0LtZMz
6FKFmK/gT7NfrmOo3sLoNOTc4HGqh5eQAmrkMeKu3lUXx6BTZ9bobTQhGfLDam8U
DgcBVBgplpNjib5mTkubAtMynFLUUQ==
=sORs
-----END PGP SIGNATURE-----

--zlCEmx7Mohiwy1CBphK8UPDB1jYjB3Rnj--
