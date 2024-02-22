Return-Path: <linux-btrfs+bounces-2644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5385F82F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47C21F26ABE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130860B98;
	Thu, 22 Feb 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTO79DgK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqsan5lQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogs8zH9a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vzNCjX5K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD946435;
	Thu, 22 Feb 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604967; cv=none; b=HfpCE9c8BGIEJbm2vXOerlagv4ouNJoBFsfI4S7EEwnxitgYkF+knHfFv+VLzhhs2I3V/Xh/CyoJsoexAW0fvvxXkXirerjwIkePwxQhOI8eXDVm9iUIdAbNw1pU3P7ts2AlVS/x6Uk8XSUsWommZSGaGqw5w82ZEI8TQUQqwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604967; c=relaxed/simple;
	bh=neV5v1ibyLjYtLARNzaXpfXUXNBQ0ef2jiWOpjBwwDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0VvVu/8H6wPqqAzK5L03RDPZmAMwKBq+5Eru6qBPg0L+ggpT2xvE6jYAMuHSkE519wS0sy8UGe2JnnLm9b2zjxgIeDTf3ig8QeOq8HKJECuPiBQu4IDfUpaDgLP1MmTUUZfkAo57t/ec9ebu/msBX0vvjhwAHrWiHGejdNfBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTO79DgK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqsan5lQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogs8zH9a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vzNCjX5K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7E11F457;
	Thu, 22 Feb 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708604963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SufLat75DKpexXFESir3zghA6fMULEE3x8LYCCpJsS8=;
	b=mTO79DgKUoNBQTcCuXoLOWwLUsiGK66g5WIukEW33F6WnMi6IMDVvkvWaUgHRxDCpv2oRF
	34hiawCW+dvAPrNxncKWEMIfCeah9lONy+FlHN3pCbWrWt1RDn3qwaKGuHEd7/mhQNM7Y+
	EkKCntd94xBatlhdMqtPKMdWBOE05yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708604963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SufLat75DKpexXFESir3zghA6fMULEE3x8LYCCpJsS8=;
	b=jqsan5lQaL1YUF4V2bJ7eDHcsLhwknt8gMUY5rlFOth3f1c5snN72PDGfmb4/BjmaCsBVV
	1rTIUnhCwUc1YmAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708604962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SufLat75DKpexXFESir3zghA6fMULEE3x8LYCCpJsS8=;
	b=ogs8zH9asPYUrN8Iqa+D7cO8n+F2eOBWTFb40LQ7qeLdwkfekvw7moJQeZupKz0llI3bnR
	CaSlxfZqgEOA6DzyCaoRQVChKyQyS/8HlOYDhCoiL6Kvl03GdzUPTj/CCTv8ZJUjnwubFa
	t+y2Qafp0nVO8Lo67Vy3IDp/e4jC3J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708604962;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SufLat75DKpexXFESir3zghA6fMULEE3x8LYCCpJsS8=;
	b=vzNCjX5KzsiQb2kjF+M8HPVOH5Lc7oy3ZIlrYxm4mPt2/IpmRSNMeBiMQmWd+0A+8ZFWS/
	kiBE+Hnnnn8urtAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 788B813A6B;
	Thu, 22 Feb 2024 12:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sO4rHSI+12VzSAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 22 Feb 2024 12:29:22 +0000
Date: Thu, 22 Feb 2024 13:28:44 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/736: fix a buffer overflow in
 readdir-while-renames.c
Message-ID: <20240222122844.GO355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ogs8zH9a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vzNCjX5K
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 8E7E11F457
X-Spam-Flag: NO

On Sun, Feb 11, 2024 at 11:28:26AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is using a 32 characters buffer to print the full path for each
> file name, which in some setups it's not enough because $TEST_DIR can
> point to a path name longer than that, or even smaller but then the buffer
> is still not large enough after appending a file name. When that's the
> case it results in a core dump like this:
> 
>   generic/736       QA output created by 736
>   *** buffer overflow detected ***: terminated
>   /opt/xfstests/tests/generic/736: line 32:  9217 Aborted                 (core dumped) $here/src/readdir-while-renames $target_dir
>   Silence is golden
>   - output mismatch (see /opt/xfstests/results//generic/736.out.bad)
>       --- tests/generic/736.out	2024-01-14 12:01:35.000000000 -0500
>       +++ /opt/xfstests/results//generic/736.out.bad	2024-01-23 18:58:37.990000000 -0500
>       @@ -1,2 +1,4 @@
>        QA output created by 736
>       +*** buffer overflow detected ***: terminated
>       +/opt/xfstests/tests/generic/736: line 32:  9217 Aborted                 (core dumped) $here/src/readdir-while-renames $target_dir
>        Silence is golden
>       ...
>       (Run diff -u /opt/xfstests/tests/generic/736.out /opt/xfstests/results//generic/736.out.bad  to see the entire diff)
>   Ran: generic/736
>   Failures: generic/736
>   Failed 1 of 1 tests
> 
> We don't actually need to print the full path into the buffer, because we
> have previously set the current directory (chdir) to the path pointed by
> "dir_path". So fix this by printing only the relative path name which
> uses at most 5 characters (NUM_FILES is 5000 plus the nul terminator).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

