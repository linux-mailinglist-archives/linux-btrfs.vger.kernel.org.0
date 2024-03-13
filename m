Return-Path: <linux-btrfs+bounces-3239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE387A2DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 07:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497BC283427
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BD134BE;
	Wed, 13 Mar 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OQJDRMZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0C111A9
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310054; cv=none; b=GKfVwI+wnPhP0yBhYT/K0wMB4shM5eS0CBSHwgivsGtH7+GjPptid9GCE9A630BqVR2i8aCoC1C1sxQSSihsAb/2srHpBSdDmeb7HjEq/cZ1RYSzcWxKqb97LkTxH/VzsC0qlvrZNzTFk+MqAjY0aQva2bA1KLLVFW7JVwGvXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310054; c=relaxed/simple;
	bh=ZgbQSWrGTQRkNvc+eXFEg9FjeGUzVV9ViFWR5/Quy+0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=SCHz+pdS8sLMFwYO+DdymqfGXABik6rELIADNi0oMOGMvXTL6/orfA5mf6kIZCQ+WUQhUWd6/CDDProf7+mTVa776Gx0xBKJi+I2Fgt+kB8ISwT8Yuu/3s5C5FHwHCkGRejYYo3eYb/Qw8Qo1fJhwI9DLvqN7wjsffHyn4DOXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OQJDRMZO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1710310046; x=1710914846; i=quwenruo.btrfs@gmx.com;
	bh=ZgbQSWrGTQRkNvc+eXFEg9FjeGUzVV9ViFWR5/Quy+0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=OQJDRMZOiAKSJL5AhgdboM/9JTwQkgMvVIgUQofgUWEiYYXrx6GpqJQKLw2XOLVy
	 szKfjwpGVG3aBWG5ehOx58sPF1vDxfHhjEp2ODxKTHNi2gm7F0btwINDdPYceLmMV
	 DfFXShNST04iKNQ+QTk1yijaxeyIdxdYx0TqycYKjxc1/cB1ylmpMXzmswe+CJMIX
	 anv5i+s+WWH+yM0ngl1/a6cEv2nv6C02oHNxGan2A4MaiNlmymc+NmC0WblkkXveN
	 RR+QQCuHnYpYgkE2eLCJjbqEaSMqW/gGrI4W03/u/u2pTO/spwkjb7E50c9GtDkHj
	 IUXhnA0viMej4X/9bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXpQ-1rJqyE16UC-00QQfj; Wed, 13
 Mar 2024 07:07:26 +0100
Content-Type: multipart/mixed; boundary="------------raABw2pHrMCLk2Qp9D5IEH8a"
Message-ID: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com>
Date: Wed, 13 Mar 2024 16:37:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About the weird tree block corruption
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
X-Provags-ID: V03:K1:mWYNF9AnpSvuk6Iddle76TjKyEJuur9PJkX0QD3tEAgYMLY4T6t
 4rIxcGyuMUONzLzGVQ4L+So7ito8V8YofBd2F8RfD4U0EzOFLCNwQtl51qdxaygwz+Veqjr
 vrbkQNn0QtKYv0CkDEUXsHD/+tbbIPFW499ix1960o5wtn1PxoLdYpA2Y1uW9kTy56dt41O
 TlE0ENsF1wadFskdbOtVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nPyU2UWjPJU=;0/HDd4Oixe654ugasBRGNK64y/V
 kOn1s2JhYNRzEnyIqpfe9z5BFEZT1K+YEzWP3ITmw/muIgBPokb5dhRbDLJrz9WYKLLfMNb7N
 OIe/bnomLCWPfU7kH5iR6aNCpdwusTIiplvtinJROrX2e0tPQoV3d18gjaCmFeqlfJ5q82frD
 O1Gb3dfl0bRz7sGunwWtOw701pmHVFYvEXPN3fAdDrf03yfWOLl5ubdCz+QGlTh12iQF4Qawl
 UpPlB7jXDF72q5yv0osTcCBIznch9tlsx/D/og9/8FR9ZyZA1oOHPL1/GhaEH0qflO2sm74uY
 NJe80cO3qV9UoTbXcdmF5/g6wAqbGtZ58GWdLFyXNINr2SlNGZsDs6By+RJQ7VxsCpf5JlWrY
 9HwTD87Y2yPt93cPjD33fVwVqtjTNawpokGnFj3GCENYBBwI7/omPncuQbE8zpcLbbZs4l0hp
 uG1CBKxCFeptwlKNce6+OQY6y0+tBpgQTnET2DHvhIJjjemppY7lj1JLFlczgdF7y9nqYd/gg
 SbUvioLmuJC8rig+Q5lOntWnwEV8rdGp7Kl4Y0gn+f21x9S4iefPH5SWk33L2oski8ONP2tdi
 ACzmc8pTBS7j1S+COfXrUjU92ZuUnTppAgUCJPiWnFzD6jXP1YWhU8L/EvQLf8BNg+lOb6sYn
 05r/uaRcjVYGfUef+ML2SnJNUwjLPnLJaUYbtfgDeN6SrgVbQEyZlrQWqo88K0XKXrcOLnmto
 D2QW1vDZ4Gp1QuOLMmpbleD5KQs8df7iC7F9l2rlcvpF3JEPxPFTYBLt3bkeymwuZ7L1R42Ad
 13QOJd25Xh5KYCgvZIY1z8HGl6k7lLJ1A+5AGXY4P3ukw=

