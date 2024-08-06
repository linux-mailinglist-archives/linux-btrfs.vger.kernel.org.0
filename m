Return-Path: <linux-btrfs+bounces-6995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C978D9489CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 09:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307C51F233D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503E166315;
	Tue,  6 Aug 2024 07:08:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A44166F14
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928119; cv=none; b=uGJCvc4E+KDg2haa0bJzbBNxEft+FDuLjXuDq09YIWANLp1cHmMXLbb1+NPRJ/sFYprWIhpz0zNOB4uYuIvJ/EADMpw/AU0zQf5zhndlYx8sn+J6VadmL4DwJ0pR3TtTdke0ewb1INKc1jEJq+dR9phQVKEWBLjPo7uoTykcg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928119; c=relaxed/simple;
	bh=BhhN/5PbmqzPogqWFfxXW1lYbJPBLnghWubGcZAgi44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VFuauvjCWFp+NFNwD68QtyKBhGlz3HRrYHCFPxrwdNzYpwoyaNuIABEYRINK5CmGVYqKskbtUMAWxTG8DsSKUy76XiomcyE3ZW4uVbXGzlA/Qy153bDzSbfpUurLpIh73Wfg32Rm0NFCh3aRveBt2WVumkoBu1O3aAX+ZegfZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nefkom.net; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nefkom.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4WdPXt4Zs7z1r1gC
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 09:08:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4WdPXt4K9Yz1qqlS
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 09:08:30 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id P1zmBvZf1E8b for <linux-btrfs@vger.kernel.org>;
 Tue,  6 Aug 2024 09:08:20 +0200 (CEST)
