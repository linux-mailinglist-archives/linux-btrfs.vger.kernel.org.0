Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1D12764D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 08:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLTHKM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 02:10:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:39165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfLTHKM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 02:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576825809;
        bh=7k3QM1DQoP9sXM/AhFcXNgXlE5iqpROhDo3sFfZ4Q0E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lth7Mmg72XSxip6DDRVD6xWJ51gFKUqr/4AFp+J2ErIxxUiPnjt+0U+N3vrl0zmkh
         5VdiW4Qbtk8qVLkTHWwSOR1PMz+PFOKHBUbx48Ni54Zx2uQTQy0VphuQaRA7vz+fet
         1ZYKcy+Hrhgk8c3NOjW9GdU+e2MCvI9eFOIEaAOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f9b-1ifjaR2jE7-0048so; Fri, 20
 Dec 2019 08:10:09 +0100
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
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
Message-ID: <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
Date:   Fri, 20 Dec 2019 15:10:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220063702.GE5861@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UjkRfm09JOXR348NjbYBOofBwuhTtPTm5"
X-Provags-ID: V03:K1:emwDwmPYGk+8+EmW5EOeccXYWkm0XulXuHXB6N9OBJR6wb6OjbG
 uWQFCcxiApbybuye4QD4HEKkkax6amLtUn8+wUR/IFdH+vwmiM84lcrczXUZrEdkX5Nq0cJ
 74082p3eNMRvQYjDYfUpJexuV27N5XJR/1GlKjpuhSY5Dr1qTYwJY3nyGGnbRHxpDFB8DBb
 RrtEuV0NkKV47FlDJ5FBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xh3IhZ+OUo=:0O7sWEmEkbYJ6ocQShGGSM
 CGOrVRVsrE4eXd+seCjNWStKPnk0mf8OFnvwsoz3M/8mD507pxlW0rWSytYhu8SiYfi2f2R1g
 CyRLUg5m4/+nYwTYlXAfAwOVG3PiSE1whTxU5FKQxEkc5Gn4rpWgUSXaMg0A02DPW+YK4arjb
 kp1yU/iEnLj6eShPoF6L39uX/fIdMPb1Cdc8X0um07K/ZnHEPmyHrqvaQLRET5ZcfcARCPAZb
 i+lYlrQRC9TkyCo7dNrrFSDePuBdHchnkMgDORmJUXF+LMbLyHdR0spEMjJlNgahBzU8lw1Mm
 Wg5y30HSTcD2ElHUChcXCgcG9RksBNXSRqZSmLZNQb2Q7Ye/GDDnAMUmOWGa3ikj+iiEeIf1S
 R8ljQaU1PziHrCnCyRM8ebR3psrcJ3C2VzfhcZFpNu5x+lM5SmDREWCusAV/o4uzwI0x2oZ3n
 1NQANWG2Rm83xRMR2EIpKUdPvf8cDLneZffznnoPNFA/bLMjUPCG95LR4QMAM/8Pfu+X6bsbA
 eQMF2ZYo4LipjGkvX1wNFtG+huV00x2CMBpcAo1HRtcHMYW9LTU8Fnyyovkjabs6eEEhm/gsp
 +qYpvzDabjpq+yBF/oUbLRnTV7F7h25UfTHOLsIVe8sVKGTLIEaAi+ZkP5xyF/bwOzQGmJXrg
 SlPYz+EpTlfnKx/3pxNVqtSOPlqS/h7KJ/08lzv3gVGGKAnlUhq5JQaFBZFamirE5q5UrUTXY
 XOVuT9F/YYGMRafgekg1y1NL8ya8+jar+y1RtGODtU9jtcb4BCdOev+wNf0Srl+2MfNrQzcLK
 fp5SjMCbH8ItL9BVd518kkAGIIALVWL8t213awEyPByLSddwqZOfby5g5YGcM1A/JIYMeDwVw
 IYR2FSWN7MseUjBdBY5D9UTjCP8/GsyvD3DdYixQnXpvXYPiprGNS7XDvdvQTj2H7shsOTHKS
 CmO06Q7o3SwM/eWxBD8Y/FMLEJ7A6WcK5Gr3E/GIn8jKU8bHakEXpXZ22fW0jeNCmfrzEUb3C
 HKGsMfIINnPyt5hkzLyMxoURqqfitha8jltpPtsCEEeRXGdUFIJxZ2gAsiTrQTQm1UxpSNt8S
 TDpM31Ulcl5w4qdvaRiX8mXn25kjuZETBYK1Ea2zfmBbqAqUsu4Mmyl7Y7D8pyXn/amz0I6I7
 fKGJWE6mMMeLZHpyz/YKYTsXK/K1KhLTCYypSswSAHySwi6+1vMt23jO2X7GL3u2G7hR3qdfd
 XoPZYC7J1o2f0lWWeDYTaJlEcFvHrn+gizQtvfpD0X+3uK7/QC5CVOUeU9tM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UjkRfm09JOXR348NjbYBOofBwuhTtPTm5
