Return-Path: <linux-btrfs+bounces-11322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA0A2AAB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B73A97D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B822DF94;
	Thu,  6 Feb 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="qKfdhw8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0D22655B
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850809; cv=none; b=k/ZSWspKHWtHGt7/EASZ3qJZ24zB6m5SsNd+sVYKim+bNiuHPpDkiNB67MYC+DAx58DX2rG8C2n0bLxGxiKz4AoOnE07bBP7wgy0qXjHY6pBvwVOccmpT+ewQXKCXLFDw9FD7JQfd2HlT0MfLMwZEJ51oUefGOG49YW0H0waU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850809; c=relaxed/simple;
	bh=b+2qyPWE3xpkAxCTID2xA529FRFQ2KWQNTNMIVzkLzA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Qnv5WvemtlN90XzM2SVstHOCX+G63DsalLh4oaHvO4iJ2ZIUqroxfwkfElQ10qO0kR43LJS22LOnRuhV7HPTCHZ69bfHsL1O//iNlZe0hJwNvAiGbNBld08QtAI/kGIWGRED0op24V/9bnIyAThqwHsXKahoSgEq7WBmTzZ+tnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=qKfdhw8I; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738850804; x=1739455604; i=massimo.b@gmx.net;
	bh=b+2qyPWE3xpkAxCTID2xA529FRFQ2KWQNTNMIVzkLzA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=qKfdhw8INb1K+v7T1Mkw9MexUBgRXDqbM53OIhyiE2jI8KPpgxC0W7GM7PKHtN0p
	 Olk4AKOKshiowyDiDCJJtHeRApp9NqDuyB6aRs7D0wCkuSdSmPywEJiuKUaaR/rJF
	 qL8MrEnq/DVTfWXpIJrIpLoz4I4MS2bAusUUOdF7SZmcK+OT37e3sDR3iINLrxR90
	 wEVw0PCFlhrB9iTKOozmXf2nBisXuec5HNoDqPirLJfZHi+4Lv5qRfyCDPQpLirUU
	 TbUM/b5weZ/K1ISlkj56lt8Zzn70L3jPAfM5RkV7z0haRartwTsiUZbgLoXl2XF1k
	 bmXVgXU1Mfiey/9p7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.1.11.68]) by mail.gmx.net (mrgmx004 [212.227.17.190])
 with ESMTPSA (Nemesis) id 1MEFzr-1tWS8X2ykX-00DSHG; Thu, 06 Feb 2025 15:06:44
 +0100
Message-ID: <4d7d8b4036327081418f54b55cd47d90fc2573b0.camel@gmx.net>
Subject: Re: Infinite --repair super bytes used mismatches actual used
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
References: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
	 <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Feb 2025 15:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:zDLgwlZkjbMym89WIRK3WS9gGGWxucmNuGG3DOPe2mPIrcpqBc7
 E0GWu342CU4ZRloujrz7cBlWn1mWKcDPjKYVMZ2C14BKBTVq4R7fyE6neuTq8JYgMBWsj0s
 5q6/msFHYml0MyjATbBPxzUNwsnC+3g+YzUIatBbTTo19F1llo3xbNh6RFC/P8X4Hiq/tv4
 wYyzbo0ItLW6D1n5i2mIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d4Fjxq1hP30=;aVOqv588jYw+IK/X7avz30jCqNJ
 Nrx9TtFQbXhZx+gzkyVf+dQyByLnOteC/l+zJrxKZxWZOADH0arLE2nAlamSDMpnEsutyrXk/
 8JS0DlIysFNfwINjqqgEvboMXdk6K/asdVoZvAmQ2P8rElb6BgiYVX5U0/nwH3rE8ICRn5Gjl
 Jor7WICcn7+iafwVSADcD5lDKk6zP1lOHp3mT2+vH5FphHTUD0wTjWi91cV/dwufjkG1Tg0bE
 +ORy2o/sgT55fgPBte5EpBgAfDbYPgBx+iPkQNNgbiX+NbHNcU5q7G+Nd7iSNyLyKS80LrrJ3
 1DeZShxMYwQt6BWUgaHdIeeJaT1xdqVG5I7OkDpYb5dwLhMuCwXytCqrbtFb7Xsek2xOUqU8g
 r+83sSFZdjOZaovQqEp5u7asW7I+Bjo9DAXN9vuGmJ8EnhM9GpQrUzVp1wlk/Qlhw6XDphorY
 Y0kZBTBL71XjXs8+UENXoESqSHH3Sawp6foi1eLNx4KhumDqn4HWUQZkfbH30Wmn1hiWPlpXX
 2ckzKXJkrHW7M5uwZHL5sFPzMP30ieUR0MjkA35lgK5VGycGoiAprmY7SCNDzBeLd34HI2v7a
 3v3yDmZfmQBhm/H8DY19ONtz0UC6+3wrfT/kd1ilZeBVorKS3giABagSjvkq8J0LRAbtxv/sa
 sGebI/cIXCFZsewC5IVo4NZX0lVFCoS7iTr9KsTMNKMn+/fWvz9iq8x0iij55D5L0IE2sD79q
 xA9Wqdw95oGSXe8ItwEJOVM5ME/5/NndZ6R73HywhZxmyDNKtewVvCHymmgHLUf1faHpp3mDu
 BOaihJZZiNwVZtsI/IgjaPqQh69l8iCEPMYto6VIHUzmUcrchevr7pJ5cGde5TpluDKUBTc0N
 t9Y1GJ2qP7A5OeVe7o6wwBXExrtqbOzfPkqgZ5/kquQcdnHPzqoJ44y+OME6fr0AOL0paOCHJ
 ezO9MJPakbJGKcFzbhNJCMAQfVp2zCnkRR1Lk4XtP0Ahb5aotc69/IMKhz93EXm2liayxBYR6
 nY8RjeGAFjXkFAVqPPoKqp5DPY3QEk8zDjsgc7A3h+iqcMrcClFnQOxaoAYbAd9/t4VanoHeI
 ggMA7Kv11Bd4o6ydI/KIEeT+VUWfwiz78gjjPvcllL8oQQfrnUnUlqOh0uDXM6f3jeYfKxSMT
 RtVgJeAzAX8DWLVNuOCuYxBunUN6CPdr/pYXeUSSGdRiyhjMjjrumqTPVx9kyyrKgyrtPspQO
 a8HMtGQ8zO6RZJeToAjCbpukGKJDAxFlEG21/tp6ZQPJYJQ2uvvmAn1xfW4CfDrOmngDZVRFp
 0fHVEKrIdzc5WsbRKIvri7xKBfz4G2XI+5DthuZxbXKKwEUO/SxSRzxOUfO9lREv+xRYFtuso
 VNbhAAqBCZKO43Li7IfbJ1/YIAWMEoh2CA8x6HtgGclHJy883+ztLskdu0

