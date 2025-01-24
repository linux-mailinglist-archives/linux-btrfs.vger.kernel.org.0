Return-Path: <linux-btrfs+bounces-11051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14025A1AE81
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 03:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72361884DF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159341D516D;
	Fri, 24 Jan 2025 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hexagon.cx header.i=@hexagon.cx header.b="MiUSRDvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D552B9BC
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685599; cv=none; b=JSut9UXXtk/CnmOuCC8BThpUoZORqlgfhxkyyrYyiqmmPkDjZ330CaF0nPdta6yl9MWdXV92Oh4sRw9v0+l7VAzCM/Pk4qmIN8VdUFgU0pPTKHZeLGpIUIykNjXMuWxauh9e5s1pc2jwnu/dkNwTNDPpctGVJpBeAX2NlL/N4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685599; c=relaxed/simple;
	bh=KFfddlCvNf2qbXkhqSDEnCm0fiQhsGcb6snS5AHzOlc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=gp0RDZO4/D8qrRp8e8dzg9CRu+5Fna+tqk8GztnAwKIiTInN1b5KqsT30xFKeErghQcAflZXDIFNbJOj3BSE7Vor/zaPjSGvDBytwZp+udArkm+RH8Lnr0VoQZ06wVRs+BAW1uPsHm7s1Fn94ig7nrz1vlqLBgHEnAZvY/n3SZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexagon.cx; spf=pass smtp.mailfrom=hexagon.cx; dkim=pass (2048-bit key) header.d=hexagon.cx header.i=@hexagon.cx header.b=MiUSRDvm; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexagon.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexagon.cx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hexagon.cx;
	s=protonmail2; t=1737685580; x=1737944780;
	bh=C6d3Muazv7jrojLdC+AFshJH+Bjmba6fOyRLJfe8GW8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=MiUSRDvmqvctc+wQCAF36ZRmp/tjpEpFNF4aHpjOccTfkmQFqPVv287CtQgRyS6Y5
	 NUgkvVg9NrZ02x6x9Dgzaopfr/J/KtJXc0CS35Y8Q/FOl6ntaZlm5C6iUmxpLnq4Wn
	 5jV38SvRHAPoel8HkZ0TKFF/qaLDmIln69y05MhqyufI7i03+/0J0xRJUB41d61OnX
	 tRbMEV1F40JrwG7Pj8qZFly+fvlLP90TBtVp2IoPl3dgwPwMppGNTA/BZI1EIdRsC1
	 5ozxZx2qVDrl2aB8gQXrYHYDY6/z4BawcXw3pc5jtox/OYUUXwj0hTXJkqtpUsWpB/
	 XJNBoeh2dxeGw==
Date: Fri, 24 Jan 2025 02:26:12 +0000
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: =?utf-8?Q?T=C3=A9o_Adams?= <ta@hexagon.cx>
Subject: Tree checker pre-write check finds corrupt leaf. drives now empty
Message-ID: <rvOGZGZ2KKMe7x59is0hpo4PXWgjMZ9wuj4H3byWhiAZnJfWC2OHOQ4b7LYuvlBKVz9giNM_qjh9TZaq0Aa7mcqa9uNF6fxdEeqnbLQ_tP0=@hexagon.cx>
Feedback-ID: 12181862:user:proton
X-Pm-Message-ID: a5f50aaa1d0b2fe290ea8bade74960df18488e36
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------b0ea7fab55b28d86d950ce1abba5260d52640f69dda318e71c3ffed66b22203d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b0ea7fab55b28d86d950ce1abba5260d52640f69dda318e71c3ffed66b22203d
Content-Type: multipart/mixed;boundary=---------------------886c0152f6c3db1b716b917e69524e58

-----------------------886c0152f6c3db1b716b917e69524e58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

I just read on your https://btrfs.readthedocs.io/en/latest/Tree-checker.ht=
ml page that you'd benefit from reports of corruption caught by tree check=
er. Obviously it would be great if you have advice on how to recover from =
my current situation, or avoid it in the future but regardless I hope the =
data I can provide will be helpful too you.

For context, possibly too much, I am running NixOS on a system with 3 diff=
erent drives, all of which use BTRFS.
Drive 1 (nvme) has two partitions: ESP for boot and a luks partition with =
3 subvolumes that house /root, /nix (where the OS lives) and /home
Drive 2 (nvme) has a single luks partition and subvol used for storing lar=
ge media. It is not used very often.
Drive 3 (ssd) has a single luks partition and subvol that houses my qemu v=
m images.

When the incident occurred I had a single VM running via libvirt and had t=
he usual assortment of multiple terminals, neovim instances (all files bei=
ng edited are on Drive 1), and browser windows. The only thing "using" Dri=
ve 3 was the libvirt and nothing was using Drive 2.

