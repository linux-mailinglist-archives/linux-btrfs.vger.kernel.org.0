Return-Path: <linux-btrfs+bounces-16366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF8B36238
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487DE8A4B09
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D322327A455;
	Tue, 26 Aug 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukpuwkX3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bD7Uo/p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukpuwkX3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bD7Uo/p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D54C6D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213887; cv=none; b=iVMHwhmTzbi4+R+fptYzj3/Cbi5cStUDIjKgUcRhKAhE/AjymbdwzMzaKQj3C+crVCl553Jvg2YeSviaXJ1FsR0zeHp66UwKXoz/Nq9APArT0qr61nIhj01bngfzVin97K5e6QgVCem6Ry8u2M+aCE2f3ncL9Pvwjiy43cqV5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213887; c=relaxed/simple;
	bh=BAqP7X7PNCuyXBku8FqJkCVu6dEKYvlnXUqpclgUVzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPi0Q6sIhs3/9xOj7UQWvhIjU01PntacEaMHbkEAdy+vFEgL2uLFR3CVkhQPshsr+xgM75Vs/tHGSA+mzE4YJ7DHV+jQEO+aMMu0DZKU/PlbhZHccU/t7K/8qQXMEJ8KSrzH+JSVY6pc/hnbRQW7U/MMByokKDzdf5qpV3ko4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukpuwkX3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bD7Uo/p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukpuwkX3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bD7Uo/p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96256211FC;
	Tue, 26 Aug 2025 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756213883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsK5/Tv+Gky5jivXNK3PJEjWTeh9Qjc7fIj2RjAjYQU=;
	b=ukpuwkX3EEpFSc/ovhJvNmEwYvWX03k1rfdozog6HXO95N4z0ICnos5tqDhwimE1NOir67
	GGfvGaimM+uIWy3otPLbhfd4O6mCs1XjMTo0XoKOXp7M12Bqw9OINPzC+GDWZEqmn4UsHp
	jeqjX/ZcZap47MnAIfiRZtz0Emgrako=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756213883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsK5/Tv+Gky5jivXNK3PJEjWTeh9Qjc7fIj2RjAjYQU=;
	b=5bD7Uo/pG/h8L1+2NHC1Pn+MdObxoB0tqvPIFVWLSpwEyMwPVgJkvdfBNFzN4gOl8QIprt
	1EVaMN/SMDZ7eeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756213883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsK5/Tv+Gky5jivXNK3PJEjWTeh9Qjc7fIj2RjAjYQU=;
	b=ukpuwkX3EEpFSc/ovhJvNmEwYvWX03k1rfdozog6HXO95N4z0ICnos5tqDhwimE1NOir67
	GGfvGaimM+uIWy3otPLbhfd4O6mCs1XjMTo0XoKOXp7M12Bqw9OINPzC+GDWZEqmn4UsHp
	jeqjX/ZcZap47MnAIfiRZtz0Emgrako=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756213883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsK5/Tv+Gky5jivXNK3PJEjWTeh9Qjc7fIj2RjAjYQU=;
	b=5bD7Uo/pG/h8L1+2NHC1Pn+MdObxoB0tqvPIFVWLSpwEyMwPVgJkvdfBNFzN4gOl8QIprt
	1EVaMN/SMDZ7eeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BFDF13A31;
	Tue, 26 Aug 2025 13:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZQeHnuyrWgaLAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Aug 2025 13:11:23 +0000
Date: Tue, 26 Aug 2025 15:11:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] btrfs: move ref-verify of btrfs_init_data_ref under
 CONFIG_BTRFS_DEBUG
Message-ID: <20250826131121.GB29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250826122901.49526-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826122901.49526-1-lukas.bulwahn@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,toxicpanda.com,suse.com,gmail.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Tue, Aug 26, 2025 at 02:29:01PM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
> removes config BTRFS_FS_REF_VERIFY and adds its functionality under config
> BTRFS_DEBUG. This change misses a reference to BTRFS_FS_REF_VERIFY in the
> btrfs_init_data_ref() function, though.
> 
> Replace this reference to BTRFS_FS_REF_VERIFY in the btrfs_init_data_ref()
> with BTRFS_DEBUG.
> 
> Fixes: dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thanks, folded to the patch because it's in the development queue.

