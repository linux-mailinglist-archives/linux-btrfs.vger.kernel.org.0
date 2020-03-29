Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BED196D96
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgC2NPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 09:15:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:48993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgC2NPC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 09:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585487687;
        bh=2Qss9zLC5HP5KnEksDYHt4oz9FFn6P89vFH4cOlISSU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PX0U3RlYAnF8C1czhOw0IfsWNVZtZCNuHXBc9EGbv4OUqbluIiGsoq3cf1oDYKQ7m
         J56USxLR3Qk1Dcu45VGs2nwNIa8HVPfO7kztJxBACqB22L8seHR8UoGT0wcbddypoC
         ygdvLc3e+BEZL+zA+jOZmpMr1JOH5oqLKH6nRbPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNKm0-1jhKhA3jqc-00Oq49; Sun, 29
 Mar 2020 15:14:47 +0200
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
To:     Brad Templeton <4brad@templetons.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <c8513b49-1408-3d99-b1ff-95c36de2ef67@templetons.com>
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
Message-ID: <38a47c1a-d5b1-43c5-e026-10c2d4a9c039@gmx.com>
Date:   Sun, 29 Mar 2020 21:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c8513b49-1408-3d99-b1ff-95c36de2ef67@templetons.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n8RTvi23YsMU9B6S0P1exWVTm49ZS7eMj"
X-Provags-ID: V03:K1:lbpo26ug+pIT5yKKx+nerpr0vRIRZt9A7eJAO0RKWQUWP8M2i6C
 4QavhE/gJOuHxXaK9KSDJoZH3vLfZk8aeydQaj9GS4paJSXKUQ4XRzvtxd+n9egioee94CX
 m4o08HGVtZ5j2d8pqPLrnjuR1ul4XHk503wmaeFn8O1WpQpXdWMDk4UUbWqDBn33Qik+Wo2
 KkvR/vt2hwP52U/4n0g/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xEmxbvWPn4=:/MIlfVQV0VIc9aCdn+B+oE
 F66GUgkDyQ+fMG8ejqEMrkNHcdbizPII0V2a3w6okAyetxko+f3LzeYcGD7Nax2tBxEStHW2n
 m0pFCrklwwM4BnONebWdebuF/c7PU+/rjF0+71ECHToJBYKULffoeC9/PN3nhCZ2BFRAigtkY
 jI4uxZvG+5WK+EQzyuFVtGN8+FJTQ2jf38Ps0j5I2JYisAtLfcblGeBGMJ99xt3j+d+7/bvFA
 M2JqRDu26O5SEHmOu6gErtvk8tT28I4c8kQnx73a7pP31a+9poTt9HeVt/hu5AKngpvuOaqaT
 Py3PatAHTxHxj8DbbQJjLhsAsH+fouse3gyIxXK0a88sjTm8xbhL/YtORYBLzOVdfYnFAOlip
 ny94/yzbYL2hS7uXtBaFKZPNkdvrsr6ri4to6vFL1SIsHHx8xwSvxKvP18OpUThADVJE5XtQm
 qyVJK5x5+NSQv17YpbZjBcPjh1wBxMVLybtWuh2sXXGUyI4SeRqUzqnWwZ7J/0SpFbMBB0HgV
 b/tMSMMoi3MPJdhzkZHPugsio8RXrDudg35zEtya67kjQ+abDXwQht9MajnZT+gPEYab9OrQQ
 OD1vfuL58LC6VbPZu8bFY+LX9PzIu+emr0UAOOOyUKwxiKn5MXi+GFcmW/zLgdmHPT5PDEZiI
 g3qA72HZzo4PZEat/8uzszcTFQxhqye8G+NwwiDiHgLcWvWTMiZRIz6rdlZHSjPbLvsr1kZjX
 kzf6mJnI5oV1DbDuIHKiO9eEuUqaP7fyq7iXjIzlQEUXYhNOQPqCNUttej/dTzrHqomYqDmx2
 ikW3pzoJfRVqcEfsLp4dlQePPHysTcmoCo+7ylLfCwFdvieeH7w9JyOiqkV2um7b0peub7Nlz
 /8M6zMrat7WK50FMUD82tAEEpiGatcjHzm0017dV0ea+jsnMOrJAN3nRYysJYp8mEo9P/hF3I
 Nt07PxOPZ9HQH2kC2zXzHUiT1LL7XAv5wJvTn2xnpc1pC1c298uF4s/H6TeBCW/vwkkNVLkga
 8dHdYek4f34qYx4fYI33iiskU/RLDvIMEX4HBI2K7jdr3Fx5kPIqvZLHuMu1kkOfGaWMZc/JD
 fauunQWsedP2oiyZW8LMepSs46+DGCUBCfzOuiDecBpcY+Vm6rVGGtLQGo5GFtCz8WdCRM0bh
 ZcgBTfROxVbu2g/xCaTmlQMSq0ya8NmpB9CrzibE2tGlXQbZGOIIbMvS/Lgpv/vjrcK0CwZb2
 477iBNjOGQyHnLTMh
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8RTvi23YsMU9B6S0P1exWVTm49ZS7eMj
Content-Type: multipart/mixed; boundary="Xw9HwbayI92ftTFHM01o2ayKFEgLiNzrv"

