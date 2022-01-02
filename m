Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D56482B79
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiABOI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 09:08:59 -0500
Received: from mout.web.de ([212.227.15.4]:47489 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbiABOI7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Jan 2022 09:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641132531;
        bh=6SIJwkRQXv0qeRQLzcPQ4BLWLTx5Tewq00GlHquDpi8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=cEIG9cCZ8UggyzEx4L+335d7WDvzdQpS/vadmuWset2nterAtfX+pr8KrvvHjbGfY
         G7BYz5hzDO4fuBaoj+nMlIs0iW1uYdzPfIHzGz6wULAuAeNmoWuQDGgWxbOZzNGQ0q
         rqV2eWYXH9hwyc8qUAg+9b/BUSjrCo9lW6CJ1F3w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.151.24]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1mmDXX42UL-00HjL6; Sun, 02
 Jan 2022 15:08:51 +0100
Date:   Sun, 2 Jan 2022 14:08:33 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: CEPH to BTRFS over NFS results in no compression
Message-ID: <20220102140833.2605a773@gecko>
In-Reply-To: <1056918704.2047.1641123173265.JavaMail.zimbra@arhont.com>
References: <1056918704.2047.1641123173265.JavaMail.zimbra@arhont.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IKhe1IjJeS7A6LWCe3iWC09";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:DgUnQQ8wIJtR9UeLuZhkByWqOXnOJxl9wVsFjXbED4KyIvoRngP
 uPJ2O/K3b6/iHhnx6tEmb2ND12yDb9gSbuIvwmCVCU7vbvvixI1MVNKCkDbYAtvAjBgO70A
 5BDLXrpXrjeEn/gKm498hdz7nKC5i1EJWOBXjcRu6k8cG9JcqaxMuBX9jcwYlavkGWwC3dj
 4xL+LYEbOdbiJ5FmoK4Vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QjAQ/bs9Zow=:kwvb9+pSYc4BhfcjHKvWQg
 /SNa4dIgp0fgMWnOYQXfVwRJlhoty6Pmc6RZJD9ozYvoD7BUY2xC8/2Y3fRevixFEHBJ26cMa
 Xt4zoHc/3s0mb+smIgF2pgWcBTdm3qjzG58iMHizUpzcNiYxnjy1xqs8aqcfp4fpZ3DAVBJnj
 Q/4nj9Tsha0eW6h1r4dntJxNmWwXiPGnhtAuOiD+/FQ5EREBSDyTmClsv0iWYK92WjuljnCRK
 yHePxbXf9ANzCu1xY/UsgwepS+diobUE9Pfi+Riflyel0mRcRO2mfasjFagy0UfIGaHTKUuWL
 2EYWrcKOy6O99SYbAJ64FMLqHMtSZgkrpdlBXC+kuFPqQOTHfadHTNesxsIJ7hv/9gtFEuXDA
 3k/UK+kvGSzHaSvAlMk3incrr2R5MZiT1QfgUcLFbORIAX10VTq4eRBGTTU53QY6SOiImSpsG
 wgN1GjjNJbfUppZ6tdzS9ozcWIox2YYvsE7AJo2HAcXulJ63WLBwfsYziIimxpZ1fpcsSx2Ux
 vYPnoSQHTMKagnQyxrNaxPGLDxPjPlfCTgdJCh+8Y6mLkogEImH6aeWpSz+UHNCeM4fsro9br
 Wux+K/R9DXqYu6WN82r/koPcI59FXoKYOIwCdaP8temQFWekDeRvRZ8XpX0c0q6CxO8iUBbdV
 HKNsgW+OpSli68VhIQ8/gmaWxAiRMOVBLGRJkCTKNAcbr6J2Rm0mzkrX2bUab8HKcEvDJF0HS
 IuomZNd73AJ6deZ+c9OO5IQ7ARX0Gti4p1MMSXI9VG4cAVD/mkkz+3WOLCzTVlLpDRfRYy5yr
 E/P6T3yLVooGOwCK3ZFjPy8KTHusaF7ST20qmYipOkdhUk56VqZo1jL7Fy/gL93ulUqEV8f2C
 BI6PhXVsoUptGWEAgVZbMmPe11wBivxVR0khPuR3Swe6enPGDOSQ4LEAFaA1TSnf+xlaidFz6
 2KJ39VfYu2rzaE3Nc12wm6eLDygMsd+IfxzynBECH1o9VFtCWeMp3pZHHerqkWtuLvXy8XXbS
 GgBOJP0xwfTwlVltyIm+8I0+GP4I+pMsOIxUpJftY9YB8TC9HMR5gMtynL/uJpuu4c3hGsMEE
 6BIXT//BJ2dahg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/IKhe1IjJeS7A6LWCe3iWC09
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Jan 2022 11:32:53 +0000 (UTC)
"Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com> wrote:

