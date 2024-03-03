Return-Path: <linux-btrfs+bounces-2988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73386F737
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0971F211BA
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461547A15F;
	Sun,  3 Mar 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bluemole.com header.i=@bluemole.com header.b="HJ1wU7cp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx24lb.world4you.com (mx24lb.world4you.com [81.19.149.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AB79B74
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Mar 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709501979; cv=none; b=s5ym9lYHgZ/kjwi+md9lusDO8XU5UuAzUFp2ohA4oa5EXBdtHdvKaD8NPvmjWcnYdoLtPnlwPs8fdRMyRXltWd0fUr0d8u1oVMyaNaFbhKh/BjFpiYUG7eMhOGC0YarRLM9daU16jRyv1TVyMFwhYY09vngRMAK4vAa788+Hjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709501979; c=relaxed/simple;
	bh=9nzIqQKNUmRh4KApsSoYmD8eXOTlhD24jqAUaHIDGrc=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=F1fXxDc98B3nr/sMYQ5ZjmyVXXHiYuxNy6SskAN9ZT7VI9AUEVKBSYielPWvGceEk+flf9jySt1QGHQpmqUY0HRI+vJKdcdxeN6vrwcDk8OjMfqxmqX/YiiOMIf77xiIzO/b2EvmS2yJVfw28t8a4fgdTor+FClnS0UhuKg3pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluemole.com; spf=pass smtp.mailfrom=bluemole.com; dkim=pass (2048-bit key) header.d=bluemole.com header.i=@bluemole.com header.b=HJ1wU7cp; arc=none smtp.client-ip=81.19.149.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluemole.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemole.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bluemole.com; s=dkim11; h=Message-Id:In-Reply-To:To:References:Date:Subject
	:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9nzIqQKNUmRh4KApsSoYmD8eXOTlhD24jqAUaHIDGrc=; b=HJ1wU7cpYSiS+9u5uNoNvu+dRk
	UtljgPQ0CDFNtVPqauwibIwlPrt7nLiztEpZGVI4/bcHJ/SSLFhA64HhfdHHoiJzpUzIiw/RVWlXP
	EvG+brKAF0wps5SkXZA4w0LLd1oX70vaak7f8O6sV3dPGVDnRVLfyq5iEBBxrxHTeyg/bfnk+tzGc
	kwcSLqPBGa9em/Cq8Sku6ckLLA/071jRZP3+x/ShYKVX8OSAfJhAkys/q0GkMSkqv9f3G4VNc7JqT
	mJqASesZYI+7S7JL12I7PFldXe1GvyVw8NxNMxeuyQPLZ2eXm/IeJrjaoxCaImmXF29m+jyP4GE7U
	g99T43pA==;
Received: from [41.66.96.86] (helo=smtpclient.apple)
	by mx24lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ubu@bluemole.com>)
	id 1rgsiB-0005ML-2u
	for linux-btrfs@vger.kernel.org;
	Sun, 03 Mar 2024 21:45:32 +0100
From: Michael Zacherl <ubu@bluemole.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: Checking status of potentially hibernating encrypted BTRFS?
Date: Sun, 3 Mar 2024 21:45:09 +0100
References: <70AC3CE8-D407-4409-AAB7-1F1FF38A7ECE@bluemole.com>
 <87cyu1b6rb.fsf@vps.thesusis.net>
To: linux-btrfs@vger.kernel.org
In-Reply-To: <87cyu1b6rb.fsf@vps.thesusis.net>
Message-Id: <673F5395-5324-4F1F-A5CA-8435D2405F0E@bluemole.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-AV-Do-Run: Yes



> On 16.01.2024, at 17:08, Phillip Susi <phill@thesusis.net> wrote:
>=20
> Michael Zacherl <ubu@bluemole.com> writes:
>=20
>> Hello,
>> after I accidentally rendered a system with encrypted BTRFS =
un-bootable, I=E2=80=99m trying to check the state of the BTRFS before I =
try to mount it externally.
>> After some intense experience *) I=E2=80=99d prefer to proceed very =
carefully.
>> I=E2=80=99ve to assume the system is hibernating, so the FS is not in =
a clean state.
>> In order to fix the system I=E2=80=99d have to mount the FS =
externally.
>>=20
>> What=E2=80=99s a save way to proceed?
>> Thank you very much!
>=20
> If you must mount any fs from an external system while it is still
> mounted by a hibernated system, the only way to stay safe is to delete
> the hibernation image and never try to resume that system.

Thanks a lot, that was exactly what I needed to know!
Extra =E2=80=98fun=E2=80=99 was provided by the fact that the system is =
encrypted via LUKS.
The swap file was indeed identified as hibernation file, so I did mkswap =
on the file with its original swap UUID, to be sure all works like =
before.
Bottomline, the kernel fix worked!
Thanks again,
Michael.


