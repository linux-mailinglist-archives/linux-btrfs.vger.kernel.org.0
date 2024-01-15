Return-Path: <linux-btrfs+bounces-1450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230682DBF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62702282248
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B58175B3;
	Mon, 15 Jan 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2VBRkrW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHA1kTmU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2VBRkrW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHA1kTmU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7A175A4
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5E3D1FD43;
	Mon, 15 Jan 2024 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705330495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWLvsg0+2z14HH5i1dQysYB7rQUYgEaopf8IflLIpA=;
	b=O2VBRkrWWP/aZCR8iqew16pCdym+dGBxSYNiVqGwJlXFXfE/pSF54fVaUXYf5zZEJVU9Rm
	7V5FDtjO68VYkZq+vmPzr4bisQBF7YAbovZjPjgsaczqRL+IuCmdtn3whco3kfGisGmSeO
	Ho3/xrFKg5kTikMeNJj9hpUqb6hW7uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705330495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWLvsg0+2z14HH5i1dQysYB7rQUYgEaopf8IflLIpA=;
	b=zHA1kTmUPKAka+9GP9VSkit+p4O4qtcME188ftM4us23mGc5T8HKtylNlggLGGyrvLaC7R
	tvNul8Qd0H7Qp4CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705330495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWLvsg0+2z14HH5i1dQysYB7rQUYgEaopf8IflLIpA=;
	b=O2VBRkrWWP/aZCR8iqew16pCdym+dGBxSYNiVqGwJlXFXfE/pSF54fVaUXYf5zZEJVU9Rm
	7V5FDtjO68VYkZq+vmPzr4bisQBF7YAbovZjPjgsaczqRL+IuCmdtn3whco3kfGisGmSeO
	Ho3/xrFKg5kTikMeNJj9hpUqb6hW7uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705330495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWLvsg0+2z14HH5i1dQysYB7rQUYgEaopf8IflLIpA=;
	b=zHA1kTmUPKAka+9GP9VSkit+p4O4qtcME188ftM4us23mGc5T8HKtylNlggLGGyrvLaC7R
	tvNul8Qd0H7Qp4CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 95DCA139D2;
	Mon, 15 Jan 2024 14:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YoQmJD9HpWW/cwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 15 Jan 2024 14:54:55 +0000
Date: Mon, 15 Jan 2024 15:54:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tree-checker: dump the tree block when
 hitting an error
Message-ID: <20240115145438.GT31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
 <20240112153602.GP31555@twin.jikos.cz>
 <7e908c1f-d14f-4562-ae1e-1431c091b140@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e908c1f-d14f-4562-ae1e-1431c091b140@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O2VBRkrW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zHA1kTmU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.22 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.01)[50.32%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.22
X-Rspamd-Queue-Id: B5E3D1FD43
X-Spam-Flag: NO

On Sat, Jan 13, 2024 at 07:03:18AM +1030, Qu Wenruo wrote:
> >> +	btrfs_print_tree((struct extent_buffer *)eb, 0);
> >
> > Printing the eb should not require writable eb, but there are many
> > functions that would need to be converted to 'const' so the cas is OK
> > for now but cleaning that up would be welcome.
> 
> I tried but failed.
> 
> Most of the call sites are fine to be constified, but there is a special
> trap inside bfs_print_children(), where we call extent_buffer_get(),
> which can never be called on a const eb pointer.

Oh, I see. We can't remove the ref update but what if we reset the path
slot to NULL before releasing it?

