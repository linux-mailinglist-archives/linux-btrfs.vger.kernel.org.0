Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12B21DABFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgETH1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 03:27:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:33393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETH1e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 03:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589959648;
        bh=cxM8hSA73QoRLJw+hwT7cbV3yOxW9VPaXEvcFoG/jZA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QTzUh1ZFSSWQJPqr9HqtHwQ3Ez1ItHKxcxSwRS2vy+pOcAYt+8+Z/2nnTp6pNe6V7
         XtSY78ULm00mD+mSPQA4dVV8bwJ9zh0qHExZGuIEztlYlhO+CWUG9eKFzOkWLxCfQ+
         fxvoo3EreCiaNvBwX/XI09hcBrj/Bok/mVLjVCIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1iyLGu1SR1-014z7V; Wed, 20
 May 2020 09:27:28 +0200
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
Message-ID: <b28aad68-727c-c319-ba7e-454ea4620b96@gmx.com>
Date:   Wed, 20 May 2020 15:27:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515151456.GF10796@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RyKcFuUOTFrBiyV05PbApyPn1hwVN6GzE"
X-Provags-ID: V03:K1:nR/jAq0ax8ztWgSog7+I+++fLplfibUq2CJVfMvsgvRDz1hwmIt
 3MLpOe1Yjq5AvL0Kcscp4s1WwZY9h1ueEbQILud1BC+BFWqs4GgNtWQ35YDKHA2EgiyrtfL
 FlQGZNIcWEyEPidpnIywWG+He6g9qCkAhxjkVTVVHF8AndBMtpmZBQ5ovI5CSS3ml5hV6JN
 IUkA8nKqETcXaMbYV86jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:19WZggskdZ0=:q9f2AwivtVKWYlegQgT/gz
 wvtxac9IgudUdSdQVVMq0fvferiX4cxOAQcIAOoK1IUgMVKTwGZTjxXE1e12GlWQpDZxshJfb
 x4t7h3BWUbZFYJ4uYQZhvDxuWdZeZvXR38NJD8lMqCqqm4hUveEe5bixiwtlb/EQPTsO8bHV5
 cnigQ6hvj+hs0TQ+sEiuYSAuHKAo8B3McI8ihgwmuzYS+3DYsqF6YZ8rlJRw9/Lg5kyGXUs0I
 dgv4lt+lA+bN2duCRhIH8QThg+XKm9yHqQbqry6p4PLSjcN3PVqmr3O6v7BBbYdLmn3Fd5olE
 3f6qUyhDlgYLz9L7byQdD0I6CGJTdDvrkEkHcnUREZKyiGPtMQIIpPgiSACQjEsWRnxv3MfrI
 Qq5M0cYnPK42wrwJOvW5nUP/QYcPvWblsXoFBTw2ISGdlX1C72vN+AteHO8qZYM/fyN8vHhA/
 R7AY/t8qQR6OP7iNl52oy/fgyEirt54oiyJX8EAHpQ+P+p0tNHWpjkhv8bmY+ZoTKsA4LnqL2
 r9BOLJ19AYOWjPZ1ivjQ0HesAq9pT8vze/9rII7v8RdKJOEWWBkchNLW3t94lxcTxXL3CEsT5
 H7W8b22KEAg/5rxWlu58+oPQB5Lhla3VshL+xU9DO2IlZbAjZu8mcYHGsaZsbhZM0JXHjxtM9
 ispv/sI+2y+xGtSklPe4J3jQ5CmiJWWbbMgSRNvRfiWCQuD5BMzn3L8y2ZofZ9klJ00Y4sDb8
 Fl7tHQ7qAPGbh4FCfBgVY1SQ7BfMQijVpsmIqsnz4Ru9EFxtrfFbJunE9/ThQWfMoYE08ZAKJ
 jyefwZxM26svBQ3OUMMcs2hBJvjFsQwSkyjYSzjxoJ3TP2QkUZR25QpvumNiKkTxX3E0zi6iO
 +THgRVZNAfqkzjn0yhdBm13Jc7n+dFWUT48Xs/vUetF5KhrBr7pyEF8mHZSP+cdzPe6U6wFgL
 IB1DKT+E0NVfwZt9TcoUkyaCWvEBqBYLjiZ8sGMTNK6DbUyTivz3mQhUx52OSvRDbO/z9UCuD
 xFothyW0wzbrzyN+hlm6/+XxE98NumHpTfl8mRT1nfrAMv1JjBjBvpTSPlk2BrmLNmEF8Whoq
 j2CF2wYLQ5o1yU/tJP0man8zVn7ZQNvytbVjwTl6g4dCcKMFO0DdmQKMVopBnTH/dKeuQ+tmg
 TnOvpwz/0NWdniBsm2tMK0oXtbsEsbRQqLG275hAstypNfuwWh5Yd+yADs3ig1Yic+y3pi7p9
 xLWaxGFpA2YVaGhPK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RyKcFuUOTFrBiyV05PbApyPn1hwVN6GzE
Content-Type: multipart/mixed; boundary="snjAHSEEPyTny57nNkDsNobxUlBjq4TO0"

--snjAHSEEPyTny57nNkDsNobxUlBjq4TO0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/15 =E4=B8=8B=E5=8D=8811:17, Zygo Blaxell wrote:
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

Finally got it pinned down and fixed.
You can fetch the fixes here (2 small fixes would solve the problem):
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D290655

The cause is indeed related to that patch.
And it doesn't need cancel to reproduce, ENOSPC can also trigger it,
which also matches what I see internally from SUSE.

Although the fix is small and already passes all my local tests, and I
believe David would push it soon to upstream, extra test would hurt.

Thank you very much for your long term testing and involvement in btrfs!
Qu

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


--snjAHSEEPyTny57nNkDsNobxUlBjq4TO0--

--RyKcFuUOTFrBiyV05PbApyPn1hwVN6GzE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7E29wACgkQwj2R86El
/qjA2Qf6AgrooZsYyYxK1M1d10c28+KPAWWaSkU+wMV5bCi2vLRED3Qo1INP62WN
AO7xqfMnNSbdLr0VIVBYxZDyC0WEVd9tiDM2hT5aRuH0uQsu1LvDqfP1zAjqDmNg
lOUkBJv7jhbn7mYA8U+VkNEZjK06TUtLWfXDdIHU1V1794zvV1Egc9NTM5oraouJ
4Lqow2eg9FaDXHDIUM9IZHe7Tlp8MKIFqAKHZugjEg7BL5ndl+3GTYYHP20EGzfz
dfeTw09chObc1lKY2OP9ftbkQXoMZfn/GOng5QTSQwUp5R1s9b1aatG3kqkVx2dQ
sQTCpUW5krZQEH2A5k/JGVq9FdB0hw==
=IGjF
-----END PGP SIGNATURE-----

--RyKcFuUOTFrBiyV05PbApyPn1hwVN6GzE--
