Return-Path: <linux-btrfs+bounces-21068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BDNJD2id2mWjgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21068-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AF8B652
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A09B303D2C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225A34BA49;
	Mon, 26 Jan 2026 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="BNPhblts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOz19Z0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9243EBF3A
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447967; cv=none; b=sS+/7zukpjLvSM/Zbd8zTXfF2HcJdJ6WLT1eJQiF8hHkZCWas093FizayLc+CoVdxOx778UiU3zWLDDcBxnlgLQEmuTP6L+YuRqII8Y8JiLMutt7z32ec01LRNwLKK4f+Gx+C/Y+AGM5cSLv6d8r/+C1OXW55x7bPPR+FDOWoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447967; c=relaxed/simple;
	bh=KWbz/e8oUeNDU+QLsD8zjwgHPl2BCvLMklu9aXIZQEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/x7oIstR49/9Tr82GAPG/x3EIW76A+mp0pq3uZZG8p2aWJiO30b6O0AuEla+SlQEXTGYPPf9Y6ltQTsvOIhQxjhVulN+0EMIlMOHOBrmjXLtuKaLDbQ4uA2xHOPgkPD9VQqZyGjOktJkzYVDOUJ3F6d/SPVXZtExxebSrrHsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=BNPhblts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOz19Z0L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E76A1400074;
	Mon, 26 Jan 2026 12:19:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Jan 2026 12:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769447965;
	 x=1769534365; bh=Jcrgn9W3fAKMeRKl4dFn73q7qnjF+JGo1aH+LhY3nyo=; b=
	BNPhbltsWxwHLlH1a/7z27QBY6AHpIVSPg8AI6bGVRpEOs5eDKezPKHpDqd3heTV
	J0N4rHSnnYux+afOZYbJYD4rZ3IsdtE05y2Az+A5c+aC9HItG7cWo1NBHbRvP44M
	6ah7d+3pREd95e05ppbgsobAFgKXSJoMkBFCt+IlcKxAuc4TXvv8eS05DWjXYfJV
	eF6CY+jsw6yb7jMylV95E/+rz9tb0Bnrbi5JOgaJlg5TFcgMm3nL9WINY3EMgIPG
	Q85YXBWFgyzFzUHdZMVRLTgmd3zWRtAfxkeGH+yah+jC6d0H9Qdui6hlnwFwAecl
	bvk+gnlKIT/BUQfPRcHsSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769447965; x=1769534365; bh=J
	crgn9W3fAKMeRKl4dFn73q7qnjF+JGo1aH+LhY3nyo=; b=EOz19Z0L3CxqoBy7G
	Rm10S14991NJYog53gqW6bwfGQf8Uh7qo3AhbsxJvs9frG25rXsiRwQJ64j6z1iS
	KoULRWiNcJcTD06md03o4kxQXt5hCFi6Y7UVyBXbuDs34CD2/GDAMMmdMTYt3+AV
	d5cs6CPpyO3ZGsPcGZwfxetSjnaTXXFAFyOEHRhask6xjrngCksA/tr6wCw00Zxr
	0XjGy+ueEj/OHif/a+D/r5r2bnL450aFaHfnXvwU4mK2X+9EnTBcaRBMmWhQnxve
	9KD/FK7CsKTXfyrjwL00+04/Hn2GLcjFFMYY/dtkSh0bAVH0iJhvph+7GuSG4upj
	Z4JEQ==
X-ME-Sender: <xms:HaJ3aUWIMPXPnOTs73pD1e5PO39DjuQuinu9a2c8Qib0fUBORw41JA>
    <xme:HaJ3aemiR04IRglqkVj3YypU47vxvnvwykmtLEOs6PsgdL8ARX6QXDlnsYs5RfXN5
    xW8akbG8dQ_2zTCyWsobta3f85pgA9qAg1xODL9J8D_Nt7BRe7K674>
X-ME-Received: <xmr:HaJ3aWCp8iG52Dmm4z-qoFhNeof46n7UIn58nanmnLCHo_Z2wjN6aLZnoN07ZQJQNILJeZ1P2SyHlkNDDMmm6IR0MJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfevtdeuffetleegfedvleeggeefkeffgeejgfffff
    eltdduleelgfehveeuteetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtoh
    hm
X-ME-Proxy: <xmx:HaJ3aeem2ATfAmH8iilyeK3W6ruLI0nHdkOLA8Kh8kJ-KOxa519o6Q>
    <xmx:HaJ3aRIY7c4MwG4L8DJ5t7OpMjXsEk4l_9VrnApTAr0Z1czeWZwVZA>
    <xmx:HaJ3aRdXw4jkDDtId4YD8t74YEJITweBlJ4oo1nzX_iONY6N61cEmQ>
    <xmx:HaJ3aY1xM9L_y_yAeKwnYIEsUY8Nu0VJqg9zQYeRjMJowFv2Q8zzhQ>
    <xmx:HaJ3aR-Ulu1eLGB6rxCSFYnzNdzaiPVvzgv9zaMtfLF0TqFae24LfPZ0>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:19:24 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs: forward declare btrfs_fs_info in volumes.h
Date: Mon, 26 Jan 2026 09:18:53 -0800
Message-ID: <4c839922e88a33145eca264394ff8aab08c0a871.1769447820.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769447820.git.boris@bur.io>
References: <cover.1769447820.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-21068-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E21AF8B652
X-Rspamd-Action: no action

Fix the build warning:
In file included from fs/btrfs/tests/chunk-allocation-tests.c:8:
fs/btrfs/tests/../volumes.h:721:53: warning: ‘struct btrfs_space_info’ declared inside parameter list will not be visible outside of this definition or declaration
  721 |                                              struct btrfs_space_info *space_info,

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 8cb72e84dc84..ebc85bf53ee7 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -30,6 +30,7 @@ struct btrfs_block_group;
 struct btrfs_trans_handle;
 struct btrfs_transaction;
 struct btrfs_zoned_device_info;
+struct btrfs_space_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
-- 
2.52.0


