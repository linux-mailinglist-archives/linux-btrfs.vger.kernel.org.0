Return-Path: <linux-btrfs+bounces-13379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14940A9A42A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 09:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2627D1719D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39F22170B;
	Thu, 24 Apr 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astutebeam.pl header.i=@astutebeam.pl header.b="FSDe8cWt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.astutebeam.pl (mail.astutebeam.pl [162.19.205.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E522126A
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.205.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479855; cv=none; b=lEtnCkeBXWm177ouObsg7XRtT4tyQDsCxgTPavMtcStmqmu2ONTfuU3DOpR6YO6BmarHYYo2FgRjxgHV2iaR1QN4sUMf+PGO/B23o+st68Bsm3y5F2l/WA6sx9lKrndAOkkNWuaaHktgxpggCxAr1a7qxpQVNtjZ/dY/vuT8nCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479855; c=relaxed/simple;
	bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=C08QRFkpbQe98pbHTCoyYwTps0cuY8hnHAmWvTzA9VIdAxpyy/La+35onB6X9gggfyb18f0ZA2bSX88JNXGNxfjVdLI88+pyydlgPJgMvyl2bgy7aDZCg9v7jDySHhrWniAhrrvK8m7nKR7FxAwsX+EDDsrJp4fvytjmf5Pbb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astutebeam.pl; spf=pass smtp.mailfrom=astutebeam.pl; dkim=pass (2048-bit key) header.d=astutebeam.pl header.i=@astutebeam.pl header.b=FSDe8cWt; arc=none smtp.client-ip=162.19.205.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astutebeam.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astutebeam.pl
Received: by mail.astutebeam.pl (Postfix, from userid 1002)
	id 3474A25AEF; Thu, 24 Apr 2025 09:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astutebeam.pl;
	s=mail; t=1745479842;
	bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=;
	h=Date:From:To:Subject:From;
	b=FSDe8cWtWgYive6eC5yoh7Wd8TLOATw/LuO8p4qfDmwbJxol85gyJVDSqkNI972F0
	 IuXausQe1dZ/jgHQec3WgDKok85XpX/qtOW+gDSfTpke67gTAwLCXpqSofL8HCueZ9
	 tude3ZRtTztmRNfBem7b4/ap3pHwsGgQhwAp474FkIsA0jtN/2Yd3vMedwYrVlVkg3
	 kNp91YO7mTOaiqItmm1gKfJkftYch+7gQ3fCKuptZzpIqwWdzOvsYqjrenGthBREpO
	 fYMaVW7lNR35kcsVuEmShhwyomxO0q2ZCIB3PIlq3mPVyZcYpQ1CiKxgkdMYMSi68Z
	 id2JaLWkmoeAQ==
Received: by mail.astutebeam.pl for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 07:30:30 GMT
Message-ID: <20250424084500-0.1.ht.1dina.0.o99a2czb2i@astutebeam.pl>
Date: Thu, 24 Apr 2025 07:30:30 GMT
From: "Adam Drzewiecki" <adam.drzewiecki@astutebeam.pl>
To: <linux-btrfs@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.astutebeam.pl
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Adam Drzewiecki

