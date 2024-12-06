Return-Path: <linux-btrfs+bounces-10097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89BB9E76D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5599D1881ADB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CD1F3D38;
	Fri,  6 Dec 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0dNcc6X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lFXPF/oT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHpqophH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="axxbBfcm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD8206296
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505395; cv=none; b=EB5q0QGO4yWNbAhoyG7wmv9LPzzMHYc19J3v8cea4K8/1bpxRrlsnLUxdX9R5SWhhYIlB7p46bBAekKVohX9ZenmO6d9nA/cZjLnRZ4V0s8rmSXS7rDN5bxHqI9UX8rpplSYzDYfiVSWzP4P46b3ygIS1EbrNjE8FJEmYeIw4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505395; c=relaxed/simple;
	bh=/pY+VmWVZHClrhbFWiMF255Pt/EeXnwDJnvpp52UsUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oaoyf4nppA8+wQKCifXwkgbzokXEy0noultVxjrOD3+mbibE51arpFLBOIHTFV5W8q3kQKAZszkapTYRKSm63gutdIGH380kSoVx3KLxAgEQ0J52UqFtaSjiUHNmHuIvn2x3DkIH2DsTKmb2Hxn/XKuR/n6WaoEpFII8mD+pOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0dNcc6X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lFXPF/oT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHpqophH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=axxbBfcm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE6F01F37E;
	Fri,  6 Dec 2024 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7N1AHxBpnoEORCnvDqTrTyulIzNoDkxNXlPn6I0vuQ=;
	b=L0dNcc6Xs4b5tWRko0dXYfA8056VZ+ko28/ksNkcjDHhMKlYgDBKhve6N8E+p85Jl2n/rD
	uhTk7YaZnz15Ff1fGQNekaRUxPmX3nIAWk+tgVttQw7c4A8MhCn2sJdYPLR+CfBbn32IbM
	ttR1ixVyW55x1+ReF59CRpIfULhSr2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7N1AHxBpnoEORCnvDqTrTyulIzNoDkxNXlPn6I0vuQ=;
	b=lFXPF/oTUAhOjcyha3kaY+ns9jGKaCvTl/nwWWpydCl0oqiGLS7fhE/Ap19sVUJkjEEuhQ
	6ZXHhuHIhGZX2eDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7N1AHxBpnoEORCnvDqTrTyulIzNoDkxNXlPn6I0vuQ=;
	b=gHpqophHF9DmdGZJgUMdvNdy5vx6WXb2li/3Mt4/Pt6uXJ4F2mEwr7NNwJixY0X7QppXJw
	qdVzr3hi3xtvUYPwFp+RLcgMkYQTdlhzPdzFlFwZhv5ugKxAKgNNvHwrBdQxlczCiYllKr
	KL4nEBL/0zCrl+jZmWGXp2mm7ww/4Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7N1AHxBpnoEORCnvDqTrTyulIzNoDkxNXlPn6I0vuQ=;
	b=axxbBfcmyFOHPDwNnPdF23g0L0HDBoQEyHEPlPs0vBtyg9C4E2FxJDZ8rJDynMOKyVSHed
	vd2mmyVaOCTazkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA7B13647;
	Fri,  6 Dec 2024 17:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ftmFLW8xU2d+GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 17:16:31 +0000
Date: Fri, 6 Dec 2024 18:16:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 07/10] btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
Message-ID: <20241206171626.GI31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731076425.git.anand.jain@oracle.com>
 <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 15, 2024 at 10:54:07PM +0800, Anand Jain wrote:
> Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
> CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
> features, print its status during module load, like so:
> 
> Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6cc9291c4552..d52f7f6e2de7 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2487,6 +2487,11 @@ static int __init btrfs_print_mod_info(void)
>  			", fsverity=yes"
>  #else
>  			", fsverity=no"
> +#endif
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +			", experimental=yes"
> +#else
> +			", experimental=no"

I think this should be the first in the list so it's obvious. Also I'm
not sure if we need to print it when it's disabled.

>  #endif
>  			;
>  	pr_info("Btrfs loaded%s\n", options);
> -- 
> 2.46.1
> 

