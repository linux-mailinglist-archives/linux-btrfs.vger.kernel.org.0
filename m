Return-Path: <linux-btrfs+bounces-440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8A7FDC3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F751C20A8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216239ACC;
	Wed, 29 Nov 2023 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2110A
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 08:09:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3B5219C6;
	Wed, 29 Nov 2023 16:09:31 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 376C61376F;
	Wed, 29 Nov 2023 16:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O5IwDDtiZ2UVXwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 29 Nov 2023 16:09:31 +0000
Date: Wed, 29 Nov 2023 17:02:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Message-ID: <20231129160217.GT18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231127163236.GF2366036@perftesting>
 <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.19
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 5C3B5219C6
X-Spamd-Result: default: False [10.19 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email];
	 NEURAL_HAM_LONG(-1.00)[-0.996];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

On Tue, Nov 28, 2023 at 08:47:33AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/28 03:02, Josef Bacik wrote:
> > On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
> >> For now extent_buffer::pages[] are still only accept single page
> >> pointer, thus we can migrate to folios pretty easily.
> >>
> >> As for single page, page and folio are 1:1 mapped.
> >>
> >> This patch would just do the conversion from struct page to struct
> >> folio, providing the first step to higher order folio in the future.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > This doesn't apply to misc-next cleanly, so I can't do my normal review, but
> > just swapping us over to the folio stuff in name everywhere is a valuable first
> > start.  I'd like to see this run through our testing infrastructure to make sure
> > nothing got missed.  Once you can get it to apply cleanly somewhere and validate
> > nothing weird got broken you can add
> >
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks, the failed apply is due to the fact that this relies on another
> patch: "btrfs: refactor alloc_extent_buffer() to allocate-then-attach
> method".

V3 of the patch has a comment from Josef, please send an update so I can
apply both patches and we can start testing the folio conversion.

