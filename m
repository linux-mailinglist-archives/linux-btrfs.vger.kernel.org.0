Return-Path: <linux-btrfs+bounces-13036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BCA8A39F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DA53AA4CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D359217733;
	Tue, 15 Apr 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYaLJeDD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NGrnEoG6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYaLJeDD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NGrnEoG6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292A1E47B0
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733113; cv=none; b=kFh04nDKdiCdKuX1qiBGWbB33dV9ULp2Wjt53UiwwxfoNNfse2i9uiieiFxXVjiHTykRnK9nVYn91YlVW1aV117JxKx31ttBGcTcaZxJuTeGDcfj8LqzeEvrDj5oUrbE8HYTOxAZXHDvuLXfHeirePGBOlvKDdotZQJGV1oYhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733113; c=relaxed/simple;
	bh=B0BCp5MWabxQuBfWMcJ5IgDovkx0f4JNUZxiYUJMpIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT9TMmJGoO226k+CJL6N1kQw8FeZS2SB5Q5v87s2ZgYg3dpE5DUzbfAGWNgsyCDi3Lh+P6f82gJtJSJUhzYhVOiObsndj5HvuCJLsk+MrvfcmeoCxazvduYeqpRmGz10yqp1Q5NJHs0OqbEf7AKKIj9N0XBjjNbZwbAfamz4IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYaLJeDD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NGrnEoG6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYaLJeDD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NGrnEoG6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F0841F749;
	Tue, 15 Apr 2025 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744733110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWF+J92O7+gb13cZXnFeznIqeIXBn01w2Xmg6CAqdOE=;
	b=CYaLJeDDDPkrjJ4krTincmDY4gtAKzJuO/jeELeNa5spTBXRwY0II/wwhfyKcjZT28ziNv
	5atAOCMxnjMo8bqZDusSOzV9l+X5Sz78/KRdwsIkDLdmcki821SHMLgJm2fnrvDjCon4hg
	IIt2Mv0FwMj7kSZWnsdQc6/p7LdzLlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744733110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWF+J92O7+gb13cZXnFeznIqeIXBn01w2Xmg6CAqdOE=;
	b=NGrnEoG6zzEdQLzWe5qAPNGpWHtUk+Hes2YG8Ijb1rkwJONw0lB88tVlKvGu9AhYKniKsM
	4o2S0wkTZp+QnIDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744733110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWF+J92O7+gb13cZXnFeznIqeIXBn01w2Xmg6CAqdOE=;
	b=CYaLJeDDDPkrjJ4krTincmDY4gtAKzJuO/jeELeNa5spTBXRwY0II/wwhfyKcjZT28ziNv
	5atAOCMxnjMo8bqZDusSOzV9l+X5Sz78/KRdwsIkDLdmcki821SHMLgJm2fnrvDjCon4hg
	IIt2Mv0FwMj7kSZWnsdQc6/p7LdzLlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744733110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWF+J92O7+gb13cZXnFeznIqeIXBn01w2Xmg6CAqdOE=;
	b=NGrnEoG6zzEdQLzWe5qAPNGpWHtUk+Hes2YG8Ijb1rkwJONw0lB88tVlKvGu9AhYKniKsM
	4o2S0wkTZp+QnIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01BCC139A1;
	Tue, 15 Apr 2025 16:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y+w2ALaD/mdrWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 16:05:10 +0000
Date: Tue, 15 Apr 2025 18:05:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Message-ID: <20250415160508.GH16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250415083808.893050-1-frank.li@vivo.com>
 <472ae717-5494-44ae-973a-85249a65d289@gmx.com>
 <SEZPR06MB52691756B32BA90DBE82BDFDE8B22@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Apr 15, 2025 at 06:46:48PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/15 18:26, 李扬韬 写道:
> >> History please.
> >
> > Did you mean change commit msg to below?
> >
> > 	Commit b28b1f0ce44c ("btrfs: delayed-ref: Introduce better documented delayed ref structures") introduce BTRFS_REF_LAST but never use it,
> > 	So let's remove it.
> 
> It's the common practice to leave a last entry for sanity checks.
> 
> But since it's not utilized for anything, I'm fine to remove it.

I think in this case it's ok to remove it, although I agree that we have
the _LAST or _NR elsewhere. In btrfs_ref_type() tere's an assertion

  ASSERT(ref->type == BTRFS_REF_DATA || ref->type == BTRFS_REF_METADATA);

which is validating the values. There's no enumeration or switch that
could utilize the upper bound.

