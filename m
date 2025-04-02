Return-Path: <linux-btrfs+bounces-12743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47995A785C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785C51891831
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767A469D;
	Wed,  2 Apr 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yomqn9/9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O16pMno8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yomqn9/9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O16pMno8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE6367
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743554402; cv=none; b=e8+ASNwFMPEiMHwXe9aCMgWtfuhajNIy8NJ2fl2JdAchKR2BPGQiCV59qEXp3G4PZYioZX2xJC1z10M3JCty6q525VvwwkgVpfmAn5+BerP60f+/P65R/ieb0o5vmneM/SbWneCTQTo3INpu/4PLtunQ3mqhC7l7gIq3dh1TVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743554402; c=relaxed/simple;
	bh=z2B5YjIB4oYvaZsEOHCBNEvTdcpIpeTogsGQxSEEw3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bi2CaDmaGtuZCWWrIqr/TwQV0x553Livz5y8xkiV8O3gweRpFdUoQIJWGWMDslsmu3z4Y5EqUIZjvBophtcZKNFpFw0VKEdf5nijalQex071/VMZqSaWnxg2hz7Rxd4VQRgYb01g/q+kNJVX3skqek6Y400FVGvZk/ck4M5meYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yomqn9/9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O16pMno8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yomqn9/9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O16pMno8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEAD921190;
	Wed,  2 Apr 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743554398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZELMXrDDi8OMD1456rnHchikUYfhobdUai2buY9MSk=;
	b=yomqn9/9beIafcKRimsvUE0+i2Q1fIG9+QQJI+YlXaFJfd0tMDXXYo5RhMSfgN47yFD197
	Ko4w/mZkU/kI0AqfNtcVLHYMjsMsqdVNH5i21EdbesmZu4LMCdF7yDEfZ17jiszlnJ0R99
	3vQAjuRlGkSLsEca6ApG/Ur4+F2m65M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743554398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZELMXrDDi8OMD1456rnHchikUYfhobdUai2buY9MSk=;
	b=O16pMno8hxBy3VeP+u4H0ucZa3Px4IALsE/w0Mb3SNweggYRtPBpCeG5ouczXIQjWUKyzE
	6P90/kFlqY6cAeAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yomqn9/9";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O16pMno8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743554398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZELMXrDDi8OMD1456rnHchikUYfhobdUai2buY9MSk=;
	b=yomqn9/9beIafcKRimsvUE0+i2Q1fIG9+QQJI+YlXaFJfd0tMDXXYo5RhMSfgN47yFD197
	Ko4w/mZkU/kI0AqfNtcVLHYMjsMsqdVNH5i21EdbesmZu4LMCdF7yDEfZ17jiszlnJ0R99
	3vQAjuRlGkSLsEca6ApG/Ur4+F2m65M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743554398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZELMXrDDi8OMD1456rnHchikUYfhobdUai2buY9MSk=;
	b=O16pMno8hxBy3VeP+u4H0ucZa3Px4IALsE/w0Mb3SNweggYRtPBpCeG5ouczXIQjWUKyzE
	6P90/kFlqY6cAeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 926251373A;
	Wed,  2 Apr 2025 00:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVonE12H7GerMgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 02 Apr 2025 00:39:57 +0000
Date: Wed, 2 Apr 2025 11:39:51 +1100
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: do more trivial BTRFS_PATH_AUTO_FREE
 conversions
Message-ID: <20250402113951.06f43687.ddiss@suse.de>
In-Reply-To: <b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
References: <cover.1743549291.git.dsterba@suse.com>
	<b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BEAD921190
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi David

On Wed,  2 Apr 2025 01:18:06 +0200, David Sterba wrote:

> @@ -308,7 +308,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
>  	bool locked = false;
>  
>  	if (block_group) {
> -		struct btrfs_path *path = btrfs_alloc_path();
> +		BTRFS_PATH_AUTO_FREE(path);
>  
>  		if (!path) {
>  			ret = -ENOMEM;

This one looks broken. btrfs_search_slot() needs it allocated.

