Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DDB1D7058
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 07:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgERFZr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 01:25:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:46921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERFZr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 01:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589779539;
        bh=d8qeRX9CFefNUJvr6VrhQP0epDHJeLzBwtcU/kCUnU4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dJXIfbW4Cq6KkOBO+kI0uavfgAXw/+mgd04bqRSooLbMc8YX7oVoUvWOXYSXte6lO
         6tIHQLK8A4I8VLPFnr5NHmmUiCfdvvaXdQMiechp+KmnsvdLXVzPdlNyXY2UtVJjR3
         wEDu5ZHN5XmHAGcsFxmc8gx1M4b5QZzNICCwQ5vY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mgeo8-1j9A583A6O-00hA0l; Mon, 18
 May 2020 07:25:39 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
 <20200513122140.GA10769@hungrycats.org>
 <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
 <70689a06-dc5f-5102-c0bb-23eadad88383@gmx.com>
 <20200514174409.GC10769@hungrycats.org>
 <db056259-1d41-68dd-b69a-d62522e09b4b@gmx.com>
 <20200515151456.GF10796@hungrycats.org>
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
Message-ID: <92c41fa9-e3ea-d57c-70cb-82c3c11dd85e@gmx.com>
Date:   Mon, 18 May 2020 13:25:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515151456.GF10796@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wh7xN4rvGmilBtcTN5fpdZ4EXV3ctxCpd"
X-Provags-ID: V03:K1:F1hR+rOMwgDwdYJqqc+QfiZ5dxQlSDih3d6YsaYryGJ70LbUcrk
 wSIsm/slFt31hX5LGrEj+ehikGZlv2di7Me8zl/aC24Uf0hOnWPj3Tw1/l7zzVrkGnSyObZ
 Vg2xjMOFozRHBenlDZXqOjXx3uuOrG//dcoK9KE1DIX7ti8owpmDFC3TOC809GQZOJVcqe6
 bkTxLZ9vN4tg8zrafq7zA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X2Hsxa+tmDg=:yEaoKpG6s5lpv3IU+Sks84
 zA87wBHzEcykdaULGFGj0bDkoOND14YEcORiot4jAH8uoemG8uu/ps+N78eu11mfJPECtx/4N
 7d1FCE40nG8iipJllctTpcl2kAZh77wrKFuxjBmy6elhDhCRiADj35PRBGoRnS6GD9tw1kvGc
 YIbHkITE9+JKrdKVlH5/bVtcbS/7IBcYEl8OpEU4lzAat53boPokhX44WbCGH4aBWu54NXh6P
 kg3OclijxTG0+ELkH9nxJjL2cXTFCZDI1rsBnmOZu/t0JnWCpcObuxvkK5/rSlqlgxWuoB0yA
 3jOUE+bObr6NDozk7FYjEBS+VmHoOfYggeSz6+kcC749p2fsLqfP3KGUwqi5cnWsMbxKMAK03
 OEUVivq+Vh0v1dANd3NXXGLGN+pB8riE2+BiZflGUd1fTAtTUFU5S6Luzdd7zzkYNUom72D4a
 QpXPcIu+6ZiDUrXKwZHGZh+KNCQbqgKqmrOpdzmsj/AvKI+YmG7aLQLJIEebIeb1sFCz2Rktj
 ABaWuJDkAKOds5/oTh+iuNItK1LTBG3Rp74bix+Q4iCi0JlMudBCQxiFZEJp9dTBn2UeLja0m
 xMf8nG6S0WlG6MLyfcrUrMCeC+jJuiWefe9kxBVXnlVNDKrCcsOw8rMa4ko5TpJlMD0kcX/Li
 6aiBaIMMP/SnrOKoJO14EHt0ecf6WmvZQ7kTdTupEFWED7lbtHo94Jnflt+SmoA7/dq+Rn/HS
 0ONydVDpBt7hlSPWs0VJTB34ki1b8qY1BxkAjtsRr4yZ5BBwIk+ZBZiGhKiahhNqLe7bDK3eM
 7vwcQgIRWu7W5ZhTdk6I45iHZE3+xdzhXIc6OsCobZrJKcXDSmm/uLLMhCMiwaXnnN+HpdA47
 EOfd7z7vCgYr/SkL/oCE8EO45HhrPnXDo2G4t2Cxb1C+k5jbCjzVUSGRerjOHkw5y4woZkjTx
 K+51tVcTKXnGvs/xnz6nTZuotSWr1CkI19E7NrxZeGVuwePzJNROcgoG/zbDePGqXEgG1xH6Y
 t0MdTyO0aqwlCoQp0vkGWYDIDEFDCNicHy/td8QHsOKn11QNk8lp/fS9cpd+nZbj+vPJBZ4+R
 PuMW9FCo68JprdwvDBKjqXsB5FPmKLYBbCwYGFDFGdL7qwnMy+LADjtm3tGTGpU1A5F+Fbsfp
 iAj5Seo3r4M8hpiSC6LZh2HkP4HjdxY7bBaSlbgTFRypmGpnw6SWcjCwgRlUHXFSO/mIUMjSu
 +fqhPgKjHj8Gn3PLh
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wh7xN4rvGmilBtcTN5fpdZ4EXV3ctxCpd
Content-Type: multipart/mixed; boundary="nidc6KHEbAaRrqk8L52qfsbks3gVrd5sJ"

