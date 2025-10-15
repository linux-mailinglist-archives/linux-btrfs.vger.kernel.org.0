Return-Path: <linux-btrfs+bounces-17861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BBBE0FE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 01:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4594A4071D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21C3115B8;
	Wed, 15 Oct 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A6cEDlFK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC02FC00E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569285; cv=none; b=Nk6qHTy441YlSjUSMkOgDsIaCiD4ba4n6BGl+sOL4fmIoN70BiazVhCiWELL2KfJ2chb8prxQsIRqCtQIc3bLlO6dR49ugFewCTNjjeBopAe+a12v1qWm5rIfTBO3771lhls52qFRxKzu20fen3XNXoYeceZb5KxnaUjoEdLS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569285; c=relaxed/simple;
	bh=VL8nW4jSotdelaoWXJ9jRWTJBFLISYchAoiKHkYGqkw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PSibxhupddYAPjr7whVZmcZWOwqXz7mPC9m2v2oDJS0Lm5YVmGB8Jt7rhgmNAJAC3r4HK2GU8lUZL2TkWoOhvS88EeXO55xRzsHWP82bDJXyduuoiyXzd9GJthjeRyq8UFFb35wPRILdiVLtOb/+rSc7F3ZmIoKswvMFDV1DMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A6cEDlFK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760569278; x=1761174078; i=quwenruo.btrfs@gmx.com;
	bh=VL8nW4jSotdelaoWXJ9jRWTJBFLISYchAoiKHkYGqkw=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A6cEDlFKZ1smvo8YlWwTUWC185Vjfk7JZ0gB8hVtzDe5CLik3gtjJjozqLNLyMuM
	 RWEwZodTIgqgz7BL7Rq359FpCtS7yBHMkDtbOZPHUXttG4gdcFVzCw1E6ixqzJISk
	 ds/ST0PvTo8iOJHgqrak00huUJG1o1R6G94k8h6CQ8IJImXXLa+yNzt4Wkoqjzzar
	 rDAK+z85tZpO6X85nY8+QLBFaj9ztjBa8WzlTVgLGVExjbiHmGJ6fe09E6yi6+ffW
	 M2iwdnic8S0nt/sb2/Y7BOZ1dZWldpRjWeKQzWuLqgZeaspNdHSFGGiH7Dx0ffSQ8
	 Uzj5oFDAwYzHr81LWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH5Q-1udPZi02hQ-00nFAZ; Thu, 16
 Oct 2025 01:01:18 +0200
Content-Type: multipart/mixed; boundary="------------tJH0KvGWTC3z0Mdfn8OJvlKr"
Message-ID: <5517a3cd-1afa-4db0-bf8b-439f3ba410ed@gmx.com>
Date: Thu, 16 Oct 2025 09:31:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Askar Safin <safinaskar@gmail.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, lists@colorremedies.com,
 wqu@suse.com
References: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
 <20251015111217.5538-1-safinaskar@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251015111217.5538-1-safinaskar@gmail.com>
X-Provags-ID: V03:K1:hixWvVv0rLBjZSj9b5PjPAjnum/ZVt3j2USvGPQ56I6rZ1mk2ay
 W9glWOQFDbFFBhlkvwE/SxugFTCBlsRNqvptIIfGsIeB/bFTjZB0G0Of4I4/UzEp/Hnq3gs
 7GucRklUDiym5lWNRePCOmOnOV4kPP/XOdOxkErrGeIpaZlELD2WPqJjMHRiHNHf2L1nQI1
 E78bZ4C1gJ2aDR9xVqQnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pYAqSm/qQuI=;Jd9xTYX9649PvfAY13CCpHSxOSo
 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
 NQuZV1KNPaPgDm4BhPv3jMoYJt7HEoO3GKmz0Z

This is a multi-part message in MIME format.
--------------tJH0KvGWTC3z0Mdfn8OJvlKr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/10/15 21:42, Askar Safin =E5=86=99=E9=81=93:
> I just noticed that suspend behavior depends on whether "btrfs scrub" is
> started in terminal window or as a systemd service. I think this is beca=
use
> systemd tries to freeze user session when suspending, but doesn't freeze
> services.

