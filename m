Return-Path: <linux-btrfs+bounces-343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56187F765A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A207282246
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D12D788;
	Fri, 24 Nov 2023 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mEvmPHPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lBOeo5PN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9B19A1;
	Fri, 24 Nov 2023 06:30:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22A9E21DBE;
	Fri, 24 Nov 2023 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700835840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dbxwk/y2VtCgNbHXNguUY9mwi4qlNBLd4z/wJfJpewQ=;
	b=mEvmPHPx6O44285u0z8s07WLRfmvtQsXh93GzJv4I+Do7bc3RnOrlRpNdxiZgzN+KNF0ne
	bWusNp/1gtlZ++KHD6Rh5DL55/Y7tHAMguP0HiQblCBaJH2cfZRBFPZffhTmrOxkrK9KLt
	bFu7EpvaIDQp3QUBKNlep406R0HQ2HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700835840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dbxwk/y2VtCgNbHXNguUY9mwi4qlNBLd4z/wJfJpewQ=;
	b=lBOeo5PN6a6CgiaqNeliUMglZIE5qyaSTAlA4InsztM09l/hf9+B9oxiy9VsBereUAQ2IC
	mQho/MwbgxdGCJAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F1885139E8;
	Fri, 24 Nov 2023 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lNfoOf+xYGV5IgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 14:23:59 +0000
Date: Fri, 24 Nov 2023 15:16:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix 64bit compat send ioctl arguments not
 initializing version member
Message-ID: <20231124141648.GA18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231124000034.27522-1-dsterba@suse.com>
 <CAL3q7H6C=FJL9cX2-uVo1AhnNAmMOGfFMkTEzHekL5OeW0OAXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6C=FJL9cX2-uVo1AhnNAmMOGfFMkTEzHekL5OeW0OAXQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.70
X-Spam-Level: 
X-Spamd-Result: default: False [-1.70 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.70)[83.38%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

On Fri, Nov 24, 2023 at 12:16:55AM +0000, Filipe Manana wrote:
> On Fri, Nov 24, 2023 at 12:08 AM David Sterba <dsterba@suse.com> wrote:
> >
> > When the send protocol versioning was added in 5.16 e77fbf990316
> > ("btrfs: send: prepare for v2 protocol"), the 32/64bit compat code was
> > not updated (added by 2351f431f727 ("btrfs: fix send ioctl on 32bit with
> > 64bit kernel")), missing the version struct member. The compat code is
> > probably rarely used, nobody reported any bugs.
> >
> > Found by tool https://github.com/jirislaby/clang-struct .
> >
> > Fixes: 2351f431f727 ("btrfs: fix send ioctl on 32bit with 64bit kernel")
> 
> So this is not the correct commit, you copy-pasted the wrong one from
> the change log above, it should be:
> 
> e77fbf990316 ("btrfs: send: prepare for v2 protocol")

Of course, fixed, thanks.

