Return-Path: <linux-btrfs+bounces-9178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F59B0D9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 20:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5911C22BF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242A20D504;
	Fri, 25 Oct 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/wyJok4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/i901wI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/wyJok4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/i901wI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8F20BB35;
	Fri, 25 Oct 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881879; cv=none; b=G0xTnfYlnWCyKIkhUgLChIX1jrTpFH0nqVWgmEpgcE/0cKe2zp5Tk+jCpeUIFNMiROmj/DcVLNQXLOretvEFGboz9Odo3Mvsk3QUPytVNR9FnS5UNABttr4fOWEzzIU95zrmQxE4EzA+A8/13Zm1yK4Iq7qL2mcQHTTsmD2KptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881879; c=relaxed/simple;
	bh=/SFf9qrwlu7lUB5bHzySHCNMwKf60gcLaSnf2rFpe80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHjF8ZmP6TeUmG1ire1XS+cwWUsbD/RM0GZ6mIRk6YxNcnI5OnIXgIczzZHN9vrN+1y+vqhX7X5vRFr6ifBJ91hc10glEXCaPFGX80IOqktOaDlhCmEKNkKffmeilwjhUvp8SKbBtXAbmTDzoZCk5Y/DNiCKcioO1c0Ww2hjs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/wyJok4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/i901wI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/wyJok4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/i901wI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3258D1FB8B;
	Fri, 25 Oct 2024 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmk/Jjg0qqxkKEUPlSILrxgutxCoNzR5GrYgpGaIa/Y=;
	b=t/wyJok41g3yIGyOXZ5t5/T0vzmBRJgyZrAQPqXWdrUjB4IBN3CZUAwd8mfEFQEdwcoQJk
	1VRgk+0rKIcsaLd3DsUxtdQzUhG1LFuzdw/gQongXzAmvfdSZmDCVA9uKrOvDQCvKYPDwU
	c819QSwi2ieMsjd2ibLd2qILaywex4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmk/Jjg0qqxkKEUPlSILrxgutxCoNzR5GrYgpGaIa/Y=;
	b=x/i901wIfIsJyeBKVsNA9dL5CRxIp+cjplNkbzF4U7TsMIHOUY0wmdAW9N3kmPUCcaD6gP
	ClHudkT7obYJtpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmk/Jjg0qqxkKEUPlSILrxgutxCoNzR5GrYgpGaIa/Y=;
	b=t/wyJok41g3yIGyOXZ5t5/T0vzmBRJgyZrAQPqXWdrUjB4IBN3CZUAwd8mfEFQEdwcoQJk
	1VRgk+0rKIcsaLd3DsUxtdQzUhG1LFuzdw/gQongXzAmvfdSZmDCVA9uKrOvDQCvKYPDwU
	c819QSwi2ieMsjd2ibLd2qILaywex4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmk/Jjg0qqxkKEUPlSILrxgutxCoNzR5GrYgpGaIa/Y=;
	b=x/i901wIfIsJyeBKVsNA9dL5CRxIp+cjplNkbzF4U7TsMIHOUY0wmdAW9N3kmPUCcaD6gP
	ClHudkT7obYJtpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B73D136E4;
	Fri, 25 Oct 2024 18:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YD9bAhLnG2fPKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 18:44:34 +0000
Date: Fri, 25 Oct 2024 20:44:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com, clm@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: add a sanity check for csum root before fill the
 data csum
Message-ID: <20241025184424.GL31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
 <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[5d2b33d7835870519b5f];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 23, 2024 at 07:04:40PM +0800, Edward Adam Davis wrote:
> Syzbot reported a null-ptr-deref in btrfs_lookup_csums_bitmap.
> The btrfs info contains IGNOREDATACSUMS, which prevents the csum root from
> being loaded.
> Before filling in the csum data, check the flag BTRFS_FS_STATE_NO_DATA_CSUMS
> to confirm that the csum root has been loaded.
> 
> Reported-and-tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5d2b33d7835870519b5f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Added to for-next, thanks.

> ---
>  fs/btrfs/scrub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3a3427428074..1ba4d8ba902b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1602,7 +1602,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
>  	}
>  
>  	/* Now fill the data csum. */
> -	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
> +	if (!test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&

I've updatd the coment as this is double negation that could be
confusing on a quick read.

> +	    bg->flags & BTRFS_BLOCK_GROUP_DATA) {
>  		int sector_nr;
>  		unsigned long csum_bitmap = 0;
>  
> -- 
> 2.43.0
> 

