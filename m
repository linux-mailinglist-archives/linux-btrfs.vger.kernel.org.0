Return-Path: <linux-btrfs+bounces-17914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D34BE6522
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 06:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9079E4EADC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 04:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669133093CB;
	Fri, 17 Oct 2025 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iapT0PAp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F1334689
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675942; cv=none; b=ngQKPJU7OUG/zU05/96MWlNwaBZAJ8w6vm4RXkBuFTNr9gvHsVNXs3AU7MCZnN8f6EpQq/4fzrjMslqbN5H7STtXWKlxppYZa5TQOxwIdmk/6NQg/dKdSOag0U46N2aoE5m8+mtgKT7ZmvYzyOMla6Ie88CuW2xxPdWdt8w1JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675942; c=relaxed/simple;
	bh=ovbdQTRz6xWPYQJNySXfzcDzJxgSdZAIp76cj774qz4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BSTKD1lDu+RIFZcnt+wfZcucMjqZlyv+ZWO+rt8BM7T9j685jtrox/q7P8wk6I6dQnJrURgbbjWAvdMIF5DfeAZlvVR2jbERYisWiLrmbQBwWcXrA24YdoFIUsqymT3JThYr/BXzUWP1GUwP3LjB6DKjKP6l8bO4GcNY3dww7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iapT0PAp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760675936; x=1761280736; i=quwenruo.btrfs@gmx.com;
	bh=ovbdQTRz6xWPYQJNySXfzcDzJxgSdZAIp76cj774qz4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iapT0PApzEm4hC6lRhj3pm8rPcBbFzt2ctB6dhDBzy9ERuyt8qb6GkfiFFW1QkiM
	 Wxq3VG8sRNsYTP23ecIlwLV08bmUlkCInUyoiukV4SchWwE5K5bUjQjk3aJ6aSpeu
	 rY8RzLj7LagtpVxZWjsRY87PHfMZcEZ07G4b2TGdlcbAtYRt/6O/UQ8HzTr/1dBBq
	 1hlBbIK/DwwDSy4bP+sxUh2BIb+RDcbpBdo0c3Oy3SiS/ZAIxULuPi2BgDJ+D7aNK
	 hKUjnrCrTZha7/2xnjr3BMrjQl3zUKrlplP1Ddpr6g1GhISFlbbV6+4sQ9Vt1eqCt
	 lYDPNYy2DS1ov+/HPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1uOn291x7W-00bhtK; Fri, 17
 Oct 2025 06:38:56 +0200
Message-ID: <32690b57-86ac-49bd-b913-b080aab03b42@gmx.com>
Date: Fri, 17 Oct 2025 15:08:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: systemd-devel@lists.freedesktop.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Any proper way to prevent system from power management
 suspension/hibernation?
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVdaLP4gmVTxFRsgt4LAOmdYsAlmaf9COBT/ZokAw8lLOfv7ULb
 9cbL1RKW+to+7NfbaffV+sYC0I8ZXjAIt6q8PX2403fledeACSFiQA8FMXBpvGO1nWlzTfQ
 xFGxHzDg8yv2VK510MGyjPjc69LGh3/zU10I5bg1AcACTTez7n4psIAFiNgmanQ+dE+Nxmx
 HoUFZlEHPgrsfhyqXdETQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Tm2LjtC3c8=;zcQnD55OHKWyvvcUa8fHpmNOYY5
 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
 EEqCpd2SjyZ9/Q==

Hi,

Recently I'm fixing a bug in btrfs scrub/replace where long running=20
scrub/dev-replace ioctl will prevent systems from suspension/hibernation.

With that fixed, btrfs scrub/dev-replace will abort the current run if=20
the filesystem or the process is being frozen, thus allowing pm to=20
freeze the fs then the process.


However this exposed another problem, now PM suspension/hibernation will=
=20
always interrupt scrub/dev-replace runs, and it's not that easy to=20
resume from the last handled bytes.

I'm wonder if there is any generic solution to prevent power management=20
from entering suspension/hibernation (using systmed), and is generic=20
enough to handle not only pure systemd, but also various GUI=20
environments (like KDE/GNOME).

If there is such solution, we can provide different systemd services=20
files to end users, and they can choose what version they want, either=20
gives pm the priority and accept scrub/dev-replace can be interrupted,=20
or prevent pm actions in the first place (no attempt to even suspend,=20
thus no extra timeout).

Thanks,
Qu

