Return-Path: <linux-btrfs+bounces-10100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACC9E790E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E41883038
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490D216E3E;
	Fri,  6 Dec 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DL/qjO2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAr9pCeR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DL/qjO2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAr9pCeR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FA206276;
	Fri,  6 Dec 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513740; cv=none; b=VPB627tRqHlgWc9YGvkCX0CvsBB7pFUxFnt0LOYdlWbLMD5fZc7Ute8zezlKcqhKT6QkrWulKHSn/OjqrnKe4l9OvaUp1Pc0HH7l6XPetCHPzOgwI+dGqGTPQeVW+F5nbSSrhcx+pVSgVdr1Cs7aDYSzR5bt7poXGViFTjRACcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513740; c=relaxed/simple;
	bh=CqzGnnq/QIuflGGemVxeISBbSrlJUijlW0rARKHNBss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q04K87m7myl1K0SZ6qiDcTUq7299GPqyxyLb5WBffQwQbPqXKqD/1GhLUfVuKHQPDI/E43XzdDhI3Mje4jwI2IjStVibc1SD/+C16FQeyNaLMTHKW+X6aaLM4gB+/vmY4+m7JdgtobCjL2ebqd1qWZSd+yxB13BFvaXuIRyz6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DL/qjO2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XAr9pCeR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DL/qjO2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XAr9pCeR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35F0F1F399;
	Fri,  6 Dec 2024 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733513736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exmmLi8UGJyWMGML5RBWITlkaIgyT3hhP+clSDASaSE=;
	b=DL/qjO2S9gKjT1fTjvCzFv1ZUD0I8m+jewY9EVEEafg8RDr3lqx1eDM1I6fyVtpkCwS/5z
	i7lKgHqBArQowKKDvaeF6/tKrVsc1lUJYjKjlzy94rnJjr/hAbaRYSQ1Ss7HG6q7WVlujN
	SmjGC+YF69QavjTESh5jGAQSHn3yN3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733513736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exmmLi8UGJyWMGML5RBWITlkaIgyT3hhP+clSDASaSE=;
	b=XAr9pCeR57LoEG5S9Qawp40609vJBMsXmy3SgBAXTouLFvK010zgE2a9HzobYK8yjjtuRF
	zus1uqp6G8AlE4Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="DL/qjO2S";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XAr9pCeR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733513736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exmmLi8UGJyWMGML5RBWITlkaIgyT3hhP+clSDASaSE=;
	b=DL/qjO2S9gKjT1fTjvCzFv1ZUD0I8m+jewY9EVEEafg8RDr3lqx1eDM1I6fyVtpkCwS/5z
	i7lKgHqBArQowKKDvaeF6/tKrVsc1lUJYjKjlzy94rnJjr/hAbaRYSQ1Ss7HG6q7WVlujN
	SmjGC+YF69QavjTESh5jGAQSHn3yN3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733513736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exmmLi8UGJyWMGML5RBWITlkaIgyT3hhP+clSDASaSE=;
	b=XAr9pCeR57LoEG5S9Qawp40609vJBMsXmy3SgBAXTouLFvK010zgE2a9HzobYK8yjjtuRF
	zus1uqp6G8AlE4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10AAF13647;
	Fri,  6 Dec 2024 19:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FLiEAwhSU2eNQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 19:35:36 +0000
Date: Fri, 6 Dec 2024 20:35:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] btrfs: selftests: prevent error pointer dereference
 in merge_tests()
Message-ID: <20241206193534.GK31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85027056-1008-4beb-addb-0bde7ca1b0f0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85027056-1008-4beb-addb-0bde7ca1b0f0@stanley.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 35F0F1F399
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Dec 06, 2024 at 03:26:14PM +0300, Dan Carpenter wrote:
> Passing an error pointer to btrfs_unselect_ref_head() will cause an
> Oops so change the error checking from a NULL check to a
> !IS_ERR_OR_NULL(head) check.
> 
> The error pointer comes from btrfs_select_ref_head().  If we
> successfully select the head, then we have to unselect it.  The select
> function is called six times and five of them change the error pointers
> to NULL, but one call was accidentally missed.
> 
> Fixes: fa3dda44871b ("btrfs: selftests: add delayed ref self test cases")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, as the fixed patch is still in the development queue I've folded
it there.

