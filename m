Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D175415B33B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 22:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLV6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 16:58:31 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:32783 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgBLV6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 16:58:31 -0500
Received: by mail-wr1-f45.google.com with SMTP id u6so4282560wrt.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 13:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ThcSZskV4+lQhc0CEfhvdl51YkgMeO9R4AUsN8PpUhY=;
        b=MnZldDiqKEDSYuthuAYBqgQQM3RHl8kUOlb8AgghsFgJqXIriNbY2SPzF1TAe1+TcO
         SFXZfOKT9DxpHYBQ8sIhy7eQyVvvLTI+t2Hz1xzfPM51HhVJIvY5/2fDmZPiTcVR/NKp
         FYZQ3FI4AaFerlWoLJuQYnf6BziN5C44j1ewPpuZS09Da5olLJRot13Nf1OJI92+P/gk
         ssZiMjkr+DP/mMUbJVoX3WlLvRaX2q5j6EKlbeU+yCOWOct45WVCeiRf2TqTQUsEfGnL
         ClBgYMbV8yp648/7FAZq2zrN4lR0KeJUqEB4+A8XXhT5lVcMf5Z6bTGEqSqH3N/VP2rk
         zEnQ==
X-Gm-Message-State: APjAAAUju6bR2KFVtdW9xeJpjxfe3c9xb6VHWvfe3A/jeg67OuroZQBS
        iaTTsZ7RxYwNGYib2qfQ1qmSRi5y
X-Google-Smtp-Source: APXvYqw5jiqQqJmL9pYlIIVYVSEFyFBj3BRF6qf4t3T7zapzksSqJrlefhmxEk7oUDQ/PcAlSAUpPQ==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr17955116wrq.280.1581544707497;
        Wed, 12 Feb 2020 13:58:27 -0800 (PST)
Received: from localhost (0541c831.skybroadband.com. [5.65.200.49])
        by smtp.gmail.com with ESMTPSA id z10sm166856wmk.31.2020.02.12.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:58:26 -0800 (PST)
Date:   Wed, 12 Feb 2020 21:58:22 +0000
From:   Samir Benmendil <me@rmz.io>
To:     linux-btrfs@vger.kernel.org
Subject: read time tree block corruption detected
Message-ID: <20200212215822.bcditmpiwuun6nxt@hactar>
X-Clacks-Overhead: GNU Terry Pratchett
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgzddi4fnc44vpup"
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--zgzddi4fnc44vpup
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I've been getting the following "BTRFS errors" for a while now, the wiki=20
[0] advises to report such occurrences to this list.

BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D194756837376=
 slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, have fi=
le offset 475136 extent num bytes 18446744073709486080
BTRFS error (device sda2): block=3D194756837376 read time tree block corrup=
tion detected
BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D194756837376=
 slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, have fi=
le offset 475136 extent num bytes 18446744073709486080
BTRFS error (device sda2): block=3D194756837376 read time tree block corrup=
tion detected
BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D194347958272=
 slot=3D131 ino=3D1357455 file_offset=3D1044480, extent end overflow, have =
file offset 1044480 extent num bytes 18446744073708908544
BTRFS error (device sda2): block=3D194347958272 read time tree block corrup=
tion detected

I can reproduce these errors consistently by running `updatedb`, I=20
suppose some tree block in one of the file it reads is corrupted.

Thanks in advance for your help,
Regards,
Samir

[0] https://btrfs.wiki.kernel.org/index.php/Tree-checker#How_to_handle_such=
_error

--zgzddi4fnc44vpup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO8iRpJat6BxHTtT0gmAAVevIWpMFAl5EdPsACgkQgmAAVevI
WpO3+Q//WW+S4dfkt/VcCyg2BJKvBc/JFiTMkppYZbhbjTUjrgkvGGeRJTfsM25f
H17VJ8eA402U+erk0viAvyeQAwOYsoK0G8C+i9EIJC9XBuEze+bk8Yq+Qy2wcmwO
xu8ig3Y4B2nenq+r2U7RjXezC1++2Egzy0wWBNR19O4/UMGeNr/2YFHPToFpeZHr
L8+/T6WMxOLOKfm3KXI1GST6cUNvLUsZjaDNKHX+3HnpPqx77wNTgKaxncgzUi98
B2Cfb1WH8YXh8l91QrM86PKsxY4b/Ih2k9UPWKg2Ds9XLpo5fv6B7AE6vQIiJJoJ
hOv/2dnOE6vZ80dZfJE309/q2Funa/PT65CO8i5924Rd8laLuKZ2ahHubPl7lwZn
VDm9ru5ZX2uiNjT/+mQz1ewb3vAXV20OMous5Uxqja8b9Z51kA0WYGjgSvOZlPbq
rv12YGQmTV7ciBjKfqIECQvl6KbBvid64gbQ0N2sYx+4sySC8/fmL8PRmnGCPfg6
L9NZubUqmy/n+wOac+SRFeZ9xf2/IN6FJeZ2DEijK4MmnqU5rV0jCvxG0q/7O43r
EJ8mWihoBEaHMS3DEbK4J5wPiR8S3A46SD/RRo80+IiG96GJEa8SqcfU4HBe1q4b
4kwNZB0XR6lbRPlFP6CFcr24GN7Ra/MD4yXAqiqxE1lOivmxKo0=
=lpYh
-----END PGP SIGNATURE-----

--zgzddi4fnc44vpup--
