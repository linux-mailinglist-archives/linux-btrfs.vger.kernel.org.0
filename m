Return-Path: <linux-btrfs+bounces-13471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92861A9F9F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10AA460168
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB02951A9;
	Mon, 28 Apr 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="n0lKmML+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF3289363
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869920; cv=none; b=rvzNyqtC0+3+StI3GKujOF+nfg9ngWp8Oc0vpeUmAsNTUhz9dumWf1lAAFXlpghGAP8IGR2M25/9pw343biK42NOaA8BQKolM2SE+meNeH8hahkkoh+35aI6V/Y0JvhCK6iVtYcLnRKJdF7b6zjz4VQ5lq1XnajVL4TU1R4SchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869920; c=relaxed/simple;
	bh=S9Iiy9q8BAjRk7DvdP89tshKSYI2DKqRhY7bBDdxQjE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Z11NHuGvgHftgGHOPEag9euLGFkTHqwyG3ZglD3M0+eEHDhnJjduXDcmOsTqK1stV4t0s6Z0rlq3WF/T1YI87Lqteq1Dl5YEqAEQj3SOrI2PpIkDbXaHJ/fBiRgG5Q6uumiIjunv+W8ZAu3bRy6liYtOfcZwc10kh1/JMU35GUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=n0lKmML+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745869913; x=1746474713; i=massimo.b@gmx.net;
	bh=S9Iiy9q8BAjRk7DvdP89tshKSYI2DKqRhY7bBDdxQjE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=n0lKmML+g0G7DWKnDzo1edltW8Jq1s2ybdAdiNNCzh6S2yKKETDVZ59E09k4JYqI
	 0BUDKrwKeVTdTv+FC4lpbeAg0xKV3gWTtziyh6LPwo4btJBzk01YDWwdHJl44q1YX
	 xMfj4OaueFuqIa00h1hdXFnuVtG0vb6bn7560gMC8X3VO3alhSnPj5fKUfvHCm8sF
	 dqYeMsLfQ3yBn1FmBCJqzp3g4uZhgpV6ipgIIz7KLTCQeT8bgyUSnl425s1AVwVOZ
	 fu5EKXxeabTDwEjGgBuXuzarxz3RzwA+9QLSgm/7RXADxI49HZoWQruU9EIblM/5Q
	 62/pWlvW5jHJgCmaMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gentoo ([2.241.16.13]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1ueEmn3HU0-00MfBo; Mon, 28
 Apr 2025 21:51:53 +0200
Message-ID: <579ce87edd7ac4ea92196ef7368331239d036717.camel@gmx.net>
Subject: Re: bad tree block start, how to repair
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
	 <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Apr 2025 21:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:xrK2rPJVXAxjYn4fAboReNyvfG8omQq/QIk2/fJlrmgDwz6d4X0
 8iHF3SdGG2hWbY3vAN6l+1lAsQcsBkdu3ZFDY/GBHCwMlr/Cm24RRY+lNhhSO4irJ0tEGZj
 ekANM0sL51EjOOqdqQRG17oaJw0q0/86/HDnOw9eOJMI2MdJofu1jmbHNQ0s08kLZk3MUN7
 DIQFd2Ir5VI4JoEwJa4RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1/na1T1daPY=;ekOCpFTy/AXj0nJUuTeqi3hXaXS
 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

On Sat, 2025-04-26 at 19:38 +0930, Qu Wenruo wrote:
> It looks like only free space tree is corrupted.
>=20
> At least you can grab all your data using "resuce=3Dall,ro" mount option.
>=20
> Unfortunately I'm not aware of tools that can drop a corrupted free=20
> space tree (the existing tools all requires a working free space tree to=
=20
> drop free space tree...).

Ok, I preferred to have rescue=3Dnologreplay:ignorebadroots:ignoresuperflag=
s for
not ignoring checksum failures.
But I failed to mount like this and got
 Bad value for 'rescue'.

I need to do it like this:

#=C2=A0mount -v -o ro,rescue=3Dnologreplay,rescue=3Dignorebadroots,rescue=
=3Dignoresuperflags,subvol=3D/ /dev/mapper/mobiledata_crypt /mnt/usb/mobile=
data/

Is that a bug? Kernel is 6.12.16-gentoo-dist

I'm transferring all snapshots via btrbk archive now, that's working well s=
o far.

How would checksum failures look like?
Just a warning in syslog from [kernel] BTRFS ?

Best regards,
Massimo

