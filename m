Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD231D04DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEMC2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 22:28:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:41365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgEMC2s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 22:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589336921;
        bh=O8a9DSRHVKIWVhzguk1JBTFRJj4QVfBGPI+RJ17bJAc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=An4KsetltIPpFHNu1DHqspbxbXWKVk4WCHRSn9+Acig230l6639MvE/xi7/9674Ne
         UkIu6AlauKT7cPf5DRNIWd3HZiRZMln/Zls9mo2Dr3E6NxIlSNyKWH7oInpreBJIbh
         nUJIlD+y110tsizrSntGtZvgnOyF32InRFAwNeQ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1ivUhL3BId-00fmxa; Wed, 13
 May 2020 04:28:41 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
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
Message-ID: <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
Date:   Wed, 13 May 2020 10:28:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512141108.GW10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xsnxBFILIIvtURAOWwOcEPaCEytxM0MdQ"
X-Provags-ID: V03:K1:PJ1WpUfL/XGmeT7tgVKZLi768oMAfjo0hcVuHuqP7DNzYbUfw/8
 +oxSG3wq2ib9gDPrChZ5TJvDR6UqMRXXlmL1KAkAhwIkXvuJ+MVtCTq7GLk8/Y6rJePW3cj
 9yOlTYpL3QOBbsob31pKXMkYuy3kzI6ySn9u10m2TOc8C30HdNXgZO/64UBiqbunFoaNTrw
 kYF9tp2EAsQh/ID6zH3/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgB88xWUMqA=:p3/QbUDfnxJLmUswMTUfdU
 lD3mxFDrWe9MeyabDxXmC0UIcuzMqC8O2ju1iE+8+JvB8poWUDOwY5CEn5pOvwYaGLveraIJC
 TtwKx/t6VVHQaHy/H+WXBKdTjQ/hqkzqwcMPj03mWk42QBR68R4wDHsxcDSqrzM+7FtQWhPnl
 j+0BZqFxLncdBZRVSSMKIFzDzZGuYtDISeL4O9ZC52nR8P6iE0MfVWOC/yYo4Z7I2llrjPt4B
 4TisROx3exodiiKfunj3A7Eh8wp6ZisWff8Myr6qk5Qrcx7v1FA9nz3dRCcWgoXG9zH1GsV4P
 uy2scHM/9IBb1X0z150qkNaoxTIJELxFaKx2U4YiTEtg1BgRFGm9TL1L+faLq0/ySKcAIhpWm
 w2Fr7lv4oDd6rT5DPVFPjXck/dKqUyXvkmc5o7tw14U2+eAIxT6HFU2zbPjJdRrKQcjcrHLMo
 sAV3LjpvsxShLgVAyex+S6eOojhwy/bW5CinURWiNlDkgnk3t3+EZSpLCcq0fFhdBlOjTrn9g
 ExR2USkd/PZsCG08VHr9hr8V2ODW6fQ21iArLxOiaX2p5kb8XDzkUnG6rKXIOpp3CjqC/+xP1
 fUX1ZP0nS+2rFUT5rLpt4O45ZOClWzYDMY0CSs8N2e/md0C/go4bvHxoEucuaBXcUpdw30yrt
 ulubvlBvt7/SU2+nJrm75nVAczZuqrzzlLf8/m97fE6gRRvBgKctpWYVwwwyHUke/eSCB9M9m
 NGm8tjHYDTFVsjzHqH2Z9i7WeJc34AsGc/BM/xfrnXULF17CNDYjlY//VyKX6gg43Lo8jRodg
 fyBKM8zySnj7QelpCd1oTQNjcT0de9GCrI4XI5cddp3S32Zq7DFHHy4AuliC4+YTPrT6JyEVb
 OK0bRcJM5CQ54K4PFYwBrH3xaPzayaJZn8oIm8vrdjv39iCpWsqJP2lCXn5p/CM/EPZ1R1zvA
 3tSBgnIMRF45KosBSwGQ/DL2r2ZRwlXbHC4YFCTE+XEKzjxFhBZzEHVLb5hYiwenuGT6mwGW/
 evClU6gtA+MRMxlrusW736sfWn5fYIhKg/tVbjSHH3kK+35W2Ip/bZcuPu3/mYGK4rh15PKtW
 b9i+HzkIneGYyvHD5E8OBruhiKV5Nhak0r/1VaDhBOiv6/nSPWWplhpyaniXQaKyprVx4mCU8
 PLPns0Daj00iUKx/W3B1puXrgpQn7pMe5mrOm4pQ4qzhxoHDsNs4BIE9Nl9MjSCQSgPJoGuOC
 MLTNKSF6n0SVt2eSv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xsnxBFILIIvtURAOWwOcEPaCEytxM0MdQ