Content-Type: multipart/mixed; boundary="7OULKL9FN6XSurA6EI9MAu3wGxYe35lVG"

--7OULKL9FN6XSurA6EI9MAu3wGxYe35lVG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/20 =E4=B8=8B=E5=8D=882:37, Marc Lehmann wrote:
> On Fri, Dec 20, 2019 at 01:24:20PM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>>> I used btrfs del /somedevice /mountpoint to remove a device, and then=
 typed
>>> sync. A short time later the system had a hard reset.
>>
>> Then it doesn't look like the title.
>=20
> Hmm, I am not sure I understand: do you mean the subject?

Oh, sorry, I mean subject line "btrfs dev del not transaction protected".=


> The command here
> is obviously not copied and pasted, and when typing it into my mail cli=
ent,
> I forgot the "dev" part. The exact command, I think, was this:

No big deal, as we all get the point.

>=20
>    btrfs dev del /dev/mapper/xmnt-cold13 /oldcold>
>> Normally for sync, btrfs will commit transaction, thus even something
>> like the title happened, you shouldn't be affected at all.
>=20
> Exactly, that is my expectation.
>=20
>>> [  247.385346] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac=
-45b3-b9ba-ed1ec5f92403 is missing
>>> [  247.386942] BTRFS error (device dm-32): failed to read chunk tree:=
 -2
>>> [  247.462693] BTRFS error (device dm-32): open_ctree failed
>>
>> Is that devid 1 the device you tried to deleted?
>> Or some unrelated device?
>=20
> I think the device I removed had devid 1. I am not 100% sure, but I am
> reasonably sure because I had "watch -n10 btrfs dev us" running while
> waiting for the removal to finish and not being able to control the dev=
ice
> ids triggers my ocd reflexes (mostly because btrfs fi res needs the dev=
ice
> id even for some single-device filesystems :), so I kind of memorised
> them.

Then it looks like a big deal.

After looking into the code (at least v5.5-rc kernel), btrfs will commit
transaction after deleting the device item in btrfs_rm_dev_item().

So even no manual sync is called, as long as there is no error report
from "btrfs dev del", such case shouldn't happen.

>=20
>>> The thing is, the device is still there and accessible, but btrfs no =
longer
>>> recognises it, as it already deleted it before the crash.
>>
>> I think it's not what you thought, but btrfs device scan is not proper=
ly
>> triggered.
>=20
> Quite possible - I based my statement that it is no longer recognized
> based on the fact that a) blkid also didn't recognize a filesystem on
> the removed device anymore and b) btrfs found the other two remaining
> devices, so if btrfs scan is not properly triggered, then this is a
> serious issue in current GNU/Linux distributions (I use debian buster o=
n
> that server).

a) means btrfs has wiped the superblock, which happens after
btrfs_rm_dev_item().
Something is not sane now.

>=20
> I assume that the device is not recognised as btrfs by blkid anymore
> because the signature had been wiped by btrfs dev del, based on previou=
s
> experience, but I of course can't exactly know it's not, say, a hardwar=
e
> error that wiped that disk, although I would find that hard to believe =
:)
>=20
>> Would you please give some more dmesg? As each scanned btrfs device wi=
ll
>> show up in dmesg.
>=20
> Here should be all btrfs-related messages for this (from grep -i btrfs)=
:
>=20
>  [   10.288533] BTRFS: device label ROOT devid 1 transid 2106939 /dev/m=
apper/vg_doom-root
>  [   10.314498] BTRFS info (device dm-0): disk space caching is enabled=

>  [   10.316488] BTRFS info (device dm-0): has skinny extents
>  [   10.900930] BTRFS info (device dm-0): enabling ssd optimizations
>  [   10.902741] BTRFS info (device dm-0): disk space caching is enabled=

>  [   11.524129] BTRFS info (device dm-0): device fsid bb3185c8-19f0-401=
8-b06f-38678c06c7c2 devid 1 moved old:/dev/mapper/vg_doom-root new:/dev/d=
m-0
>  [   11.528554] BTRFS info (device dm-0): device fsid bb3185c8-19f0-401=
8-b06f-38678c06c7c2 devid 1 moved old:/dev/dm-0 new:/dev/mapper/vg_doom-r=
oot
>  [   42.273530] BTRFS: device label LOCALVOL3 devid 1 transid 1240483 /=
dev/dm-28
>  [   42.312354] BTRFS info (device dm-28): enabling auto defrag
>  [   42.314152] BTRFS info (device dm-28): force zstd compression, leve=
l 12
>  [   42.315938] BTRFS info (device dm-28): using free space tree
>  [   42.317696] BTRFS info (device dm-28): has skinny extents
>  [   49.115007] BTRFS: device label LOCALVOL5 devid 1 transid 146201 /d=
ev/dm-29
>  [   49.138816] BTRFS info (device dm-29): using free space tree
>  [   49.140590] BTRFS info (device dm-29): has skinny extents
>  [  102.348872] BTRFS info (device dm-29): checking UUID tree
>  [  102.393185] BTRFS: device label COLD1 devid 5 transid 1876906 /dev/=
dm-30

