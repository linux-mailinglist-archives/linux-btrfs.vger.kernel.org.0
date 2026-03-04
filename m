Return-Path: <linux-btrfs+bounces-22221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEgFLQ47qGkTqgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22221-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 15:00:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C2200DFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012873124CC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC613A8727;
	Wed,  4 Mar 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KYmys5yj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DED396596
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632457; cv=none; b=XiiqIdI/LJkrIWoNO2ltscF1mkaFW8B1LkO9WejCVWtu70MFQh1YVbQ8mEZiQMJ2BieLvf8bPR9rJQzjZllF/k3TRKu/GCUa6vfK17iIOOPT1/KoRttXDzPFAaquA+eGrhwHtoN6aIkuON24Exa5u79om/sfPKnRFp+7SIHSHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632457; c=relaxed/simple;
	bh=xvdRkZj57oc8RHWeWgbR6cK30VjNYlk6ZDbpmNzXzBY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=n7JXxmkLsHKITGA+oPj5Xcky2M5/9WHsPBYr2XDMWO3rjdaGud1YMlm3h0zCVafPMVxDRtHmoWkj9AAs+BOr9ECR9JivbCtAuC4vkZFrN+grUXsgbyLqmYAjc39TFF2EGhLitp4YTylNpmW8y9uoSeR9NkX4tArsgyU2i3KDA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KYmys5yj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fQvKb0F7Wz9tB3;
	Wed,  4 Mar 2026 14:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772632451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xvdRkZj57oc8RHWeWgbR6cK30VjNYlk6ZDbpmNzXzBY=;
	b=KYmys5yjHTYJUpVPB+5m89JkyHwVhZ4IW+TtY/gdEnr9+KVc9sFLAD7KTQn1SJ0olIm/HG
	QzUoBEzC85dcLrwllnilgXJ0d7L6feAHrPhHf69Y/BTdZJG8VwdOz7+dEsyivjA5oPDnjj
	SMx7UKj7PJW4mgl0AT7/Cmsc3cX88VqUW66NPoopxN2A7DJfUMrkdNaTwYNKkWrRqcHCsO
	cNdrVBMdveU2/eDR0P3AhHq2LOhJLs0125XXiDrCn80SlsGLnG6Gs0hzmXKcZNN69DIDGk
	0R9shRkcwcpu2KhV7q6GFoIUgJlGYlAmjdlYpEs8AaCWBWucMt8el/1r7DxA0w==
Date: Wed, 4 Mar 2026 14:54:08 +0100 (CET)
From: torvic9@mailbox.org
To: "sunk67188@gmail.com" <sunk67188@gmail.com>,
	"clm@meta.com" <clm@meta.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>
Message-ID: <1333479338.178488.1772632448830@app.mailbox.org>
Subject: btrfs: fix periodic reclaim condition - missing patch in stable?
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: ubz6gzxth61czkmji3gfu5hqgwy7nba7
X-MBO-RS-ID: c53b355a4e8d3d92018
X-Rspamd-Queue-Id: 0B0C2200DFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,meta.com,vger.kernel.org,suse.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-22221-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[torvic9@mailbox.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.mailbox.org:mid]
X-Rspamd-Action: no action

Hello,

Commit "btrfs: fix periodic reclaim condition" (25ecb24405928d3f5db48029c2237b2c7cefb479) was added to stable,
however it seems that a subsequent locking fix [1] to that patch was not added, possibly due to a missing stable tag.
Shouldn't that fix also be included in stable?

Cheers,
Tor

[1] https://lore.kernel.org/linux-btrfs/20260209130248.29418-1-sunk67188@gmail.com/

