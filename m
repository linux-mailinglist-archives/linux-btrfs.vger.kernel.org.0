Return-Path: <linux-btrfs+bounces-17816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA2EBDCD09
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839574F7BB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5357221710;
	Wed, 15 Oct 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TOqr2oVx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A04502F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511638; cv=none; b=YogsyYiT4Sb/5kl2NPQhJnrtnZHZuSkDzBwjVWP2/Q+g46rNM2YlsXaEKQbdnWvu7AcYTE+UzgqrXYUT7l+zZ/xENXlr8er2sJPjQ3aPRmKqPJJoc6aj2QWyPMRCwD1PTSf3Gp5vIskYduGbHlk8VmVmOi7pgZe4280qAt8mbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511638; c=relaxed/simple;
	bh=yWWSDgM2ddv/s2dgYu+ZEzh2eYm6Zz5i+gzoRE7iNOo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=QoFRBjnJUFtjzjrzmTotDjCE6gMIsUcwlOTvr8F9u3ogy/c9xYHvZro+awpS46rYKKyifp9HHYyj4struR7VcBmyb417klf4u3A9JSkTd7D2EojSqy/hcj7iVSNDKlF8HCX+UYZPCaFeDLfuRjAb7a/JW3rSqKMRz1paM99LS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TOqr2oVx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760511633; x=1761116433; i=quwenruo.btrfs@gmx.com;
	bh=P58cho5EnuwNbyrQceSzjCO+FHiC/yvNI5IHQ3LFh5A=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TOqr2oVxUkdvLRI4fA1xhWvdpQ/WJVC5mxzSuanP9PAeWd47ovqx+eBVlpQ1GGEn
	 3rzP9K+txdyj0a6299wH3NoeLz1UOz1iTVMQt3zNm+T1XNQxUOHVDd/2ycfDP/9gr
	 bg2IBl8e1jPGKcM04RxXqLSryoFKU3CrqKtV5U28Ofxr4rSyVS7vr5VwalmHLmdgo
	 e6zEJDdPdPRYnHurtz7YAFnVhfWu71TiinVTPaKGJzmzfFgo+f8hJEDu9iu9nU4uC
	 o+TDP6ExjAHOt+nOtfhFMuonqjyxjeei0gWioAO2uHB74f2eOeo2xhS5j5g7M7Utq
	 /gpWkcLkbAEXJEYuOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1uNnzA3mnc-00eU74; Wed, 15
 Oct 2025 09:00:33 +0200
Content-Type: multipart/mixed; boundary="------------QRlVu0I8lsY4j0ZIFNZyazcy"
Message-ID: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
Date: Wed, 15 Oct 2025 17:30:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Askar Safin <safinaskar@gmail.com>, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
 David Sterba <dsterba@suse.com>
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <20251012082355.5226-1-safinaskar@gmail.com>
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
In-Reply-To: <20251012082355.5226-1-safinaskar@gmail.com>
X-Provags-ID: V03:K1:YJFbdLvfv4EnGpVG3xZKjRGTTMtXrha1gRQzNnEcPvE02MMaVKn
 6dsNbiSaLkR+4YVsJY3ZWS/XRhxLgX6u08PJbl+RP7sjk++5O2a67Je0YpqNa3i5NhSmN3l
 kMx12LkW3YN/CLM//Bhx+4/Sj6LVNJPLAZ6p29TWB+YUVkWedLF8WxL4CPHOhuYDuwI3mJY
 OAB5otUpsKEbgfrb7n6/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+C7RBsBHqeQ=;XxF7Ql6fi7HMHN48OC7ACeGQjsX
 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
 pDiKIrQCKOW7WvfT8OzrvseI6b/wxFhC2OP2f9

This is a multi-part message in MIME format.
--------------QRlVu0I8lsY4j0ZIFNZyazcy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/10/12 18:53, Askar Safin =E5=86=99=E9=81=93:
> Qu Wenruo <wqu@suse.com>:
>> There are some reports that btrfs is unable to be frozen if there is a
>=20
> I tested your patch on real hardware.
>=20
> I applied it to current Linux mainline.
>=20
> I have btrfs-raid on two big disks.
>=20
> I started "sudo btrfs scrub start -B -d /" and pressed "Suspend" in GUI.
>=20
> If /sys/power/freeze_filesystems is 0 (this is default), then your patch=
 doesn't work.

In that case, the problem is my patch only checks if the fs is being=20
frozen. And if suspension doesn't need to freeze the fs, it will not work.

>=20
> If /sys/power/freeze_filesystems is 1, then the system stops to respond =
for a minute
> and then suspends. Here is journalctl:
> https://zerobin.net/?e3376d7d056dcb04#LyzGFYeVdWsbZfgC25G4TuSct6QDyZ278g=
QlZgCfR94=3D .

Btrfs detects the freezing request, and canceled the run, so that part=20
is working:

   Oct 12 10:56:08 comp kernel: BTRFS info (device nvme1n1p1): scrub:=20
not finished on devid 1 with status: -125
   Oct 12 10:56:08 comp kernel: BTRFS info (device nvme1n1p1): scrub:=20
