Return-Path: <linux-btrfs+bounces-4069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAEC89DE57
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA12294FAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642213C9D2;
	Tue,  9 Apr 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXVD5odn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fj1Qw+LQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltrw0Tvp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J671nK/5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D6137C4F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675247; cv=none; b=LwRoCQeIf+Nbx5SPD/3YskyTN1LUy2LLv2VWTv15nKKTixfTHD+un2eTMjXyIDqNhlShesXxkpCikF5TteBekEYM/8oSA9g4hhQjOwrNs+ZgcXFTu4RfCQ/lkuCwsvJy9QxgUbow9ECTISAxoIN7+6xJtLY9bIhadBDyViZ+QOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675247; c=relaxed/simple;
	bh=aKdkYm60iOrfQHZPAFHGvKLMScf/Jx+NMe/rNMcfkT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI4Hkmq13hi0H4xvaar3GJF3pGOY+k9miSpt9FRzvzupjcdq3oMghPblIO0PVLiiwzw2wIy5q5w4195mRsBa1SBpv+TKvWnX5/GWWzBWLHmVmUhROJP0zqxGckg61KNYVOWiD+pRqd3G/ref9ULz0lRafvR/3a/RkY2ZQeO8pHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXVD5odn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fj1Qw+LQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltrw0Tvp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J671nK/5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B783220A85;
	Tue,  9 Apr 2024 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712675243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu3u2LV47YsbfUGeA74x00GCoM+ThDkJeGZUaWkSds=;
	b=pXVD5odn/C4fBvABc79ANjmFOk3Ao+7nVVRJpJ+Tq4YMxtlMi/y7mTIB60An5fdAIzl3a0
	lm/74afawV0onhS8PEY9B5nNB5DdDR++OKq14nuR7u9Wog3cudba0aVJTIW0u77Othmlym
	rakk4pQAt9HsEE59xZ9RZtQdf0gFZYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712675243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu3u2LV47YsbfUGeA74x00GCoM+ThDkJeGZUaWkSds=;
	b=fj1Qw+LQxey+nS0TUPAK4xmrJxswVe9Xfgfu67ZAHeOYC21f3Iy1Qsx/OaeLriJUbkve57
	Iafs48a932lnP5Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712675241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu3u2LV47YsbfUGeA74x00GCoM+ThDkJeGZUaWkSds=;
	b=ltrw0Tvpo6cqReJnmwgW5U5CAHyebngkg9hM/Zzhm/heTvz1Cb01YsBF8hOfH3RlVx4+bS
	2uNtN/lZatVnLdhocnnSOXuLAiovHsLPciyUFjsKzRqDFCAQKZ4mCI9Lh1Bh2m66gaA11i
	ESQ+EBcylCcNiZuC7KFyWA9IfrzyTmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712675241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu3u2LV47YsbfUGeA74x00GCoM+ThDkJeGZUaWkSds=;
	b=J671nK/5wYFgVkKN4ustvwtwg+4vV2JGKkR6iHIeCd/p+aez/qtxi8Xi8pLX+lQL32IMwM
	shPM1htACSsW+MDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A822F13253;
	Tue,  9 Apr 2024 15:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id feY+KKlZFWaEFQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 15:07:21 +0000
Date: Tue, 9 Apr 2024 16:59:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] btrfs: remove extent_map::orig_start member
Message-ID: <20240409145952.GI3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712614770.git.wqu@suse.com>
 <37f412e3ba65036c94ba9b178e7f1ab9b928c4a5.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f412e3ba65036c94ba9b178e7f1ab9b928c4a5.1712614770.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -6.17
X-Spam-Level: 
X-Spamd-Result: default: False [-6.17 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-1.17)[88.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:replyto]

On Tue, Apr 09, 2024 at 08:03:44AM +0930, Qu Wenruo wrote:
> 
> @@ -877,7 +873,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>  	TP_STRUCT__entry_btrfs(
>  		__field(	u64,  bytenr		)
>  		__field(	u64,  num_bytes		)
> -		__field(	int,  action		) 
> +		__field(	int,  action		)

Also here and in the following hunks, trailing space, please drop that.

>  		__field(	u64,  parent		)
>  		__field(	u64,  ref_root		)
>  		__field(	int,  level		)
> @@ -940,7 +936,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>  	TP_STRUCT__entry_btrfs(
>  		__field(	u64,  bytenr		)
>  		__field(	u64,  num_bytes		)
> -		__field(	int,  action		) 
> +		__field(	int,  action		)
>  		__field(	u64,  parent		)
>  		__field(	u64,  ref_root		)
>  		__field(	u64,  owner		)
> @@ -1006,7 +1002,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
>  	TP_STRUCT__entry_btrfs(
>  		__field(	u64,  bytenr		)
>  		__field(	u64,  num_bytes		)
> -		__field(	int,  action		) 
> +		__field(	int,  action		)
>  		__field(	int,  is_data		)
>  	),
>  
> -- 
> 2.44.0
> 

