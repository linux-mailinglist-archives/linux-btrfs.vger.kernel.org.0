Return-Path: <linux-btrfs+bounces-3720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9888FD3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629B21F266AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B107CF27;
	Thu, 28 Mar 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="MLZdJbNK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9353818
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622391; cv=none; b=cesMRw3t7pu2JrJfk/Ad9Zcd9Bi4wnQBwGIqrBrKCEwRDKRGg9+97bmXirOxKi3Pr4FswvsRkh56fg2NrsfDw8qdwLssHi10B8viMgJYyGonC6efL97BK00TcJeOK5QfE+Qi6XKGVB9xTpG6cR9yMZnCKzIWK0PD6p2M4hbZ8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622391; c=relaxed/simple;
	bh=zizeEGSdkixaD7dn0Nr7lpMHrIBuephY10jMMcJenbE=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SIUiOfGAWwTeq3ZcTUaXwhxs688d5zAHHiuDNnFKsZ2gkM3AVutLgWU9H51UK+OJ4Ca4+nV+xKUv/uD3uO+RgupKqbzF0sBjd8Jd2/5NEogBymhyjSnxUaKY+psbHcNdGN3EiS4lYsbyc3M6lx3z+CzijhNPoQvfmCVpqI8Rf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=MLZdJbNK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1711622387; x=1712227187; i=massimo.b@gmx.net;
	bh=whyqKqqO9jIjTzcBVmrVTB/RYb+w2M91w/1XBo/jyXI=;
	h=X-UI-Sender-Class:Subject:From:To:In-Reply-To:References:Date;
	b=MLZdJbNKJCHtx2T40L5pbVglvD5B1CEuFq5Lrv2cnwX7Kxm2AfEFeg0eejKRzE4M
	 eJR0Boc8I8+PvnFPqdnuYYxlVMW4hTXgQ7ljJDaVrJ8lnVIB2jBudA1YGIIhKXDVU
	 ZtrkcMNcur18Nzikp//q2HBx8UBFgjTkwsLFDVorbEhEaUCb0V8Bj8EEFuaUK26E4
	 DfT5U/5plW02t1btwQ1Bva/3hCpGSfl99XR3i9oa2oDV1AGIsx4F2lFLoL6z1GBI+
	 XLNahc23JEAVHA+HieZyRBBcO3Q8MWfAGj2HC+yPCWulf4Hbtchxlmyk106USzUDz
	 71ddwSqYG+b6r3z4Wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.7.129.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1rtOKq17Kh-006PNh; Thu, 28
 Mar 2024 11:39:47 +0100
Message-ID: <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
Subject: Re: I/O blocked after booting
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	 <linux-btrfs@vger.kernel.org>
In-Reply-To: <22650868-6777-41ae-a068-37821929be7c@gmx.com>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
	 <22650868-6777-41ae-a068-37821929be7c@gmx.com>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 11:39:36 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Provags-ID: V03:K1:5fuzJO+n8DCU7ghPCbWGg4I4KmSqL5FFD8GPGQh7uw/VZtVYlx7
 pyCu69GlWuXCO6jse6a6kHDPj65IaEiqNkJfy3zbNpt9B2hzbrY9wRlPPdSJiIu6mLzCVbb
 pRTdHqoz9IykG2lWazj/E36Uno/a9Z8tzDbyrVj7gaApUAF6kqm8hGUBW1b1at9wa+wz4IZ
 KG0detPH/YY9e/uhkoBiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLdIsG5IQf4=;uHRmi4PHL7NDkZ3Q2SO5AJFni9e
 K5pROpOeQkPXnZN3bEQFFv3y8o/0amYBuz2MJTL256XTHZgOlhDCqEG6XuvQriTkt9El1IO5H
 6Bsp6yzvtbeHj60mtlEIsWcPZ2arNcMHMiIA4VwoEBj76B3iLEMUuXS6xweDc1sODcSpHUArz
 G/uKLeaAjOyNSFdvDaMQnXlG91q7+KQDE8Fn98nUN9Oe02G36bIWA9v1r3Q/9JOks1AeDFY0M
 Fx5t6usaJXZjWIRMzikkTjfAD9FJZPwmjB4Gr7apg57mvFGOQhQsPPYYnyHbzMhkHYu3DatBP
 CEHcGjeo6r4D5gOkivB0tT6A68ewDyhfR/MJarPldE3NoPohCctCtYmYbRh6/UVQQEK8RNUA8
 nXYWjzsmi7r1K/QYYEVDOR75Df8CUHcgGBiw/O5MwdUOo3cndOSEn+lUzi4M88Dgl9ruO8JMt
 DqhjDp0GB52Dncg6nux2JsTBpKbARyOq8hrf4moTcN9KmiLdYSF7w+FhtJNaCpaTO+bc7IQIQ
 G7zxrFAGuHMtXyUKT0HewihJOZjTPtBPPAJniD/XPFmepPiH6hQGR2siF/4jien4pE5/tzLiJ
 C3Tinhjlf8o3VQC+pnb+JLA6cnCMghVTPRBsQbPFzRty11DtJ+Hmzm+BUgjwmzSPTcPVmArt7
 j4UsRYb7QUKV1VNCfk44w82Lr9lqpPLISjfOdOZV+DMUnU5t5ek4ZVDbLaRuRbT3QpSZs6WTT
 HD++aWJ/N+4W/QezT8+bnVCQKf3gAsyud5DTl1FgnPonRgUtQM0V5w4mBOMvJmxd41+94HUzK
 AJulSmk9u9qkCAG7HoFc1T5LmLMDNWR6Kt/UKIxYYBpPU=

On Thu, 2024-03-28 at 20:40 +1030, Qu Wenruo wrote:
> Disable disable (nodiscard mount option), as it looks like there is
> something wrong with the auto discard, then retry.
>=20
> This is mostly related to your NVME device's discard implementation, and
> I believe manually fstrim may be a better and more reliable solution.

Ok, I'm going to try.
Beside that I'm using different NVMe models and also an SATA SSD "Samsung S=
SD
860" and all are affected by that issue.

So you mean a daily cronjob for fstrim would be preferable?

Trying  fstrim -a -v  here with the very common Samsung SSD 970 PRO 1TB NVM=
e,
the command=C2=A0started discarding small partitions:

/boot/efi: 31,6 MiB (33183744 bytes) trimmed on /dev/nvme1n1p1
/boot: 0 B (0 bytes) trimmed on /dev/nvme1n1p2

but then does not return after 20 minutes. There is no IO on the disk which
might be ok for fstrim only communicating with the controler. But fstrim pr=
ocess
has some CPU usage...

And I see the same syslog entries after starting the fstrim:

Mar 28 11:38:26 [kernel] [14826.740669] BTRFS warning (device dm-0): failed=
 to trim 698 block group(s), last error -512
Mar 28 11:38:26 [kernel] [14826.741731] BTRFS warning (device dm-0): failed=
 to trim 1 device(s), last error -512

Best regards,
Massimo

