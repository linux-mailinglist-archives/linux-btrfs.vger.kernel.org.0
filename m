Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC014C658
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgA2GFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 01:05:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:51019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2GFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 01:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580277938;
        bh=Z8AX4OUjwQEA91Rr+eP/hJw2yNFfSGMwT55QPsQ5bn8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I0Ktl7r1QCkj4MHqqeQUpii3xfRtOLEgKjAbVdV2Q7ejvd4klQo5fLe3f/gIBGOEu
         lF/bOsBmQ2SK94938ZWKslAMJsiSi3aAXSuHM1YFKZk0G61RNLF6II1SdAKP59LOpk
         6Igw1wJRON6xkGsstBXJnJS9oCJwK3La3l+3mbok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1jc7uR1loc-015obz; Wed, 29
 Jan 2020 07:05:38 +0100
Subject: Re: [PATCH 0/3][v2] clean up how we mark block groups read only
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.cz>
References: <20200117140739.42560-1-josef@toxicpanda.com>
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
Message-ID: <cda6acc2-b91e-c6f6-757e-92b5628cec29@gmx.com>
Date:   Wed, 29 Jan 2020 14:05:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200117140739.42560-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A1eYlVS8gR7EINJ86vUwNEwRsAhPGwA0i"
X-Provags-ID: V03:K1:WodF5GzAJIrxNEHOeWaz9+MRh3cmzKZYO4C1Av1ODwinva1Noji
 91ms0UcZ/SxQ0WWh7qXVMZg2M+YCG4InnGu2FDTSnqMvbSpZlAqiQh2Bbm41kf93BfMCwtP
 cJhbcYkv6qGCK0JSsYgRqWCsYEfp+BMYP6Ru3V8vDCwhff+AdmHd5sJEEXHEUMajualfdR/
 OwLRQGxe3KY7be0yraWkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zG7Mz+DH9Fg=:hYY0vqXDF+xZ4hXlx42Dbu
 /eHUmzu17AEDgZoEJHtb+PEUGfe7zQgSf/gC9RHveySzCZebOA76riHDKtHDpqIGQeBrZvEpf
 WOtZTa2M9cCTloWCv2HFH/TUEip1lW+LKkJ8ebdOfHH3TPY0g920znnh1hx9D3KSt9s8oaoPn
 3shghreqV0Q4917KuBQYRqRiABSEmuaN28XgdWNKA+W8TZj273wIHZea/C2rdlmCFKOYJXRAk
 sH7nKT9JBkt/qpLHsfZG56SE3NVK//gdb5rCAQeMgA5stxU/+JVicTKVebdO9HXpHv4dXxYIV
 P1wEO9QrVyamYYZ3TScqq6m4vbi0cLEWZJB6MbSfs2Rs/7IsAXjm7I1VZgoX4ApPcjID0zntV
 Ixm0bseLhEoU3LJXJVn2QoV6Xpd+bMDBRSSDOEPW9zoc30j9EybdIG5rM5K1iXP1VAOuNYcjq
 sCO+9W+N8PWiwpj5jBeI+LNk4AG4RNyKwwYrnHtyp7D559bRo3of5Eix/Tl3SgCAE5Wthr1r/
 gTcPxZMUm1907+0kc8zwTXiwFGD43hMtqk+NAsLlNW9UupZTktYec/nkhOnRjYnDeyBcFgb3y
 zmaRt5Gjj7/CIh3TuPh4MPbJZdutNJmts+3cDhARuSmaiRabDSHB+gQEdd81MV/BIULjU4Caw
 wLhAL4YClhKU2FLcDPLE5L7y41BR2ys1TPffHBl3XUgSeMe8EqTpgodTdweaJ6VoWSwpj1RX2
 Q8LPjeVqq02lHWtoAtPUebJktEZ4pf/a2hVZufLsEUFQKOuzsQDo+hQPeuVXBxNRLLMRawAU0
 VfIuyF+ugFxD4bST3WO8ig2pZJz057cutGuWjpO/jC2PjiQ8oLL+zd4g76T+IzjLzsHN8L6rH
 d57MDDz/0NXpI3iZQ6KirjNANlwQhLuaurmXPlECdJ8PLjsef0UZmhYHuRBaa3h3oRDamk07W
 CejZPUwPJaPSX8Ojmiv7NAfnptJS5YHH9tfQwVQtKWB0NDQt8hXKNMXnqLImzzosoEx+Skska
 pFxpY7CIw0ztIRnmD9ofjUtPVgl3532taB8VaMc+A6chq8GPPxyhSeWiCh45F4o6nv6e7cSn+
 0aY2BrGY5MENS2+1MvwFFy95PyEjCdP8R03f21rqyFRkbBbUnxy7PX5spfsvpl6SFxq9uKcaj
 jfE54mUoNs5nAhRd5JpHkcbG5ablp0qSvwTY7fiqawE1LjQp+RvwYljK9ZVPnLsddNtE960w0
 Rn6MjLts9nU5OU24o
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A1eYlVS8gR7EINJ86vUwNEwRsAhPGwA0i
Content-Type: multipart/mixed; boundary="4m4e6fBdVnTMT98ED48cryYh4dWzaI5aQ"