I don't think it's the case, as the pm suspend-to-ram requires all user=20
space programs to be frozen.

I guess the difference is in the systemd's handling of user slice.
Maybe it is sending some signal first, then freeze for the time-out=20
case, but directly freeze for the service.

Anyway, mind to test the attached newer patch?

This one also adds the extra signal checking (including the regular=20
SIGINT and fatal ones), hope it would be the last testing patch.

Please apply it upon clean upstream branch (aka, no previous test=20
patches applied).


But if the latest patch doesn't work, I'm running out of ideas.
Inside the kernel I can only find out how to check signals and freezing=20
status, but if systemd is not using those two ways, I have no more ideas.

Thanks,
Qu

>=20
> So I retested everything.
>=20
> All tests were done with my distro's version of btrfs-progs (6.14-1).
> My distro is Debian Trixie.
> I have btrfs raid-1, which spans two actual partitions, 3.5 TiB each.
>=20
> Let's start with unpatched v6.18-rc1.
>=20
> - scrub in win, freeze_filesystems=3D0 - suspend doesn't work
>=20
> - scrub as a service, freeze_filesystems=3D0 - suspend doesn't work
>=20
> - scrub in win, freeze_filesystems=3D1
> suspend takes 6-10 mins. I. e. the system hangs for 6-10 mins and then
> suspends. I suspect this is time needed to complete scrub
>=20
> - scrub as a service, freeze_filesystems=3D1 - the same
>=20
> Also: on unpatched kernel "btrfs scrub" terminates instantly if it recei=
ves
> INT, but doesn't terminate if it receives KILL, TERM or HUP.
>=20
> Now v6.18-rc1 with your old 7 Jul 2025 patch
> ( https://lore.kernel.org/linux-btrfs/9606fae20bff6c1fbe14dc7b067f3b333c=
2a955b.1751847905.git.wqu@suse.com/ ).
>=20
> - scrub in win, freeze_filesystems=3D0 - suspend doesn't work
>=20
> - scrub as a service, freeze_filesystems=3D0 - suspend doesn't work
>=20
> - scrub in win, freeze_filesystems=3D1
> suspend takes 1 min. I. e. the system hangs for 1 min, then suspends
>=20
> - scrub as a service, freeze_filesystems=3D1
> suspend works perfectly. I. e. the system instantly suspends. I don't ev=
en
> notice 19s delay you are talking about
>=20
> Now v6.18-rc1 with your new 15 Oct 2025 patch
> ( https://lore.kernel.org/linux-btrfs/8c3628d5-8fce-45a1-b29c-65c2c52f1c=
06@gmx.com/ ).
>=20
> - scrub in win, freeze_filesystems=3D0 - hangs for 60s, then suspends
>=20
> - scrub as a service, freeze_filesystems=3D0 - works perfectly, i. e. su=
spends instantly
>=20
> - scrub in win, freeze_filesystems=3D1 - hangs for 60s, then suspends
> here is journalctl: https://zerobin.net/?7b394069a9050b8d#7PrnCDJV2t9inN=
FS3/EhxHJUS24iSGX7FAmjUstKKr4=3D
>=20
> - scrub as a service, freeze_filesystems=3D1 - works perfectly, i. e. su=
spends instantly
>=20