--nidc6KHEbAaRrqk8L52qfsbks3gVrd5sJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/15 =E4=B8=8B=E5=8D=8811:17, Zygo Blaxell wrote:
> On Fri, May 15, 2020 at 02:57:52PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/5/15 =E4=B8=8A=E5=8D=881:44, Zygo Blaxell wrote:
>>> On Thu, May 14, 2020 at 04:55:18PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/5/14 =E4=B8=8B=E5=8D=884:08, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2020/5/13 =E4=B8=8B=E5=8D=888:21, Zygo Blaxell wrote:
>>>>>> On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>> [...]
>>>>>>
>>>>>> Kernel log:
>>>>>>
>>>>>> 	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -=
d
>>>>>> 	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block=
 group 4396679168000 flags data
>>>>>> 	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block=
 group 4395605426176 flags data
>>>>>> 	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block=
 group 4394531684352 flags data
>>>>>> 	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents=
, loops 1, stage: move data extents
>>>>>> 	[...]
>>>>>> 	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extent=
s, loops 131823, stage: update data pointers
>>>>>> 	(qemu) stop
>>>>>>
>>>>>> btrfs-image URL:
>>>>>>
>>>>>> 	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin
>>>>>>
>>>>> The image shows several very strange result.
>>>>>
>>>>> For one, although we're relocating block group 4394531684352, the
>>>>> previous two block groups doesn't really get relocated.
>>>>>
>>>>> There are still extents there, all belongs to data reloc tree.
>>>>>
>>>>> Furthermore, the data reloc tree inode 620 should be evicted when
>>>>> previous block group relocation finishes.
>>>>>
>>>>> So I'm considering something went wrong in data reloc tree, would y=
ou
>>>>> please try the following diff?
>>>>> (Either on vanilla kernel or with my previous useless patch)
>>>>
>>>> Oh, my previous testing patch is doing wrong inode put for data relo=
c
>>>> tree, thus it's possible to lead to such situation.
>>>>
>>>> Thankfully the v2 for upstream gets the problem fixed.
>>>>
>>>> Thus it goes back to the original stage, still no faster way to
>>>> reproduce the problem...
>>>
>>> Can we attack the problem by logging kernel activity?  Like can we
>>> log whenever we add or remove items from the data reloc tree, or
>>> why we don't?
>>>
>>> I can get a filesystem with a single data block group and a single
>>> (visible) extent that loops, and somehow it's so easy to do that that=
 I'm
>>> having problems making filesystems _not_ do it.  What can we do with =
that?
>>
>> OK, finally got it reproduced, but it's way more complex than I though=
t.
>>
>> First, we need to cancel some balance.
>> Then if the canceling timing is good, next balance will always hang.
>=20
> I've seen that, but it doesn't seem to be causative, i.e. you can use
> balance cancel to trigger the problem more often, but cancel doesn't
> seem to cause the problem itself.
>=20
> I have been running the fast balance cancel patches on kernel 5.0 (this=

> is our current production kernel).  Balances can be cancelled on that
> kernel with no looping.  I don't know if the cancel leaves reloc trees
> in weird states, but the reloc roots merging code manages to clean them=

> up and break balance out of the loop.
>=20
> Loops did occur in test runs before fast balance cancels (or balance
> cancels at all) and others have reported similar issues without patched=

> kernels; however, those older observations would be on kernels 5.2 or
> 5.3 which had severe UAF bugs due to the delayed reloc roots change.
>=20
> A lot of weird random stuff would happen during balances on older kerne=
ls
> that stopped after the UAF bug fix in 5.4.14; however, the balance loop=
s
> persist.
>=20
>> Furthermore, if the kernel has CONFIG_BTRFS_DEBUG compiled, the kernel=

>> would report leaking reloc tree, then followed by NULL pointer derefer=
ence.
>=20
> That I have not seen.  I'm running misc-next, and there were some fixes=

> for NULL derefs caught by the new reference tracking code.  Maybe it's
> already been fixed?

Latest misc-next still shows the NULL pointer dereference, so that's
something persistent, and would help me to ping down the bug.

Thanks,
Qu

