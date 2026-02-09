Return-Path: <linux-btrfs+bounces-21522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eQN6OyheiWnZ7gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21522-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:10:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9B10B84E
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68BE3006B60
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF93265CDD;
	Mon,  9 Feb 2026 04:10:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758891CEADB
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770610206; cv=pass; b=rWpsXtJz74D48+wKBPiHp8jLzrF7plzytpbkuktrruiaCZRLSGVsFbHP0rRl6aXAOIv0c+FgO6SaMwHryrzKCsH5yZvy6GV5Quuo/UOjrePmzcgQoMGb4T17LYQo48rcVwRRLi66xfjWjHgaQu6y8rrbt0IODP926dL6EHuuSv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770610206; c=relaxed/simple;
	bh=Yfp43SoApQE8TaDOZa9rL37I+xDaRPRa3KqCRfJxNmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gN4sb1xXF2JGF6FE9eLX9tBq7lSfimy9q5wBJ9gEXtYAZIAfrupTowcZ44H4lxc5X+DvAk46RAG2qAHcC5coQRNMVoDzLZkLPlb8pEqYAGPYP5GamE27/ohYKSovWIV34pX0N6l+IW2BLhLDXM+dcWut9Ch2urrL+C/zW1vQBls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 20A95461E80;
	Mon, 09 Feb 2026 03:32:22 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-81-148.trex-nlb.outbound.svc.cluster.local [100.96.81.148])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2FFE146235B;
	Mon, 09 Feb 2026 03:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770607941;
	b=w0mglxSOEfFnuWraX2sVD45L2EqzVWYUjVT9jCfzwMz6T4+WBlPTSasM+ZPT+YFDeQAtTV
	QyNcxoje9chU+pzGHKMk72tgKSPiqwmdyhU+M3uWVJR29Ep6oULDJxbhihQcAqf7EUT4h2
	wleKh6Sbr7fiZbbzYdmkGU1cPzhrn4t8e4kpPpMIIsaVHelQbR04v+ZRNMc21TMbm864QB
	K9PBufc5djWFq8s1uWxlxdY4zHQ94yf5E9BCRIS0XCbH7TaXcPVu9Vk47igBWPzVTJchJD
	zUhjqpFdazQXiTsMAwc9oEXSy10mxoP8VdfDWZCruS2ZRLyoEMLIJjereSHy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770607941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfp43SoApQE8TaDOZa9rL37I+xDaRPRa3KqCRfJxNmI=;
	b=6yc5IH5VYLy+MuNCYr9ztSBv+NqScENVX9wwtp4ywvKoQhneZytzVVyzvMsrm9Jd9uyt8w
	n9g4jP9JWAJ0gujFx/OB76CO5LkFUcVYUzKxrZRV3vb6aYmOqZ8NhZyHkYOJ9mNBxsWAJi
	6Yni6h44oZUwdMExbVVWEnFiuRAubK5ieK12SNJzVnLJApf/8Bllc4Hl4lRXNL6KuDyhR7
	/8d43Mea1JIRHMaqI+dw54SgpU1qJU17UVDLSrjI6CkqyAgrj3eV2Uxws9DtUUQJqfi0uY
	2TUtwX0sAQYNcXDbWVPX59cZKcgyq/WZ+NTy3K2pMh1cBZvU+P9xwZwk9SqfVg==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-rtwjf;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Company-Descriptive: 17edafe717557bce_1770607941872_625575656
X-MC-Loop-Signature: 1770607941872:2964859231
X-MC-Ingress-Time: 1770607941872
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.81.148 (trex/7.1.3);
	Mon, 09 Feb 2026 03:32:21 +0000
Received: from p5b071a6f.dip0.t-ipconnect.de ([91.7.26.111]:62710 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vpI0Y-00000007dNY-1jPQ;
	Mon, 09 Feb 2026 03:32:19 +0000
Message-ID: <3137a2417287037a2ed52ded55fab35181254009.camel@scientia.org>
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full // open_ctree failed: -2
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Mon, 09 Feb 2026 04:32:17 +0100
In-Reply-To: <9b05f9a3-5efe-4e57-9585-a3886bb419fa@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
	 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
	 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
	 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
	 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
	 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
	 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
	 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
	 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
	 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
	 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
	 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
	 <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
	 <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
	 <89188b7b8b5a1f9bb64af37777aec906134ad75c.camel@scientia.org>
	 <9b05f9a3-5efe-4e57-9585-a3886bb419fa@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21522-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.880];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA9B10B84E
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 13:51 +1030, Qu Wenruo wrote:
> I think you're safe to clear the v2 cache, and let the kernel create
> at=20
> mount time.

Would it help you if I keep the fs for further debugging (or later
checking a possible fix)?

If so, any rough estimate on how long that would take (cause in
principle I would sooner or later want to use that device again for
backups ;-) ).


Thanks,
Chris

