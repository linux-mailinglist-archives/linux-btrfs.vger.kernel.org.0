Return-Path: <linux-btrfs+bounces-17962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A9BE8B9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA64088DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A4C342C89;
	Fri, 17 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="FKWnZE5m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78164331A55
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706308; cv=none; b=Z6O7NDG+OLv6yQ5ekisW1zUGh1amxsohElKPUN409/VOsUAqe7fN2mxC3fCEZ0X2AafNVL8uFMZz1RJgfY9Lf/kHM0lVoENxizH4VFSIw3xRKUKzrP5Sv1TI3H1Gf1rnqXbLXX0wgjVZph0UIRB36KxMGM86e6uzPxawujTquzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706308; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lboJRmYw4llTS5Xe9bnAJRWtVYr0oBXAcg2LSwlJQvMRwyUuW1pBbIiWxXqqdBw5WXdX9/HeoKNG394EAWvhkoI0lhzPCSgUvJs4+QPVN7bi+z5AT89ishjIZnsOAABA4RatqU/vAloCIuRm0lPF3ZrqTBbGs7S8fyXKdW6DN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=FKWnZE5m reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 171E54A75CAF
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 07:45:31 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705132; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=FKWnZE5mpna+2itE80AN6195mnO6F3TMJkCG5QTwWL5ZA6RXT/SxQhpqQZ4P4/GbrgXVQF
	snVP1C2LaBlBJxbYyxH42Ra+90FQns6jQJBuCtiDTW91Va174DXsWOBPoEnDvFt0cXfjiH
	918X37roTes+6NhYpH/S+OImjz7WndPz+yX4FuUyMFwtUy80NiNpp1rLoRQ2ItQzGLhdOV
	Z0nTj9m6lxjVeQasPfDeRWNTT28yUKriCsT7ZYrhASJSdQA+JU/wbg3Yf8LmQ/L3EUhQ57
	DPaEFKncmflPW6IjQuK34FU4PbDHSpfkq4wv/wS5nwwFsMT0tJNEl4I/Hayucg==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-btrfs@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:31 -0700
Message-ID: <20251017054531.48A5A4802450267C@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

