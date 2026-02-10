Return-Path: <linux-btrfs+bounces-21612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ1uMlBUi2kMUAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21612-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:52:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5B11CC5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9479230405CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242236F403;
	Tue, 10 Feb 2026 15:51:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CF6F2F2;
	Tue, 10 Feb 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738687; cv=none; b=nVK0D3rkcMCstZUjfRpCknbKtWX8scdXN+a8FkEiHg4w6UEOl/1l3/0jNatFdxPm9ZOieIM3KmdXq9MHLBc5xsSBkOgP2JOvLLXAW6wwyob3l65uEwbfuoljnrGHDR+nQiwgM0cO5dMa73y/4Nwnjc1BjAhg4W+j2ZibW4uow9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738687; c=relaxed/simple;
	bh=jgYnLxMrUYl9JfsyQ0hIBmj851BJ5k1XLeSzSPI3zzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InVw6DzOQ2pKo3IUqCTwfMtXcxCOSbhjzfJz5iaeNuZemGQtDGuVOk5PXMHleT8FZEc1FfFEpEpt/MsfhZ+FHD2Sx0NdOIqkvu7ojye/M7dpIHkUwj7QCdzINPQQljUS18oDAaL+L2fXHvvVM7mA3kWTGRujTq3DOT+D5r6Nb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD42B68D1E; Tue, 10 Feb 2026 16:51:23 +0100 (CET)
Date: Tue, 10 Feb 2026 16:51:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260210155123.GA3552@lst.de>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21612-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 60F5B11CC5B
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> diff --git a/tests/generic/783 b/tests/generic/783
> new file mode 100755
> index 000000000000..f996d78803a1
> --- /dev/null
> +++ b/tests/generic/783

What tree is this against?  generic/783 has already been added to
xfstests in Nov 2025.

> +if [ "$FSTYP" = btrfs ]; then
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \

Can we please finally clean up all this mess with a
_fixed_by_fs_commit <fstype> <commitid> helper?