On Tue, 2025-02-04 at 19:48 +1030, Qu Wenruo wrote:
> Can you provide the full dmesg, not just grepping btrfs for that failed
> ENOENT balance?

Ok, I try.
Mounting the btrfs already leads to a ro mount with this dmesg:

[102401.363345] BTRFS info (device dm-2: state EA): last unmount of filesys=
tem 3d537e3a-1234-1234-8787-cc20ccfda91d
[102421.377114] BTRFS: device label local_data devid 1 transid 153298 /dev/=
mapper/localdata_crypt scanned by mount (13849)
[102421.378249] BTRFS info (device dm-2): first mount of filesystem 3d537e3=
a-1234-1234-8787-cc20ccfda91d
[102421.378259] BTRFS info (device dm-2): using crc32c (crc32c-intel) check=
sum algorithm
[102421.378267] BTRFS info (device dm-2): force zstd compression, level 15
[102421.378269] BTRFS info (device dm-2): using free space tree
[102432.346467] BTRFS error (device dm-2): incorrect extent count for 21370=
5031680; counted 8054, expected 1351
[102493.781034] BTRFS info (device dm-2): checking UUID tree
[102537.367177] BTRFS error (device dm-2): incorrect extent count for 21370=
5031680; counted 8053, expected 1337
[102537.367183] BTRFS error (device dm-2: state A): Transaction aborted (er=
ror -5)
[102537.367185] BTRFS: error (device dm-2: state A) in convert_free_space_t=
o_extents:471: errno=3D-5 IO failure
[102537.367188] BTRFS info (device dm-2: state EA): forced readonly
[102537.367191] BTRFS: error (device dm-2: state EA) in add_to_free_space_t=
ree:1057: errno=3D-5 IO failure
[102537.367192] BTRFS: error (device dm-2: state EA) in do_free_extent_acco=
unting:2887: errno=3D-5 IO failure
[102537.367194] BTRFS error (device dm-2: state EA): failed to run delayed =
ref for logical 213854011392 num_bytes 16384 type 182 action 2 ref_mod 1: -=
5
[102537.367196] BTRFS: error (device dm-2: state EA) in btrfs_run_delayed_r=
efs:2184: errno=3D-5 IO failure
[102537.367202] BTRFS info (device dm-2: state EA): balance: resume -dusage=
=3D90,vrange=3D568106942464..568106942465
[102537.367657] BTRFS info (device dm-2: state EA): balance: ended with sta=
tus: -30
[102538.408582] BTRFS warning (device dm-2: state EA): Skipping commit of a=
borted transaction.

There seems to be a balance being resumed. Should I cancel this? Do I need =
to
mount the btrfs for balancing?

Best regards,
Massimo

