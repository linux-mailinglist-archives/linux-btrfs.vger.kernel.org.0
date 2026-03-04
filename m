Return-Path: <linux-btrfs+bounces-22204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPc1GBClp2nTiwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22204-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:20:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D059C1FA48A
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D45302FE8E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C43659E2;
	Wed,  4 Mar 2026 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m37MYBw7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zi2CtOi6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m37MYBw7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zi2CtOi6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE193385B6
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594444; cv=none; b=dzcruPCrQgJMJZ7D8CJyygcPcu/POPl4gbxORillnJKbKlOQDWtyZbHGOZD3RGRLsPYmkKsEqRZhw0uTe+QQTQNcavtkDaD1aYRNCW8+qp/BazBjF32dDlkZzQgd+r74CR+BfOj23W6PwD87dxYn9AGg8yyY4QbwJV7dBUuTga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594444; c=relaxed/simple;
	bh=fkeOLhUG8ATdB2uqZl7XtYx7f7teZcc9mSUZLDYm68I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0ZLuyK2dNX0nqz7Qd793B5DOYXVh+uIBBdB9LdK1rKaKtDFtTljriLD8/jzGCjkLQ+JW2B2XdqcIo2X+BTUEI26AsHcbOWGNmFXCqSn8OKU3+sDlzDuVUDROpj2ZHX0M2NJfUdM0fZbjzV1Gu5CTgQ19nnRRPBUzfSEHZD1+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m37MYBw7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zi2CtOi6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m37MYBw7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zi2CtOi6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FC1B5BE29;
	Wed,  4 Mar 2026 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772594436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WccU0OQY3IzjWSnrxKDCtXo9Z10h/rcg7h9cMTNMxLI=;
	b=m37MYBw7RjUfKXNU6rdWJwE9ZTjbpwQ/28kk/sr88RVK+k66CLDEqTcPuX8LWpKqMFfodq
	QQZCCxJUE7NKukKuZ2hVSsIWD66uMWc6ra1ACkPo4/5EW31Jd8enUqUKTfrt3iG2yOOvPx
	CQv2SmZLlR1VSuzp8xHhlWvUCPcxyxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772594436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WccU0OQY3IzjWSnrxKDCtXo9Z10h/rcg7h9cMTNMxLI=;
	b=zi2CtOi6ktRv7P/0AI5MMaGZBBWV/lxDFol4o6OQliumLIwBHVOQAuojY675jKltDe0eCS
	v+5o9Ec1l11ZlLDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772594436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WccU0OQY3IzjWSnrxKDCtXo9Z10h/rcg7h9cMTNMxLI=;
	b=m37MYBw7RjUfKXNU6rdWJwE9ZTjbpwQ/28kk/sr88RVK+k66CLDEqTcPuX8LWpKqMFfodq
	QQZCCxJUE7NKukKuZ2hVSsIWD66uMWc6ra1ACkPo4/5EW31Jd8enUqUKTfrt3iG2yOOvPx
	CQv2SmZLlR1VSuzp8xHhlWvUCPcxyxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772594436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WccU0OQY3IzjWSnrxKDCtXo9Z10h/rcg7h9cMTNMxLI=;
	b=zi2CtOi6ktRv7P/0AI5MMaGZBBWV/lxDFol4o6OQliumLIwBHVOQAuojY675jKltDe0eCS
	v+5o9Ec1l11ZlLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D893EA69;
	Wed,  4 Mar 2026 03:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62G4DASlp2l8VAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Mar 2026 03:20:36 +0000
Date: Wed, 4 Mar 2026 04:20:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove the alignment check in
 end_bbio_data_write()
Message-ID: <20260304032034.GE8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1772525669.git.wqu@suse.com>
 <51818a7c1233086fe42a3e7a18cf6a144ef14513.1772525669.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51818a7c1233086fe42a3e7a18cf6a144ef14513.1772525669.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spam-Level: 
X-Rspamd-Queue-Id: D059C1FA48A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22204-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,twin.jikos.cz:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:45:09PM +1030, Qu Wenruo wrote:
> The check is not necessary because:
> 
> - There is already assert_bbio_alignment() at btrfs_submit_bbio()
> 
> - There is also btrfs_subpage_assert() for all btrfs_folio_*() helpers
> 
> - No similar check in all other endio functions
>   No matter if it's data read, compressed read or write.
> 
> - There is no such report for very long
>   I do not even remember if there is any such report.

Going back in history the first warning was added in 2013 commit
17a5adccf3fd01 ("btrfs: do away with non-whole_page extent I/O") and
then refactored a few times. The changelog says

"   I've replaced the whole_page computations with warnings, just to be
    sure that we're not issuing partial page reads or writes.  The
    warnings should probably just go away some time."

I've checked my old logs, no hits and neither on a general web search so
this counts as safe to remove.