While attempting to write a neovim buffer I got an error about a database =
I don't recognize being read-only, my system began to stutter, and I notic=
ed in a btop monitor that my RAM was pinned. While closing anything I didn=
't need and trying to save my work, my WM (hyprland/wayland) froze for abo=
ut 20 seconds but recovered. from there the system was very unresponsive, =
I could change windows but couldn't kill anything. Eventually I had to reb=
oot.

Later on I went to spin up the VM but it complained that the VM didn't exi=
st. on further investigation I discovered that both Drive 2 and Drive 3 ar=
e completely empty. They are both unlocked (which is automated using a sec=
ondary unlock key used shortly after Drive 1 is unlocked), mounted, and I =
can cd into them but there is no content at all.

I'm completely at a loss to how this may have happened.  The clue that led=
 me to this email came from the following kernel message in logs that occu=
rred around the same time.


Jan 22 19:03:10 ghost kernel: BTRFS critical (device dm-0): corrupt leaf: =
root=3D258 block=3D67236839424 slot=3D43, bad key order, prev (18446744073=
709551611 48 42564423) current (184467440737095>
Jan 22 19:03:10 ghost kernel: BTRFS info (device dm-0): leaf 67236839424 g=
en 313844 total ptrs 77 free space 11791 owner 258
Jan 22 19:03:10 ghost kernel:         item 0 key (42725548 108 0) itemoff =
15251 itemsize 1032
Jan 22 19:03:10 ghost kernel:                 inline extent data size 1011
Jan 22 19:03:10 ghost kernel:         item 1 key (42725554 1 0) itemoff 15=
091 itemsize 160
Jan 22 19:03:10 ghost kernel:                 inode generation 313844 size=
 23509 mode 100600
Jan 22 19:03:10 ghost kernel:         item 2 key (42725554 12 75511) itemo=
ff 15041 itemsize 50
Jan 22 19:03:10 ghost kernel:         item 3 key (42725554 108 0) itemoff =
14988 itemsize 53
Jan 22 19:03:10 ghost kernel:                 extent data disk bytenr 5280=
100352 nr 8192
Jan 22 19:03:10 ghost kernel:                 extent data offset 0 nr 2457=
6 ram 24576


Fortunately I do have backups of most of the content that is missing from =
the drives.
If there's any additional info I can provide, please let me know.|

Kind regards,
Teo



Sent with Proton Mail secure email.
-----------------------886c0152f6c3db1b716b917e69524e58
Content-Type: application/pgp-keys; filename="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"; name="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"; name="publickey - ta@hexagon.cx - 0xF41BB5E4.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWEtwL0lSWUpLd1lCQkFI
YVJ3OEJBUWRBVUVNVDBndmxIUEtRdFliWkFya2NMUGZoQmhrNDRMVVIKV21hdXFFR0xTNWJOSHlK
MFlVQm9aWGhoWjI5dUxtTjRJaUE4ZEdGQWFHVjRZV2R2Ymk1amVEN0Nkd1FRCkZnb0FId1VDWEtw
L0lRWUxDUWNJQXdJRUZRZ0tBZ01XQWdFQ0dRRUNHd01DSGdFQUNna1Ezc3BkUkpCVAo2QzRsOXdE
L2V4cENycEt5QnFCMEs3WkVteXJiTjBybVJ1SGFkNUtUZEkzM2NmcGFZY0VCQUtUT2UxL0kKcU14
N1VmenhPMnA2RE1IOVNjTkFTQ0lHVmNrM2lGdzlBeTBKempnRVhLcC9JUklLS3dZQkJBR1hWUUVG
CkFRRUhRTTQwU2hFeTNDR2RVR1NVdGZTNlcxaWZOcmVxcEVRcEJUek1QbWV4eGM4T0F3RUlCOEpo
QkJnVwpDQUFKQlFKY3FuOGhBaHNNQUFvSkVON0tYVVNRVStndW1Mb0EvaWFBM0xJL0hPUlVDYlRF
K1NmUWZmVjYKOWw0U1dlNDJZQkpFdlZ4cURkandBUUNUa2w5V1QxOFpnUndkaTlBeW5SOEpEQ0F1
Y1EvRWZOMkVXemlXCmNkdnBBUT09Cj1TSS9FCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NL
LS0tLS0K
-----------------------886c0152f6c3db1b716b917e69524e58--

--------b0ea7fab55b28d86d950ce1abba5260d52640f69dda318e71c3ffed66b22203d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmeS+jYJkN7KXUSQU+guRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcH6RJjGlqaMrd9p1anEk+anxn0KlBYlEXowSWU
/FvsExYhBPQbteQsSdyHIw9Ue97KXUSQU+guAADftgEAhBVLOX4Im1+Knklu
I03XbOsTC8eJVKgdFzrDTIK+83EA/jAvflAAVl5t/r0TYi8IRbsAap7pwnP0
4/Dz+7EQHDMD
=6GwI
-----END PGP SIGNATURE-----


--------b0ea7fab55b28d86d950ce1abba5260d52640f69dda318e71c3ffed66b22203d--