not finished on devid 2 with status: -125

And since we canceled the run, the ioctl returned, thus all user space=20
programs can be frozen:

   Oct 12 10:56:08 comp kernel: Freezing user space processes
   Oct 12 10:56:08 comp kernel: Freezing user space processes completed=20
(elapsed 0.001 seconds)

Unfortunately the delay (19s) between the freeze request may not be=20
reduced any further, the current check timing is for each full stripe (64K=
).

Maybe we can reduce the number of running stripes in the future.

But you experienced a full 60s, which I can not explain.

>=20
> As well as I understand from journalctl, systemd tries to freeze userspa=
ce
> process "btrfs scrub" and fails. Then systemd times out after a minute,
> and then suspend proceeds.
>=20
> So, in short, this is not complete solution yet.

Please try the attached patch, the idea is still based on the older=20
patch, but now added the extra check for user space process freezing check=
s.
Thus it should still work without freeze_filesystems set to 1.


BTW, since the user space process freezing part require the process to=20
exit to user space, it means pausing is not feasible, as pausing is=20
still waiting inside kernel space, thus will not work.


Unfortunately that patch is only taking scrub into consideration, thus=20
please do not test any relocation yet.

Thanks,
Qu

>=20
> Also I tested Sterba's patch, and it doesn't work either:
> https://lore.kernel.org/linux-btrfs/20250720194803.3661-1-safinaskar@zoh=
omail.com/ .
>=20
> I really want this bug to be fixed. Please, CC me with your future attem=
pts.
>=20

--------------QRlVu0I8lsY4j0ZIFNZyazcy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-cancel-the-scrub-if-the-fs-or-the-process-is-b.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-cancel-the-scrub-if-the-fs-or-the-process-is-b.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhNjE4NjI3YjZiZjMxNmI2NGE4YjBiMmEyODlkYWIwYzhhMDFiNDg1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8YTYxODYyN2I2YmYzMTZiNjRhOGIwYjJh
Mjg5ZGFiMGM4YTAxYjQ4NS4xNzYwNTEwOTMwLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
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
eTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+Ci0tLQogZnMvYnRyZnMvc2NydWIuYyB8IDE1
ICsrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMv
c2NydWIuYwppbmRleCBmZTI2Njc4NTgwNGUuLmNkNmM3MGMzNzA3NiAxMDA2NDQKLS0tIGEv
ZnMvYnRyZnMvc2NydWIuYworKysgYi9mcy9idHJmcy9zY3J1Yi5jCkBAIC0yMjM0LDYgKzIy
MzQsMTggQEAgc3RhdGljIGludCBzY3J1Yl9yYWlkNTZfcGFyaXR5X3N0cmlwZShzdHJ1Y3Qg
c2NydWJfY3R4ICpzY3R4LAogCXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBib29sIHNob3Vs
ZF9jYW5jZWxfc2NydWIoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pCit7CisJLyoK
KwkgKiBJZiBzb21lIG9uZSBpcyB0cnlpbmcgdG8gZnJlZXplIHRoZSBmcyBvciB0aGUgc2Ny
dWIgcHJvY2VzcywKKwkgKiBjYW5jZWwgdGhlIHJ1bi4KKwkgKi8KKwlpZiAoZnNfaW5mby0+
c2ItPnNfd3JpdGVycy5mcm96ZW4gPiBTQl9VTkZST1pFTiB8fAorCSAgICBmcmVlemluZyhj
dXJyZW50KSkKKwkJcmV0dXJuIHRydWU7CisJcmV0dXJuIGZhbHNlOworfQorCiAvKgogICog
U2NydWIgb25lIHJhbmdlIHdoaWNoIGNhbiBvbmx5IGhhcyBzaW1wbGUgbWlycm9yIGJhc2Vk
IHByb2ZpbGUuCiAgKiAoSW5jbHVkaW5nIGFsbCByYW5nZSBpbiBTSU5HTEUvRFVQL1JBSUQx
L1JBSUQxQyosIGFuZCBlYWNoIHN0cmlwZSBpbgpAQCAtMjI2Myw3ICsyMjc1LDggQEAgc3Rh
dGljIGludCBzY3J1Yl9zaW1wbGVfbWlycm9yKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsCiAK
IAkJLyogQ2FuY2VsZWQ/ICovCiAJCWlmIChhdG9taWNfcmVhZCgmZnNfaW5mby0+c2NydWJf
Y2FuY2VsX3JlcSkgfHwKLQkJICAgIGF0b21pY19yZWFkKCZzY3R4LT5jYW5jZWxfcmVxKSkg
eworCQkgICAgYXRvbWljX3JlYWQoJnNjdHgtPmNhbmNlbF9yZXEpIHx8CisJCSAgICBzaG91
bGRfY2FuY2VsX3NjcnViKGZzX2luZm8pKSB7CiAJCQlyZXQgPSAtRUNBTkNFTEVEOwogCQkJ
YnJlYWs7CiAJCX0KLS0gCjIuNTAuMQoK

--------------QRlVu0I8lsY4j0ZIFNZyazcy--

