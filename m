Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2C1513AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBDAhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 19:37:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:39443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgBDAhV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 19:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580776638;
        bh=IDAbNuGZENAP9ca+HznWBm2qLTeZBQ5+Yw2UMbmbmSE=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=b6+w111Yrlnlml7Vh1t0Gv2BuRQubRnd1Nd4aQe6o7A1by75dBOyLCUtp7n2k7uFI
         ZOKq7FEUIe5Z0KgVvJyzRP012fvo18xQIAZrYDqrCreFbpq8LVWy/7FW03s7EK0fvc
         4PPKmtzXk+5gMzVoXIL/S1f3dENCatFsptfqCbwo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mFi-1jfYcj2s4i-0136d4; Tue, 04
 Feb 2020 01:37:18 +0100
To:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About stale qgroup auto removal behavior change
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
Message-ID: <2dfbf017-9c82-1224-bdfc-73d0c0111e40@gmx.com>
Date:   Tue, 4 Feb 2020 08:37:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VKSK9rP8gzJCtGzlo0TZFtQZfyQ6trBTm"
X-Provags-ID: V03:K1:MrhWxCp9NCYTaO16ToS4g6fdLzSeZr0I3WMaiKP7LEk0NUqjryW
 jDe76AtUWvBZ8M5XrYfZif99uy9Z6CUWjrJ0rvtwAbFbgrpIfM9P09XzGGyxONT8HzF14Y4
 1FW9PocTqikVUNiDPLpUpdO/My5qrrzRY3sPe4O5D1WPUebhDJtZrCbI5lS8ob1U1xdHboT
 V9/aTcX2joIkyGxgcD0mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dddEZaaY96w=:7N3Vhzj9QL5tfSKYXCfvP1
 z7IcPF7cG1/xGE0rNVJsvNzbn0Vkf7qfj8ok/zonOa/e/0BA69mu5j1X3JkQHqGM3eqLcO0Gp
 qVDnRFdHlwJBdmkRbKHb086tM+KydkLqMjHbUecVIcPDkkjt/itE95qSTa6YRAzFnYEvAHUa3
 8wZSW5DytRqLBNKR1Sr+6tRzbfbaNPMOo461JKH6UkQsB8EfTuWT8l44jRPl7pjIxJVl24v2B
 lywtmerKwWzoZ2aHdy2EGjCp6CK32WvECvI3BrjT1T0wuNCiM2GpvsK8ft9Cr2QET0iFnnA4w
 M+jNR/8tR2x+522MWY8WmX64Qu5bPrHGX+ECLAn2Ud+57zp34Fqcl3AzNBlkbsz3G9GSz0Bxv
 ijwca2+ek3ZDjNtu4rbkcBAGxvomr1Oo8i+V1agQ0I2Zc1ny/PPp47yBDt4ts5ZXcdIbeCBW/
 caYNiOHeX2C+F6qzvIJufr5GcWrTabGvLsIdVOkmudk1ul45Xs1vFRUJp/i0g/tXnTwcL4sMm
 ypw/oyiIm9zevDQ+qpLUhzPZh7ihq+PKx+vOe+ymASTcp6oEZTXJwMDkgIhgFwlaYK/dIljCa
 ULUzGCqtt4dU6cjJg7gFPu+0PtuBNlH1LjLO0mN0y0oJGo2pewB4Bd2NbZWXlwnog4EkuvT5J
 7AhSmB2ANufba4UQSMjDbfBTu1nMNUKFUpD582iKyMuKqIOSC/VLOS2P0ucnCgRWGp4BImVZ9
 FKSt/66qjDWkAEi4hlM9GSjgUrkAjGllEdV7+na5bJRCV79EdF9dBxf8L449E5BxhSajRSrpy
 bHe0JlvdXbPupeNkM9pYVgXGGwQM01cJw64ho59gjEZCt3xKdmscv59dVpJYwVvXl+4mjhkyR
 vinwxxjjyqg3Cht6eR/+Yjq0Xt4ggxEk9WjDAkWcpm2/EiEqVZ8I8jJsrFpSedxohCCXf/10y
 Nne1k2L8EGxKOOiwczJ3/0+qE9OZAfzuKmrUnMK8+A6LFto7uHMpNDGS0ioQzvkxRRwW+yy/E
 MrhPwMiacn9tNBZ2FkFeBT4PNqH9JREyS8IaqQ/GFseP+txYWf5FuiArOcaau+R8Dg6GGtjmU
 C/eXd0WS0igA03oe20gd93ct7kyfgOO5SUK8IeWGMXEQWe2fEyUz3C3RHOeVExC6dy+dxJGgQ
 UKwa7sDZW9axJEnX8OAvJFyb7XPKPj1F36n2fh9UbTA4Zb2WaMBOwAxBAh2xrjjODDA/zaXGt
 +zWEF0lsVK0OMWiyf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VKSK9rP8gzJCtGzlo0TZFtQZfyQ6trBTm
