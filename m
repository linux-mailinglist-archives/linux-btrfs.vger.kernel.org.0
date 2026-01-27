Return-Path: <linux-btrfs+bounces-21106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAs6LgpSeGm+pQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21106-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 06:50:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0C902BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 06:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DCA43033232
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357D245020;
	Tue, 27 Jan 2026 05:49:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3123EBF3A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492988; cv=none; b=bCz9oH43ny9OrLBIY1+TvIHT/gV5RC84Wnat7uXcBfzHzzW+gwPtZvYgyO2/d9U88ByxOAdUXaMsSaz1a1Sljue3LUnl2egxdOz45VA5TDCDEiEGTBGCivTYn7XiwFv/MZFtME0lmEiH3deXyCMIXioR8gXru4M0pKJJlFZeeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492988; c=relaxed/simple;
	bh=aJRWMpR31bECKMMOQO5/kfGdTXti9SYtZHE4CjAwArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGV11dRJzmPCOOUEn6uu+RJVtRwdVOmEYkxbCyF2Pu2YcoWaliJZvaK/OXwSZI1801pN+QUj14JTjbrx+0xa+F8lU71HehDjGxwHob/6T4NP15N5PXETcMk7HufQI9oL6syAENj9S9i59+Odl2gT1qrX2K5E3YBjRSmcQ9E+7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B558227AAE; Tue, 27 Jan 2026 06:49:44 +0100 (CET)
Date: Tue, 27 Jan 2026 06:49:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: do not ASSERT() when the fs flips RO inside
 btrfs_repair_io_failure()
Message-ID: <20260127054943.GA25269@lst.de>
References: <f21d342502c5ab027f38945fe06cda99af759784.1769491014.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21d342502c5ab027f38945fe06cda99af759784.1769491014.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21106-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 5BB0C902BA
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:46:55PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that when btrfs hits ENOSPC error in a critical
> path, btrfs flips RO (this part is expected, although the ENOSPC bug
> still needs to be addressed).
> 
> The problem is after the RO flip, if we trigger a read repair, we can
> hit the ASSERT() inside btrfs_repair_io_failure() like the following:

This makes the assert go away, and now the test seems to fail
consistently with:


output mismatch (see /root/xfstests-dev/results//btrfs/124.out.bad)
    --- tests/btrfs/124.out	2024-08-19 04:21:17.339959767 +0000
    +++ /root/xfstests-dev/results//btrfs/124.out.bad	2026-01-27 05:45:24.341140050 +0000
    @@ -3,5 +3,11 @@
     Write data with degraded mount
     
     Mount normal and balance
    +ERROR: error during balancing '/mnt/scratch': Read-only file system
    +There may be more info in syslog - try dmesg | tail
     
on the mixes size setup.  I guess this counts as:

Tested-by: Christoph Hellwig <hch@lst.de>

?

