Return-Path: <linux-btrfs+bounces-948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8C81222D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C8D1F218D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650781E5D;
	Wed, 13 Dec 2023 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVCgMRR4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zQdcDEE4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVCgMRR4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zQdcDEE4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15306CF
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 14:57:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 647871F789;
	Wed, 13 Dec 2023 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702508228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad8AKRK3bbIkHAVOXzadd2ury2RB9xjSAYLOy9Y1AtA=;
	b=yVCgMRR4CSSh6fI8UuiccQ2JSkUQnRyWggzPhqPd0Q00hYFfdqqIiUUyeUmuezu3MOkE7O
	PbPTfbf1q1rvVNGUYVOtyq6IFE1bJ28U7c1D0bCR4HLwI4gxt2ziWCwN4c6qBHzJODUCuO
	jrKPINzAukxBMLGxgnj9qQNbRLgXHOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702508228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad8AKRK3bbIkHAVOXzadd2ury2RB9xjSAYLOy9Y1AtA=;
	b=zQdcDEE4GwahIMw2XFMjSlLKCAlLfiQKpO9lRO6JtGrE8J0dL6EQXotG1yfcGHrW3mPfcz
	OcsT2TkIyZko6dCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702508228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad8AKRK3bbIkHAVOXzadd2ury2RB9xjSAYLOy9Y1AtA=;
	b=yVCgMRR4CSSh6fI8UuiccQ2JSkUQnRyWggzPhqPd0Q00hYFfdqqIiUUyeUmuezu3MOkE7O
	PbPTfbf1q1rvVNGUYVOtyq6IFE1bJ28U7c1D0bCR4HLwI4gxt2ziWCwN4c6qBHzJODUCuO
	jrKPINzAukxBMLGxgnj9qQNbRLgXHOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702508228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad8AKRK3bbIkHAVOXzadd2ury2RB9xjSAYLOy9Y1AtA=;
	b=zQdcDEE4GwahIMw2XFMjSlLKCAlLfiQKpO9lRO6JtGrE8J0dL6EQXotG1yfcGHrW3mPfcz
	OcsT2TkIyZko6dCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C62A1391D;
	Wed, 13 Dec 2023 22:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tLUkEsQ2emUKOgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 22:57:08 +0000
Date: Wed, 13 Dec 2023 23:50:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Disseldorp <ddiss@suse.de>, David Sterba <dsterba@suse.cz>,
	linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: validate scrub_speed_max sysfs string
Message-ID: <20231213225009.GI3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231207135522.GX2751@twin.jikos.cz>
 <20231208004156.9612-1-ddiss@suse.de>
 <7d72dca9-d995-40b8-a2f1-97f5526bccc4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d72dca9-d995-40b8-a2f1-97f5526bccc4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 7.93
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 647871F789
X-Spam-Score: 4.40
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yVCgMRR4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zQdcDEE4;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Spamd-Result: default: False [4.40 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.19)[70.63%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

On Mon, Dec 11, 2023 at 01:48:15PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/12/8 11:11, David Disseldorp wrote:
> > Fail the sysfs I/O on any trailing non-space characters.
> >
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I have an unrelated idea.
> 
> Since memparse() provides the @endptr, can we rewind the @endptr, so
> that we can check if the last valid charactor is suffix 'e'.
> Then reject it from btrfs size.
> 
> I really don't think we need exabytes suffix for our scrub speed limit
> usage.

I think nobody will intentionally use the 'e' exabyte suffix in this
case but I don't want to add an exception to parsing the values. We'd
have to document that, explain why it's not accepted, it's additional
work for a case I still dont understand why it's so important.

If the exabyte scale values are not properly parsed by memparse() due to
simple_strtoull() as a workaround we can add our parser based on
kstrtoull() or do such change in memparse() proper.

