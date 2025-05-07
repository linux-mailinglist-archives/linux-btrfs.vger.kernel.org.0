Return-Path: <linux-btrfs+bounces-13794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2ACAAE696
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 18:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF591C47395
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3528D827;
	Wed,  7 May 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wg5Ds4V7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXMIWJG+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wg5Ds4V7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXMIWJG+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF528CF7F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634720; cv=none; b=LKJugN6kA+qe8vryjGkRuWxZ2j1sx/dQsngr63bmoeXLdjpUK7S5Pk8fxn7eYbRO/90fVABC1bNjWr8i1sIr7A5GY/QjwHGDp6JaqUFMvQyXliQqcuvLY9wzt4TF2IifNsH4l0Fb6fyiV8bmIJf/fvgb3HkBSUS14pDtdJDp5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634720; c=relaxed/simple;
	bh=vnI9NL0fKn97GCbRucNV8eEly+/dG7WSYYvymbMGiYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHeblB3+hV+ODptOM/F4FEenwqhemJlRZlPZUPD2j9SY0zz5XA3yfW6ggl1sHyK0TQQgoEcjGoMkb8vh6SajCwfHlXwKXzx8bpt8tkqdwS6326szoTCpCnT5Ir4ZApsEg7O0cxycXpG07lqSe8tSax+x7f8n/Gwq7Yhkw1wt/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wg5Ds4V7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXMIWJG+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wg5Ds4V7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXMIWJG+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 434601F395;
	Wed,  7 May 2025 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746634717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mdIaDdD+SV/X7LR1AwH4Rd7X5N1WYrHdN2z5W8n5Xg=;
	b=Wg5Ds4V7TOrN7pQ9+DdM62UofAzLOpbK6eBlhtYAdQcA/VCOqUCwnE/7ywEm9yoKEq2CGp
	o1XZPUAagY0OzmK3exJSvEBS4/6jXsjQLR8TMMpMdszqHsKYJnHA0e8nLocDL+Od9I07tm
	YPWZnvoISV91K3O+g8enIv8aE8f0MDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746634717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mdIaDdD+SV/X7LR1AwH4Rd7X5N1WYrHdN2z5W8n5Xg=;
	b=zXMIWJG+M7H1OhyZ+pWkg8lkAl9QSdAxzrSZyGrg7Gh7FKyqAUOsxHzMyW9jaHkRU81fNU
	MR/dPHRcrJtqdUBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746634717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mdIaDdD+SV/X7LR1AwH4Rd7X5N1WYrHdN2z5W8n5Xg=;
	b=Wg5Ds4V7TOrN7pQ9+DdM62UofAzLOpbK6eBlhtYAdQcA/VCOqUCwnE/7ywEm9yoKEq2CGp
	o1XZPUAagY0OzmK3exJSvEBS4/6jXsjQLR8TMMpMdszqHsKYJnHA0e8nLocDL+Od9I07tm
	YPWZnvoISV91K3O+g8enIv8aE8f0MDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746634717;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mdIaDdD+SV/X7LR1AwH4Rd7X5N1WYrHdN2z5W8n5Xg=;
	b=zXMIWJG+M7H1OhyZ+pWkg8lkAl9QSdAxzrSZyGrg7Gh7FKyqAUOsxHzMyW9jaHkRU81fNU
	MR/dPHRcrJtqdUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25A73139D9;
	Wed,  7 May 2025 16:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bj7vCN2HG2hkdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 16:18:37 +0000
Date: Wed, 7 May 2025 18:18:35 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix false alert on missing csum for
 hole
Message-ID: <20250507161835.GI9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00

On Fri, May 02, 2025 at 03:32:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we log a hole, fsync a file, partially write to the front of the hole
> and then fsync again the file, we end up with a file extent item in the
> log tree that represents a hole and has a disk address of 0 and an offset
> that is greater than zero (since we trimmed the front part of the range to
> accomodate for a file extent item of the new write).
> 
> When this happens 'btrfs check' incorrectly reports that a csum is missing
> like this:
> 
>   $ btrfs check /dev/sdc
>   Opening filesystem to check...
>   Checking filesystem on /dev/sdc
>   UUID: 46a85f62-4b6e-4aab-bfdc-f08d1bae9e08
>   [1/8] checking log
>   ERROR: csum missing in log (root 5 inode 262 offset 5959680 address 0x5a000 length 1347584)
>   ERROR: errors found in log
>   [2/8] checking root items
>   (...)
> 
> And in the log tree, the corresponding file extent item:
> 
>   $ btrfs inspect-internal dump-tree /dev/sdc
>   (...)
>         item 38 key (262 EXTENT_DATA 5959680) itemoff 1796 itemsize 53
>                 generation 11 type 1 (regular)
>                 extent data disk byte 0 nr 0
>                 extent data offset 368640 nr 1347584 ram 1716224
>                 extent compression 0 (none)
>   (...)
> 
> This false alert happens because we sum the file extent item's offset to
> its logical address before we attempt to skip holes at
> check_range_csummed(), so we end up passing a non-zero logical address to
> that function (0 + 368640), which will attempt to find a csum for that
> invalid address and fail.
> 
> This type of error can be sporadically triggered by several test cases
> from fstests such as btrfs/192 for example.
> 
> Fix this by skipping csum search if the file extent item's logical disk
> address is 0 before summing the offset.
> 
> Fixes: 88dc309aca10 ("btrfs-progs: check: explicit holes in log tree don't get csummed")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to devel, thanks.