Content-Type: multipart/mixed; boundary="l3phuOxoZuKEmkcB40fcOGqRsDle6Yi3q"

--l3phuOxoZuKEmkcB40fcOGqRsDle6Yi3q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/12 =E4=B8=8B=E5=8D=8810:11, Zygo Blaxell wrote:
> On Tue, May 12, 2020 at 09:43:06AM -0400, Zygo Blaxell wrote:
>> On Mon, May 11, 2020 at 04:31:32PM +0800, Qu Wenruo wrote:
>>> Hi Zygo,
>>>
>>> Would you like to test this diff?
>>>
>>> Although I haven't find a solid reason yet, there is another report a=
nd
>>> with the help from the reporter, it turns out that balance hangs at
>>> relocating DATA_RELOC tree block.
>>>
>>> After some more digging, DATA_RELOC tree doesn't need REF_COW bit at =
all
>>> since we can't create snapshot for data reloc tree.
>>>
>>> By removing the REF_COW bit, we could ensure that data reloc tree alw=
ays
>>> get cowed for relocation (just like extent tree), this would hugely
>>> reduce the complexity for data reloc tree.
>>>
>>> Not sure if this would help, but it passes my local balance run.
>>
>> I ran it last night.  It did 30804 loops during a metadata block group=

>> balance, and is now looping on a data block group as I write this.

OK, not that surprised the patch doesn't help.
But still, the patch itself could still make sense for removing the
REFCOW bit for data reloc tree.

But I'm interesting in that, after that 30804 loops, it found its way to
next block group?!

>=20
> Here's the block group that is failing, and some poking around with it:=


In fact, such poking would be the most valuable part.

>=20
> 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_contents=
=2Epy 4368594108416 /media/testfs/
> 	block group vaddr 4368594108416 length 1073741824 flags DATA used 5305=
09824 used_pct 49
> 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags D=
ATA
> 	    inline shared data backref parent 4374646833152 count 1
> 	extent vaddr 4368715161600 length 120168448 refs 1 gen 1318394 flags D=
ATA
> 	    inline shared data backref parent 4374801383424 count 1
> 	extent vaddr 4368835330048 length 127623168 refs 1 gen 1318394 flags D=
ATA
> 	    inline shared data backref parent 4374801383424 count 1
> 	extent vaddr 4368962953216 length 124964864 refs 1 gen 1318394 flags D=
ATA
> 	    inline shared data backref parent 4374801383424 count 1
> 	extent vaddr 4369182420992 length 36700160 refs 1 gen 1321064 flags DA=
TA
> 	    inline extent data backref root 257 objectid 257 offset 822607872 =
count 1

One interesting thing is, there are 5 extents during the loop.
The first 4 looks like they belong to data reloc tree, which means they
have been swapped, waiting to be cleaned up.

The last one belongs to root 257, and looks like it hadn't been relocated=
=2E

>=20
> The extent data backref is unusual--during loops, I don't usually see t=
hose.
> And...as I write this, it disappeared (it was part of the bees hash tab=
le, and
> was overwritten).  Now there are 4 extents reported in the balance loop=
 (note:
> I added a loop counter to the log message):

Then it means the last one get properly relocated.

The cleanup for the first 4 doesn't happen properly.
>=20
> 	[Tue May 12 09:44:22 2020] BTRFS info (device dm-0): found 5 extents, =
loops 378, stage: update data pointers
> 	[Tue May 12 09:44:23 2020] BTRFS info (device dm-0): found 5 extents, =
loops 379, stage: update data pointers
> 	[Tue May 12 09:44:24 2020] BTRFS info (device dm-0): found 5 extents, =
loops 380, stage: update data pointers
> 	[Tue May 12 09:44:26 2020] BTRFS info (device dm-0): found 5 extents, =
loops 381, stage: update data pointers
> 	[Tue May 12 09:44:27 2020] BTRFS info (device dm-0): found 5 extents, =
loops 382, stage: update data pointers
> 	[Tue May 12 10:04:49 2020] BTRFS info (device dm-0): found 5 extents, =
loops 383, stage: update data pointers
> 	[Tue May 12 10:04:53 2020] BTRFS info (device dm-0): found 4 extents, =
loops 384, stage: update data pointers
> 	[Tue May 12 10:04:58 2020] BTRFS info (device dm-0): found 4 extents, =
loops 385, stage: update data pointers
> 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, =
loops 386, stage: update data pointers
> 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, =
loops 387, stage: update data pointers
> 	[Tue May 12 10:05:01 2020] BTRFS info (device dm-0): found 4 extents, =
loops 388, stage: update data pointers
>=20
> Some of the extents that remain are confusing python-btrfs a little:
>=20
> 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_data_ext=
ent_filenames.py 4368594108416 /media/testfs/
> 	block group vaddr 4368594108416 length 1073741824 flags DATA used 5305=
09824 used_pct 49
> 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags D=
ATA
> 	Traceback (most recent call last):
> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent=
_filenames.py", line 52, in <module>
> 	    inodes, bytes_missed =3D logical_to_ino_fn(fs.fd, extent.vaddr)
> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent=
_filenames.py", line 28, in find_out_about_v1_or_v2
> 	    inodes, bytes_missed =3D using_v2(fd, vaddr)
> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent=
_filenames.py", line 17, in using_v2
> 	    inodes, bytes_missed =3D btrfs.ioctl.logical_to_ino_v2(fd, vaddr, =
ignore_offset=3DTrue)
> 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 565, =
in logical_to_ino_v2
> 	    return _logical_to_ino(fd, vaddr, bufsize, ignore_offset, _v2=3DTr=
ue)
> 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 581, =
in _logical_to_ino
> 	    fcntl.ioctl(fd, IOC_LOGICAL_INO_V2, args)

