Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8212BD31
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 10:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfL1JyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 04:54:01 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:53070 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfL1JyB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 04:54:01 -0500
Received: from archlinux.localnet (unknown [66.115.176.28])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id E766740728
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Dec 2019 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1577526840; bh=60LyYAo7xQRTT8JJIVMQ1tEdtT5l6sYtkAiWWnl3Bhw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XzASjnXXQQQAsJBataEboADmRS6qHOF4AmNqci6oZjplyXvAwNCAulBOdvCBHV68v
         wUeJUGGOZErBtNy8CXNDUlFQbkhK03Gig2wsgAMvkZt9Nyk6JZtoUNFdT2FmXvM8fq
         T9H+4UT7owl3YStervTqofzT13LWAZ0gxk0iwA2pkmfMuQzebAgIXA/CGQGNE1dWvU
         peDftgUWgKy91sqUvBftKq173ZSvO8BRRU8Ir9hn2BOZIchHIN0pWWizsTBIwRyefp
         Stmr1/OYKErH8PlxqOga8Y0IQ821wplO9H5BbC5vGjpItfatoj3lCvj5PIA5x9YXYE
         THWZTHfe3emiQ==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Error during balancing '/': Input/output error
Date:   Sat, 28 Dec 2019 01:53:55 -0800
Message-ID: <2135877.ElGaqSPkdT@archlinux>
Organization: mruiz.dev
In-Reply-To: <4196932.LvFx2qVVIh@archlinux>
References: <4196932.LvFx2qVVIh@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4495578.GXAFRqVoOG"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart4495578.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

> There are quite some reports about this problem. So far no real
> corrupted confirmed.
>
> You can confirm it by scrub.
>
> I'm afraid there is some bug in data balance code which leads to this.
> We will dig further to pin down the cause.
>
> BTW, does that problem always show up at block group 253562454016? Or it
> randomly shows up at different block groups?
>
> Thanks,
> Qu

Hi Qu,
It appears to be the same data blocks giving me this issue. I have tried it=
=20
while mounting from a bootable usb and in my arch linux install both with=20
similar results. I should also mention I have a btrfs root partition within=
 a=20
luks lvm partition becuase btrfs provides no encryption. I'm not sure this=
=20
makes a difference. Would you suggest running somekind of disk check or by=
=20
running scrub? Please let me know what I should try to resolve this.
=E8=B0=A2=E8=B0=A2

``` BEGIN DEBUG INFO ```
ERROR: error during balancing '/': Input/output error
[michael@linux /]$ dmesg | tail
[  462.460626] audit: type=3D1104 audit(1577525576.905:124): pid=3D3415 uid=
=3D0=20
auid=3D1000 ses=3D1 msg=3D'op=3DPAM:setcred grantors=3Dpam_unix,pam_permit,=
pam_env=20
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/p=
ts/2=20
res=3Dsuccess'
[  465.880807] BTRFS info (device dm-1): found 25 extents
[  470.501319] BTRFS info (device dm-1): found 25 extents
[  471.713073] BTRFS info (device dm-1): relocating block group 25356245401=
6=20
flags data
[  472.251356] BTRFS warning (device dm-1): csum failed root -9 ino 262 off=
=20
1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
[  472.254390] BTRFS warning (device dm-1): csum failed root -9 ino 262 off=
=20
1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
[  472.716215] BTRFS info (device dm-1): balance: ended with status: -5
[  473.122721] audit: type=3D1106 audit(1577525587.565:125): pid=3D2775 uid=
=3D0=20
auid=3D1000 ses=3D1 msg=3D'op=3DPAM:session_close=20
grantors=3Dpam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin/sud=
o"=20
hostname=3D? addr=3D? terminal=3D/dev/pts/3 res=3Dsuccess'
[  473.122840] audit: type=3D1104 audit(1577525587.565:126): pid=3D2775 uid=
=3D0=20
auid=3D1000 ses=3D1 msg=3D'op=3DPAM:setcred grantors=3Dpam_unix,pam_permit =
acct=3D"root"=20
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/3 res=3Dsuc=
cess'
[  629.160619] audit: type=3D1131 audit(1577525743.603:127): pid=3D1 uid=3D=
0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dpackagekit comm=3D"systemd=
" exe=3D"/usr/
lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
``` END DEBUG INFO ```

--nextPart4495578.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5lRECE0UfhBqjDUbhv/EZtxrWIFAl4HJioACgkQbhv/EZtx
rWK4Xwf/T39VbcEhisWXlyvGQoCdp27u729c7NT2aLOl+rnMUwAHCge7Fw5qdaQT
Lb/7FAqcERBaIGRvK5s6x4YPVSL1M1SwEhr3x9U2rvIFePkfHrmEofC4wcHLDwrC
N1vWtFLT7UsgD7ZcISeqEjbmkIAWjyNRNVqBy4Dr+pnT6R8EVvHqkbpF9iVFTCGu
9WL7PXuRngGZTP/haXvb3iJ5RW2LkcAd+NHg/+LlVaR2NL8WwjpN2I4MARVJ4BAU
UzYPWwnBVu3cZ96tpDNlOS9inaOYrmrEw0E83Nee6nkqtLY7dhU9OFLCMlLGMemV
wuIYd7e8ELF3WyZTk+Sd5gkKNMerOg==
=YN6J
-----END PGP SIGNATURE-----

--nextPart4495578.GXAFRqVoOG--