> Hi list,=20
>=20
> I have noticed an interesting and surprising behaviour of my BTRFS with r=
egards to compression of the files and NFS.=20
>=20
> I have BTRFS RAID10 with 8 disks , that is mounted with the " nofail,noat=
ime,space_cache=3Dv2,compress-force=3Dzstd:9,subvol=3D@cloudstack-secondary=
" flags and is exported via NFS.=20
>=20
> When I create a snapshot of a disk in Cloudstack from CEPH and save it to=
 a secondary storage to this BTRFS RAID10 over NFS, the file does not compr=
ess, despite the compress-force mount option being set on FS=20
> So in the below example, the file eeceaf0e-9780-408b-a748-1495d517a9b6 wa=
s copied over NFS and is not compressed. When I copy the same file directly=
 on a host, it does get compressed pretty well, as per example below.=20
>=20
> [...]
>=20
>=20
> So what I have checked so far what works=20
> - after the original files is copied over NFS, the copy of the file using=
 #cp gets compressed.=20
> - after the original files is copied over NFS, the original file can be c=
ompressed using #btrfs defrag -czstd option=20
> - If I copy the original file to some other host, and copy it back via NF=
S using cp, it does get compressed.=20
>=20
> So the problem seems to appear only when the file is exported from Ceph a=
nd copied to NFS.=20
>=20
> Any hints what could be causing such a behaviour?=20
>=20
>=20
>=20
> Yours sincerely,=20
> Kos
>=20

Btrfs doesn't compress direct-io writes. This suggests that whatever you us=
e for "I create a snapshot of a disk in Cloudstack from CEPH and save it to=
 a secondary storage to this BTRFS RAID10 over NFS", it writes with O_DIREC=
T.

Regards,
Lukas Straub

--=20


--Sig_/IKhe1IjJeS7A6LWCe3iWC09
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmHRseEACgkQNasLKJxd
slgYWQ//SWHfQVcq+wwdtyxKhvUdem79R0eKBOr+zcXHOyMtmkZbNfX6ptV6SQbn
cjN2pfPdhWxnxxl/WYAiXrrsq11d8H0kScQhIXQi7SKy+rXTNTR+UlqJczcAOXXQ
6nH3D5u3+TYr2lkAjHC3nldbnJcQoJJwxrTX+9qflMFfe0FuK2IZM48w+nmFWHbZ
1Qm/RqCpEQMOJnurUUBHTYRUiuADgKXpRsxKUu2QHfkRJPZ0SQK0uDGuN0ZhhOWY
XW+JYx7lPRR1hH9e/mKmn2HuJXtx0eu3aD92kv/hPVD8RpziQ/53w8VnLt+bj8m1
r1wqGw7QZ4+fLwSATjMkc6FDQkWbMPcRW9F7G+gdf8aLI6kzu+xXSANLwkJv82ha
YYOXUnsIOyBZAuKICYHuyLDJeoJFcyZ2NMG6PrZZ0fiApw4a4EA3dl4VWln1ZLFJ
nQXtc36LIsNsmIyOmbHr/f7YKbycxnx0Vf0NYqJ/aBGuiFwxcL/prb7pj4jIRrYQ
xTNSz4h1YWVg9/t2UniSC41yZNDBMTftkH7vZaqG8o87YWXT4JYueQwAh9+2tm7x
IVNaqH1tKcT52MNlJRT27kNKqCjN6dRMyCx+fKUNQWHekHQ4JZen63+pL75bu7qt
bG5kiu8u3ELRVzVHHQh/HMutxCOgwmhdRaqNk1+pucoQHaBfPdw=
=PD8u
-----END PGP SIGNATURE-----

--Sig_/IKhe1IjJeS7A6LWCe3iWC09--