I'm a little surprised about the it's using logical ino ioctl, not just
TREE_SEARCH.

I guess if we could get a plain tree search based one (it only search
commit root, which is exactly balance based on), it would be easier to
do the digging.

> 	OSError: [Errno 22] Invalid argument
>=20
> 	root@tester:~# btrfs ins log 4368594108416 /media/testfs/
> 	/media/testfs//snap-1589258042/testhost/var/log/messages.6.lzma
> 	/media/testfs//current/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589249822/testhost/var/log/messages.6.lzma
> 	ERROR: ino paths ioctl: No such file or directory
> 	/media/testfs//snap-1589249547/testhost/var/log/messages.6.lzma
> 	ERROR: ino paths ioctl: No such file or directory
> 	/media/testfs//snap-1589248407/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589256422/testhost/var/log/messages.6.lzma
> 	ERROR: ino paths ioctl: No such file or directory
> 	/media/testfs//snap-1589251322/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589251682/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589253842/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589246727/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589258582/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589244027/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589245227/testhost/var/log/messages.6.lzma
> 	ERROR: ino paths ioctl: No such file or directory
> 	ERROR: ino paths ioctl: No such file or directory
> 	/media/testfs//snap-1589246127/testhost/var/log/messages.6.lzma
> 	/media/testfs//snap-1589247327/testhost/var/log/messages.6.lzma
> 	ERROR: ino paths ioctl: No such file or directory
>=20
> Hmmm, I wonder if there's a problem with deleted snapshots?

Yes, also what I'm guessing.

The cleanup of data reloc tree doesn't look correct to me.

Thanks for the new clues,
Qu

