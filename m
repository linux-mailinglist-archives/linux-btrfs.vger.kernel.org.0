Return-Path: <linux-btrfs+bounces-1512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32CC83016A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 09:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A437287A54
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561971173E;
	Wed, 17 Jan 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=severnouse.com header.i=@severnouse.com header.b="DPc3kXtb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.severnouse.com (mail.severnouse.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF11170F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480829; cv=none; b=IPooVaobECOuaQfKKAGqR4zRl9jB7lJKHYNMDJUCCJMO3VrwKa2crLaSSU68FIf2KZjP8Qp9EMWajm7WeRADu2OE1IHISolHDFhSCpl4sKmFlzgzET6+Tpy0TqzvMDvQWce0cFzLXocNZOMEJso8R1qtWrP9YOnX+KTXqJeCL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480829; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Received:DKIM-Signature:Received:Message-ID:Date:From:To:Subject:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=SW0QBVeNp6n/CI1dln72GE6j2XtGd7rtjTpV/EgcxjE0cFeARC6PX/ZR1cXEktyuCEemB/oVYPmEA7Mz74uGgErIBuV/ngp2QwIEV87R24X2EhUkhlZuzAmB1gKJm4phD7ubwyQFyutdkh9ZBrcLvOl45gy5VeyzumENsUind+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=severnouse.com; spf=pass smtp.mailfrom=severnouse.com; dkim=pass (2048-bit key) header.d=severnouse.com header.i=@severnouse.com header.b=DPc3kXtb; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=severnouse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=severnouse.com
Received: by mail.severnouse.com (Postfix, from userid 1002)
	id 928E7A2CC9; Wed, 17 Jan 2024 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=severnouse.com;
	s=mail; t=1705480822;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=DPc3kXtb+61CN5y52v6gSkzhjrdeW5QQrsVnnSTEjnI9tg4HbxiOhvixxYifHAf7R
	 eE9rfZFymGuG5CYV5SajB0S6fZ1r2UPHYtJUVwajUF9Bvk4Jqf0c7887qTdJk57RHE
	 nP8vp6VUTQcqpnKtV2w7sxUrOSxqPZ3UnXXV4ROxLxihRKq0y1NV9CuhNy+N1Za5s2
	 7H6ZqrQbwIj5KVo4330r9ompfMM8W9XQCQ2D9dh+RWpw5jIJl18e7Mqj2xi90EYQU2
	 Eu+ij9gkHuzI/Qmgdbj6P2HPcrZ7E2n3f83Wb8LwZPMQ2rLSm3bZZugMmUEzAUa3Yu
	 dbYYnkx1TrjDA==
Received: by mail.severnouse.com for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 08:40:20 GMT
Message-ID: <20240117074500-0.1.bh.olob.0.nowqk4ibek@severnouse.com>
Date: Wed, 17 Jan 2024 08:40:20 GMT
From: "Ray Galt" <ray.galt@severnouse.com>
To: <linux-btrfs@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.severnouse.com
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

