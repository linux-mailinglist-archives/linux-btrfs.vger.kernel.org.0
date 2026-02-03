Return-Path: <linux-btrfs+bounces-21330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wExFMDlSgmk8SQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21330-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 20:53:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32341DE467
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 20:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088E53016285
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B0366821;
	Tue,  3 Feb 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZImnLI6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268622D795
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148401; cv=none; b=rj9RwQNASVoVy+JXprnPXXmhP7YuEsuvmt6bcgVov8fUWD1EeXPsc4NwrQp/gMTPOW4GLSgPQB7AA4e3kHqX0gYEeErPfjky8O0HPuYuDMRD0G14zrpbOIzRKElDo75G2p1PZ0GLvlpLaK1y6SvkBXMyEWELxofBtDmdpRc2VAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148401; c=relaxed/simple;
	bh=khH7QA4JpNoATPTaEJB/8OeNhyjyp1TV57kf1jt2tPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAuZcgnghtvfkOmTGxk8XjUzjuVol9rlsG4XrwjM8Mub1LZS1XD7nWQjK6ni4uVHgJHCcoyWWxL739X9BNgZPTuBEssjwcxZ2dGCkzIh95+esMFLdrXsKvY/SZB09Ucz449eROJhUSHNJZVhf7MuFWfI+D8wLjiTbmWV07Dp0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZImnLI6; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6495d592c10so5503543d50.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770148399; x=1770753199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is44Zkl7T4nJa6iq4/zjgjXseatB4mQazocrAjvynp0=;
        b=QZImnLI6vKfCjLcXGQpCGvJbEB936exX+Zi2OrhXDkHI9eXfjOS8Df8jvHvhGr1dug
         lAKQg2XXlJ2BhvqqxgPRdFJ97MfDzgUJEcqu7hWIfYK1GhcQD+w1ZISqTy+mDQdmyJ49
         fvFdAPKT+tm6wt3KcOhNB3psLtxNfa/fXijNVWx5cynxsOsjdPUooDSTuF/lqObErCio
         ikEPqVBVgyWHcPWvetvTI84Rvgcyg5Ru7gicxVgpfbU5O5FZO7qGbC0gg6XRS48xzV7i
         Svh1Z1NP4ZFWZagnteoj8H7XXGdZTycXx9tasJZknaw7jGB3gWMCDd1r4zFF6Sjn+/Tu
         a0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148399; x=1770753199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=is44Zkl7T4nJa6iq4/zjgjXseatB4mQazocrAjvynp0=;
        b=jheVCRBcT5M6pv/aMEJst6e+KGCk7LC8wxdadTNOrY2kwLQdZA2zur+oD9gYcL2Ido
         eemvn38TVCFbMDigLGoTlf0aSXzO0O8RtDg8f1LMNCopf6K3Apmr6inYsKDeHCdNtGq0
         DwYkIjn87tFj9++WJEITqFd6egzv/PA9+FSU2DBclx2ecAbh6aO2IKSDyqCIa8bV+3Qf
         wXPOHQZe1GomaZ0ZzrdC5VShlnybjqL9VsUMFvYCyxzxLOAItTy0BBMc2LgPse1geRlK
         kOsILAqW8tHr0+p8bNBF0OIbiSIvXoamWJzuREWlNozw8igN1A+9Z+ZcAb8Or/HedPOS
         LxHQ==
X-Gm-Message-State: AOJu0Yz7U06auEl4Nqr9zq1iEPv+RoLMlKTH65U2YToS19vVlDjxpt0s
	+xM+I1FwTcutBlVLSATNJg679R/yax87S4+aHM6pV9/oSR09vukeGARs
