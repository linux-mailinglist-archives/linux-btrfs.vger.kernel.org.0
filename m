Return-Path: <linux-btrfs+bounces-4278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6D8A596B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCDD28579F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5E71B50;
	Mon, 15 Apr 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oluceps.uk header.i=@oluceps.uk header.b="lMTx/hj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-200166.simplelogin.co (mail-200166.simplelogin.co [176.119.200.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD085925
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203331; cv=pass; b=tHZFeAelx5+jbWwWJ2eORKUfTlHBlsrM4G0npCXxrxy3e7PbBYk0DXLIZl4tlF456L+3bA9VrC+tjNvDfRVmCsPy9XvzE1Jjf6wVbYEviD7EVCBr/YeZ7mIe/DjMwWyq3CDEyXFvKqHU9Vk6NbZ68nQV9iC3qsOB0esUojdt2gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203331; c=relaxed/simple;
	bh=/3/rml+TRaxg3yfp9K/dkIDkYV292Jhp96ckzXDT1uA=;
	h=Subject:Date:MIME-Version:From:To:Cc:Message-ID; b=kPh9PKfr6kx6fW4MVx6DZJCjX0X9/rykVqlb00XeSzc7r06xXfGrV3fHSQno9kK5RXQ1M8VWKpL3SoihqlAIEecOcqwTv3M+G4BMlxeOoedSMlTS1ZQ+lqsjuNmQ6C3grYYstqBnNAcxG6rAkhYs6O/1mbOQmcI88YTbuEy87+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oluceps.uk; spf=pass smtp.mailfrom=oluceps.uk; dkim=pass (1024-bit key) header.d=oluceps.uk header.i=@oluceps.uk header.b=lMTx/hj7; arc=pass smtp.client-ip=176.119.200.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oluceps.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oluceps.uk
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1713201823;
	cv=none; b=ZinZODvw4AzBWnyHtMRSiznzV1F9Ph9+ryiJxaSxEcGoy+m8IywFTUJbnnLZluiQySrZFd+/NTzwVpOPn2p7Ci8I5g29iGk9VNW0kBN6XmNrvQgrWNKf6HXdLFbj76SG4bSmZwWwuHx25fb9eYlRcnksgADklJ13SH/QfZl7wYyH6kSUh/T1bU6TeWmSswX5at96pIP5/6Xkl6JbGm4Knxa7I2SMT+R5aqExLXvvlxCM8Q2d7I86WmmXwdkmpbDWQGNH6wiZUJqj4dpTu7jzEr9YtJ/kk9Unyn1PM9W3yMkmx7SDqHAAlw4TH7ZUj+Sf4YBWlP8KtfhHjlbphZwLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1713201823; c=relaxed/simple;
	bh=/3/rml+TRaxg3yfp9K/dkIDkYV292Jhp96ckzXDT1uA=;
	h=Subject:Date:From:To:Cc; b=QkhDH0nx4EtyeWAO+yJdGfHQQsvKYfzli6qNcyNjLeCd4N6BcMpa1vT+FWV9bIjSNoTdpcdIad1m+8gr7tBwf4ctT62KioezeC+bf7KzX0QIvQ5w9a+R5e9ojmBqdJtHCPYaOao0y9rmkfkrVYXYA+GXFndUYOyD1QZT+xoXAG3Ig2f0wZIfSsJSEyRfwGT2pvXj1wld4FHxjRgrdv/Xwonq0OkwT9yb3S8UtbuZwHY+pm6e96ooiPIa+3p3HuMPxc++9Z6+mekP0BSD3XthIMtTdQltTCOTED4bW3A76K4eRLGlx2Oqmil52uy+A3c78uLIURqG0xXnydoGq+RwTw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oluceps.uk; s=dkim;
	t=1713201823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=88ik/rMfbQcx58W/ixq31XYoyzb3p2Kuj8XbnQkdTZ0=;
	b=lMTx/hj7NmOPFKuEdpSIt35MceXcvq3BRNRqiyG3LqtQVCTN3g6V3QjC/Uj8mwVM4Ny8OQ
	JEp5N8JIohRyHz1TRC4f+a/SIe+43a/yrLp77p3CK1pYrh6yxMvAgcIFqfTFrUKGcP62LR
	mm9qws2htR7jDidbBtYmpAnklyu+N+A=
Subject: [PATCH] btrfs-progs: property set: fix typo in help message
Date: Mon, 15 Apr 2024 17:23:06 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: linux@oluceps.uk
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Message-ID: <171320182308.8.1632190135551877582.308812139@oluceps.uk>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 308812140
X-SimpleLogin-Want-Signing: yes

From: oluceps <linux@oluceps.uk>

Correct a typo by replacing "then" with "than".

Signed-off-by: oluceps <linux@oluceps.uk>
---
 cmds/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/property.c b/cmds/property.c
index 8777d144..a36b5ab2 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -588,7 +588,7 @@ static const char * const cmd_property_get_usage[] = {
 	"A filesystem object can be the filesystem itself, a subvolume,",
 	"an inode or a device. The option -t can be used to explicitly",
 	"specify what type of object you meant. This is only needed when a",
-	"property could be set for more then one object type.",
+	"property could be set for more than one object type.",
 	"",
 	"Possible values for type are: inode, subvol, filesystem, device.",
 	"They can be abbreviated to the first letter, i/s/f/d",
-- 
2.44.0