This is a multi-part message in MIME format.
--------------raABw2pHrMCLk2Qp9D5IEH8a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Tavian,

Thanks for all the awesome help debugging the weird tree block corruption.
And sorry for the late reply.

Unfortunately I still failed to reproduce the bug, so I can only craft a
debug patchset for you to test.

The patchset contains 2 patches, the first one is adding the extra
trace_printk() into btrfs.
It requires CONFIG_FTRACE and CONFIG_DYNAMIC_FTRACE kernel configs to be
enabled.

You can use ftrace-cmd to help setting up your environment, but for my
case I normally go with the following bash snippet:

  tracefs=3D"/sys/kernel/debug/tracing"
  begin_trace()
  {
	trace-cmd clear
	echo 1 > $tracefs/tracing_on
  }

  stop_trace()
  {
	cp $tracefs/trace /tmp
	chmod 666 /tmp/trace
	trace-cmd clear
  }

  # Setup the environment
  begin_trace
  workload
  stop_trace

The second patch is to making tree-checker to BUG_ON() when something
went wrong.
This patch should only be applied if you can reliably reproduce it
inside a VM.

When using the 2nd patch, it's strongly recommended to enable the
following sysctl:

  kernel.ftrace_dump_on_oops =3D 1
  kernel.panic =3D 5
  kernel.panic_on_oops =3D 1

And you need a way to reliably access the VM (either netconsole or a
serial console setup).
In that case, you would got all the ftrace buffer to be dumped into the
netconsole/serial console.

This has the extra benefit of reducing the noise. But really needs a
reliable VM setup and can be a little tricky to setup.

Feel free to ask for any extra help to setup the environment, as you're
our last hope to properly pin down the bug.

Thanks,
Qu

--------------raABw2pHrMCLk2Qp9D5IEH8a
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-btrfs-trigger-BUG_ON-when-tree-checker-failed.patch"
Content-Disposition: attachment;
 filename="0002-btrfs-trigger-BUG_ON-when-tree-checker-failed.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NjMyYTIxZDYxNmIzNThkNGRiMzA3OTZiNTdlNmYwNWIyOTY0NDY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ODYzMmEyMWQ2MTZiMzU4ZDRkYjMwNzk2