dm-30 is one transaction older than other devices.

Is that expected? If not, it may explain why we got the dead device. As
we're using older superblock, which may points to older chunk tree which
has the device item.

>  [  109.626550] BTRFS: device label COLD1 devid 4 transid 1876907 /dev/=
dm-32
>  [  109.654401] BTRFS: device label COLD1 devid 3 transid 1876907 /dev/=
dm-31

And I'm also curious about the 7s delay between devid5 and devid 3/4
detection.

Can you find a way to make devid 3/4 show up before devid 5 and try again=
?

And if you find a way to mount the volume RW, please write a single
empty file, and sync the fs, then umount the fs, ensure "btrfs ins
dump-super" gives the same transid of all 3 related disks.

Then the problem *may* be gone if it matches my assumption.
(After all these assumed success, please to do an unmounted btrfs check
just to make sure nothing is wrong)

>  [  109.656171] BTRFS info (device dm-32): use zstd compression, level =
12
>  [  109.657924] BTRFS info (device dm-32): using free space tree
>  [  109.660917] BTRFS info (device dm-32): has skinny extents
>  [  109.662687] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-=
45b3-b9ba-ed1ec5f92403 is missing
>  [  109.664832] BTRFS error (device dm-32): failed to read chunk tree: =
-2
>  [  109.742501] BTRFS error (device dm-32): open_ctree failed
>=20
> At this point, /dev/mapper/xmnt-cold11 (dm-32),
> /dev/mapper/xmnt-oldcold12 (dm-31) and /dev/mapper/xmnt-cold14 (dm-30)
> were the remaining disks in the filesystem, while xmnt-cold13 was the
> device I had formerly removed (which doesn't show up).
>=20
> (There are two btrfs filesystems with the COLD1 label in this machine a=
t
> the moment, as I was migrating the fs, but the above COLD1 messages sho=
uld
> all relate to the same fs).
>=20
> "blkid -o value -s TYPE /dev/mapper/xmnt-cold13" didn't give any output=

> (the mounting script checks for that and pauses to make provisioning
> of new disks easier), while normally it would give "btrfs" on volume
> members. This, I think, would be normal behaviour for devices that have=

> been removed from a btrfs.
>=20
> BTW, the four devices in question are all dmcrypt-on-lvm and are single=

> devices in a hardware raid controller (a perc h740).
>=20
>>> Probably nbot related, but maybe worth mentioning: I found that syste=
m
>>> crashes (resets, not power failures) cause btrfs to not mount the fir=
st
>>> time a mount is attempted, but it always succeeds the second time, e.=
g.:
>>>
>>>    # mount /device /mnt
>>>    ... no errors or warnings in kernel log, except:
>>>    BTRFS error (device dm-34): open_ctree failed
>>>    # mount /device /mnt
>>>    magically succeeds
>>
>> Yep, this makes it sound more like a scan related bug.
>=20
> BTW, this (second issue) also happens with filesystems that are not
> multi-device.

Single device btrfs doesn't need device scan.
If that happened, something insane happened again...
Thanks,
Qu

> Not sure if that menas that btrfs scan would be involved, as
> I would assume the only device btrfs would need in such cases is the on=
e
> given to mount, but maybe that also needs a working btrfs scan?
>=20
> Thanks for your working on btrfs btw. :)
>=20


--7OULKL9FN6XSurA6EI9MAu3wGxYe35lVG--

--UjkRfm09JOXR348NjbYBOofBwuhTtPTm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl38c80ACgkQwj2R86El
/qiKbQf8Cv3dlx9pOdIyPpp8u0I3+4/P+1hdtcXK7EzaspoQNTINoI7cGVeuw+b/
9etK+IKK7d5Plng6rxutZxxq0xgrrBqN6WiHAdNndWUF0lEQ2/mDIEHaBEV3ld3B
dgD0J5iRJ4pghC9c6MsDUsToJG2WJ9lmvVXYg7S8OALVjAQR2mB7oAwcGmsa3bB0
0WzKW0NL/cVBNONDuuQ2ASiFwkw5MXc+NyC1FR7K4GZWdjU9ohAxqt10VEYlMN83
YYy+jK9kB3/RCfdmtNMHiT0brek7eQdDzQzquLWjReocRNzbck5qw3uqDaWs+Sxa
i5hwSi9yrtpD5iFAbxq9kor9HkwLhA==
=yzVZ
-----END PGP SIGNATURE-----

--UjkRfm09JOXR348NjbYBOofBwuhTtPTm5--
