Return-Path: <linux-btrfs+bounces-22167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GerCGuPpmnxRAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22167-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 08:36:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B361EA39B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A20C308ADF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD337FF5A;
	Tue,  3 Mar 2026 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3w28i0C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE80379EDE
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523293; cv=none; b=I61EimQiO2m4UM4/3R7l0S/5wlFrqMxxRjQ9P5v8mcfQL+Z6kyFVyfEy16jMBw5SqOjclNaeA/8D5cJXLel/5k8ci4QME5LRAZ9xIQoSIP9lvZIj7DfYBuT0hvYndpoHci4f0j0S/d5LpmwqvUs7NhWTX0A7eawwRSMNEWTKTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523293; c=relaxed/simple;
	bh=gOHJTDQks0KzHN8phSZJOBiVNaXYRaSSSkhv1OY5TVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6qDEyCc3QpUM2WhioY+nJCTM9CyJ+lYDcbz4xMCc436dMBX7bTi/7bt1Z/+Aw03Zirmg8Jd6Xuz0H7lfolF1vrwCw9YVdqJzqWkQhhD+jX4xl62Mb7+ShNex76nBKtcvNPL3uORCimBB2oDBk/BhaWOSUiKes9L6YNK1AsnKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3w28i0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B0C19425;
	Tue,  3 Mar 2026 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772523292;
	bh=gOHJTDQks0KzHN8phSZJOBiVNaXYRaSSSkhv1OY5TVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u3w28i0Cq4TzzaBwu/PxoYvFKRQqbs62xjmQ+r2vsofUNB1o7+olmRojBwOY8ohX3
	 teEqwEfIGsNnOj01Z2r7nyO2i/hhyEbb29SS+xi4n8K+iBGNb705dQhpOqbt2orzIC
	 X1uI52epKKlG9POelp5yJbILPyJpFCtNDqbvomnkHmWaDa95jhEddIOwoP0T+2NmHI
	 hwcdq2GvSQt65tlmr5OuYsk0OB8Cte+MwKkP+GtWK6HtUi/gL4Cl8Zg7GoQjPBS391
	 ORieMcqgMl7JfUPGi6Hip+B8oUQOdc5MU81YWrLC98B6Zac3lraSgbPmZJao6mC1e0
	 6Ef72PAqTd0kQ==
Message-ID: <8ebff2b0-9150-4a5e-b3fc-0918bb93ccc2@kernel.org>
Date: Tue, 3 Mar 2026 16:34:51 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: create btrfs_reclaim_block_groups()
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
References: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
 <20260302143942.115619-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260302143942.115619-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E8B361EA39B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22167-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 23:39, Johannes Thumshirn wrote:
> Create a function btrfs_reclaim_block_groups() that gets called from the
> block-group reclaim worker.
> 
> This allows creating synchronous block_group reclaim later on.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