YjU3ZTZmMDViMjk2NDQ2NC4xNzEwMzA5NDQwLmdpdC53cXVAc3VzZS5jb20+CkluLVJlcGx5
LVRvOiA8Y292ZXIuMTcxMDMwOTQ0MC5naXQud3F1QHN1c2UuY29tPgpSZWZlcmVuY2VzOiA8
Y292ZXIuMTcxMDMwOTQ0MC5naXQud3F1QHN1c2UuY29tPgpGcm9tOiBRdSBXZW5ydW8gPHdx
dUBzdXNlLmNvbT4KRGF0ZTogV2VkLCAxMyBNYXIgMjAyNCAxNjoyNjo0NyArMTAzMApTdWJq
ZWN0OiBbUEFUQ0ggMi8yXSBidHJmczogdHJpZ2dlciBCVUdfT04oKSB3aGVuIHRyZWUtY2hl
Y2tlciBmYWlsZWQKClRoaXMgYWxsb3dzIGtlcm5lbCB0byBjcmFzaCBhbmQgZHVtcCBpdCBm
dHJhY2UgYnVmZmVyLgoKU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+
Ci0tLQogZnMvYnRyZnMvdHJlZS1jaGVja2VyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL3RyZWUtY2hlY2tlci5jIGIvZnMvYnRyZnMvdHJlZS1jaGVja2VyLmMKaW5kZXgg
YzhmYmNhZTRlODhlLi5lYmYwMTljOTZhZGEgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3RyZWUt
Y2hlY2tlci5jCisrKyBiL2ZzL2J0cmZzL3RyZWUtY2hlY2tlci5jCkBAIC0xOTQyLDggKzE5
NDIsMTAgQEAgaW50IGJ0cmZzX2NoZWNrX2xlYWYoc3RydWN0IGV4dGVudF9idWZmZXIgKmxl
YWYpCiAJZW51bSBidHJmc190cmVlX2Jsb2NrX3N0YXR1cyByZXQ7CiAKIAlyZXQgPSBfX2J0
cmZzX2NoZWNrX2xlYWYobGVhZik7Ci0JaWYgKHVubGlrZWx5KHJldCAhPSBCVFJGU19UUkVF
X0JMT0NLX0NMRUFOKSkKKwlpZiAodW5saWtlbHkocmV0ICE9IEJUUkZTX1RSRUVfQkxPQ0tf
Q0xFQU4pKSB7CisJCUJVR19PTigxKTsKIAkJcmV0dXJuIC1FVUNMRUFOOworCX0KIAlyZXR1
cm4gMDsKIH0KIEFMTE9XX0VSUk9SX0lOSkVDVElPTihidHJmc19jaGVja19sZWFmLCBFUlJO
Tyk7CkBAIC0yMDA2LDggKzIwMDgsMTAgQEAgaW50IGJ0cmZzX2NoZWNrX25vZGUoc3RydWN0
IGV4dGVudF9idWZmZXIgKm5vZGUpCiAJZW51bSBidHJmc190cmVlX2Jsb2NrX3N0YXR1cyBy
ZXQ7CiAKIAlyZXQgPSBfX2J0cmZzX2NoZWNrX25vZGUobm9kZSk7Ci0JaWYgKHVubGlrZWx5
KHJldCAhPSBCVFJGU19UUkVFX0JMT0NLX0NMRUFOKSkKKwlpZiAodW5saWtlbHkocmV0ICE9
IEJUUkZTX1RSRUVfQkxPQ0tfQ0xFQU4pKSB7CisJCUJVR19PTigxKTsKIAkJcmV0dXJuIC1F
VUNMRUFOOworCX0KIAlyZXR1cm4gMDsKIH0KIEFMTE9XX0VSUk9SX0lOSkVDVElPTihidHJm
c19jaGVja19ub2RlLCBFUlJOTyk7Ci0tIAoyLjQ0LjAKCg==
--------------raABw2pHrMCLk2Qp9D5IEH8a
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-eb-read-path.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-eb-read-path.patch"
Content-Transfer-Encoding: base64