>  I have those
> nearly continuously in my test environment, which is creating and delet=
ing
> snapshots all the time.
>=20
> 	root@tester:~# btrfs ins log 4368594108416 -P /media/testfs/
> 	inode 20838190 offset 0 root 10347
> 	inode 20838190 offset 0 root 8013
> 	inode 20838190 offset 0 root 10332
> 	inode 20838190 offset 0 root 10330
> 	inode 20838190 offset 0 root 10331
> 	inode 20838190 offset 0 root 10328
> 	inode 20838190 offset 0 root 10329
> 	inode 20838190 offset 0 root 10343
> 	inode 20838190 offset 0 root 10333
> 	inode 20838190 offset 0 root 10334
> 	inode 20838190 offset 0 root 10336
> 	inode 20838190 offset 0 root 10338
> 	inode 20838190 offset 0 root 10325
> 	inode 20838190 offset 0 root 10349
> 	inode 20838190 offset 0 root 10320
> 	inode 20838190 offset 0 root 10321
> 	inode 20838190 offset 0 root 10322
> 	inode 20838190 offset 0 root 10323
> 	inode 20838190 offset 0 root 10324
> 	inode 20838190 offset 0 root 10326
> 	inode 20838190 offset 0 root 10327
> 	root@tester:~# btrfs sub list -d /media/testfs/
> 	ID 10201 gen 1321166 top level 0 path DELETED
> 	ID 10210 gen 1321166 top level 0 path DELETED
> 	ID 10230 gen 1321166 top level 0 path DELETED
> 	ID 10254 gen 1321166 top level 0 path DELETED
> 	ID 10257 gen 1321166 top level 0 path DELETED
> 	ID 10274 gen 1321166 top level 0 path DELETED
> 	ID 10281 gen 1321166 top level 0 path DELETED
> 	ID 10287 gen 1321166 top level 0 path DELETED
> 	ID 10296 gen 1321166 top level 0 path DELETED
> 	ID 10298 gen 1321166 top level 0 path DELETED
> 	ID 10299 gen 1321166 top level 0 path DELETED
> 	ID 10308 gen 1321166 top level 0 path DELETED
> 	ID 10311 gen 1321166 top level 0 path DELETED
> 	ID 10313 gen 1321166 top level 0 path DELETED
> 	ID 10315 gen 1321166 top level 0 path DELETED
> 	ID 10317 gen 1321166 top level 0 path DELETED
> 	ID 10322 gen 1321166 top level 0 path DELETED
> 	ID 10323 gen 1321166 top level 0 path DELETED
> 	ID 10327 gen 1321166 top level 0 path DELETED
> 	ID 10328 gen 1321166 top level 0 path DELETED
> 	ID 10330 gen 1321166 top level 0 path DELETED
> 	ID 10333 gen 1321166 top level 0 path DELETED
>=20
>=20
>>> Thanks,
>>> Qu
>>
>>> From 82f3b96a68561b2de9712262cb652192b8ea9b1b Mon Sep 17 00:00:00 200=
1
>>> From: Qu Wenruo <wqu@suse.com>
>>> Date: Mon, 11 May 2020 16:27:43 +0800
>>> Subject: [PATCH] btrfs: Remove the REF_COW bit for data reloc tree
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/disk-io.c    | 9 ++++++++-
>>>  fs/btrfs/inode.c      | 6 ++++--
>>>  fs/btrfs/relocation.c | 3 ++-
>>>  3 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 56675d3cd23a..cb90966a8aab 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -1418,9 +1418,16 @@ static int btrfs_init_fs_root(struct btrfs_roo=
t *root)
>>>  	if (ret)
>>>  		goto fail;
>>> =20
>>> -	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
>>> +	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
>>> +	    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>>>  		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
>>>  		btrfs_check_and_init_root_item(&root->root_item);
>>> +	} else if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJ=
ECTID) {
>>> +		/*
>>> +		 * Data reloc tree won't be snapshotted, thus it's COW only
>>> +		 * tree, it's needed to set TRACK_DIRTY bit for it.
>>> +		 */
>>> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>>>  	}
>>> =20
>>>  	btrfs_init_free_ino_ctl(root);
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 5d567082f95a..71841535c7ca 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -4129,7 +4129,8 @@ int btrfs_truncate_inode_items(struct btrfs_tra=
ns_handle *trans,
>>>  	 * extent just the way it is.
>>>  	 */
>>>  	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>>> -	    root =3D=3D fs_info->tree_root)
>>> +	    root =3D=3D fs_info->tree_root ||
>>> +	    root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)
>>>  		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
>>>  					fs_info->sectorsize),
>>>  					(u64)-1, 0);
>>> @@ -4334,7 +4335,8 @@ int btrfs_truncate_inode_items(struct btrfs_tra=
ns_handle *trans,
>>> =20
>>>  		if (found_extent &&
>>>  		    (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>>> -		     root =3D=3D fs_info->tree_root)) {
>>> +		     root =3D=3D fs_info->tree_root ||
>>> +		     root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID=
)) {
>>>  			struct btrfs_ref ref =3D { 0 };
>>> =20
>>>  			bytes_deleted +=3D extent_num_bytes;
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index f25deca18a5d..a85dd5d465f6 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_han=
dle *trans,
>>>  		 * if we are modifying block in fs tree, wait for readpage
>>>  		 * to complete and drop the extent cache
>>>  		 */
>>> -		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
>>> +		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
>>> +		    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {=

>>>  			if (first) {
>>>  				inode =3D find_next_inode(root, key.objectid);
>>>  				first =3D 0;
>>> --=20
>>> 2.26.2
>>>
>>
>>
>>
>>
>=20
>=20


--l3phuOxoZuKEmkcB40fcOGqRsDle6Yi3q--

--xsnxBFILIIvtURAOWwOcEPaCEytxM0MdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl67W1UACgkQwj2R86El
/qjANgf+OG2yrRDXXeiok5aySKf0DwqusX0FCAQApjP5QIbE2cE7fhyi9ta52bHl
DrJbhkEJ4GIu0/rFBzCa0yW3Q+adxI6E4V0fDrCIMZMS1daAz4VK05RHmgsIeLSA
DptzPK90JNC3karKR7w4RFJn5QwFO4kLYYbAemAk+aNYR7omO27rWNpfWhZfGZ4y
lUMPkDl0YJpZ8axftSGNuwyicQ6Lwam0Zeoz7gkFjZs5tIVRHxe7kbt91Ua2CcAn
7sgMP2UucLJeEMyfQjNudeoTXZizRxY5c+I1a56n/M4z50jzjwe/+zJZSWLwUGu3
wwv648EWYERDdwDvRQB2Pi3npK+1Pw==
=ihi5
-----END PGP SIGNATURE-----

--xsnxBFILIIvtURAOWwOcEPaCEytxM0MdQ--
