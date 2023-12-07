Return-Path: <linux-btrfs+bounces-746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25730808797
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05701F22477
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CFA39FFB;
	Thu,  7 Dec 2023 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mA+LXoXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="drCVTGcP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571D84
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 04:22:30 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 449BC1FB41;
	Thu,  7 Dec 2023 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701951748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mr4W+cJzjEMODr537AAT/EAXvDIpBm6ZgLylz2prmUY=;
	b=mA+LXoXNEDFkUfdwSIx7U9Tict3J1qt6kx0seREhAFDncPMGtizMnkZh9W9DKy/l5Bl4cl
	yy0z196HlEqsPt5fWC+ZS1KwgYtlJkwmysy4qjNt46zDb9uVFr1qlu+x7T8nad02AKEFHw
	xwR0gBNj8FiRM+JsDXqOfH7KhHr5LOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701951748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mr4W+cJzjEMODr537AAT/EAXvDIpBm6ZgLylz2prmUY=;
	b=drCVTGcPT3bvrWc/S8Cm8RW4PQUB0/mCLpZLncdq/Wupu3FPC3F9rzZ5BzJ3e9pPFIW7lq
	O/Zt9rl8gkEKohBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BCBB139E3;
	Thu,  7 Dec 2023 12:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /ZfpAAS5cWVvfQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 07 Dec 2023 12:22:28 +0000
Date: Thu, 7 Dec 2023 13:15:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231207121537.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231205111329.6652-1-ddiss@suse.de>
 <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.10
X-Spamd-Result: default: False [4.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

On Thu, Dec 07, 2023 at 01:01:50PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/12/5 21:43, David Disseldorp wrote:
> > The @retptr parameter for memparse() is optional.
> > btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> > validation, so the parameter can be dropped.
> 
> To me, I believe it's better to completely get rid of memparse().
> 
> As you already found out, some suffix, especially "e|E" can screw up the 
> result.
> E.g. "25e" would be interpreted as 25 with "e" as suffix, which is fine 
> according to the rule. (without prefix, the base is 10, so only "25" is 
> valid. Then the remaining part is interpreted as suffix).
> 
> And since btrfs is not going to do pretty size output for sysfs (as most 
> sysfs is not directly for end users, and we need accurate output), to be 
> consistent there isn't much need for suffix handling either.
> 
> So can't we just replace memparse() with kstrtoull()?

The value that can be read from the sysfs file is in bytes and it's so
that applications do not need to interpret it, like multiplying with
1024. We'll probably never return the pretty values with suffixes in
sysfs files.

However, on the input side the suffixes are a convenience, setting to
limit the throughput as '32m' is better than typing '32000000' and
counting zeros or $((32*1024*1024)) or 33554432.

This is why memparse is there and kstrtoull does not do that.

