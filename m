Return-Path: <linux-btrfs+bounces-22066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEjVMKWcoWl8ugQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22066-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 14:31:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED11B7AE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 14:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8873037926
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACB2857EA;
	Fri, 27 Feb 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+H7jAzE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74A19755B
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199067; cv=none; b=Ra9m3dwfxjKOkrxYQEbaYHP9o+ZNGtCT8VB0wbe0WX5JgIXJ5S/eDZ+kAFHfm56NvWPfjNifOjs92RSWv/RgRcsye9Ep/isLNhMvNYIvvZy1x0cv0XtXLOsuWjSSJGkr+kQ6ksNb6RvmmFPqMbwNfbNDvSMswN/b+YZ71+80aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199067; c=relaxed/simple;
	bh=QA5bnNam1kU6vWzWgqPQu1A1iNsCY8+lB+Yy1q1wmkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JDPPbTw6XbLk2mJaQtKTCMAkIWECZMAY8w7TCQ9wWg36jOoZsB17yWZ3xe9dv6HPk0ObsGR+xaZXsADSdQ5fIrAZntD5C5yv6JSM2oRrcJne0IC6Sp1srHavccoi+fwHFJ1JTIQiruOzODBs21mRBwZ2Pthq3fgbj5G3bL2J7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+H7jAzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F10C116C6;
	Fri, 27 Feb 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772199067;
	bh=QA5bnNam1kU6vWzWgqPQu1A1iNsCY8+lB+Yy1q1wmkM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=J+H7jAzEeSXl9G/bRG1Gmq4GRSrIZbf8HOQLVO/tbmrOS94LB4I1AAATVXEBMKsqk
	 ZNN23EnjilRHQpTTXAcJfXSOx9/1e3gislVSwVI4po9vA/Zf3wqQ7GlTbJNK5WA5Bd
	 wFapI/p8m0nzbEmj6Xug+iBj9Cfmdvqz2G0bNQB6gsZ5somf73jaax7ZEIv0WnwSTp
	 QGuc5CRfJjDqOvTrIWSDv6Hl8s1uEe332KWu3FKiAguFUXqdOWPqnIgO6CGmDGDAKz
	 3gxQPz9Jw9EefccO/0KnfNOBFbjsYY46ds73N6oUK88nEOgwY3t9ao3+u+JLeas33F
	 ZNhFOjLms1G2g==
Message-ID: <0ed215c2-39ba-455e-9750-7f99dbcfe88f@kernel.org>
Date: Fri, 27 Feb 2026 22:31:05 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: pass 'verbose' parameter to
 btrfs_relocate_block_group
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
References: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-22066-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CED11B7AE0
X-Rspamd-Action: no action

On 2/27/26 22:12, Johannes Thumshirn wrote:
> Function `btrfs_relocate_chunk()` always passes verbose=true to
> `btrfs_relocate_block_group()` instead of the `verbose` parameter passed
> into it by it's callers.
> 
> While user initiated rebalancing should be logged in the Kernel's log
> buffer. This causes excessive log spamming from automatic rebalancing,
> e.g. on zoned filesystems running low on usable space.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

