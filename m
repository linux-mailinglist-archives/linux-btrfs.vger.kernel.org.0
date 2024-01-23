Return-Path: <linux-btrfs+bounces-1633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF778382DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796ABB24B27
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B45C5FC;
	Tue, 23 Jan 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JneVXpy2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGTGI0bW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSGzfJsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nv80j5S2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECD5C908;
	Tue, 23 Jan 2024 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974375; cv=none; b=ZZHJpjgyW2OGIfUyeASihh4rgYXy+nsviqRXFQcfLaLjRNUswBA+Oq0EEfJz4AkXXHY6EcSAp0r0hNVMmO3mLcdB9rE4BLmWZ/DHGayrGvtE6KRvZJs5BZELwQQ0pdgk2TLNn4SHYhgekEnkvAASocMlHnzyO1iECmiKJVj7MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974375; c=relaxed/simple;
	bh=Cr3vXVGJzQNTBQ/AT8VbtlhWbetssrpxmltQSTV8bFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqia53ea1rcqXnoq+FSuvQJh1C7Q5NNXmP5zPjKwStdAFDOjnzGo3AfDKFB/Cjo4khWEErweqX/HIzHA7O5tq7NdxQk0Si04EzPcQ9pXQ9+zVnwUu4a9OuzijqPl03lc4kLR6lhzugFIIul8U4TmWS2btOPROQSWTtWiu9d1E8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JneVXpy2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGTGI0bW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSGzfJsr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nv80j5S2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE9BB1F441;
	Tue, 23 Jan 2024 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705974371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn0TR7tjK3IyZ6RoFJ/9OaPFrdgAA8FH9d3xYVGNY1o=;
	b=JneVXpy2GoJd+Ccj0gMjzwnpyL1oG9+5PhoxuiDbV1nXMdJJwWoj32H7ywXpibn7ObECuz
	JO09xVO8G4F+Lin6mig0xtxDaNLbCy01TKy5H9fRzq3Tc5qPXpT/PpWIrJzShMP4YSn+Bb
	BBETHmDiwNJFgTMEOVDyv0ZvjdCrxDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705974371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn0TR7tjK3IyZ6RoFJ/9OaPFrdgAA8FH9d3xYVGNY1o=;
	b=xGTGI0bWotzaT+lUotadC9FHxpKU3OQ8dCjHE03D03lIqOoEipV0ONjW2ZoVt6+dDuRA9k
	QjQ2/FSZzLusL6Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705974370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn0TR7tjK3IyZ6RoFJ/9OaPFrdgAA8FH9d3xYVGNY1o=;
	b=cSGzfJsr4LX3IHiP70HWZlLbd8VW+bKJ/r8KOsw7/JfGOvpOvcfJTvQo69MUsVqQxORXy0
	PNNSL2wISO7svkzKB6PImkrgHJceSWGYSABuqBRIaxChHhbbMdE62fSNMOYUhPkq6mWigl
	tmjGtYL9Azlmij4cjN9M0H6vE3dO/Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705974370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn0TR7tjK3IyZ6RoFJ/9OaPFrdgAA8FH9d3xYVGNY1o=;
	b=nv80j5S2LBjihXZ4BzOqCq+Hgxn998l/BwVPdTWJAgLTgIg/w0N5YG1PIyGJkY9qiSHk/R
	1aEiqlXV+Zh9z9Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9503A13465;
	Tue, 23 Jan 2024 01:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LIBpI2Iar2UGHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 23 Jan 2024 01:46:10 +0000
Date: Tue, 23 Jan 2024 02:45:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/82] btrfs: Refactor intentional wrap-around calculation
Message-ID: <20240123014545.GH31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-13-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-13-keescook@chromium.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.07 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[74.10%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.07

On Mon, Jan 22, 2024 at 04:26:48PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> wrap-around sanitizer in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David Sterba <dsterba@suse.com>

