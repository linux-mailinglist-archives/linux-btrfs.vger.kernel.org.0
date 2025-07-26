Return-Path: <linux-btrfs+bounces-15682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A5B12A0F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208914E24FB
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293CC233148;
	Sat, 26 Jul 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="q8Dg7oCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244F22A4FE
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525667; cv=none; b=R3pb2TQc5sDGvFnE2FfQtzJpzYiYFhqRMuzLGDRnXyBCpfzrsBzWhfKdgDbFx58yqQ+wRpE+VDZwH+VlcFyFFqGMRROu2Bqtlk83acPNlsClcskgDt3g7Kj6T5bHroi6DSpl0y98Aah+TCbss1a+e6Uqc4DCxP+2+RRhFt2dhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525667; c=relaxed/simple;
	bh=kiLTZlOz/b9M7euCZRINo/HMJz8uU1Jt9sn0QRv1jZw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SXc07fJffW0+TXQlnoR2wsXJeQ1S/ZKptAraJapOgEUHb39RWbJKfREYaYqDwL0hKP0zpb4TjGWUgdO+Kvl9pv9l6EshUdineBANYPygzIFK0VzDbC76BppcodZLKHBxkDd2SzInbtyXfj0gecKZ7JMR2MaTLUbMtmNjhJVfYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=q8Dg7oCU; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1753525662; x=1754130462; i=massimo.b@gmx.net;
	bh=w+uvkQ23irKG5EmDTXH3BoIh3G2MoDnNE83SBSS9sO0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=q8Dg7oCURB+u8exyiLXr/SOv3EeiMLWMvKneupe1ISHFA1+3PjfVbLF6Mn0UriDs
	 fqySgtWqrClSdx/RUQTkxYfknxtjxBhAG5DhVK8OQySFdod3LlLiUmuNvzGldwDTP
	 Z5lIIz1wt/ej6fQCZQwdYFU/YnvZoaprIzkwv5ChhB7ZU1efbt/nsxmgkr0IH+vli
	 r7pX6dDbRzAKTjfc9wjJHcEkkRNwYx59HnqvjMAUvJgxhBfZJzbtAxiweJl1480tp
	 nn9mddbxT34OZVvQs0hmj+8ln2/Jjbu+tCGGBV2G+jEcL/tOxmvtPgRffDXpY72qC
	 IEuAXkQjCrhqi/OMUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gentoo ([95.119.131.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1uxYWF1QK9-00MGrH; Sat, 26
 Jul 2025 12:27:42 +0200
Message-ID: <59e218bf24c5a079d19b3eaa8c8f25d912d832fb.camel@gmx.net>
Subject: Re: bad tree block start, how to repair
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <579ce87edd7ac4ea92196ef7368331239d036717.camel@gmx.net>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
		 <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
	 <579ce87edd7ac4ea92196ef7368331239d036717.camel@gmx.net>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Jul 2025 12:27:33 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 
X-Provags-ID: V03:K1:m4qhjNzeIixw4Wd38uwbkvmSst8uUB1UjhIVzfVsvJgXz8birVU
 E1aONAz4xyxbYaEBymZj8SzWlcnGMnY0meZqbnoO6Ti2xtfX+zzVI3qQ28qoGoG58mx1rFK
 ntSjXhYotBPHN3psLuJyvV10quabqbA3R3ap+/dJ1H5E8kTCZQBnZp96ohTtxVm3wxyZzQR
 Oy9Kh68YtlKnyteArt3nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EHfu0hb1tlE=;6CQhOZnavphlcrYbQnLKglXV6KJ
 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

On Mon, 2025-04-28 at 21:51 +0200, Massimo B. wrote:
> #=C2=A0mount -v -o ro,rescue=3Dnologreplay,rescue=3Dignorebadroots,rescue=
=3Dignoresuperflags,subvol=3D/ /dev/mapper/mobiledata_crypt /mnt/usb/mobile=
data/

After restoring that device and recreating a new btrfs, I ran into the same
issue again due to a power loss with some balancing or bees operation runni=
ng on
that device.

The device is an NVMe inside a USB 3.2 Gen 2x2 enclosure:

# lsusb |grep Storage
Bus 002 Device 002: ID 0bda:9220 Realtek Semiconductor Corp. Ugreen Storage=
 Device

# fdisk -l /dev/sdb |grep model
Disk model:  SN850X 4000GB =20

# hdparm -W /dev/sdb
/dev/sdb:
 write-caching =3D not supported


The machine also has more btrfs on local NVMe and HDD. These drives where n=
ot
damaged yet on power losses. So I guess the USB bridge is not optimal.

Realtek RTL9220 is reported to be suboptimal for btrfs, not supporting
discard/trim, buggy write cache etc. true?
Would some of these perform better? ASM2362, JMS578, JMS583?

Could mount option flushoncommit could provide a bit more safety on that RT=
L
chipset without too much performance impact?

We had similar discussions on
https://github.com/Zygo/bees/issues/319#issuecomment-3103659313

Best regards,
Massimo

