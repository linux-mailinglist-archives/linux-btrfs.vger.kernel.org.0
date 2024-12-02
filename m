Return-Path: <linux-btrfs+bounces-10008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D549E042D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CEF167712
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F608202F95;
	Mon,  2 Dec 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JV/19aWz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvxVqZzv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JV/19aWz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvxVqZzv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8521F8AC5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147968; cv=none; b=EEl/N0NnrIGKWtV4IkxfqpEl93ls9lK+QxDG633XjdACc8yEKI/L75bub3lOdROzCIjfTsHbyT6NB1XfgGYfer8qmz9xYN0Lf2f2jkf4Zf1JSrUUiyJQLPTMY3IMWlL9pyoXX3DPpGpil+oP0H4y5KiwL1QtZ2Mc79pMePWaj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147968; c=relaxed/simple;
	bh=G0gtfeDuRzaWs+Dol40OR4zZV92EGUD0B5RnEp1tCko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMiqKUg1V9YiFp0Sn/jWR7DN6XgTRZFE5lDfq9Cc/i2Q9LSHE4D+f+mO8wA5788agY68aHWQCwVlBWdCfcm0E7z4mZ7EdFLJK4M+UPgL5Wadf+yDEu67BJJ8ZhM4wFTH/GrC4u64TOiSqNKGF0ESfjbOb8BqIAr5YHqFXJ9nAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JV/19aWz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvxVqZzv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JV/19aWz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvxVqZzv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7601F444;
	Mon,  2 Dec 2024 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
	b=JV/19aWzZZK2hczwTFG/XvFTBpcW08BjmLlV/0wpgl4528yNzS0HcFXzowQgwr3zeLrQuj
	bmTOIIcYA5FZv4xhndn+Yr2y2K6tOsuyT7QYLdU97LicUxCDFdP+N7NwPNj0jaEJdmd982
	dW+VAXiSHS+K7IBjZkR/9OnOrdJdedU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
	b=wvxVqZzvLttAe1vFOSwOtUBqYpmFrZJu7UZUF6Q4u7F/IdLOwtyAuX4Ee1xZ4hJ70IisYc
	4nRVM9NQIHDWUmAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JV/19aWz";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wvxVqZzv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733147965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
	b=JV/19aWzZZK2hczwTFG/XvFTBpcW08BjmLlV/0wpgl4528yNzS0HcFXzowQgwr3zeLrQuj
	bmTOIIcYA5FZv4xhndn+Yr2y2K6tOsuyT7QYLdU97LicUxCDFdP+N7NwPNj0jaEJdmd982
	dW+VAXiSHS+K7IBjZkR/9OnOrdJdedU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733147965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
	b=wvxVqZzvLttAe1vFOSwOtUBqYpmFrZJu7UZUF6Q4u7F/IdLOwtyAuX4Ee1xZ4hJ70IisYc
	4nRVM9NQIHDWUmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D00B13A31;
	Mon,  2 Dec 2024 13:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FAgIBj29TWdoFQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:59:25 +0000
Date: Mon, 2 Dec 2024 14:59:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: linux-btrfs@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <Z029S0wgjrsv9qHL@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z02337yqxrfeZxIn@yuki.lan>
X-Rspamd-Queue-Id: 2C7601F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi!
> The code to skip filesystems in the case of all filesystems is in the
> run_tcase_per_fs() function:
> 
> static int run_tcases_per_fs(void)
> {
>         int ret = 0;
>         unsigned int i;
>         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
> 
> The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> function which filters out them.

Perhaps you mean that the skiplist does not work with .all_filesystems
_and_ the LTP_SINGLE_FS_TYPE environment variable?

I guess that we need:

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19..49b1d7205 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

        if (only_fs) {
                tst_res(TINFO, "WARNING: testing only %s", only_fs);
+
+               if (tst_fs_in_skiplist(only_fs, skiplist))
+                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
+
                if (tst_fs_is_supported(only_fs))
                        fs_types[0] = only_fs;
                return fs_types;


-- 
Cyril Hrubis
chrubis@suse.cz