RnJvbSBmYWQxZDVmZjY3ZTE4Y2VhYThmYTQzOWYwOWJlN2Y0MzIwZjMyN2RmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ZmFkMWQ1ZmY2N2UxOGNlYWE4ZmE0Mzlm
MDliZTdmNDMyMGYzMjdkZi4xNzEwMzA5NDQwLmdpdC53cXVAc3VzZS5jb20+CkluLVJlcGx5
LVRvOiA8Y292ZXIuMTcxMDMwOTQ0MC5naXQud3F1QHN1c2UuY29tPgpSZWZlcmVuY2VzOiA8
Y292ZXIuMTcxMDMwOTQ0MC5naXQud3F1QHN1c2UuY29tPgpGcm9tOiBRdSBXZW5ydW8gPHdx
dUBzdXNlLmNvbT4KRGF0ZTogV2VkLCAxMyBNYXIgMjAyNCAxNjoyNDowMyArMTAzMApTdWJq
ZWN0OiBbUEFUQ0ggMS8yXSBidHJmczogYWRkIGV4dHJhIGRlYnVnIGZvciBlYiByZWFkIHBh
dGgKClRoaXMgaXMgZm9yIHRoZSByZWNlbnRseSBleHBvc2VkIGJ1dCB2ZXJ5IGhhcmQgdG8g
cmVwcm9kdWNlIChmb3IKZXZlcnlvbmUgZXhjZXB0IGF3ZXNvbWUgYW5kIGhlbHBmdWwgVGF2
aWFuIEJhcm5lcykgYnVnLCB3aGVyZSB3ZSBzZWVtIHRvCmdvdCB0cmFzaCBjb250ZW50cyBm
b3Igb3VyIGV4dGVudCBidWZmZXIuCgpTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBz
dXNlLmNvbT4KLS0tCiBmcy9idHJmcy9leHRlbnRfaW8uYyB8IDI0ICsrKysrKysrKysrKysr
KysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnRfaW8uYyBiL2ZzL2J0cmZzL2V4
dGVudF9pby5jCmluZGV4IGJiMjI1Nzk4YmI4OS4uNDMzMzFiYTc0YzY0IDEwMDY0NAotLS0g
YS9mcy9idHJmcy9leHRlbnRfaW8uYworKysgYi9mcy9idHJmcy9leHRlbnRfaW8uYwpAQCAt
OTAsNiArOTAsMTggQEAgdm9pZCBidHJmc19leHRlbnRfYnVmZmVyX2xlYWtfZGVidWdfY2hl
Y2soc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pCiAjZGVmaW5lIGJ0cmZzX2xlYWtf
ZGVidWdfZGVsX2ViKGViKQkJCWRvIHt9IHdoaWxlICgwKQogI2VuZGlmCiAKK3N0YXRpYyBp
bmxpbmUgdm9pZCBkdW1wX2V4dGVudF9idWZmZXIoY29uc3QgY2hhciAqcHJlZml4LCBzdHJ1
Y3QgZXh0ZW50X2J1ZmZlciAqZWIpCit7CisJdTggZnNpZFtCVFJGU19GU0lEX1NJWkVdID0g
eyAwIH07CisKKwlyZWFkX2V4dGVudF9idWZmZXIoZWIsICZmc2lkLCBvZmZzZXRvZihzdHJ1
Y3QgYnRyZnNfaGVhZGVyLCBmc2lkKSwKKwkJCSAgIEJUUkZTX0ZTSURfU0laRSk7CisKKwl0
cmFjZV9wcmludGsoIiVzLCBlYj0lbGx1IHBhZ2VfcmVmcz0lZCBlYiBsZXZlbD0lZCBmc2lk
PSVwVWJcbiIsCisJCQlwcmVmaXgsIGViLT5zdGFydCwgYXRvbWljX3JlYWQoJmViLT5yZWZz
KSwKKwkJCWJ0cmZzX2hlYWRlcl9sZXZlbChlYiksIGZzaWQpOworfQorCiAvKgogICogU3Ry
dWN0dXJlIHRvIHJlY29yZCBpbmZvIGFib3V0IHRoZSBiaW8gYmVpbmcgYXNzZW1ibGVkLCBh
bmQgb3RoZXIgaW5mbyBsaWtlCiAgKiBob3cgbWFueSBieXRlcyBhcmUgdGhlcmUgYmVmb3Jl
IHN0cmlwZS9vcmRlcmVkIGV4dGVudCBib3VuZGFyeS4KQEAgLTM0ODEsNiArMzQ5Myw3IEBA
IHN0YXRpYyB2b2lkIGJ0cmZzX3JlbGVhc2VfZXh0ZW50X2J1ZmZlcl9wYWdlcyhzdHJ1Y3Qg
ZXh0ZW50X2J1ZmZlciAqZWIpCiB7CiAJQVNTRVJUKCFleHRlbnRfYnVmZmVyX3VuZGVyX2lv
KGViKSk7CiAKKwlkdW1wX2V4dGVudF9idWZmZXIoImJlZm9yZSByZWxlYXNlIiwgZWIpOwog
CWZvciAoaW50IGkgPSAwOyBpIDwgSU5MSU5FX0VYVEVOVF9CVUZGRVJfUEFHRVM7IGkrKykg
ewogCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gZWItPmZvbGlvc1tpXTsKIApAQCAtMzQ5OSw2
ICszNTEyLDcgQEAgc3RhdGljIHZvaWQgYnRyZnNfcmVsZWFzZV9leHRlbnRfYnVmZmVyX3Bh
Z2VzKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYikKICAqLwogc3RhdGljIGlubGluZSB2b2lk
IGJ0cmZzX3JlbGVhc2VfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIp
CiB7CisJdHJhY2VfcHJpbnRrKCJjYWxsZWQgZnJvbSAlcyIsIF9fZnVuY19fKTsKIAlidHJm
c19yZWxlYXNlX2V4dGVudF9idWZmZXJfcGFnZXMoZWIpOwogCWJ0cmZzX2xlYWtfZGVidWdf
ZGVsX2ViKGViKTsKIAlfX2ZyZWVfZXh0ZW50X2J1ZmZlcihlYik7CkBAIC0zNTMyLDYgKzM1
NDYsNyBAQCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqYnRyZnNfY2xvbmVfZXh0ZW50X2J1ZmZl
cihjb25zdCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqc3JjKQogCWludCBudW1fZm9saW9zID0g
bnVtX2V4dGVudF9mb2xpb3Moc3JjKTsKIAlpbnQgcmV0OwogCisJdHJhY2VfcHJpbnRrKCIl
czogYWxsb2MgZWI9JWxsdSBsZW49JXVcbiIsIF9fZnVuY19fLCBzcmMtPnN0YXJ0LCBzcmMt
Pmxlbik7CiAJbmV3ID0gX19hbGxvY19leHRlbnRfYnVmZmVyKHNyYy0+ZnNfaW5mbywgc3Jj
LT5zdGFydCwgc3JjLT5sZW4pOwogCWlmIChuZXcgPT0gTlVMTCkKIAkJcmV0dXJuIE5VTEw7
CkBAIC0zNTczLDYgKzM1ODgsNyBAQCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqX19hbGxvY19k
dW1teV9leHRlbnRfYnVmZmVyKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLAogCWlu
dCBudW1fZm9saW9zID0gMDsKIAlpbnQgcmV0OwogCisJdHJhY2VfcHJpbnRrKCIlczogYWxs
b2MgZWI9JWxsdSBsZW49JWx1XG4iLCBfX2Z1bmNfXywgc3RhcnQsIGxlbik7CiAJZWIgPSBf
X2FsbG9jX2V4dGVudF9idWZmZXIoZnNfaW5mbywgc3RhcnQsIGxlbik7CiAJaWYgKCFlYikK
IAkJcmV0dXJuIE5VTEw7CkBAIC0zODkzLDYgKzM5MDksNyBAQCBzdHJ1Y3QgZXh0ZW50X2J1
ZmZlciAqYWxsb2NfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywKIAlpZiAoZWIpCiAJCXJldHVybiBlYjsKIAorCXRyYWNlX3ByaW50aygiJXM6IGFsbG9j
IGViPSVsbHUgbGVuPSVsdVxuIiwgX19mdW5jX18sIHN0YXJ0LCBsZW4pOwogCWViID0gX19h
bGxvY19leHRlbnRfYnVmZmVyKGZzX2luZm8sIHN0YXJ0LCBsZW4pOwogCWlmICghZWIpCiAJ
CXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwpAQCAtNDExNCw2ICs0MTMxLDggQEAgc3RhdGlj
IGludCByZWxlYXNlX2V4dGVudF9idWZmZXIoc3RydWN0IGV4dGVudF9idWZmZXIgKmViKQog
CQl9CiAKIAkJYnRyZnNfbGVha19kZWJ1Z19kZWxfZWIoZWIpOworCisJCXRyYWNlX3ByaW50
aygiY2FsbGVkIGZyb20gJXMiLCBfX2Z1bmNfXyk7CiAJCS8qIFNob3VsZCBiZSBzYWZlIHRv
IHJlbGVhc2Ugb3VyIHBhZ2VzIGF0IHRoaXMgcG9pbnQgKi8KIAkJYnRyZnNfcmVsZWFzZV9l
eHRlbnRfYnVmZmVyX3BhZ2VzKGViKTsKICNpZmRlZiBDT05GSUdfQlRSRlNfRlNfUlVOX1NB
TklUWV9URVNUUwpAQCAtNDM0Nyw5ICs0MzY2LDEyIEBAIHN0YXRpYyB2b2lkIGVuZF9iYmlv
X21ldGFfcmVhZChzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvKQogCiAJZWItPnJlYWRfbWlycm9y
ID0gYmJpby0+bWlycm9yX251bTsKIAorCWR1bXBfZXh0ZW50X2J1ZmZlcigicmVhZCBkb25l
IiwgZWIpOwogCWlmICh1cHRvZGF0ZSAmJgotCSAgICBidHJmc192YWxpZGF0ZV9leHRlbnRf
YnVmZmVyKGViLCAmYmJpby0+cGFyZW50X2NoZWNrKSA8IDApCisJICAgIGJ0cmZzX3ZhbGlk
YXRlX2V4dGVudF9idWZmZXIoZWIsICZiYmlvLT5wYXJlbnRfY2hlY2spIDwgMCkgeworCQl0
cmFjZV9wcmludGsoIiEhISBWYWxpZGF0aW9uIGZhaWxlZCwgZWI9JWxsdSAhISFcbiIsIGVi
LT5zdGFydCk7CiAJCXVwdG9kYXRlID0gZmFsc2U7CisJfQogCiAJaWYgKHVwdG9kYXRlKSB7
CiAJCXNldF9leHRlbnRfYnVmZmVyX3VwdG9kYXRlKGViKTsKLS0gCjIuNDQuMAoK

--------------raABw2pHrMCLk2Qp9D5IEH8a--

