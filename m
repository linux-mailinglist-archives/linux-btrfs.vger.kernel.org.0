Return-Path: <linux-btrfs+bounces-4663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC88B94A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3827DB228B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20E224DD;
	Thu,  2 May 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Nz/tovUh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114D219F6
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631370; cv=none; b=nDhz28ITJJaWfSlia2v/aUBHxLFwaux2O71lmQ48UeW4nKZykvN+bzCYF2F8uyvNb/Z2KGyj5oV+o5HDka9wkhyN3ZqdJtQVcK8DzBI0xvV9G7kHtStJ6P62G65qXxlDjAGnosXGE4zeUL1kvnfqtNIQA0fDPHNnKMVtrP06K00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631370; c=relaxed/simple;
	bh=Q+yTobCE/hBpS6u2V8uD+EKPG6SImIY3ryqwdkg06MU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TuxZPhFD3IQi+er2Eh7rFdmthKKsZGJNyGoDuK4ZcLS/qs3Fpa5BdyNJfDFtdHsOw3ENVlCAFOY/cL/j+LISiY7jUMOYyT3hDhMC6CwKO7XT6En9HGAD52iU7ssbjNK3bbQe3+LF1gxzbP4sZQ0Kmz4BEJXmzQAHmxZhLraHsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Nz/tovUh; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4VVPD24ZrPz9v3S
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1714631362; bh=Q+yTobCE/hBpS6u2V8uD+EKPG6SImIY3ryqwdkg06MU=;
	h=Date:To:From:Subject:From;
	b=Nz/tovUhLYl6Ki4OcUM/DW2N//36gcY946xco+qMW1oHjiqT1Fu5jSUHe7LHtbPYR
	 XqBrzNx6VoExQwXckD0jsa9l6ZhBAqOYXfZATLTMCd0LMpIsZUeli0L8E+1Xb9mSDY
	 +J+yApigXGfqPO2EG1S4yWY2mGnFSPYWrut/0e5E=
X-Riseup-User-ID: 628D189DE70137B42859A4C0B54C02F0563A8B4B8B796A6DDAA9C3946D23C126
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4VVPCq3SHXzJs79
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 06:29:11 +0000 (UTC)
Message-ID: <2236adc5-3520-4ceb-ad88-5bcc6afd18d0@riseup.net>
Date: Wed, 1 May 2024 23:29:10 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Eliza May <eliza@riseup.net>
Subject: Help with ROFS on Cache Folder Deletion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


I am trying to remove the paru .cache folder from my computer, but every 
time I do my btrfs filesystem goes read-only. Here is the dmesg output: 
https://termbin.com/f4sw

A scrub found no errors, and I have not yet ran a check -- I will be 
doing so and reporting back when I figure out how to do so.


My filesystem is a main partition, a separate home subvolume, a var/log 
subvolume, and a /var/cache/pacman/pkg subfolder, but I am attempting to 
delete the paru one; not the pacman one.


If there are any other logs or details I should include, let me know.


Thank you,

Eliza


