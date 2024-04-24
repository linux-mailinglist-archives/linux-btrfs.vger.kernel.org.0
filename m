Return-Path: <linux-btrfs+bounces-4531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F28B115E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70491C24831
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0816D4E2;
	Wed, 24 Apr 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HclW3Xav";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QT3zm5ym";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qXW7eTDi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8dVWXctJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09016D4CC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980597; cv=none; b=s84Q6xQn9tPhJkssZc8szdj5eOV13Pxx0ANsJjEZeOWmEnvLTbJhwvnkMz1S9vjFtbgyr/5u+pCMI2T5v8NT1TkRStgJkt8X5rIXL85NIrwL9KQQ1v3oNwRHP2x3NiZd4C5/BOti1+6nXMotP4VUfC+cUFo/O1qvwavGPIVIw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980597; c=relaxed/simple;
	bh=IwswhD98ah3QAcSgcpwY9CWotILoZQx9MmglX6JghmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNVd5u9w/a+KdjG0wKDhTWYjF0/LakBxfY4oopC498bqowmqX0JmTIyJNom34HNrPWXqRIPQAM30UWZEOvehqUbJy8jreQVF29ATW4KtnagZ+SR3Fn/2uf5bDVdVa8Toup8nIYQuD8CKWX2CL253J4gKZKAbPXUALUCwAcacl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HclW3Xav; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QT3zm5ym; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qXW7eTDi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8dVWXctJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0F0A21A9C;
	Wed, 24 Apr 2024 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1eTK8NMotePTdCEDl1/R9nGSwjEberxWa2RcBK5utM=;
	b=HclW3XavmKWHy23ke9P/WylBdazGNFgYP6rjaJtb9v6C81XPvVsnYHZDxSwm2CPdJ06rpY
	RMaS1f7Suia9nSVnVYCKEPpVodLOz2H4BxhbLCblHC1ShZAH3jwyJ3S14L/5mfrfJ/0xQC
	bZj+ul9qlxPQOcq8wlesFAJRnx/YIjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1eTK8NMotePTdCEDl1/R9nGSwjEberxWa2RcBK5utM=;
	b=QT3zm5ymt3h7CCIqfzPZq60ZDwQEubwYEyoLL+IMLSfkCyNWs6RnNEdtBydc/sEWxJ5qt0
	Rlfd3UFQwwG9G+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1eTK8NMotePTdCEDl1/R9nGSwjEberxWa2RcBK5utM=;
	b=qXW7eTDiU9wzXchPK5z/MvIyJRbpJgsqeNm4/+8dxUuJb1uy1QmJIS7rtneWExiCcqHXII
	uJ6lSC3QoK+l0YIB2vm9X7ST+qpvwOnuzu5BFr1Qba95NEp1tefF2ckHz4Cz7luwMk7yIN
	aR+PU/eauZ4AveoEQyrHS1CHdFd3gqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1eTK8NMotePTdCEDl1/R9nGSwjEberxWa2RcBK5utM=;
	b=8dVWXctJizr9wNLdJ/n0I3WRBDp8wp3aBDlpBBN2tQYMr6k8l+8OX0x3e7mmjzUYFtMyMz
	JR0t4jTfmQP+XuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA9FA13690;
	Wed, 24 Apr 2024 17:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GrdDLbFEKWY0TQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:43:13 +0000
Date: Wed, 24 Apr 2024 12:43:05 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 10/17] btrfs: remove unlock_extent from
 run_delalloc_compressed
Message-ID: <2stehm3olsoep2st66ymbyjz3iv5st36tnuq2hw5uhbe7ab5ny@5nzimvulq22c>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <62c3ad839000ac851c813c84f94580fafae16389.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c3ad839000ac851c813c84f94580fafae16389.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -3.74
X-Spam-Level: 
X-Spamd-Result: default: False [-3.74 / 50.00];
	BAYES_HAM(-2.94)[99.75%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On 10:35 17/04, Josef Bacik wrote:
> Since we immediately unlock the extent range when we enter
> run_delalloc_compressed() simply move the lock_extent() down to cover
> cow_file_range() and then remove the unlock_extent() from
> run_delalloc_compressed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