--4m4e6fBdVnTMT98ED48cryYh4dWzaI5aQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi David,

This is also an important patchset, mostly to solve the false ENOSPC
from btrfs_inc_block_group_ro() calls.
One obvious example is btrfs/182 test case.

Would you mind to merge it for misc-next?

Thanks,
Qu

On 2020/1/17 =E4=B8=8B=E5=8D=8810:07, Josef Bacik wrote:
> v1->v2:
> - Rebased onto misc-next.
> - Fixed a bug where we weren't adjusting space_info->bytes_readonly in =
the force
>   case.
> - Dropped the RFC, these are pretty important fixes.
>=20
> -------------- Original email ----------------------
> Qu has been looking into ENOSPC during relocation and noticed some weir=
dness
> with inc_block_group_ro.  The problem is this code hasn't changed to ke=
ep up
> with the rest of the reservation system.  It still assumes that the amo=
unt of
> space used will always be less than the total space for the space info,=
 which
> hasn't been true for years since I introduced overcommitting.  This log=
ic is
> correct for DATA, but not for METADATA or SYSTEM.
>=20
> The first few patches are just cleanups, and can probably be taken as i=
s.  The
> final patch is the real meat of the problem to address Qu's issues.  Th=
is is an
> RFC because I'm elbow deep in another problem and haven't tested this b=
eyond
> compile testing, but I think it'll work.  Once I've gotten a chance to =
test it
> and Qu has tested it I'll update the list if it's good to go as is, or =
send a V2
> with any changes.  Thanks,
>=20
> Josef
>=20


--4m4e6fBdVnTMT98ED48cryYh4dWzaI5aQ--

--A1eYlVS8gR7EINJ86vUwNEwRsAhPGwA0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4xIK0ACgkQwj2R86El
/qh7mAf9EwHEZMk7UjT3G88AUIE0VRe+WwsjRaA9mN16r2ZDLyLvizZA9ZYciJ75
Hd1O6dm9MFgf5VNVrNmj06P9xRTKRv9sZ76tsLGBCsRfqCAY4Jjjf8tXHwjXwWWd
ppliY94iDe+LLqXFSyt+0g3ZM0pEhHuoW4zZe4lIts1gKOAoG75Rq+U41hh6LnF9
dS+Q4yz6MvSa73vLHIeK36fgYXy21coLjJYykL1KFo5KO7/sBpue45xFS6HMLDm2
Wcb5fs0bh19cCm8YjX9NDDJ+AW3ibO6+vctlISbAZbkz1KdBqCa6dfaLoWUlqDW9
DrrABmGoXbPZEUnfWH9DEuQSsEQqJA==
=xNuF
-----END PGP SIGNATURE-----

--A1eYlVS8gR7EINJ86vUwNEwRsAhPGwA0i--