Content-Type: multipart/mixed; boundary="pKwZfUxw1jdz998iJ0OMa173iSMdcKgSY"

--pKwZfUxw1jdz998iJ0OMa173iSMdcKgSY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi David,

This is the reminder of how we could handle the behavior change of
staled qgroup auto removal.

[PROBLEM]
If btrfs has dropped one subvolume, it will not delete the level 0
qgroup automatically, leaving the qgroup still hanging there, with all
numbers set to 0.
This needs manual user interaction to delete all those staled qgroups.

[SOLUTIONS]
There are several way to solve it, all with its advantage and disadvantag=
e.

- Auto remove them by default, and no way to keep the the staled qgroups
  Pro: Easy to implement (already submitted)
  Con: User has no choice to keep staled qgroups. But I could argue that
       no one sane would want to keep them anyway.

- Mount option `qg_auto_remove`
  Pro: Still easy to implement, and users can have their choice
  Con: Mount options are never a good nor extendable solution, not to
       mention there are tons of users who will never user qgroup.
       Introducing a default mount option for users who will never use
       qgroup doesn't look good to me.

- New qgroup status flag (QGROUP_STATUS_FLAG_AUTO_REMOVE)
  Pro: Only affects qgroup, users can have their choice
  Con: More complex to implement, needs both btrfs-progs and kernel
       change, and even change the ioctl interface, as we don't have
       method to pass extra flags to btrfs_quota_enable().
       I strongly doubt if such hassle is really needed if no one wants
       staled qgroup.

One of the biggest concern is, is there any user cares about the staled
qgroups? Their numbers are all 0, and doesn't affect anything.
The only impact is, users need to delete them manually.

Thus except back-compatible issue, I see no reason to allow user to keep
staled qgroups.

Anyway you have the final call, I just hope we won't leave some complex
mechanism and let later developers to wonder why all this hassle is neede=
d.

Thanks,
Qu


--pKwZfUxw1jdz998iJ0OMa173iSMdcKgSY--

--VKSK9rP8gzJCtGzlo0TZFtQZfyQ6trBTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl44vLoACgkQwj2R86El
/qhCfQf/bq597aypJLQGsuj8KE9fizM+eytVSFHLUN/KfObXKRRp3hST8PWpQVT/
khB2hs6nGzoZPUTOrmyIUHI4BwNJ7/m4MhzFZ82Xvkkk0ZzDrqt8rIqPLnzXnL92
LcgEAsn6Masryijjh14TnVvvpHRkAGE7hkv3gyiV9IwytsHWx7eEHdwvezfBHKyv
PV0VpugVFdu7TWEVApWmKh7c5DCEhkP72LA/bBRsto6qtq18V2twjQ0E7EP471sY
2atSBWhb81daZD4Xz86IR7OVBe8Be82uUcL8NtiF0zOuW6gQvv8sXCHEQ4N3uzan
p0f84FwU8FYiH6flkcIaB+LgrxARGw==
=vVS9
-----END PGP SIGNATURE-----

--VKSK9rP8gzJCtGzlo0TZFtQZfyQ6trBTm--