X-Auth-Info: 6yjM405cg2fo4Zsdi2ywkGdP1+iBNfqkRT/gU0E9IcscbuK09wiOlb4ckGGXLeEH
Received: from localhost (aftr-185-17-205-67.dynamic.mnet-online.de [185.17.205.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 09:08:20 +0200 (CEST)
Received: from erlangen.localnet (localhost [IPv6:::1])
	by localhost (Postfix) with ESMTP id AFAF29C7E80
	for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 09:08:18 +0200 (CEST)
From: Karl Mistelberger <karl.mistelberger@nefkom.net>
To: linux-btrfs@vger.kernel.org
Subject: btrfs check errors
Date: Tue, 06 Aug 2024 09:08:18 +0200
Message-ID: <2511346.XAFRqVoOGU@erlangen>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3570583.dWV9SEqChM"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart3570583.dWV9SEqChM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Encuntered errors, see attached file. Any idea how to proceed?
--nextPart3570583.dWV9SEqChM
Content-Disposition: attachment; filename="btrfs-check.err"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="x-UTF_8J"; name="btrfs-check.err"

[1/7] checking root items
[2/7] checking extents
ref mismatch on [735002624 16384] extent item 67, found 66
tree extent[735002624, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 735002624 found 67 wanted 66
backpointer mismatch on [735002624 16384]
ref mismatch on [736215040 16384] extent item 67, found 66
tree extent[736215040, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 736215040 found 67 wanted 66
backpointer mismatch on [736215040 16384]
ref mismatch on [947355648 16384] extent item 67, found 66
tree extent[947355648, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 947355648 found 67 wanted 66
backpointer mismatch on [947355648 16384]
ref mismatch on [1334427664384 16384] extent item 67, found 66
tree extent[1334427664384, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 1334427664384 found 67 wanted 66
backpointer mismatch on [1334427664384 16384]
ref mismatch on [1334640738304 16384] extent item 67, found 66
tree extent[1334640738304, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 1334640738304 found 67 wanted 66
backpointer mismatch on [1334640738304 16384]
ref mismatch on [2266727923712 16384] extent item 67, found 66
tree extent[2266727923712, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 2266727923712 found 67 wanted 66
backpointer mismatch on [2266727923712 16384]
ref mismatch on [2437845401600 16384] extent item 67, found 66
tree extent[2437845401600, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 2437845401600 found 67 wanted 66
backpointer mismatch on [2437845401600 16384]
ref mismatch on [2464338608128 16384] extent item 67, found 66
tree extent[2464338608128, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 2464338608128 found 67 wanted 66
backpointer mismatch on [2464338608128 16384]
ref mismatch on [2465005666304 16384] extent item 67, found 66
tree extent[2465005666304, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 2465005666304 found 67 wanted 66
backpointer mismatch on [2465005666304 16384]
ref mismatch on [2465103298560 16384] extent item 67, found 66
tree extent[2465103298560, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 2465103298560 found 67 wanted 66
backpointer mismatch on [2465103298560 16384]
ref mismatch on [3349449375744 16384] extent item 67, found 66
tree extent[3349449375744, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3349449375744 found 67 wanted 66
backpointer mismatch on [3349449375744 16384]
ref mismatch on [3349464137728 16384] extent item 67, found 66
tree extent[3349464137728, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3349464137728 found 67 wanted 66
backpointer mismatch on [3349464137728 16384]
ref mismatch on [3349488664576 16384] extent item 67, found 66
tree extent[3349488664576, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3349488664576 found 67 wanted 66
backpointer mismatch on [3349488664576 16384]
ref mismatch on [3349488680960 16384] extent item 67, found 66
tree extent[3349488680960, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3349488680960 found 67 wanted 66
backpointer mismatch on [3349488680960 16384]
ref mismatch on [3947868045312 16384] extent item 26, found 25
tree extent[3947868045312, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947868045312 found 26 wanted 25
backpointer mismatch on [3947868045312 16384]
ref mismatch on [3947868061696 16384] extent item 26, found 25
tree extent[3947868061696, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947868061696 found 26 wanted 25
backpointer mismatch on [3947868061696 16384]
ref mismatch on [3947868274688 16384] extent item 26, found 25
tree extent[3947868274688, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947868274688 found 26 wanted 25
backpointer mismatch on [3947868274688 16384]
ref mismatch on [3947868291072 16384] extent item 26, found 25
tree extent[3947868291072, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947868291072 found 26 wanted 25
backpointer mismatch on [3947868291072 16384]
ref mismatch on [3947870093312 16384] extent item 26, found 25
tree extent[3947870093312, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947870093312 found 26 wanted 25
backpointer mismatch on [3947870093312 16384]
ref mismatch on [3947904319488 16384] extent item 26, found 25
tree extent[3947904319488, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947904319488 found 26 wanted 25
backpointer mismatch on [3947904319488 16384]
ref mismatch on [3947906711552 16384] extent item 26, found 25
tree extent[3947906711552, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947906711552 found 26 wanted 25
backpointer mismatch on [3947906711552 16384]
ref mismatch on [3947906727936 16384] extent item 26, found 25
tree extent[3947906727936, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947906727936 found 26 wanted 25
backpointer mismatch on [3947906727936 16384]
ref mismatch on [3947909201920 16384] extent item 26, found 25
tree extent[3947909201920, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909201920 found 26 wanted 25
backpointer mismatch on [3947909201920 16384]
ref mismatch on [3947909218304 16384] extent item 26, found 25
tree extent[3947909218304, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909218304 found 26 wanted 25
backpointer mismatch on [3947909218304 16384]
ref mismatch on [3947909464064 16384] extent item 26, found 25
tree extent[3947909464064, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909464064 found 26 wanted 25
backpointer mismatch on [3947909464064 16384]
ref mismatch on [3947909709824 16384] extent item 26, found 25
tree extent[3947909709824, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909709824 found 26 wanted 25
backpointer mismatch on [3947909709824 16384]
ref mismatch on [3947909726208 16384] extent item 26, found 25
tree extent[3947909726208, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909726208 found 26 wanted 25
backpointer mismatch on [3947909726208 16384]
ref mismatch on [3947909758976 16384] extent item 26, found 25
tree extent[3947909758976, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947909758976 found 26 wanted 25
backpointer mismatch on [3947909758976 16384]
ref mismatch on [3947910119424 16384] extent item 26, found 25
tree extent[3947910119424, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947910119424 found 26 wanted 25
backpointer mismatch on [3947910119424 16384]
ref mismatch on [3947910184960 16384] extent item 26, found 25
tree extent[3947910184960, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947910184960 found 26 wanted 25
backpointer mismatch on [3947910184960 16384]
ref mismatch on [3947910299648 16384] extent item 26, found 25
tree extent[3947910299648, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947910299648 found 26 wanted 25
backpointer mismatch on [3947910299648 16384]
ref mismatch on [3947910447104 16384] extent item 26, found 25
tree extent[3947910447104, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947910447104 found 26 wanted 25
backpointer mismatch on [3947910447104 16384]
ref mismatch on [3947910545408 16384] extent item 26, found 25
tree extent[3947910545408, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947910545408 found 26 wanted 25
backpointer mismatch on [3947910545408 16384]
ref mismatch on [3947995250688 16384] extent item 26, found 25
tree extent[3947995250688, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3947995250688 found 26 wanted 25
backpointer mismatch on [3947995250688 16384]
ref mismatch on [3948005195776 16384] extent item 26, found 25
tree extent[3948005195776, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948005195776 found 26 wanted 25
backpointer mismatch on [3948005195776 16384]
ref mismatch on [3948101697536 16384] extent item 26, found 25
tree extent[3948101697536, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101697536 found 26 wanted 25
backpointer mismatch on [3948101697536 16384]
ref mismatch on [3948101713920 16384] extent item 26, found 25
tree extent[3948101713920, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101713920 found 26 wanted 25
backpointer mismatch on [3948101713920 16384]
ref mismatch on [3948101844992 16384] extent item 26, found 25
tree extent[3948101844992, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101844992 found 26 wanted 25
backpointer mismatch on [3948101844992 16384]
ref mismatch on [3948101861376 16384] extent item 26, found 25
tree extent[3948101861376, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101861376 found 26 wanted 25
backpointer mismatch on [3948101861376 16384]
ref mismatch on [3948101877760 16384] extent item 26, found 25
tree extent[3948101877760, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101877760 found 26 wanted 25
backpointer mismatch on [3948101877760 16384]
ref mismatch on [3948101894144 16384] extent item 26, found 25
tree extent[3948101894144, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101894144 found 26 wanted 25
backpointer mismatch on [3948101894144 16384]
ref mismatch on [3948101910528 16384] extent item 26, found 25
tree extent[3948101910528, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948101910528 found 26 wanted 25
backpointer mismatch on [3948101910528 16384]
ref mismatch on [3948102500352 16384] extent item 26, found 25
tree extent[3948102500352, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 3948102500352 found 26 wanted 25
backpointer mismatch on [3948102500352 16384]
ref mismatch on [4080860266496 16384] extent item 6, found 5
tree extent[4080860266496, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080860266496 found 6 wanted 5
backpointer mismatch on [4080860266496 16384]
ref mismatch on [4080860397568 16384] extent item 6, found 5
tree extent[4080860397568, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080860397568 found 6 wanted 5
backpointer mismatch on [4080860397568 16384]
ref mismatch on [4080860545024 16384] extent item 6, found 5
tree extent[4080860545024, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080860545024 found 6 wanted 5
backpointer mismatch on [4080860545024 16384]
ref mismatch on [4080860708864 16384] extent item 6, found 5
tree extent[4080860708864, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080860708864 found 6 wanted 5
backpointer mismatch on [4080860708864 16384]
ref mismatch on [4080860790784 16384] extent item 6, found 5
tree extent[4080860790784, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080860790784 found 6 wanted 5
backpointer mismatch on [4080860790784 16384]
ref mismatch on [4080861052928 16384] extent item 6, found 5
tree extent[4080861052928, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861052928 found 6 wanted 5
backpointer mismatch on [4080861052928 16384]
ref mismatch on [4080861511680 16384] extent item 6, found 5
tree extent[4080861511680, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861511680 found 6 wanted 5
backpointer mismatch on [4080861511680 16384]
ref mismatch on [4080861560832 16384] extent item 6, found 5
tree extent[4080861560832, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861560832 found 6 wanted 5
backpointer mismatch on [4080861560832 16384]
ref mismatch on [4080861577216 16384] extent item 6, found 5
tree extent[4080861577216, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861577216 found 6 wanted 5
backpointer mismatch on [4080861577216 16384]
ref mismatch on [4080861675520 16384] extent item 6, found 5
tree extent[4080861675520, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861675520 found 6 wanted 5
backpointer mismatch on [4080861675520 16384]
ref mismatch on [4080861954048 16384] extent item 6, found 5
tree extent[4080861954048, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080861954048 found 6 wanted 5
backpointer mismatch on [4080861954048 16384]
ref mismatch on [4080862068736 16384] extent item 6, found 5
tree extent[4080862068736, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862068736 found 6 wanted 5
backpointer mismatch on [4080862068736 16384]
ref mismatch on [4080862101504 16384] extent item 6, found 5
tree extent[4080862101504, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862101504 found 6 wanted 5
backpointer mismatch on [4080862101504 16384]
ref mismatch on [4080862281728 16384] extent item 6, found 5
tree extent[4080862281728, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862281728 found 6 wanted 5
backpointer mismatch on [4080862281728 16384]
ref mismatch on [4080862298112 16384] extent item 6, found 5
tree extent[4080862298112, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862298112 found 6 wanted 5
backpointer mismatch on [4080862298112 16384]
ref mismatch on [4080862314496 16384] extent item 6, found 5
tree extent[4080862314496, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862314496 found 6 wanted 5
backpointer mismatch on [4080862314496 16384]
ref mismatch on [4080862330880 16384] extent item 6, found 5
tree extent[4080862330880, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862330880 found 6 wanted 5
backpointer mismatch on [4080862330880 16384]
ref mismatch on [4080862347264 16384] extent item 6, found 5
tree extent[4080862347264, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862347264 found 6 wanted 5
backpointer mismatch on [4080862347264 16384]
ref mismatch on [4080862363648 16384] extent item 6, found 5
tree extent[4080862363648, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080862363648 found 6 wanted 5
backpointer mismatch on [4080862363648 16384]
ref mismatch on [4080863035392 16384] extent item 6, found 5
tree extent[4080863035392, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863035392 found 6 wanted 5
backpointer mismatch on [4080863035392 16384]
ref mismatch on [4080863166464 16384] extent item 6, found 5
tree extent[4080863166464, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863166464 found 6 wanted 5
backpointer mismatch on [4080863166464 16384]
ref mismatch on [4080863264768 16384] extent item 6, found 5
tree extent[4080863264768, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863264768 found 6 wanted 5
backpointer mismatch on [4080863264768 16384]
ref mismatch on [4080863395840 16384] extent item 6, found 5
tree extent[4080863395840, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863395840 found 6 wanted 5
backpointer mismatch on [4080863395840 16384]
ref mismatch on [4080863461376 16384] extent item 6, found 5
tree extent[4080863461376, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863461376 found 6 wanted 5
backpointer mismatch on [4080863461376 16384]
ref mismatch on [4080863526912 16384] extent item 6, found 5
tree extent[4080863526912, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863526912 found 6 wanted 5
backpointer mismatch on [4080863526912 16384]
ref mismatch on [4080863641600 16384] extent item 6, found 5
tree extent[4080863641600, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863641600 found 6 wanted 5
backpointer mismatch on [4080863641600 16384]
ref mismatch on [4080863739904 16384] extent item 6, found 5
tree extent[4080863739904, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863739904 found 6 wanted 5
backpointer mismatch on [4080863739904 16384]
ref mismatch on [4080863805440 16384] extent item 6, found 5
tree extent[4080863805440, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4080863805440 found 6 wanted 5
backpointer mismatch on [4080863805440 16384]
ref mismatch on [4081209131008 16384] extent item 5, found 4
tree extent[4081209131008, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081209131008 found 5 wanted 4
backpointer mismatch on [4081209131008 16384]
ref mismatch on [4081232248832 16384] extent item 5, found 4
tree extent[4081232248832, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232248832 found 5 wanted 4
backpointer mismatch on [4081232248832 16384]
ref mismatch on [4081232265216 16384] extent item 5, found 4
tree extent[4081232265216, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232265216 found 5 wanted 4
backpointer mismatch on [4081232265216 16384]
ref mismatch on [4081232297984 16384] extent item 5, found 4
tree extent[4081232297984, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232297984 found 5 wanted 4
backpointer mismatch on [4081232297984 16384]
ref mismatch on [4081232314368 16384] extent item 5, found 4
tree extent[4081232314368, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232314368 found 5 wanted 4
backpointer mismatch on [4081232314368 16384]
ref mismatch on [4081232330752 16384] extent item 5, found 4
tree extent[4081232330752, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232330752 found 5 wanted 4
backpointer mismatch on [4081232330752 16384]
ref mismatch on [4081232347136 16384] extent item 5, found 4
tree extent[4081232347136, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232347136 found 5 wanted 4
backpointer mismatch on [4081232347136 16384]
ref mismatch on [4081232363520 16384] extent item 5, found 4
tree extent[4081232363520, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232363520 found 5 wanted 4
backpointer mismatch on [4081232363520 16384]
ref mismatch on [4081232379904 16384] extent item 5, found 4
tree extent[4081232379904, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232379904 found 5 wanted 4
backpointer mismatch on [4081232379904 16384]
ref mismatch on [4081232396288 16384] extent item 5, found 4
tree extent[4081232396288, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232396288 found 5 wanted 4
backpointer mismatch on [4081232396288 16384]
ref mismatch on [4081232412672 16384] extent item 5, found 4
tree extent[4081232412672, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232412672 found 5 wanted 4
backpointer mismatch on [4081232412672 16384]
ref mismatch on [4081232429056 16384] extent item 5, found 4
tree extent[4081232429056, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232429056 found 5 wanted 4
backpointer mismatch on [4081232429056 16384]
ref mismatch on [4081232445440 16384] extent item 5, found 4
tree extent[4081232445440, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232445440 found 5 wanted 4
backpointer mismatch on [4081232445440 16384]
ref mismatch on [4081232461824 16384] extent item 5, found 4
tree extent[4081232461824, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232461824 found 5 wanted 4
backpointer mismatch on [4081232461824 16384]
ref mismatch on [4081232510976 16384] extent item 5, found 4
tree extent[4081232510976, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232510976 found 5 wanted 4
backpointer mismatch on [4081232510976 16384]
ref mismatch on [4081232527360 16384] extent item 5, found 4
tree extent[4081232527360, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232527360 found 5 wanted 4
backpointer mismatch on [4081232527360 16384]
ref mismatch on [4081232543744 16384] extent item 5, found 4
tree extent[4081232543744, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081232543744 found 5 wanted 4
backpointer mismatch on [4081232543744 16384]
ref mismatch on [4081234083840 16384] extent item 5, found 4
tree extent[4081234083840, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234083840 found 5 wanted 4
backpointer mismatch on [4081234083840 16384]
ref mismatch on [4081234132992 16384] extent item 5, found 4
tree extent[4081234132992, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234132992 found 5 wanted 4
backpointer mismatch on [4081234132992 16384]
ref mismatch on [4081234149376 16384] extent item 5, found 4
tree extent[4081234149376, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234149376 found 5 wanted 4
backpointer mismatch on [4081234149376 16384]
ref mismatch on [4081234182144 16384] extent item 5, found 4
tree extent[4081234182144, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234182144 found 5 wanted 4
backpointer mismatch on [4081234182144 16384]
ref mismatch on [4081234198528 16384] extent item 5, found 4
tree extent[4081234198528, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234198528 found 5 wanted 4
backpointer mismatch on [4081234198528 16384]
ref mismatch on [4081234214912 16384] extent item 5, found 4
tree extent[4081234214912, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234214912 found 5 wanted 4
backpointer mismatch on [4081234214912 16384]
ref mismatch on [4081234231296 16384] extent item 5, found 4
tree extent[4081234231296, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234231296 found 5 wanted 4
backpointer mismatch on [4081234231296 16384]
ref mismatch on [4081234280448 16384] extent item 5, found 4
tree extent[4081234280448, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234280448 found 5 wanted 4
backpointer mismatch on [4081234280448 16384]
ref mismatch on [4081234296832 16384] extent item 5, found 4
tree extent[4081234296832, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234296832 found 5 wanted 4
backpointer mismatch on [4081234296832 16384]
ref mismatch on [4081234329600 16384] extent item 5, found 4
tree extent[4081234329600, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234329600 found 5 wanted 4
backpointer mismatch on [4081234329600 16384]
ref mismatch on [4081234345984 16384] extent item 5, found 4
tree extent[4081234345984, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234345984 found 5 wanted 4
backpointer mismatch on [4081234345984 16384]
ref mismatch on [4081234362368 16384] extent item 5, found 4
tree extent[4081234362368, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234362368 found 5 wanted 4
backpointer mismatch on [4081234362368 16384]
ref mismatch on [4081234378752 16384] extent item 5, found 4
tree extent[4081234378752, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234378752 found 5 wanted 4
backpointer mismatch on [4081234378752 16384]
ref mismatch on [4081234395136 16384] extent item 5, found 4
tree extent[4081234395136, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234395136 found 5 wanted 4
backpointer mismatch on [4081234395136 16384]
ref mismatch on [4081234411520 16384] extent item 5, found 4
tree extent[4081234411520, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234411520 found 5 wanted 4
backpointer mismatch on [4081234411520 16384]
ref mismatch on [4081234427904 16384] extent item 5, found 4
tree extent[4081234427904, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234427904 found 5 wanted 4
backpointer mismatch on [4081234427904 16384]
ref mismatch on [4081234444288 16384] extent item 5, found 4
tree extent[4081234444288, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234444288 found 5 wanted 4
backpointer mismatch on [4081234444288 16384]
ref mismatch on [4081234460672 16384] extent item 5, found 4
tree extent[4081234460672, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234460672 found 5 wanted 4
backpointer mismatch on [4081234460672 16384]
ref mismatch on [4081234477056 16384] extent item 5, found 4
tree extent[4081234477056, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234477056 found 5 wanted 4
backpointer mismatch on [4081234477056 16384]
ref mismatch on [4081234493440 16384] extent item 5, found 4
tree extent[4081234493440, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234493440 found 5 wanted 4
backpointer mismatch on [4081234493440 16384]
ref mismatch on [4081234509824 16384] extent item 5, found 4
tree extent[4081234509824, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234509824 found 5 wanted 4
backpointer mismatch on [4081234509824 16384]
ref mismatch on [4081234526208 16384] extent item 5, found 4
tree extent[4081234526208, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234526208 found 5 wanted 4
backpointer mismatch on [4081234526208 16384]
ref mismatch on [4081234542592 16384] extent item 5, found 4
tree extent[4081234542592, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234542592 found 5 wanted 4
backpointer mismatch on [4081234542592 16384]
ref mismatch on [4081234558976 16384] extent item 5, found 4
tree extent[4081234558976, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234558976 found 5 wanted 4
backpointer mismatch on [4081234558976 16384]
ref mismatch on [4081234575360 16384] extent item 5, found 4
tree extent[4081234575360, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234575360 found 5 wanted 4
backpointer mismatch on [4081234575360 16384]
ref mismatch on [4081234591744 16384] extent item 5, found 4
tree extent[4081234591744, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234591744 found 5 wanted 4
backpointer mismatch on [4081234591744 16384]
ref mismatch on [4081234608128 16384] extent item 5, found 4
tree extent[4081234608128, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234608128 found 5 wanted 4
backpointer mismatch on [4081234608128 16384]
ref mismatch on [4081234657280 16384] extent item 5, found 4
tree extent[4081234657280, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234657280 found 5 wanted 4
backpointer mismatch on [4081234657280 16384]
ref mismatch on [4081234673664 16384] extent item 5, found 4
tree extent[4081234673664, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234673664 found 5 wanted 4
backpointer mismatch on [4081234673664 16384]
ref mismatch on [4081234690048 16384] extent item 5, found 4
tree extent[4081234690048, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234690048 found 5 wanted 4
backpointer mismatch on [4081234690048 16384]
ref mismatch on [4081234706432 16384] extent item 5, found 4
tree extent[4081234706432, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234706432 found 5 wanted 4
backpointer mismatch on [4081234706432 16384]
ref mismatch on [4081234722816 16384] extent item 5, found 4
tree extent[4081234722816, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234722816 found 5 wanted 4
backpointer mismatch on [4081234722816 16384]
ref mismatch on [4081234739200 16384] extent item 5, found 4
tree extent[4081234739200, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234739200 found 5 wanted 4
backpointer mismatch on [4081234739200 16384]
ref mismatch on [4081234755584 16384] extent item 5, found 4
tree extent[4081234755584, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081234755584 found 5 wanted 4
backpointer mismatch on [4081234755584 16384]
ref mismatch on [4081235623936 16384] extent item 5, found 4
tree extent[4081235623936, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235623936 found 5 wanted 4
backpointer mismatch on [4081235623936 16384]
ref mismatch on [4081235640320 16384] extent item 5, found 4
tree extent[4081235640320, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235640320 found 5 wanted 4
backpointer mismatch on [4081235640320 16384]
ref mismatch on [4081235656704 16384] extent item 5, found 4
tree extent[4081235656704, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235656704 found 5 wanted 4
backpointer mismatch on [4081235656704 16384]
ref mismatch on [4081235705856 16384] extent item 5, found 4
tree extent[4081235705856, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235705856 found 5 wanted 4
backpointer mismatch on [4081235705856 16384]
ref mismatch on [4081235722240 16384] extent item 5, found 4
tree extent[4081235722240, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235722240 found 5 wanted 4
backpointer mismatch on [4081235722240 16384]
ref mismatch on [4081235738624 16384] extent item 5, found 4
tree extent[4081235738624, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235738624 found 5 wanted 4
backpointer mismatch on [4081235738624 16384]
ref mismatch on [4081235755008 16384] extent item 5, found 4
tree extent[4081235755008, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235755008 found 5 wanted 4
backpointer mismatch on [4081235755008 16384]
ref mismatch on [4081235771392 16384] extent item 5, found 4
tree extent[4081235771392, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235771392 found 5 wanted 4
backpointer mismatch on [4081235771392 16384]
ref mismatch on [4081235787776 16384] extent item 5, found 4
tree extent[4081235787776, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235787776 found 5 wanted 4
backpointer mismatch on [4081235787776 16384]
ref mismatch on [4081235804160 16384] extent item 5, found 4
tree extent[4081235804160, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235804160 found 5 wanted 4
backpointer mismatch on [4081235804160 16384]
ref mismatch on [4081235820544 16384] extent item 5, found 4
tree extent[4081235820544, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235820544 found 5 wanted 4
backpointer mismatch on [4081235820544 16384]
ref mismatch on [4081235836928 16384] extent item 5, found 4
tree extent[4081235836928, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235836928 found 5 wanted 4
backpointer mismatch on [4081235836928 16384]
ref mismatch on [4081235869696 16384] extent item 5, found 4
tree extent[4081235869696, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235869696 found 5 wanted 4
backpointer mismatch on [4081235869696 16384]
ref mismatch on [4081235886080 16384] extent item 5, found 4
tree extent[4081235886080, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235886080 found 5 wanted 4
backpointer mismatch on [4081235886080 16384]
ref mismatch on [4081235902464 16384] extent item 5, found 4
tree extent[4081235902464, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235902464 found 5 wanted 4
backpointer mismatch on [4081235902464 16384]
ref mismatch on [4081235918848 16384] extent item 5, found 4
tree extent[4081235918848, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235918848 found 5 wanted 4
backpointer mismatch on [4081235918848 16384]
ref mismatch on [4081235935232 16384] extent item 5, found 4
tree extent[4081235935232, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235935232 found 5 wanted 4
backpointer mismatch on [4081235935232 16384]
ref mismatch on [4081235951616 16384] extent item 5, found 4
tree extent[4081235951616, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235951616 found 5 wanted 4
backpointer mismatch on [4081235951616 16384]
ref mismatch on [4081235968000 16384] extent item 5, found 4
tree extent[4081235968000, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235968000 found 5 wanted 4
backpointer mismatch on [4081235968000 16384]
ref mismatch on [4081235984384 16384] extent item 5, found 4
tree extent[4081235984384, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081235984384 found 5 wanted 4
backpointer mismatch on [4081235984384 16384]
ref mismatch on [4081236000768 16384] extent item 5, found 4
tree extent[4081236000768, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081236000768 found 5 wanted 4
backpointer mismatch on [4081236000768 16384]
ref mismatch on [4081236017152 16384] extent item 5, found 4
tree extent[4081236017152, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081236017152 found 5 wanted 4
backpointer mismatch on [4081236017152 16384]
ref mismatch on [4081275813888 16384] extent item 5, found 4
tree extent[4081275813888, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4081275813888 found 5 wanted 4
backpointer mismatch on [4081275813888 16384]
ref mismatch on [4115473137664 16384] extent item 4, found 3
tree extent[4115473137664, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4115473137664 found 4 wanted 3
backpointer mismatch on [4115473137664 16384]
ref mismatch on [4115591282688 16384] extent item 6, found 5
tree extent[4115591282688, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4115591282688 found 6 wanted 5
backpointer mismatch on [4115591282688 16384]
ref mismatch on [4126650761216 16384] extent item 3, found 2
tree extent[4126650761216, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126650761216 found 3 wanted 2
backpointer mismatch on [4126650761216 16384]
ref mismatch on [4126650957824 16384] extent item 3, found 2
tree extent[4126650957824, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126650957824 found 3 wanted 2
backpointer mismatch on [4126650957824 16384]
ref mismatch on [4126652940288 16384] extent item 3, found 2
tree extent[4126652940288, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126652940288 found 3 wanted 2
backpointer mismatch on [4126652940288 16384]
ref mismatch on [4126654775296 16384] extent item 3, found 2
tree extent[4126654775296, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126654775296 found 3 wanted 2
backpointer mismatch on [4126654775296 16384]
ref mismatch on [4126683480064 16384] extent item 3, found 2
tree extent[4126683480064, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126683480064 found 3 wanted 2
backpointer mismatch on [4126683480064 16384]
ref mismatch on [4126684413952 16384] extent item 3, found 2
tree extent[4126684413952, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126684413952 found 3 wanted 2
backpointer mismatch on [4126684413952 16384]
ref mismatch on [4126685396992 16384] extent item 3, found 2
tree extent[4126685396992, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126685396992 found 3 wanted 2
backpointer mismatch on [4126685396992 16384]
ref mismatch on [4126690181120 16384] extent item 3, found 2
tree extent[4126690181120, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126690181120 found 3 wanted 2
backpointer mismatch on [4126690181120 16384]
ref mismatch on [4126692360192 16384] extent item 3, found 2
tree extent[4126692360192, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126692360192 found 3 wanted 2
backpointer mismatch on [4126692360192 16384]
ref mismatch on [4126692720640 16384] extent item 3, found 2
tree extent[4126692720640, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126692720640 found 3 wanted 2
backpointer mismatch on [4126692720640 16384]
ref mismatch on [4126694440960 16384] extent item 3, found 2
tree extent[4126694440960, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126694440960 found 3 wanted 2
backpointer mismatch on [4126694440960 16384]
ref mismatch on [4126694948864 16384] extent item 3, found 2
tree extent[4126694948864, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126694948864 found 3 wanted 2
backpointer mismatch on [4126694948864 16384]
ref mismatch on [4126696226816 16384] extent item 3, found 2
tree extent[4126696226816, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126696226816 found 3 wanted 2
backpointer mismatch on [4126696226816 16384]
ref mismatch on [4126696472576 16384] extent item 3, found 2
tree extent[4126696472576, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126696472576 found 3 wanted 2
backpointer mismatch on [4126696472576 16384]
ref mismatch on [4126696652800 16384] extent item 3, found 2
tree extent[4126696652800, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126696652800 found 3 wanted 2
backpointer mismatch on [4126696652800 16384]
ref mismatch on [4126696800256 16384] extent item 3, found 2
tree extent[4126696800256, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126696800256 found 3 wanted 2
backpointer mismatch on [4126696800256 16384]
ref mismatch on [4126696947712 16384] extent item 3, found 2
tree extent[4126696947712, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126696947712 found 3 wanted 2
backpointer mismatch on [4126696947712 16384]
ref mismatch on [4126697029632 16384] extent item 3, found 2
tree extent[4126697029632, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697029632 found 3 wanted 2
backpointer mismatch on [4126697029632 16384]
ref mismatch on [4126697046016 16384] extent item 3, found 2
tree extent[4126697046016, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697046016 found 3 wanted 2
backpointer mismatch on [4126697046016 16384]
ref mismatch on [4126697144320 16384] extent item 3, found 2
tree extent[4126697144320, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697144320 found 3 wanted 2
backpointer mismatch on [4126697144320 16384]
ref mismatch on [4126697324544 16384] extent item 3, found 2
tree extent[4126697324544, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697324544 found 3 wanted 2
backpointer mismatch on [4126697324544 16384]
ref mismatch on [4126697422848 16384] extent item 3, found 2
tree extent[4126697422848, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697422848 found 3 wanted 2
backpointer mismatch on [4126697422848 16384]
ref mismatch on [4126697684992 16384] extent item 3, found 2
tree extent[4126697684992, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697684992 found 3 wanted 2
backpointer mismatch on [4126697684992 16384]
ref mismatch on [4126697799680 16384] extent item 3, found 2
tree extent[4126697799680, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697799680 found 3 wanted 2
backpointer mismatch on [4126697799680 16384]
ref mismatch on [4126697865216 16384] extent item 3, found 2
tree extent[4126697865216, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126697865216 found 3 wanted 2
backpointer mismatch on [4126697865216 16384]
ref mismatch on [4126698192896 16384] extent item 3, found 2
tree extent[4126698192896, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126698192896 found 3 wanted 2
backpointer mismatch on [4126698192896 16384]
ref mismatch on [4126698553344 16384] extent item 3, found 2
tree extent[4126698553344, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126698553344 found 3 wanted 2
backpointer mismatch on [4126698553344 16384]
ref mismatch on [4126698569728 16384] extent item 3, found 2
tree extent[4126698569728, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126698569728 found 3 wanted 2
backpointer mismatch on [4126698569728 16384]
ref mismatch on [4126720802816 16384] extent item 3, found 2
tree extent[4126720802816, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126720802816 found 3 wanted 2
backpointer mismatch on [4126720802816 16384]
ref mismatch on [4126720819200 16384] extent item 3, found 2
tree extent[4126720819200, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126720819200 found 3 wanted 2
backpointer mismatch on [4126720819200 16384]
ref mismatch on [4126724456448 16384] extent item 3, found 2
tree extent[4126724456448, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126724456448 found 3 wanted 2
backpointer mismatch on [4126724456448 16384]
ref mismatch on [4126724505600 16384] extent item 3, found 2
tree extent[4126724505600, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126724505600 found 3 wanted 2
backpointer mismatch on [4126724505600 16384]
ref mismatch on [4126724947968 16384] extent item 3, found 2
tree extent[4126724947968, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126724947968 found 3 wanted 2
backpointer mismatch on [4126724947968 16384]
ref mismatch on [4126724997120 16384] extent item 3, found 2
tree extent[4126724997120, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126724997120 found 3 wanted 2
backpointer mismatch on [4126724997120 16384]
ref mismatch on [4126725046272 16384] extent item 3, found 2
tree extent[4126725046272, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126725046272 found 3 wanted 2
backpointer mismatch on [4126725046272 16384]
ref mismatch on [4126725062656 16384] extent item 3, found 2
tree extent[4126725062656, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126725062656 found 3 wanted 2
backpointer mismatch on [4126725062656 16384]
ref mismatch on [4126725177344 16384] extent item 3, found 2
tree extent[4126725177344, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126725177344 found 3 wanted 2
backpointer mismatch on [4126725177344 16384]
ref mismatch on [4126726111232 16384] extent item 3, found 2
tree extent[4126726111232, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126726111232 found 3 wanted 2
backpointer mismatch on [4126726111232 16384]
ref mismatch on [4126726651904 16384] extent item 3, found 2
tree extent[4126726651904, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126726651904 found 3 wanted 2
backpointer mismatch on [4126726651904 16384]
ref mismatch on [4126727553024 16384] extent item 3, found 2
tree extent[4126727553024, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126727553024 found 3 wanted 2
backpointer mismatch on [4126727553024 16384]
ref mismatch on [4126727569408 16384] extent item 3, found 2
tree extent[4126727569408, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126727569408 found 3 wanted 2
backpointer mismatch on [4126727569408 16384]
ref mismatch on [4126727897088 16384] extent item 3, found 2
tree extent[4126727897088, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126727897088 found 3 wanted 2
backpointer mismatch on [4126727897088 16384]
ref mismatch on [4126727962624 16384] extent item 3, found 2
tree extent[4126727962624, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126727962624 found 3 wanted 2
backpointer mismatch on [4126727962624 16384]
ref mismatch on [4126727979008 16384] extent item 3, found 2
tree extent[4126727979008, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126727979008 found 3 wanted 2
backpointer mismatch on [4126727979008 16384]
ref mismatch on [4126728568832 16384] extent item 3, found 2
tree extent[4126728568832, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126728568832 found 3 wanted 2
backpointer mismatch on [4126728568832 16384]
ref mismatch on [4126729224192 16384] extent item 3, found 2
tree extent[4126729224192, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729224192 found 3 wanted 2
backpointer mismatch on [4126729224192 16384]
ref mismatch on [4126729240576 16384] extent item 3, found 2
tree extent[4126729240576, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729240576 found 3 wanted 2
backpointer mismatch on [4126729240576 16384]
ref mismatch on [4126729306112 16384] extent item 3, found 2
tree extent[4126729306112, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729306112 found 3 wanted 2
backpointer mismatch on [4126729306112 16384]
ref mismatch on [4126729453568 16384] extent item 3, found 2
tree extent[4126729453568, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729453568 found 3 wanted 2
backpointer mismatch on [4126729453568 16384]
ref mismatch on [4126729469952 16384] extent item 3, found 2
tree extent[4126729469952, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729469952 found 3 wanted 2
backpointer mismatch on [4126729469952 16384]
ref mismatch on [4126729519104 16384] extent item 3, found 2
tree extent[4126729519104, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729519104 found 3 wanted 2
backpointer mismatch on [4126729519104 16384]
ref mismatch on [4126729584640 16384] extent item 3, found 2
tree extent[4126729584640, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729584640 found 3 wanted 2
backpointer mismatch on [4126729584640 16384]
ref mismatch on [4126729617408 16384] extent item 3, found 2
tree extent[4126729617408, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729617408 found 3 wanted 2
backpointer mismatch on [4126729617408 16384]
ref mismatch on [4126729715712 16384] extent item 3, found 2
tree extent[4126729715712, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729715712 found 3 wanted 2
backpointer mismatch on [4126729715712 16384]
ref mismatch on [4126729781248 16384] extent item 3, found 2
tree extent[4126729781248, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729781248 found 3 wanted 2
backpointer mismatch on [4126729781248 16384]
ref mismatch on [4126729863168 16384] extent item 3, found 2
tree extent[4126729863168, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126729863168 found 3 wanted 2
backpointer mismatch on [4126729863168 16384]
ref mismatch on [4126730158080 16384] extent item 3, found 2
tree extent[4126730158080, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730158080 found 3 wanted 2
backpointer mismatch on [4126730158080 16384]
ref mismatch on [4126730223616 16384] extent item 3, found 2
tree extent[4126730223616, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730223616 found 3 wanted 2
backpointer mismatch on [4126730223616 16384]
ref mismatch on [4126730256384 16384] extent item 3, found 2
tree extent[4126730256384, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730256384 found 3 wanted 2
backpointer mismatch on [4126730256384 16384]
ref mismatch on [4126730289152 16384] extent item 3, found 2
tree extent[4126730289152, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730289152 found 3 wanted 2
backpointer mismatch on [4126730289152 16384]
ref mismatch on [4126730354688 16384] extent item 3, found 2
tree extent[4126730354688, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730354688 found 3 wanted 2
backpointer mismatch on [4126730354688 16384]
ref mismatch on [4126730371072 16384] extent item 3, found 2
tree extent[4126730371072, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730371072 found 3 wanted 2
backpointer mismatch on [4126730371072 16384]
ref mismatch on [4126730567680 16384] extent item 3, found 2
tree extent[4126730567680, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730567680 found 3 wanted 2
backpointer mismatch on [4126730567680 16384]
ref mismatch on [4126730649600 16384] extent item 3, found 2
tree extent[4126730649600, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730649600 found 3 wanted 2
backpointer mismatch on [4126730649600 16384]
ref mismatch on [4126730747904 16384] extent item 3, found 2
tree extent[4126730747904, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730747904 found 3 wanted 2
backpointer mismatch on [4126730747904 16384]
ref mismatch on [4126730846208 16384] extent item 3, found 2
tree extent[4126730846208, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730846208 found 3 wanted 2
backpointer mismatch on [4126730846208 16384]
ref mismatch on [4126730862592 16384] extent item 3, found 2
tree extent[4126730862592, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126730862592 found 3 wanted 2
backpointer mismatch on [4126730862592 16384]
ref mismatch on [4126731517952 16384] extent item 3, found 2
tree extent[4126731517952, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731517952 found 3 wanted 2
backpointer mismatch on [4126731517952 16384]
ref mismatch on [4126731550720 16384] extent item 3, found 2
tree extent[4126731550720, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731550720 found 3 wanted 2
backpointer mismatch on [4126731550720 16384]
ref mismatch on [4126731583488 16384] extent item 3, found 2
tree extent[4126731583488, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731583488 found 3 wanted 2
backpointer mismatch on [4126731583488 16384]
ref mismatch on [4126731616256 16384] extent item 3, found 2
tree extent[4126731616256, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731616256 found 3 wanted 2
backpointer mismatch on [4126731616256 16384]
ref mismatch on [4126731632640 16384] extent item 3, found 2
tree extent[4126731632640, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731632640 found 3 wanted 2
backpointer mismatch on [4126731632640 16384]
ref mismatch on [4126731862016 16384] extent item 3, found 2
tree extent[4126731862016, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731862016 found 3 wanted 2
backpointer mismatch on [4126731862016 16384]
ref mismatch on [4126731894784 16384] extent item 3, found 2
tree extent[4126731894784, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731894784 found 3 wanted 2
backpointer mismatch on [4126731894784 16384]
ref mismatch on [4126731927552 16384] extent item 3, found 2
tree extent[4126731927552, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126731927552 found 3 wanted 2
backpointer mismatch on [4126731927552 16384]
ref mismatch on [4126732091392 16384] extent item 3, found 2
tree extent[4126732091392, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732091392 found 3 wanted 2
backpointer mismatch on [4126732091392 16384]
ref mismatch on [4126732156928 16384] extent item 3, found 2
tree extent[4126732156928, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732156928 found 3 wanted 2
backpointer mismatch on [4126732156928 16384]
ref mismatch on [4126732533760 16384] extent item 3, found 2
tree extent[4126732533760, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732533760 found 3 wanted 2
backpointer mismatch on [4126732533760 16384]
ref mismatch on [4126732566528 16384] extent item 3, found 2
tree extent[4126732566528, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732566528 found 3 wanted 2
backpointer mismatch on [4126732566528 16384]
ref mismatch on [4126732599296 16384] extent item 3, found 2
tree extent[4126732599296, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732599296 found 3 wanted 2
backpointer mismatch on [4126732599296 16384]
ref mismatch on [4126732615680 16384] extent item 3, found 2
tree extent[4126732615680, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732615680 found 3 wanted 2
backpointer mismatch on [4126732615680 16384]
ref mismatch on [4126732730368 16384] extent item 3, found 2
tree extent[4126732730368, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732730368 found 3 wanted 2
backpointer mismatch on [4126732730368 16384]
ref mismatch on [4126732779520 16384] extent item 3, found 2
tree extent[4126732779520, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732779520 found 3 wanted 2
backpointer mismatch on [4126732779520 16384]
ref mismatch on [4126732812288 16384] extent item 3, found 2
tree extent[4126732812288, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732812288 found 3 wanted 2
backpointer mismatch on [4126732812288 16384]
ref mismatch on [4126732828672 16384] extent item 3, found 2
tree extent[4126732828672, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732828672 found 3 wanted 2
backpointer mismatch on [4126732828672 16384]
ref mismatch on [4126732894208 16384] extent item 3, found 2
tree extent[4126732894208, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732894208 found 3 wanted 2
backpointer mismatch on [4126732894208 16384]
ref mismatch on [4126732959744 16384] extent item 3, found 2
tree extent[4126732959744, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126732959744 found 3 wanted 2
backpointer mismatch on [4126732959744 16384]
ref mismatch on [4126733926400 16384] extent item 3, found 2
tree extent[4126733926400, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126733926400 found 3 wanted 2
backpointer mismatch on [4126733926400 16384]
ref mismatch on [4126733975552 16384] extent item 3, found 2
tree extent[4126733975552, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126733975552 found 3 wanted 2
backpointer mismatch on [4126733975552 16384]
ref mismatch on [4126733991936 16384] extent item 3, found 2
tree extent[4126733991936, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126733991936 found 3 wanted 2
backpointer mismatch on [4126733991936 16384]
ref mismatch on [4126734041088 16384] extent item 3, found 2
tree extent[4126734041088, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734041088 found 3 wanted 2
backpointer mismatch on [4126734041088 16384]
ref mismatch on [4126734123008 16384] extent item 3, found 2
tree extent[4126734123008, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734123008 found 3 wanted 2
backpointer mismatch on [4126734123008 16384]
ref mismatch on [4126734155776 16384] extent item 3, found 2
tree extent[4126734155776, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734155776 found 3 wanted 2
backpointer mismatch on [4126734155776 16384]
ref mismatch on [4126734352384 16384] extent item 3, found 2
tree extent[4126734352384, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734352384 found 3 wanted 2
backpointer mismatch on [4126734352384 16384]
ref mismatch on [4126734499840 16384] extent item 3, found 2
tree extent[4126734499840, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734499840 found 3 wanted 2
backpointer mismatch on [4126734499840 16384]
ref mismatch on [4126734516224 16384] extent item 3, found 2
tree extent[4126734516224, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734516224 found 3 wanted 2
backpointer mismatch on [4126734516224 16384]
ref mismatch on [4126734548992 16384] extent item 3, found 2
tree extent[4126734548992, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4126734548992 found 3 wanted 2
backpointer mismatch on [4126734548992 16384]
ref mismatch on [4127124750336 16384] extent item 3, found 2
tree extent[4127124750336, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4127124750336 found 3 wanted 2
backpointer mismatch on [4127124750336 16384]
ref mismatch on [4127280594944 16384] extent item 3, found 2
tree extent[4127280594944, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4127280594944 found 3 wanted 2
backpointer mismatch on [4127280594944 16384]
ref mismatch on [4127283003392 16384] extent item 3, found 2
tree extent[4127283003392, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4127283003392 found 3 wanted 2
backpointer mismatch on [4127283003392 16384]
ref mismatch on [4160118161408 16384] extent item 2, found 1
tree extent[4160118161408, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4160118161408 found 2 wanted 1
backpointer mismatch on [4160118161408 16384]
ref mismatch on [4160125157376 16384] extent item 2, found 1
tree extent[4160125157376, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4160125157376 found 2 wanted 1
backpointer mismatch on [4160125157376 16384]
ref mismatch on [4160125173760 16384] extent item 2, found 1
tree extent[4160125173760, 16384] parent 4160294617088 has no tree block found
incorrect global backref count on 4160125173760 found 2 wanted 1
backpointer mismatch on [4160125173760 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
warning line 3967
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)

--nextPart3570583.dWV9SEqChM--




