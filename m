Return-Path: <linux-btrfs+bounces-20874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIrsDgNMcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20874-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:58:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE045E646
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54E893ECE75
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4343D513;
	Wed, 21 Jan 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="G/YJ7zOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGlabDn9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30443D4F7
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031779; cv=none; b=KbxNKL3Sy/9qvct1Bv1vv14NKnwK6n4THHHIlT9IkMgNLaBppyXZagiRtWm88Bpn2fsxSTb7OlCZvapi2oeFET+R2YSFCk8EyVyo8AGvZfFhEASPYvE4l3kSvwdm4UUMfIJyTV8XOvGJUzC2rDTC31Sb6HOQGz3FDyzvdN/S3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031779; c=relaxed/simple;
	bh=bcyJsGL4GK/xsddf0/qhrySUAREzA9ZjNs2TL15PN44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0zOG/PFN8cf4XQ925+/k2c7Bfq9UsBZVd5lw5tTufiZUkuMjO/Og7Ih9LiACQNj9+wbK/F4INzr5D4uRUWAcfdFJnavc/WagxFis059Y8QRbF4tdfxDsc6uL79yM0kE/Lqk4M9dY+ZuphiJ7uzbceXN8i5890VQ/SpflLJMB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=G/YJ7zOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGlabDn9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB3B31400081;
	Wed, 21 Jan 2026 16:42:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 16:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769031775; x=1769118175; bh=bN6QM7YDe8
	OPtKcBnkCbJxnLqAhhKAbLnLEpLMrhHOs=; b=G/YJ7zOwdnuOzxglAnHAzONGTo
	goXGrahKzl9SeCVuSNTPPOX7K+sxpdW3DGIkv/XRMKEA6/oh5WB3GSpw4nzzgbG+
	B7+UZyFQgq72zgAF73hwBZyKErVGnpGo/9nuHYScu9UzmoqWmUQkLhtPjrqvYDsY
	EH03AffZM9wKUn1Ja6a44sL/HrxFKLPKAVfKatPlHNudmCQLK/wbjFy/V237Yx+/
	e8b0SzNeyiexc1AHU2nU4WVAwXWJsFMZN0erl43ay3tlFpwoa9oglymKU7TYKwsG
	JmilxEhcxWfNJjazkS3hdKew6bPz7IcnSNNMHlTuA7TFSPGoSHjofcDxzPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769031775; x=1769118175; bh=bN6QM7YDe8OPtKcBnkCbJxnLqAhhKAbLnLE
	pLMrhHOs=; b=MGlabDn9voe8IPL22lrtV71aHIjB6cgtS6PP6TGikEJR2EC1Bro
	pAbVFuJzawR4I4QlDOygIyNdjCxZ03wzPLuoaekjavdJqgWVN/mw6KK95mUGacn1
	dwkxr2gnMnrzwfUhbuMt96Q6B+qg9VGNjbJj1ME1KM/tJTeSYfcRcPw0pxmuw9JL
	MBeQTerq/9eFCUkBIm2QoD/JXka3JrhNAjNZpt6ruKCY32kDZSMmiQ964DxKzqWu
	nLVABrW44UQ1Y2lkTF5Nn/MTfnZlys5nHFvoCX+vRJESSF20U4J76PV3rZ39zocc
	ysDKhP8ZoU6Y0GxJQg7TdYI6I0jfpAdNPEA==
X-ME-Sender: <xms:X0hxaTm48WmtpxdB6hSLmtxhIOmUiS5e2jb8EGDV2i7cx2ryVLLbxg>
    <xme:X0hxac1FjmLvsxDF5bdBCc2SwVkgJV1IcVuXzPJLkuSwf2eHeykqZg0iBRw1OodGG
    HdhrI5Rd0ZhDAF3ha1a5i5N8t4fsNjyr8E08S1oJsRtDYtX1R61rQ>
X-ME-Received: <xmr:X0hxaXTcjhwJVOmdKb8g9w4GHs9rCZUsReHKMDH51cYD0PiPGBP-2BUs2XymGSDchTTKGi50xIMj-FPq8aoYAdPoY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:X0hxaWtern0graKJGQvp6oyOSxCZWnDXbKCl93kkm5PR8aAW4c0uLw>
    <xmx:X0hxaUbTfOofJeehVpjJ207Fj6YWmgnczm7vbnrq5Zvh1JQmMUn24Q>
    <xmx:X0hxaTvEFhN1sE5vC_Wzrqzg0OVeQi-LgQIPccIqgb6FAMK9eq8T6w>
    <xmx:X0hxaeFB94Bqe4NhmuXR3xsGuDpbHxift1RSnf3mD_mByvdb0Vws7Q>
    <xmx:X0hxaX4zCPd3zzWPPzkoa6XKXXoIUMgS-9vAOq-EVGW-GCfhuiV_eZ3T>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:42:55 -0500 (EST)
Date: Wed, 21 Jan 2026 13:42:41 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: cleanup and fix
 sample_block_group_extent_item()
Message-ID: <20260121214241.GC1432482@zen.localdomain>
References: <cover.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769028677.git.fdmanana@suse.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20874-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,bur.io:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zen.localdomain:mid,suse.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: BAE045E646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:52:36PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial changes, details in the change logs.

LGTM, thanks.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (2):
>   btrfs: remove bogus root search condition in sample_block_group_extent_item()
>   btrfs: deal with missing root in sample_block_group_extent_item()
> 
>  fs/btrfs/block-group.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> -- 
> 2.47.2
> 