X-Gm-Gg: AZuq6aLs1YCvg5JU0ZzD2OpxdK82pTNFfiTX0zTZPe1arCRZ3IyDsNAMy6KCDI5GV1Q
	XTtDeS8SEqbr4N0uQFeq3UAOHvgJMNBG2K9rTBgT4DaqGuLwBXw1ZQ1Rb8TaoEcuPRMlU4B18Of
	1ydJPPmQ+9CHvSeE9cJgLJ1ffK9vM/v+eRrzjIi8z9bEL2kG7FVAry/+E0tQd+BmFDeRf2thS8M
	V1YkVDCw1XTeJReKEyztsJbd3waaEIauTu73LAHRDyEZmMwLp4104gFS3bWhYecLPBRlAiSwHDH
	KTjKPYDQOnLKtnh9Q/5xNiF7kBQej3oFFmxTOhHeNVH5ZeqCYGTYxDWdtzQNYolnLGp13c4Rx4i
	oX0D9MTD6ynivMZjG6BseN3m4xrneXJ+1PeA5v4ug4LZ+yBSR3IIDKUVZHkejzDW04gwGqNzGms
	aKmc09
X-Received: by 2002:a53:b252:0:b0:649:5789:deb with SMTP id 956f58d0204a3-649db4c1162mr490891d50.83.1770148398799;
        Tue, 03 Feb 2026 11:53:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc494629sm340995d50.2.2026.02.03.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 11:53:18 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: don't allow log trees to consume global reserve or overcommit metadata
Date: Tue,  3 Feb 2026 11:52:52 -0800
Message-ID: <20260203195255.201241-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2e171d116e186d839cde6430cb42551aaea5943e.1770123545.git.fdmanana@suse.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21330-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32341DE467
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 13:02:32 +0000 fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> For a fsync we never reserve space in advance, we just start a transaction
> without reserving space and we use an empty block reserve for a log tree.
> We reserve space as we need while updating a log tree, we end up in
> btrfs_use_block_rsv() when reserving space for the allocation of a log
> tree extent buffer and we attempt first to reserve without flushing,
> and if that fails we attempt to consume from the global reserve or
> overcommit metadata. This makes us consume space that may be the last
> resort for a transaction commit to succeed, therefore increasing the
> chances for a transaction abort with -ENOSPC.
> 
> So make btrfs_use_block_rsv() fail if we can't reserve metadata space for
> a log tree exent buffer allocation without flushing, making the fsync
> fallback to a transaction commit and avoid using critical space that could
> be the only resort for a transaction commit to succeed when we are in a
> critical space situation.

I agree. I thought it might be an interesting idea to use an
allowlist vs blocklist to be extra explicit about who is able
to use global block reserve, but it looks like the log tree
is unique in its ability to fallback from failing to reserve.

Reviewed-by: Leo Martins <loemra.dev@gmail.com>

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-rsv.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index e823230c09b7..fe81d9e9f08c 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -540,6 +540,31 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
>  					   BTRFS_RESERVE_NO_FLUSH);
>  	if (!ret)
>  		return block_rsv;
> +
> +	/*
> +	 * If we are being used for updating a log tree, fail immediately, which
> +	 * makes the fsync fallback to a transaction commit.
> +	 *
> +	 * We don't want to consume from the global block reserve, as that is
> +	 * precious space that may be needed to do updates to some trees for
> +	 * which we don't reserve space during a transaction commit (update root
> +	 * items in the root tree, device stat items in the device tree and
> +	 * quota tree updates, see btrfs_init_root_block_rsv()), or to fallback
> +	 * to in case we did not reserve enough space to run delayed items,
> +	 * delayed references, or anything else we need in order to avoid a
> +	 * transaction abort.
> +	 *
> +	 * We also don't want to do a reservation in flush emergency mode, as
> +	 * we end up using metadata that could be critical to allow a
> +	 * transaction to complete successfully and therefore increase the
> +	 * chances for a transaction abort.
> +	 *
> +	 * Log trees are an optimization and should never consume from the
> +	 * global reserve or be allowed overcommitting metadata.
> +	 */
> +	if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
> +		return ERR_PTR(ret);
> +
>  	/*
>  	 * If we couldn't reserve metadata bytes try and use some from
>  	 * the global reserve if its space type is the same as the global
> -- 
> 2.47.2

