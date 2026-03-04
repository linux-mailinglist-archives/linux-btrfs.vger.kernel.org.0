Return-Path: <linux-btrfs+bounces-22230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G/gBvtSqGnUtAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22230-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:42:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E24220305A
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B99C30DFD65
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5608933C1BD;
	Wed,  4 Mar 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BxpFnBOw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20033F37F;
	Wed,  4 Mar 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637937; cv=none; b=q6J/oF2iJ8Po/zvgcGz4m/ZzwhEDfQeVQUszFEtMO32snivLS/Ob76KcWtxZvmKOxOXmS0+1VzTTFjfEq8lI3EAp1hTjxj0vxB30/N6TCHpBrYa/9Ls+1bE/yaroU9CDnR0u8xMdwlpDBJVNh0iRmCSC1FbMdH9B05AB9s979WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637937; c=relaxed/simple;
	bh=3TMcHI3fpBXUKGV1pTVwgnH6e8rfMQ03ftP6Od4ORtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+r1id6Gy9M2+/bdyBCz9LLA1p/UxPbmbqNwsvlT1VnuDE87o5Nv/FHkG//Xs1oE/bkmLom35cbT1FlN2i4DWMZLolwqIUJ01cwNkioBEG+sqaYJvVklG1Jq25x5ZMdmbKR/03kjRUo6+ndxJg93WjtG/cEolIDu7IuDs4uzleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BxpFnBOw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwsrxkPOXCaYkQX0joRl0M8XJJY5G8w37JtoiYGpkHw=; b=BxpFnBOwTfdz6+tAMVJtZ+EGtr
	/nLSq3ik6/oKx9A+1Ujp0looFVrCTaJsxpQ1dixrWAqfObLrOM6aeWdtDj/wqA3X9I7bfpw62DMv3
	FDq6IO0jhJcpwVJqy2+ceJXuI/n1o0aeEfRjrRLFdo1ssDaRzucz4y8OGrLQDJDw4ejPJOT0fPneU
	RawkaeEkEVterh7YZfYywjnQWezyQkeK31fd2NiTA+pWeOrs81JLKH/sOCk+tOJf7JzrYMXLvjiKs
	Vcz0hgbeJmvyWsIgN+i2LaE2DYsJ5hmYDJvPB1n2kYbd9Fe/LCJHMmyQJE9RdjeOwF6U6x5YO2XS+
	pdYES3oA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxo6Q-0000000HXSZ-0pJa;
	Wed, 04 Mar 2026 15:25:34 +0000
Date: Wed, 4 Mar 2026 07:25:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fdmanana@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test a directory fsync scenaro after replacing
 a subdir with a file
Message-ID: <aahO7rnnaYg2MQ1o@infradead.org>
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
 <aaguMUK6TgYfwtZk@infradead.org>
 <20260304151800.6qkmxjsufen7sbq4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304151800.6qkmxjsufen7sbq4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 9E24220305A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22230-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:18:00PM +0800, Zorro Lang wrote:
> On Wed, Mar 04, 2026 at 05:05:53AM -0800, Christoph Hellwig wrote:
> > The subject is wrong, this is actually a generic test.
> 
> Yeah, thanks Christoph, I'll change it to "generic" when I merge it.

Assuming you also pick up Johanne's per fs fixed by cleanups, it
would be good to switch the new test over to that scheme.