--------------tJH0KvGWTC3z0Mdfn8OJvlKr
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-cancel-the-scrub-if-the-fs-or-the-process-is-b.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-cancel-the-scrub-if-the-fs-or-the-process-is-b.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlNTZiZmYxNTFkZTJjOThhZDQ4OWFiMDcyMWIxZDY4ZTU4YjQ1MTI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ZTU2YmZmMTUxZGUyYzk4YWQ0ODlhYjA3
MjFiMWQ2OGU1OGI0NTEyOS4xNzYwNTY5MTg3LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBXZWQsIDE1IE9jdCAyMDI1IDE3OjA3OjAw
ICsxMDMwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGNhbmNlbCB0aGUgc2NydWIgaWYgdGhl
IGZzIG9yIHRoZSBwcm9jZXNzIGlzIGJlaW5nCiBmcm96ZW4KCkl0J3MgYSBrbm93biBidWcg
dGhhdCBidHJmcyBzY3J1Yi9kZXYtcmVwbGFjZSBjYW4gcHJldmVudCB0aGUgZnMgZnJvbQpz
dXNwZW5kaW5nLgoKVGhlcmUgYXJlIGF0IGxlYXN0IHR3byBmYWN0b3JzIGludm9sdmVkOgoK
LSBIb2xkaW5nIHN1cGVyX2Jsb2NrOjpzX3dyaXRlcnMgZm9yIHRoZSB3aG9sZSBzY3J1Yi9k
ZXYtcmVwbGFjZQogIGR1cmF0aW9uCiAgV2UgaG9sZCB0aGF0IG11dGV4IHRocm91Z2ggbW50
X3dhbnRfd3JpdGVfZmlsZSgpIGZvciB0aGUgd2hvbGUKICBzY3J1Yi9kZXYtcmVwbGFjZSBk
dXJhdGlvbi4KCiAgVGhhdCB3aWxsIHByZXZlbnQgdGhlIGZzIGJlaW5nIGZyb3plbi4KICBJ
dCdzIHR1bmFibGUgZm9yIHRoZSBrZXJuZWwgdG8gc3VzcGVuZCB0aGUgZnMgYmVmb3JlIHN1
c3BlbmRpbmcsIGlmCiAgdGhhdCdzIHRoZSBjYXNlLCBidHJmcyB3aWxsIHJlZnVzZSB0byBm
cmVlemUgYW5kIGJyZWFrIHRoZSBzdXNwZW5zaW9uLgoKLSBTdHVjayBpbiBrZXJuZWwgc3Bh
Y2UgZm9yIGEgbG9uZyB0aW1lCiAgRHVyaW5nIHN1c3BlbnNpb24gYWxsIHVzZXIgcHJvZ3Jl
c3NlcyAoYW5kIHNvbWUga2VybmVsIHRocmVhZHMpIHdpbGwKICBiZSBmcm96ZW4uCiAgQnV0
IGlmIGEgdXNlciBzcGFjZSBwcm9ncmVzcyBoYXMgZmFsbGVuIGludG8ga2VybmVsIGFuZCBk
byBub3QgcmV0dXJuCiAgZm9yIGEgbG9uZyB0aW1lLCBpdCB3aWxsIG1ha2Ugc3VzcGVuc2lv
biB0byB0aW1lIG91dC4KCiAgVW5mb3J0dW5hdGVseSBzY3J1Yi9kZXYtcmVwbGFjZSBpcyBh
IGxvbmcgcnVubmluZyBpb2N0bCwgYW5kIGl0IHdpbGwKICBwcmV2ZW50IHRoZSBidHJmcy1w
cm9ncyBmcm9tIHJldHVybmluZyB0byB1c2VyIHNwYWNlLgoKQWRkcmVzcyB0aGVtIGluIG9u
ZSBnbzoKCi0gSW50cm9kdWNlIGEgbmV3IGhlbHBlciBzaG91bGRfY2FuY2VsX3NjcnViKCkK
ICBXaGljaCBjaGVja3MgYm90aCBmcyBhbmQgcHJvY2VzcyBmcmVlemluZy4KCi0gQ2FuY2Vs
IHRoZSBydW4gaWYgc2hvdWxkX2NhbmNlbF9zY3J1YigpIGlzIHRydWUKICBUaGUgY2hlY2sg
aXMgZG9uZSBhdCBzY3J1Yl9zaW1wbGVfbWlycm9yKCkgYW5kCiAgc2NydWJfcmFpZDU2X3Bh
cml0eV9zdHJpcGUoKS4KCiAgVW5mb3J0dW5hdGVseSBjYW5jZWxpbmcgaXMgdGhlIG9ubHkg
ZmVhc2libGUgc29sdXRpb24gaGVyZSwgcGF1c2luZyBpcwogIG5vdCBwb3NzaWJsZSBhcyB3
ZSB3aWxsIHN0aWxsIHN0YXkgaW4gdGhlIGtlcm5lbCBzdGF0ZSB0aHVzIHdpbGwgc3RpbGwK
ICBwcmV2ZW50IHRoZSBwcm9jZXNzIGZyb20gYmVpbmcgZnJvemVuLgoKU2lnbmVkLW9mZi1i
eTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+Ci0tLQogZnMvYnRyZnMvc2NydWIuYyB8IDE5
ICsrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc2NydWIuYyBiL2ZzL2J0
cmZzL3NjcnViLmMKaW5kZXggZmUyNjY3ODU4MDRlLi4xZGRjZDhhODg2MTAgMTAwNjQ0Ci0t
LSBhL2ZzL2J0cmZzL3NjcnViLmMKKysrIGIvZnMvYnRyZnMvc2NydWIuYwpAQCAtMjIzNCw2
ICsyMjM0LDIyIEBAIHN0YXRpYyBpbnQgc2NydWJfcmFpZDU2X3Bhcml0eV9zdHJpcGUoc3Ry
dWN0IHNjcnViX2N0eCAqc2N0eCwKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgYm9vbCBz
aG91bGRfY2FuY2VsX3NjcnViKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQorewor
CS8qCisJICogSWYgc29tZSBvbmUgaXMgdHJ5aW5nIHRvIGZyZWV6ZSB0aGUgZnMgb3IgdGhl
IHNjcnViIHByb2Nlc3MsCisJICogY2FuY2VsIHRoZSBydW4uCisJICovCisJaWYgKGZzX2lu
Zm8tPnNiLT5zX3dyaXRlcnMuZnJvemVuID4gU0JfVU5GUk9aRU4gfHwKKwkgICAgZnJlZXpp
bmcoY3VycmVudCkpCisJCXJldHVybiB0cnVlOworCisJLyogQWxzbyBjaGVjayBmb3IgcGVu
ZGluZyBzaWduYWxzLiAqLworCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50KSkKKwkJcmV0
dXJuIHRydWU7CisJcmV0dXJuIGZhbHNlOworfQorCiAvKgogICogU2NydWIgb25lIHJhbmdl
IHdoaWNoIGNhbiBvbmx5IGhhcyBzaW1wbGUgbWlycm9yIGJhc2VkIHByb2ZpbGUuCiAgKiAo
SW5jbHVkaW5nIGFsbCByYW5nZSBpbiBTSU5HTEUvRFVQL1JBSUQxL1JBSUQxQyosIGFuZCBl
YWNoIHN0cmlwZSBpbgpAQCAtMjI2Myw3ICsyMjc5LDggQEAgc3RhdGljIGludCBzY3J1Yl9z
aW1wbGVfbWlycm9yKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsCiAKIAkJLyogQ2FuY2VsZWQ/
ICovCiAJCWlmIChhdG9taWNfcmVhZCgmZnNfaW5mby0+c2NydWJfY2FuY2VsX3JlcSkgfHwK
LQkJICAgIGF0b21pY19yZWFkKCZzY3R4LT5jYW5jZWxfcmVxKSkgeworCQkgICAgYXRvbWlj
X3JlYWQoJnNjdHgtPmNhbmNlbF9yZXEpIHx8CisJCSAgICBzaG91bGRfY2FuY2VsX3NjcnVi
KGZzX2luZm8pKSB7CiAJCQlyZXQgPSAtRUNBTkNFTEVEOwogCQkJYnJlYWs7CiAJCX0KLS0g
CjIuNTAuMQoK

--------------tJH0KvGWTC3z0Mdfn8OJvlKr--

