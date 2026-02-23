Return-Path: <linux-btrfs+bounces-21848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMoNL+iinGnqJgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21848-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 19:56:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0517BE4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88345307C9CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD536A024;
	Mon, 23 Feb 2026 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZ2MCy4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZaQX/0S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZ2MCy4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZaQX/0S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5436923F
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872933; cv=none; b=DOkUzabxAUs7VSJevY3Cb5gENXic8mFZ0IKkTPj6xwJsP1/b66pLHYF6/i3xrX7OsiKRAxgDm17fzaTLyG4H4ZZz+rTj+SmA0cNOD9dwPfK9Js5589nfimxrDCeeomkVgK266kn1OyQzBhtwIAH0Bnx8P2H5AQUBQaXJxfwhERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872933; c=relaxed/simple;
	bh=IbXsTTXVhH3CHedr1wqXSPyN2lvsmw/q1HIapTxMUps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8/tS/0rCcxVrRDN1hXoY3dlou8S0UmvQVbyHc64deHdO181juybDcktG4ZrJ73l01/hDgUV2MuLxXFETki+6u8fyA6omGsvnUFXtIr1yvFvINyWqxXaW+VIhFNegVjgBhkyJHRTl+nVO+NpySCZgSHNgGjdADR5ZhtCWpK/Pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZ2MCy4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZaQX/0S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZ2MCy4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZaQX/0S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47ABF3ED67;
	Mon, 23 Feb 2026 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771872929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gup9FBAT5KcIJm2vrHB8DcYq2Bf4l5SQ8E/bLZOR2M=;
	b=LZ2MCy4zzucH4hs+QrG7ZeR9t8nuWCFon5UbG76wVhn9B/8I9uFZ6q/k/dBWPlN69VctM6
	hvwqhiSZeS94MXoBVMpAHR3UQK+oqcgjhgYISpsFMR7frayVUAuMmwMYgyxyCKB6tLA9S3
	JfhKRCAViDejhBObMf/L+WldHomPSIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771872929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gup9FBAT5KcIJm2vrHB8DcYq2Bf4l5SQ8E/bLZOR2M=;
	b=bZaQX/0SQJMOOuhYrXesVGcr/jKJaJSuuWVhu+T1G6G/wrr8boqsCi+bKysBZlY2aJkXjM
	zahxlbGtWiJA+cBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LZ2MCy4z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="bZaQX/0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771872929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gup9FBAT5KcIJm2vrHB8DcYq2Bf4l5SQ8E/bLZOR2M=;
	b=LZ2MCy4zzucH4hs+QrG7ZeR9t8nuWCFon5UbG76wVhn9B/8I9uFZ6q/k/dBWPlN69VctM6
	hvwqhiSZeS94MXoBVMpAHR3UQK+oqcgjhgYISpsFMR7frayVUAuMmwMYgyxyCKB6tLA9S3
	JfhKRCAViDejhBObMf/L+WldHomPSIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771872929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gup9FBAT5KcIJm2vrHB8DcYq2Bf4l5SQ8E/bLZOR2M=;
	b=bZaQX/0SQJMOOuhYrXesVGcr/jKJaJSuuWVhu+T1G6G/wrr8boqsCi+bKysBZlY2aJkXjM
	zahxlbGtWiJA+cBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D1233EA68;
	Mon, 23 Feb 2026 18:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8lTlBqGinGl6DQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Feb 2026 18:55:29 +0000
Date: Mon, 23 Feb 2026 19:55:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix error messages in btrfs_check_features()
Message-ID: <20260223185527.GN26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260218111346.31243-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218111346.31243-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21848-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harmstone.com:email]
X-Rspamd-Queue-Id: 34D0517BE4A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:13:40AM +0000, Mark Harmstone wrote:
> Commit d7f67ac9

Please use full commit reference in changelog text at least for the
first occurence, the format is the same as for the Fixes: line. Thanks.

> introduced a regression when it comes to handling
> unsupported incompat or compat_ro flags. Beforehand we only printed the
> flags that we didn't recognize, afterwards we printed them all, which is
> less useful. Fix the error handling so it behaves like it used to.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: d7f67ac9a928 ("btrfs: relax block-group-tree feature dependency checks")
> ---
>  fs/btrfs/disk-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f39008591631..7478d1c50cca 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3176,7 +3176,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>  	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>  		btrfs_err(fs_info,
>  		"cannot mount because of unknown incompat features (0x%llx)",
> -		    incompat);
> +		    incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP);
>  		return -EINVAL;
>  	}
>  
> @@ -3208,7 +3208,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>  	if (compat_ro_unsupp && is_rw_mount) {
>  		btrfs_err(fs_info,
>  	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
> -		       compat_ro);
> +		       compat_ro_unsupp);
>  		return -EINVAL;
>  	}
>  
> @@ -3221,7 +3221,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>  	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
>  		btrfs_err(fs_info,
>  "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> -			  compat_ro);
> +			  compat_ro_unsupp);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.52.0
> 

