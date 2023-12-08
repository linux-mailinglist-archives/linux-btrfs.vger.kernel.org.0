Return-Path: <linux-btrfs+bounces-763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C238D80AC09
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37DBB20A5A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA02481A0;
	Fri,  8 Dec 2023 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Scmj8W6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7FwLtlW1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Scmj8W6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7FwLtlW1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE290
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 10:28:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6D6621C99;
	Fri,  8 Dec 2023 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLa70ZtYnbiJWKQCC7Zmm2vRjR7RMdyFkdo6O5aM9PY=;
	b=Scmj8W6VYWQvTdN5H5jdd29+fXfXHBtoS02ipFEE0iQF/7soy02CJAv1lKeRkqKXaZDutN
	fakCB1NaQzUldgA/ITKFliDJkeUiUlYS/DZBvcb0YVr1PLtxOaeeC0AP3p35PpH4Obrosp
	UV/NMU++pvgH8rNw0YNuO+oQNY0nAAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLa70ZtYnbiJWKQCC7Zmm2vRjR7RMdyFkdo6O5aM9PY=;
	b=7FwLtlW138GbRDlWWMcM/+gpiqTWk+3tyrrQWpTmGerxMuEe6W2CHEkvRhMEKE49adA2rV
	oEgVlqLstz51xcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLa70ZtYnbiJWKQCC7Zmm2vRjR7RMdyFkdo6O5aM9PY=;
	b=Scmj8W6VYWQvTdN5H5jdd29+fXfXHBtoS02ipFEE0iQF/7soy02CJAv1lKeRkqKXaZDutN
	fakCB1NaQzUldgA/ITKFliDJkeUiUlYS/DZBvcb0YVr1PLtxOaeeC0AP3p35PpH4Obrosp
	UV/NMU++pvgH8rNw0YNuO+oQNY0nAAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLa70ZtYnbiJWKQCC7Zmm2vRjR7RMdyFkdo6O5aM9PY=;
	b=7FwLtlW138GbRDlWWMcM/+gpiqTWk+3tyrrQWpTmGerxMuEe6W2CHEkvRhMEKE49adA2rV
	oEgVlqLstz51xcCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B51A3138FF;
	Fri,  8 Dec 2023 18:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2Ij9KzFgc2WZXQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 08 Dec 2023 18:28:01 +0000
Date: Fri, 8 Dec 2023 19:21:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: scrub: improve Rate reporting for
 sub-second durations
Message-ID: <20231208182106.GA2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231207135647.24332-1-ddiss@suse.de>
 <d1463937-9917-4cac-83f6-aa5186d8ce41@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1463937-9917-4cac-83f6-aa5186d8ce41@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 8.11
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Scmj8W6V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7FwLtlW1;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.85 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.12)[-0.601];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[27.54%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.18)[0.910];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 8.85
X-Rspamd-Queue-Id: C6D6621C99
X-Spam-Flag: NO

On Fri, Dec 08, 2023 at 06:33:25AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/12/8 00:26, David Disseldorp wrote:
> > Scrubs which complete in under one second may carry a duration rounded
> > down to zero. This subsequently results in a bytes_per_sec value of
> > zero, which corresponds to the Rate metric output, causing intermittent
> > tests/btrfs/282 failures.
> >
> > This change ensures that Rate reflects any sub-second bytes processed.
> > Time left and ETA metrics are also affected by this change, in that they
> > increase to account for (sub-second) bytes_per_sec.
> >
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> 
> Looks good to me.
> 
> In the future we should also increase the resolution to proper time
> stamp level.

It seems possible, we have some of the timestamps as time_te which is in
seconds but the end time measured in scrub_one_dev() uses gettimeofday()
so we would have the sub-second precision. However I'm not sure we need
this, most scrubs run for a long time, I'd be fine with the simple fix
like in this patch.

