Return-Path: <linux-btrfs+bounces-19039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E621C620F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 03:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C74E56FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195F23BF91;
	Mon, 17 Nov 2025 02:09:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF34748F
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345349; cv=pass; b=fcR2TGhd7zEdzJqafMyjmneChffLuc4hXORP8kbgsBEgb/VEgaBNZBA3lCZqveGdVhwI32/mHohu5uaYBCQupZtM+k3K80g5rdz++UQLBssdDd8ziVjt+VpHjY5HazWmUqR7lx/PnJeaGpEMIr/A/x/t/OhCu2wiazeKaql/EX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345349; c=relaxed/simple;
	bh=5F8Toz04yryjOvNb6jVNmculkLf5z9s5LFiqMK8qYxg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=fUlaxL4QRClpm7xozFfK1fFLlnjN1a67BLE+JP7dhWf1yx7szWa+pMC4bLnlzHQQazDoUIvHPoT63qykCmP98T4c7Uj+76MvCoJThcoY0UCLQ7/OlLM1fZzZAS767FWzSNjX/xPtTe/MCvsIQAP+zRYhDdvyxRV12WI1XexxI18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2A2E54421A5
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 02:09:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-202-58.trex-nlb.outbound.svc.cluster.local [100.96.202.58])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 442EF4412DA
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 02:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763345340;
	b=nUD/30nbxhe/6JsT4/Ok4zSABolOoxfj5D0vf/R7gjrsp/nBMfDlpT3kYbyqSzCMQEUB2o
	vgjx6GviCdrg5K3Y0UcR6cbCcM7UQFVfMBMXqroKeaZSI6V06V7I8zXa5fMCt7IwacGzwf
	CxWp1AtCOALGufrVy5oCH41DpbU+Zt+7VePLjx4z14oGj2rwQZ/qBsNF7QEM3i7biMxgSw
	ue+7SUqinmRUZ2cHJejUr4PwGXN81BolLRO1CaotqIgaEDBtn02Xvrh8yVdNB2X+Fjdyd+
	YzULt0qDawHK5Fx2xyZ0DC/+GZn0E+eWcOjEy7+kqTqQ67fr/xCqA4SQor2n+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763345340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5F8Toz04yryjOvNb6jVNmculkLf5z9s5LFiqMK8qYxg=;
	b=J64EVya6esoH8kdZN+YAAlcx5F2qsv9S9rV62jRpnmTVCsQC1/cp7jbQu4jw43vuh2abSR
	x1Q/iJgxh6S7e//T9o6SH4YpA5HWG/QPE86Fbv7O5H4ERpDP0W4xV9NJc2rslb+VNd7zwo
	BvbnppAvBqwtH4cDlbNFgDmFO5ZC7b/fKX5gormJ3vbcvuWA7+vReMPQAczUqVImrJ+Cvy
	ZZEdlz21eLYjdxAOMPlIPfCA/J0cXbZ6KJLTmSFq+pXLE7e157wIbZ+P18iFfY70i8G4+u
	dLbgxXsPTS5b5E/QyPpvubliK5gprZ63DxF/BrBDlUQToVHghEPEJX0rWhNKCA==
ARC-Authentication-Results: i=1;
	rspamd-5664d6b969-2jbwf;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Harmony-Illegal: 7d2050113a99d183_1763345341012_1419718890
X-MC-Loop-Signature: 1763345341012:1747677160
X-MC-Ingress-Time: 1763345341012
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.202.58 (trex/7.1.3);
	Mon, 17 Nov 2025 02:09:01 +0000
Received: from p5090fa32.dip0.t-ipconnect.de ([80.144.250.50]:63394 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vKofq-00000000631-1Nff
	for linux-btrfs@vger.kernel.org;
	Mon, 17 Nov 2025 02:08:58 +0000
Message-ID: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
Subject: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Mon, 17 Nov 2025 03:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

With kernel 6.17.8-1 and progs 6.17.1, I suddenly got this on two
filesystems:

# btrfs check /dev/mapper/data-b-1 ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-b-1
UUID: 42cfffe9-a4fe-44dd-863a-6c02896ab7f3
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
We have a space info key for a block group that doesn't exist
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 13074117332992 bytes used, error(s) found
total csum bytes: 12754122916
total tree bytes: 13895467008
total fs tree bytes: 759627776
total extent tree bytes: 103284736
btree space waste bytes: 296939334
file data blocks allocated: 20763397128192
 referenced 18946684219392
1

# btrfs check /dev/mapper/data-b-3 ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-b-3
UUID: 8e4d238c-0a69-4f0f-8f35-a16e3c220763
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
We have a space info key for a block group that doesn't exist
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 13083770884096 bytes used, error(s) found
total csum bytes: 12763657764
total tree bytes: 13785333760
total fs tree bytes: 671154176
total extent tree bytes: 106496000
btree space waste bytes: 244008214
file data blocks allocated: 18338522918912
 referenced 17654672998400
1

Don't think that error showed up on earlier versions of btrfs-progs.

Is it something to worry about or a false positive? Can it be fixed?
Would you rather recommend to re-create the fs from scratch?


Thanks,
Chris.