>=20
>> Now since I can reproduce it reliably, I guess I don't need to bother
>> you every time I have some new things to try.
>>
>> Thanks for your report!
>> Qu
>>
>>>
>>> What am I (and everyone else with this problem) doing that you are no=
t?
>>> Usually that difference is "I'm running bees" but we're running out o=
f
>>> bugs related to LOGICAL_INO and the dedupe ioctl, and I think other p=
eople
>>> are reporting the problem without running bees.  I'm also running bal=
ance
>>> cancels, which seem to increase the repro rate (though they might jus=
t
>>> be increasing the number of balances tested per day, and there could =
be
>>> just a fixed percentage of balances that loop).
>>>
>>> I will see if I can build a standalone kvm image that generates balan=
ce
>>> loops on blank disks.  If I'm successful, you can download it and the=
n
>>> run all the experiments you want.
>>>
>>> I also want to see if reverting the extended reloc tree lifespan patc=
h
>>> (d2311e698578 "btrfs: relocation: Delay reloc tree deletion after
>>> merge_reloc_roots") stops the looping on misc-next.  I found that
>>> reverting that patch stops the balance looping on 5.1.21 in an earlie=
r
>>> experiment.  Maybe there are two bugs here, and we've already fixed o=
ne,
>>> but the symptom won't go away because some second bug has appeared.
>=20
> I completed this experiment.  I reverted the delay reloc tree commit,
> which required also reverting all the bug fixes on top of delay reloc
> tree in later kernels...
>=20
> 	Revert "btrfs: relocation: Delay reloc tree deletion after merge_reloc=
_roots"
> 	Revert "btrfs: reloc: Fix NULL pointer dereference due to expanded rel=
oc_root lifespan"
> 	Revert "btrfs: reloc: Also queue orphan reloc tree for cleanup to avoi=
d BUG_ON()"
> 	Revert "btrfs: relocation: fix use-after-free on dead relocation roots=
"
> 	Revert "btrfs: relocation: fix reloc_root lifespan and access"
> 	Revert "btrfs: reloc: clean dirty subvols if we fail to start a transa=
ction"
> 	Revert "btrfs: unset reloc control if we fail to recover"
> 	Revert "btrfs: fix transaction leak in btrfs_recover_relocation"
>=20
> This test kernel also has fast balance cancel backported:
>=20
> 	btrfs: relocation: Check cancel request after each extent found
> 	btrfs: relocation: Check cancel request after each data page read
> 	btrfs: relocation: add error injection points for cancelling balance
>=20
> My test kernel is based on 5.4.40.  On 5.7-rc kernels there's a lot
> of changes for refcounting roots that are too much for mere git reverts=

> to unwind.
>=20
> I ran it for a while with randomly scheduled balances and cancels: 65
> block groups, 47 balance cancels, 20 block groups completed, 0 extra
> loops.  With the delay reloc tree commit in place it's normally not mor=
e
> than 5 block groups before looping starts.
>=20
>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>>>> index 9afc1a6928cf..ef9e18bab6f6 100644
>>>>> --- a/fs/btrfs/relocation.c
>>>>> +++ b/fs/btrfs/relocation.c
>>>>> @@ -3498,6 +3498,7 @@ struct inode *create_reloc_inode(struct
>>>>> btrfs_fs_info *fs_info,
>>>>>         BTRFS_I(inode)->index_cnt =3D group->start;
>>>>>
>>>>>         err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>>>>> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>>>>>  out:
>>>>>         btrfs_put_root(root);
>>>>>         btrfs_end_transaction(trans);
>>>>> @@ -3681,6 +3682,7 @@ int btrfs_relocate_block_group(struct
>>>>> btrfs_fs_info *fs_info, u64 group_start)
>>>>>  out:
>>>>>         if (err && rw)
>>>>>                 btrfs_dec_block_group_ro(rc->block_group);
>>>>> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>>>>>         iput(rc->data_inode);
>>>>>         btrfs_put_block_group(rc->block_group);
>>>>>         free_reloc_control(rc);
>>>>>
>>>>
>>>
>>>
>>>
>>
>=20
>=20
>=20


--nidc6KHEbAaRrqk8L52qfsbks3gVrd5sJ--

--Wh7xN4rvGmilBtcTN5fpdZ4EXV3ctxCpd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7CHE8ACgkQwj2R86El
/qi/SAf/dLhxVzBdVKEx1lV0kQAMyZqKSNyzlkn6fh02iRG7/83iNKWqED/mV7js
3LT18S2SrQlJlKaBpDRXmW2dWE3/OsMToVprvTfPzOknZmaCsDYBxEWONC1Y72+J
0TR9vF9EaW3PkaRshm4c+KMLtkmH4+Al4/KUZbaPwimx2TX5/x1Q5RlgWNaljKrL
OMWJQuQoyZOBPQDyGjh2py+GrEzEM/kh1mRdWQa/coZaxrdujYQFjn3SfXpDHROP
8zabgucAHAnDGjThqM0enRP5ThVOKepjlJ+pSywFGpnUjkE2/f2v1k0EYnnFp6gO
PGWsKlWK7lHY4IUCq6xgdQTQ+LsfIA==
=IeC9
-----END PGP SIGNATURE-----

--Wh7xN4rvGmilBtcTN5fpdZ4EXV3ctxCpd--
