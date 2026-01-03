Return-Path: <linux-btrfs+bounces-20081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D83CEFB27
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 06:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA952300A9D9
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7B21CC44;
	Sat,  3 Jan 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Q27Diak7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167F145FE0
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767417914; cv=none; b=JO7ZrfapOA6gfd/upiPis4yr87Q78mMrx6VM2ubBdq6DbjWS4aaFcBxQJzwWW66h2JWowa9CETuSj9rp84rGIyweiiqHArbseBwS5TAEYhSIlI/r3r80qcCp/ITMYBjhNOexvZkaaEdY5fjKz1W1UIWie0XDj9cx2KEzCF1CJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767417914; c=relaxed/simple;
	bh=Ma8fD2GNsA/23ogBEXZpKXE6GBNa54yqpa5l+6wAW1A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E9+gLi2RRRECEOn0mshoQAYOlBTBaPL8Nw3Rdo7v8/KJ4N/4Dk0bFGttCb6zFelZ3oiuzkDtF2mrpR8ZXkuzFgshB5j4ybhTIK3ZBjNqxo00qoOySNF8znd2zg3poBCuUiH1XsJKwAYKthdwaNFhInb1Utzr6e46cxKfcs8x0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Q27Diak7; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767417904; x=1767677104;
	bh=Ma8fD2GNsA/23ogBEXZpKXE6GBNa54yqpa5l+6wAW1A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Q27Diak7Xv5Q8SWTk3Qm1MjsSyCaD3YDMVnww3qBUJLvvKcY9qWptxwZRjXTtMwBN
	 wrW7znk834Rx6Tq3cpHp1AoBfEoFEFOCiMzMIYTNwUfIa1Vq4bDCpjeCMkQLpJpg7l
	 9yXZN23CNhLx0qT6jxjiBGppUbK/r8yckwONWI/SZ7ZyWHmz22WMhF6MFFWJvm8AEN
	 PS8voWmmfEhLBeWqTY20uky5Blf7nLnzuNtmLcXh8Pp81IppMAv1VyJzXMVHYOTQkU
	 cS/ZZN7wdj9tfBTedsqOyxi1z0HTvIHzjT0zfmbGiIJO/ixs366lsMI238rO6+HzNC
	 FT9469zvY99yQ==
Date: Sat, 03 Jan 2026 05:25:00 +0000
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <ceotdtem@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: TeraCopy can be used to copy files even when the source harddisk has bad sectors (confirmed)
Message-ID: <Lm0qJPBkTst3PlBvSRGz7Yox2TGWkpRA9fwyRYO0Y09bKBiB5A-jRdDdkJ9z4Gkf4fRhihDqTYcECvGIxIf3ftKtPArqtWxqmpFjeKT6dtw=@protonmail.com>
Feedback-ID: 165137334:user:proton
X-Pm-Message-ID: fe4a14361894bdfe9f056e8efedb499986d28af9
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: TeraCopy can be used to copy files even when the source harddisk h=
as bad sectors (confirmed)

Good day from Singapore,

Recently I have THREE (3) units of Western Digital WD My Passport 4 TB USB =
portable harddisks (model: WD40NDZW-11BCVS1) which developed bad sectors. A=
ccording to Reddit and other forums (reported by ChatGPT), many many many u=
sers reported Western Digital 4 TB USB portable harddisks developed bad sec=
tors after a short period of use or have high failure rates. According to C=
hatGPT, Seagate harddisks have an even higher failure rate compared to West=
ern Digital harddisks. According to ChatGPT, internal SATA harddisks and NA=
S harddisks have a much higher reliability than USB portable harddisks.

ChatGPT artificial intelligence (AI) told me TeraCopy can be used to copy f=
iles even when the source harddisk has bad sectors, while Windows File Expl=
orer will stall or hang forever when it encounters files with bad sectors. =
TeraCopy can be configured to skip files with bad sectors or corruption ins=
tead of hanging there forever like Windows File Explorer. Unfortunately, I =
didn't come across this configuration option in TeraCopy. Maybe I need to b=
uy the Pro licensed copy of TeraCopy.

Last night on 2nd Jan 2026 Friday, I have downloaded and installed TeraCopy=
 3.17 from Microsoft Store on my Windows 11 home desktop computer.

At about/approximately 10.53 PM on 2nd Jan 2026 Friday, I started/initiated=
 TeraCopy copy operation. By this time, TeraCopy was at 2.0% copying.

My objective is to copy 3.56 TB of data from one unit of Western Digital 4 =
TB USB portable harddisk to another unit of Western Digital 4 TB USB portab=
le harddisk, over USB 3.0 link. USB 3.0 has a theoretical file transfer spe=
ed of 5 Gbps, as opposed to 1 Gbps for Gigabit Networking.

After waiting for 14 hours 28 minutes, TeraCopy has finally managed to copy=
 3.56 TB of data from one unit of Western Digital 4 TB USB portable harddis=
k to another unit of Western Digital 4 TB USB portable harddisk, over USB 3=
.0 link.

At 1.11 PM on 3rd Jan 2026 Saturday, TeraCopy copy operation has finally co=
mpleted.

Yes, it took TeraCopy 14 hours 28 minutes to copy 3.56 TB of data over USB =
3.0 link (5 Gbps). For Gigabit Networking of 1 Gbps, it would even be sever=
al times slower. Unless you have 2.5 Gbps or 10 Gbps Gigabit Networking.

If it was 7 TB of data, I don't know how many hours it will take. Basically=
 you just sit there and wait for super long hours and do nothing. Just star=
ing into blank space.

According to ChatGPT, if TeraCopy couldn't do it, Linux ddrescue will do th=
e job. ddrescue is for Advanced sector-level recovery. FreeBSD also support=
s ddrescue.

Indeed, I have confirmed that TeraCopy can be used to copy files even when =
the source harddisk has bad sectors, without stalling or hanging there fore=
ver.

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
3rd Jan 2026 Saturday 1.23 PM Singapore Time







