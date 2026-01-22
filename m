Return-Path: <linux-btrfs+bounces-20884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFbyIV6AcWk1IAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20884-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:41:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361760725
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 956674216A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4634F482;
	Thu, 22 Jan 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uEyZ8h6W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RWNSEH4Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0cOYI0DA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q949vMb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F368350D5D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046039; cv=none; b=EJRT16mcnBdVbEk5XOsdgyPf+4e4hKqgRejtDzA+cYNQZen7a8UNKuO53sWLrdlZrHaGRkdN1TtnGEoprDOeGqzpEOQG9fMNP/+3WvHRUUPjwhx6hr5AREyHhIhlOOqUYFfuecsErgkQmPy7c4yOEhSgvdxkd2rbD6WfV1f4rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046039; c=relaxed/simple;
	bh=LlXPMr1teDQsXQM/wFsmbrCVFOjw02Y/aSIlNJfLL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqTnK8HV12amviGCVPGpEZJo85jVF1/XxtWoPtoDhTQK0WzpxisrbSaEYDQH2EhJ7FKGAqWphUQExRZDuDcmKYTYXC/k4/Ee+VIEdxdlIYDeu33UgvUB2IPcfVyJ4W/E5y5qZaEgVJFUakAgLdR4646lFqXZRXenfN9Cus9Lpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uEyZ8h6W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RWNSEH4Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0cOYI0DA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q949vMb3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FB1E33698;
	Thu, 22 Jan 2026 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8NsrKwm2CdYMFVTOWa81azdU9uPHTi0NdKdnz7Lzx4=;
	b=uEyZ8h6WTh+dH7EmBdGFK6Deo4a/0yIy2traeSclI2As3KQZzupZW25/qp8HPDCh+ZgO5Q
	0pzQfA0GMfWEh9SlQKMqicy7S2NsRcIxH38gonmPrPAxQtZAExDT96Cf91oFxnWR1NFWP+
	JJ315aY7baxTfVQb8usBn8nvVWe04FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8NsrKwm2CdYMFVTOWa81azdU9uPHTi0NdKdnz7Lzx4=;
	b=RWNSEH4Z5oxwfmKrxcHhyCaFrMh5cMMFS3OoiFKoh39DKw/ebo30Upgqtt7IQFjWUJ/9Xs
	nNltgl6D2je4BrDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8NsrKwm2CdYMFVTOWa81azdU9uPHTi0NdKdnz7Lzx4=;
	b=0cOYI0DAA984fOu0twyCDW7kk3HdyMOUFrHLylZp14eD5bvOnXHQy6PfiFvpSbvDmSqxOr
	zBAQ4QecJItnE7Ko0qS9pxNDX6HCB3br9LYX1lIgLWi2GTUnzJYvJ9cmozGjaMTpk4co0S
	Jakcc5RGV2MfB3awOG7VWRwzVKVAsWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8NsrKwm2CdYMFVTOWa81azdU9uPHTi0NdKdnz7Lzx4=;
	b=Q949vMb3yzOIJiZj7njKLJe1geLt2ApX47hFnVA3McSpljA+y9KUyHDdtdaU3RQqfV6Ko6
	mXqP80v/PQcVZ0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 524093EA63;
	Thu, 22 Jan 2026 01:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r46eExKAcWkgbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 22 Jan 2026 01:40:34 +0000
Date: Thu, 22 Jan 2026 02:40:33 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction aborts in
 btrfs_finish_one_ordered()
Message-ID: <20260122014033.GS26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-20884-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,twin.jikos.cz:mid,suse.com:email]
X-Rspamd-Queue-Id: 3361760725
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:40:45PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a single transaction abort that can be caused either by a failure
> from a call to btrfs_mark_extent_written(), if we are dealling with a
> write to a prealloc extent, or otherwise from a call to
> insert_ordered_extent_file_extent(). So when the transaction abort happens
> we can know for sure which case failed. Unfold the aborts so that it's
> clear in case of a failure.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

