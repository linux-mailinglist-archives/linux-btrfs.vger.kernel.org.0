Return-Path: <linux-btrfs+bounces-18729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9AC3514D
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 11:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E91888E5E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BC301499;
	Wed,  5 Nov 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oTPrlOV6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220C3009EA;
	Wed,  5 Nov 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338388; cv=none; b=DuhgE8bKrOCwTuo5IVWJB00eWqiqr5dZY5zrnHdgSb77c55lvTKgmzkO6wSB55ugXgGDIf5x7nF+osRgGOg43g1h9oyDjTfCYkIR+gHKzXssb6ifrMAJW+6MeNa08W7HSVA6lGXWIc3WRYg4gERo64QyklgKwDEE5oxOKzeE3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338388; c=relaxed/simple;
	bh=pG/SsMAm2rsGT5sehyGQ6GuFin7MYNCQZeSjrjEeme0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CKvjANiI9dD/sRf0hXv9Vkltc1vhdSdxxwmHotDo+7oSc73FnogrtRNvWf49LmLm8WaWzNREcok5mjHBHf92oflGuv5fOM4t1DXHzIGYtsh/7131m3o2hkaBLZLt5tCi4anzrrPPxAIUgvvCqIpjVXgEJqvAfHt+s9Mv65p1UdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oTPrlOV6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762338383; x=1762943183; i=markus.elfring@web.de;
	bh=pG/SsMAm2rsGT5sehyGQ6GuFin7MYNCQZeSjrjEeme0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oTPrlOV61ed9xMrkwOT9tiVysjp8EhoZtbsRDHh9l/OPOxa8atlOOXlWbyfzlcoC
	 cBwngWHshI5mbo4VTvIldes+NLw/1IFFpx9NEjSRATNjFG91Qo3gGPYIEbhzJsL8D
	 KfKzNrAVqRazkyOIcZtujb0ZtRPZRnbMXxAddEfKbZTw8OHw/mAvt/kvXizhn+fXi
	 bMTk2n1o0AKZi4xOE/sTfXO5OjQIxd1gZ7/E+71eyH7ipcjWb2LDSXnRncdgXLpxl
	 OpUlKNcAfZ42KG8XLo80zcGy5OzNcHqX3jo4L6aDF98auhcjHYbIBzRngsjYgIF4t
	 bfpP3RF0EThsfuxt+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1wLb9W06Fx-00vWBG; Wed, 05
 Nov 2025 11:26:23 +0100
Message-ID: <2603afff-0789-46d3-9872-3911132a53b1@web.de>
Date: Wed, 5 Nov 2025 11:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>, linux-btrfs@vger.kernel.org,
 Chris Mason <clm@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] btrfs: scrub: fix memory leak in
 scrub_raid56_parity_stripe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251105035321.1897952-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2YmVQFN2qJp+aRPD0bRloKkiaw7x/+Myxzu+i0yLhigP6nhLxkF
 +wgpOFZRBT3/38s4RtFmzdczX9UYRMWFuHh8tZ2HYNKQ19TQNsuSARb5iFdrFnBx9foLsV+
 EDy0V6I24mTxE4CLOMHB5t6a6HbKxe857ccB1tkO5z4vfr1jCU4/ctVdgYaUjwegJ9RCLVG
 T1n5WneQs5l9cmYliz50Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:22fa162rS3I=;bOIMF09Z8LGXv2qgNh8U1RyPL/r
 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

=E2=80=A6
> Add the missing bio_put() calls to properly drop the bio reference
> in those error cases.

How do you think about to use additional labels?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.18-rc4#n526

Regards,
Markus

