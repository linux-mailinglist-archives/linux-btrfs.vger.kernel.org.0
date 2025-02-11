Return-Path: <linux-btrfs+bounces-11381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84016A3194A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 00:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E963A48A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D314268C6B;
	Tue, 11 Feb 2025 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="aIHyzYnF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sakCGqni"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C627293D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315211; cv=none; b=mDme2X9a42UewKllo5MptZc/pC7kHEqqN/hgUMx8hEMRK9X91KByGARGSUpOhgPXvTueyQDGTmhIFB8AsVTFqBwjn4thRN9bR0JzL7t5HCY8IMs3RlCrT5lWzyD1hF3IcHe91HGD1bzkU2ohjESHOYO1UctYOHlG4W2b5lapeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315211; c=relaxed/simple;
	bh=96Y+niokb54yPJBn/qxDO2H9SCplHG0DQg3wtRG+LXo=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=TzcMspyq4iF8BBP8vZd5HITmWv3Vilt1KrABqZh2EttkRpsGGK+6a8AnjtrhTEolrnIxeE1eQPghoSNt13+LpoWGwDnphFdK8hf6G6icBm5oBo4qR55VHZdqhCMs0QXduOvFaQs19Oy1Cgv0Z61cj9f8O1M+3+CfQSRZ3WCAyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=aIHyzYnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sakCGqni; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ACE6611400CC
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 18:06:47 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Tue, 11 Feb 2025 18:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1739315207; x=1739401607; bh=96Y+niokb54yPJBn/qxDO2H9SCplHG0DQg3
	wtRG+LXo=; b=aIHyzYnF6pOIxq7ADtx/c8V37i1lQ1Z176Gqbzowq6fm2L3pgXt
	FXQZQIAjZQHGP0XYU/fWk68mXAbf6YYJwrAiOPqBcG2rUCY5+pADmD2uP+S23xty
	Vx7K8oiSsUPNoa6N1RZwdkJLDxTgsS+R13RmN/zvpcOghAa+7YjOJwoCUaurXyqz
	8yw6JdzZMmuABRbWsbfYH5l5XwgnzBWCOVU1ncaUcfR837Mz5rXF1HndCVkqfRuW
	qwHROl+eCRSCbohjrMYXGyS1q9q6qrY3zt4ZCTnIjqhFHBJ5LLksN0nSliyHNOGA
	ThlNMJi8U0eKNWvj7MjSaD15Y1WvcY/j4Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739315207; x=1739401607; bh=96Y+niokb54yPJBn/qxDO2H9SCplHG0DQg3
	wtRG+LXo=; b=sakCGqni5cJ57uMKMeLYpBUdOc/7vk1c5INkHj8EX5E4MUVo39L
	ShNTNUQAeqMnK8Si7WyDLgm7V2ICsLpe5fz9z+8/hawi+f1/etmEu/Sr4HT0FRwF
	3ToWJmxa6nMz3sKEDWzNQYa2R3gBuBZ/2XVR38nF/FlPP5xNG4nmsV12teTjY8yQ
	41G8UDb1m3iS2k3cvEcO1rxdQvOp1hyVDwJ4wALXrE0yIuN5dfKq2t2TfyhhyMBI
	wRihenFogb95V0Xw79tO4tv1DxdI64uFdCDRSUH3cRCTrqwjfR82Bq6HzzQigo4t
	Mw/0lOKMafR7c69GPb/TPXSB7aoT2NBszVA==
X-ME-Sender: <xms:B9irZ1vWWa-ytr679dyaqCQU0xdLgHl1yVqDcmJFzqTM2-aNRKkMqA>
    <xme:B9irZ-cisC2mZgmmj6G4GcV5p_N85Nf4CdCe0Dep_FemOd9lhsAKAG-pGgmnQAZUB
    LMJkAvs61teOAxWnoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmh
    gvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeevjeeltdefffegvdeggedtvedt
    fefffeelffdtteffgeffjedttdejkeelvedutdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghs
    rdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B9irZ4y-rikGk1oNan6fABa_Fub8S2EHHdUo6VOpx5utgJ1PDes4iw>
    <xmx:B9irZ8NVjBSCuu_WKwkhqLwMVf7_sDQuYaWwPjzeB74PmVIP1jX-Pw>
    <xmx:B9irZ1961TqUPD1GBvV6KdeyDL_2CFHi38P8yhC3BWZvLLv0H7-woA>
    <xmx:B9irZ8UQUYsiMwddUF97N1Pkf2kcoHl4eOaQC83G7TU1n03legM45g>
    <xmx:B9irZyGhaI6nKb2-73JweSjKWumtMpCx17HimmJ6v1FWIXuLp8AVQZL8>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 33B341C20066; Tue, 11 Feb 2025 18:06:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 16:06:26 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <238af852-4eee-42cf-bda2-0c50a7bc289a@app.fastmail.com>
Subject: lazy free space tree creation, deprecation of space cache v1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Recent kernels warn about the deprecation of space cache v1, advising users to switch to v2. Many desktop users don't see this message and won't switch to v2 on their own.

I think the concern with silently and forcefully converting users from v1 to v2 automatically is the potentially long time it takes for large file systems? e.g. Zygo has reported days for some of his large file systems.

Since the free space tree can just be deleted and recreated again, is there a possibility of a lazy free space tree creation? Similar to ext4 lazy init (totally different structure and reasoning but high level, same idea - reduce the offline wait for initializing something).

Thanks,

--
Chris Murphy

