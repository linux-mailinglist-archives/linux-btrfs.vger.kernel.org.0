Return-Path: <linux-btrfs+bounces-2114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C8849F3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC21C21BE4
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965B33CF6;
	Mon,  5 Feb 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LxHABtr1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlrvhEnM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LxHABtr1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlrvhEnM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA52DF87;
	Mon,  5 Feb 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149081; cv=none; b=HTcVZVzpDAwmSQmINzcwPohAOHlQW/X+Iux6HboKfPasQi0RBD93nTrhpgJ05shxC9aVDdE9bJIsgAE5KhIhc3pe8kIyCkms3lEWIFug5+lPrhZkmAzSWRVs7gI29/YmW708dMyeD036UDYjnTxmrxK2PV3zfRyR0eI6AT1Mn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149081; c=relaxed/simple;
	bh=LY1woPs2w7IdncE7cHCuLOftAXsdnvsS/3dBDGoJ5Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgQlCu7u3FXQ583xFMktaNHmKLQS4Buol5zUTEPDUdkSJxBJhf+53GXhwlnMpsA/sdfIANdBsM8m8CW76jQRHeFeq+LfOcMNStSwgw9WalOi6RIL8T6RxL2mfmebsKGI3KrfaU8V0BAlv733BB6/RdWvrYWVrLpPLPOnKsx1t34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LxHABtr1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlrvhEnM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LxHABtr1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlrvhEnM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FEC622167;
	Mon,  5 Feb 2024 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707149077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWfJS+gwVj+PUGX+6rqFWBY+Qy089fOxJXy1xT8gFLI=;
	b=LxHABtr1VV4i598J0WC8E8T+bX8nRiCa64d7hrWW3cEyAyvaDHkJ3n9P+IsWu6sOEnuGzw
	n+KSPridy1JuAk4e8Jv0PD7ydOcEV4iVFkKumFhkTpdxhUUo6U2MckvqGAW8yyVA5jmVSA
	nlr7ZdozrEFWOL2pMbHDwxSopcX5VXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707149077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWfJS+gwVj+PUGX+6rqFWBY+Qy089fOxJXy1xT8gFLI=;
	b=XlrvhEnMEdD0jy3dA/L4oZOe0uEy8+FFC0bZPmzlEUGSCa3aMitP1D7lRqCDYaGFj00XnA
	pj4FvNVweZ4z/4CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707149077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWfJS+gwVj+PUGX+6rqFWBY+Qy089fOxJXy1xT8gFLI=;
	b=LxHABtr1VV4i598J0WC8E8T+bX8nRiCa64d7hrWW3cEyAyvaDHkJ3n9P+IsWu6sOEnuGzw
	n+KSPridy1JuAk4e8Jv0PD7ydOcEV4iVFkKumFhkTpdxhUUo6U2MckvqGAW8yyVA5jmVSA
	nlr7ZdozrEFWOL2pMbHDwxSopcX5VXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707149077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWfJS+gwVj+PUGX+6rqFWBY+Qy089fOxJXy1xT8gFLI=;
	b=XlrvhEnMEdD0jy3dA/L4oZOe0uEy8+FFC0bZPmzlEUGSCa3aMitP1D7lRqCDYaGFj00XnA
	pj4FvNVweZ4z/4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65130136F5;
	Mon,  5 Feb 2024 16:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dUKDGBUHwWXLCgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 16:04:37 +0000
Date: Mon, 5 Feb 2024 17:04:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	Johannes.Thumshirn@wdc.com, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Message-ID: <20240205160408.GI355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240201084406.202446-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201084406.202446-1-chentao@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LxHABtr1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XlrvhEnM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.20%]
X-Spam-Score: -1.23
X-Rspamd-Queue-Id: 7FEC622167
X-Spam-Flag: NO

On Thu, Feb 01, 2024 at 04:44:06PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> Make the code cleaner and more readable.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
> Changes in v2:
>     - Update commit msg only, no functional changes

Please convert all kmem_cache_create calls where the KMEM_CACHE macro is
suitable, ie the cache name and the structure name match.