--Xw9HwbayI92ftTFHM01o2ayKFEgLiNzrv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/29 =E4=B8=8B=E5=8D=8812:03, Brad Templeton wrote:
> Not using qgroups.  Not doing snapshots.    Did a reboot with the
> options to upgrade to v2 -- it failed,

What did you mean about "it failed"

It failed to mount or something else showed up?

If failed to mount, would you like to shared the dmesg of that mount
failure?

> in that the disk check took more
> than 6 minutes,

Please be aware that, btrfs check, unlike e2fsck, will always check all
metadata of the fs, no matter if the fs is clean unmounted or not.

In fact, btrfs unlike other journal based fs, has no clear way to
determine if an fs is unmounted cleanly or not.
(Log tree is one method, but not a reliable one).

6 min looks completely valid to me.

> but it worked, and the second time I was able to boot,
> and -- knock on wood -- so far it has not hung.

If you hit the hang, you could try to use 'perf' command to try to probe
the runtime of btrfs_commit_transaction() and its major components.

It would be super helpful if we could determine which is the major cause.=


>=20
> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
> LTS if it has a data corruption bug.   I don't know if I've seen any
> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
> the few times I have done it.  I could revert, but the reason I switche=
d
> to 5.3, not long ago, was another problem with sound drivers.
>=20
> BTW, even though it now works, it still takes 90 seconds every boot
> doing a disk check, even after what I think is a clean shutdown.   I
> presume that is not normal, any clues on what may cause that?
>=20
Another thing I found is, in your initial report, your swap is heavily us=
ed.

I guess it may be related to the memory pressure, where every metadata
write needs to do a lot of metadata read before it can do anything.

If that's the case, it would be good to keep an eye on the memory
pressure to make sure fs can still have enough metadata cache without
triggering too much IO in its critical section.

Thanks,
Qu


--Xw9HwbayI92ftTFHM01o2ayKFEgLiNzrv--

--n8RTvi23YsMU9B6S0P1exWVTm49ZS7eMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6An0AACgkQwj2R86El
/qhBcggAkzEXqZCNvEPUWzIOaaWs0kw2DksCPNiopTnpb/LrFVP7l4kpXQKXGNXC
2b8e/v1i5kirAUnBpEDz2Z6TG3rmw4lNDIQwG1zzhbj+/IFONGKiK6o3QyM9dbnY
gyKlYilllnLWKAvXpExg7UpH+K1mLb42IMPLf8+TSWTolfmjCOXqoEOQWdNqGaDI
fWCWuV4lq1uL1aT8RM/QqtZKnAwFYllCjXv9VLYVYENlc3PBOFFKOdTM3twHfolE
XFJmaSMaTTeFV3SJWrdRq33Pt1jcNYQlo4ou3Ly1UedAuVYz4EcC25ewGKqBWkh/
VofE4FmbYYkdsGIEabzqa6Y/IHhmow==
=qBMe
-----END PGP SIGNATURE-----

--n8RTvi23YsMU9B6S0P1exWVTm49ZS7eMj--
