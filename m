Return-Path: <linux-btrfs+bounces-21191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE/OGFF4emmE6wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21191-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:57:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F005EA8E2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FE1306825E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AA37647B;
	Wed, 28 Jan 2026 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD792+R+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333332F75B;
	Wed, 28 Jan 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633612; cv=none; b=lnEDuOq/HsRAlEE52UKklHEz1GUXYVFgvYpALThAlWedh6CY/NbSTPk1+picGMFulgf3VQIdrwjlBRwEC9qpxPicMeafqcIQvhKtjHDM6SIQZc45SdL0sZsZHlLTsr7xfj21RfQExLgoCPZWGk36v2D2WG61mgXW/uJXAjCYrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633612; c=relaxed/simple;
	bh=oaPyHJVoqafuwvfzUI+30Hd7phkVZf3qKG8N8ROV87U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttt5ltQheM0LNCAa1xXd9h2/hU33cS25XIZRJaNtoe9KAA28P+SqFMmYzN51dDdJuuzLtSGTCWBm/dyurEJ0tV4ENo4ETM33s3b88vucwNUx0885sD4dUX582EUlMrri/qyVyDsM1UN3NAKbcxTW9tBIZ9l81cCVEHj/XZQ38e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD792+R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2FDC4CEF1;
	Wed, 28 Jan 2026 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769633611;
	bh=oaPyHJVoqafuwvfzUI+30Hd7phkVZf3qKG8N8ROV87U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD792+R+3FhCEwifLo4OTg1MTsqXNlWnq4wA3NjBDHtfQhBg9RuVsR21Nv99dMCin
	 6zi62DgaDAiCnU/zLbcmeF1dGUK3xoeR3PefTRCKREu7ZSjqPk8VHmyt/ueR+PLvV2
	 O36qCsbVyvqoyrzqN1NEKLdB/SccXKYW888duM8hleEQRQPIH73DL+UZtrYpAwRDYa
	 hUrVp9k1yG4NPrOmOR8zR/dvvgnwu09xSi9lOsZMTo1zd6+DDlo/t5me3Eo9NbPg4T
	 Nkzh9LvfSD119Mc5frXudTbPO/gh9OZIOCTl2/6U9KaPkPJceHz/XACszXi6Su/A4b
	 qvqZftnuojanA==
Date: Wed, 28 Jan 2026 13:53:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@meta.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] block: remove bio_last_bvec_all
Message-ID: <aXp3SZdfHA5NYhz7@kbusch-mbp>
References: <20260126162724.1864652-1-kbusch@meta.com>
 <176948707247.253132.515140634443961704.b4-ty@kernel.dk>
 <4fe6a07e-3387-46bd-bbef-1a929cede082@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe6a07e-3387-46bd-bbef-1a929cede082@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21191-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F005EA8E2E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:11:32AM +1030, Qu Wenruo wrote:
> My bad, btrfs is recently add a usage of bio_last_bvec_all().

...

> So what's the best next step?
> Keep the old bio_last_bvec_all()? Or just implement it inside btrfs?

I noticed it's currently unused because I was doing an audit of bi_vcnt
usage. There are new patches that bounce for stable pages, and the read
side does some clever tricks that make bi_vcnt not always mean what this
function expects. As there are no current in-tree users, it seemed safe
to prevent any potential misuse by removing the function.

But if you need it for btrfs, I think you should reintroduce it inside
btrfs since I think the fs would know if it's using the iomap bounce
helpers or not.

