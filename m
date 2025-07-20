Return-Path: <linux-btrfs+bounces-15577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F924B0B853
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 23:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60750177C25
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0E221540;
	Sun, 20 Jul 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BBavBblf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F98BF8
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753046395; cv=none; b=AKvaNb1WQPUcP7RBFgheCBth0or0HdbIq8clBZTM39E9kZsOOnljdkkDFC84jf5nQof1TRhlHOtuWQ4Z9z1MjGXONgQK/vSKYO2shXsnYiNJJzt+r8F9oyyi2JLuX8N9YUb6TugZEft6WpDBligGgR1LPqvl6Gpmub74onPVleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753046395; c=relaxed/simple;
	bh=GzRPhUqyvxfbo7PEyZOeaySDNwcQlOa2iwm+WfBQ+pg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=tF6J6wtM9yNusdkr90ygfgq7rLsevXBxOhXDEk0yEPQaXUG1X3Cux21aWqVgoxzirhQQ9uDv2DuAGBrSBthhrkuioWqmYrzK9K2jzSjitBqcmzi81Rqx0s5X436KaLUfJglKDZh5nBwV1zVpjUSeLRYeXMpkGaWDHiH4OinSc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BBavBblf; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753046385; x=1753305585;
	bh=GzRPhUqyvxfbo7PEyZOeaySDNwcQlOa2iwm+WfBQ+pg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BBavBblfrAZTIw/ttUn6ibTjM9mZQtEu4DrmzZ+JpAdr33/3l0UIdhzykvR7ByBzD
	 1FHNYeCVmgFu20i6cG8vl5EHw9yk/cCaLaHm2S9v3Qw5khstQvJ6XuvaqVlim1L3oR
	 yYz7RIySs6atTcEVRrF4AaW5lkbMEgEbdBoaGFJZlRcHrpoDSsjB2NNMptpcH+AerJ
	 vutXD+ezYJ0rVq1gyCA6cXF/DLMwo0kzg0kqbJjeilK4znYE0xzCzkEgJCpAX+KXTF
	 2CUufOFAAupjTD5bWS9pH7ajTkN4zp7+7ZNNFsXEWZWpIDho366VbuFGS/0hqnvT5W
	 gRvGilS4KtXVA==
Date: Sun, 20 Jul 2025 21:19:42 +0000
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: burneddi <burneddi@protonmail.com>
Subject: log tree corrupted (and successfully fixed) -- anything I can do to diagnose why?
Message-ID: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com>
Feedback-ID: 41869915:user:proton
X-Pm-Message-ID: 890eb502ea5b8ec485887a687676116aae379794
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
My system had a hard crash today (some AMD graphics instability), which res=
ulted in the log tree on my boot drive becoming corrupt, giving me the erro=
r "open_ctree failed: -2".

I managed to fix this successfully with "btrfs-rescue zero-log", but now I'=
m wondering if I should try to diagnose and report this somehow. I have bee=
n running this drive with btrfs for many years and have had a fair number o=
f hard crashes during that time (AMD graphics instability...), but this is =
the first time the log tree has been corrupted, so I suspect it could be a =
kernel bug rather than an issue with my drive's firmware. I run Fedora, so =
my kernel is quite new; 6.15.6 right now.

Is there anything I should or even can do after zeroing the log that could =
help btrfs developers narrow the cause down?

Best regards,
Peter Wedder

