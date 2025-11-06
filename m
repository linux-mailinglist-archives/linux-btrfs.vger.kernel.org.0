Return-Path: <linux-btrfs+bounces-18754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81290C394E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 07:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B91A404A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABC2773EC;
	Thu,  6 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lVrcZoFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE0264619;
	Thu,  6 Nov 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412137; cv=none; b=WMYQpYxPx1SnTV0q4QgVW5Td+NMI8CidP88GSM1Jpdy8O+V8yXIgEQK8xekY1yrCmQ6hVnmtiC/PhY6QMqsYRHGdDOqkeVpED0ipHNAhkdIcVDSYMHd5xWyOrYqo1GMmqpsz1RnLbDNA7eSa75+TgBj+RziQtw2ivA5WicuUsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412137; c=relaxed/simple;
	bh=lc4SDCvI8tHtCQyMEtNCI+Gdx6+CAB/Prb8AUrIbLlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRGPJ3QRuhwy9nsEv4MW9GxuyQdgL7/iJN7kTXalTX7tSAaxoOt1OfW3L07PVx2kRkgZT6sc6jDSHKD9qmwCNTlk2ZnqhnLk/L1XUeiGfv6eELNqS9/jTGkNcmbA7zLgCp+IGez/SXyFyDwnm23g0rXr5ZLYAFGDTpYU+5FqBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lVrcZoFy; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762412128; x=1763016928; i=markus.elfring@web.de;
	bh=lc4SDCvI8tHtCQyMEtNCI+Gdx6+CAB/Prb8AUrIbLlU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lVrcZoFyd9UcoahVCMeGcgM4w+WsCvwv5kb1Cb4CY7RLVMQ4f1PJk1PMpHO/iKa8
	 5aH8abW6CnR8KHOCjtj2Jw3r59H2hwFBJlzJcvhm2KgoUdohOBqqK5ifsv5/fwHsB
	 lyITxCJkkbvCgbIM+70UQIgRfxqx00tKq6zh4BaPlUJ3zvTmyrG6+QG+qk3Zg3kO8
	 /P09wiHVf1WUq58b44znXRJTcLryy5pFag0qS7CvdmLGozPyvLCB+RTBFQ5mRNe+r
	 2Lw50lta2wJ3a7T06YeXPS39eqxU68Rd34RTnW28dibg1fnpbjsdbPrRbON7sDK4t
	 GclVsLLkY6q9Ld9qDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1vIIXS3fMz-007FpX; Thu, 06
 Nov 2025 07:55:27 +0100
Message-ID: <c31de8ba-77d2-4d79-890a-c23f1797a735@web.de>
Date: Thu, 6 Nov 2025 07:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: scrub: fix memory leak in scrub_raid56_parity_stripe()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Zilin Guan <zilin@seu.edu.cn>,
 linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
 <2603afff-0789-46d3-9872-3911132a53b1@web.de>
 <a2d629ab-9f21-4b98-a442-fd73cbbb2dcd@gmx.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a2d629ab-9f21-4b98-a442-fd73cbbb2dcd@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iaKDqiUA6zg/SfeQ9PRVtv/h26ntlxf8lbRKDpNAPRUYw2IZ8tn
 dlD1k/muqMrjk5J+Hd4VAIapKcT8A1pMFKW1mTtC4PhqBkh8Mb8EfLZmtPVYJZHvPxFD4uY
 Y/Rb0ggmiXxmhn/UadvZJ7kj3Rh9cqatUECz0J3vWy7F9TLKGPP+leFVAEmZMiNEwrd4QUx
 mx6jPXV3R+P26pbIgq4rA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvLbLdBqG4U=;x/ZzUkUURS3ji9E5LAb6xfjTfWx
 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

>> =E2=80=A6
>>> Add the missing bio_put() calls to properly drop the bio reference
>>> in those error cases.
>>
>> How do you think about to use additional labels?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv6.18-rc4#n526
>=20
> I believe the current hot fix is fine.
=E2=80=A6

Would you like to care a bit more for avoidance of duplicate source code
(also according to better exception handling)?

Regards,
Markus

