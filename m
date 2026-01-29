Return-Path: <linux-btrfs+bounces-21206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCNaEfTCemk3+QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21206-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:16:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B145EAB127
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF407301A400
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6835503D;
	Thu, 29 Jan 2026 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RiAbDkU8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXMe4CZ+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbQYSRUD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUhOiByO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AA354AC0
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652972; cv=none; b=cQUpV1HrTx6orIYsbt6PeiM1j2+s07x0fbcyoGYGGPZEJgb6xkD5Gvp9DpYB+EKuSinaoTzqZoNSi8q/1lsZ8k8aWs0NCxDr/ohchHe+Rp7EmceXm2sLZGJfhDy9QwpLTBywKtZE1fdnJXdZcFQzaZc1EC4VBuRsFftgKLbu6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652972; c=relaxed/simple;
	bh=my9hgD2EsdfA72g86wwYz//EjhOTx99sDKpdWgF22kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOT7XncZ11pjOvrZod4XjwXawXynV9bn/0mab7O7ZEdDSLagG8vo6sxAh2/1+eR6lvCgLV0YiUsowsyycgR1pEpfMUBhtkiwwpAJw6Ic/l2PF0JQ1zi/9dkl6VP5YJ76ZAOOXinb19krUZ+crWbMRtPqUs2u4XnPaiVyLtTZhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RiAbDkU8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXMe4CZ+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbQYSRUD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUhOiByO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA1B65BCF3;
	Thu, 29 Jan 2026 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769652968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiHottw9zoYs1jFLVmE3fBlSrWY+mCtETvmuulyrpyM=;
	b=RiAbDkU8ysw1Guc8GmlSpZyw608mQpYwc+JMoSSJcSrwBFCkvEniVsb33AvUcssthHsri5
	92DGyYqFMLB1eDtTfJ8zNQ5hplZ5vcwHbtrzQO3whPzLSfqb5/q66fPP59oYRaJXFbGGd4
	iHyQOvF3j9j2XPFs23MoO5bG5RTW+AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769652968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiHottw9zoYs1jFLVmE3fBlSrWY+mCtETvmuulyrpyM=;
	b=aXMe4CZ+wvCwx0jPSheqm5s8zEK5belLBaA0di7aeyauke2Ze7XSgANMtVD9D7sFDjiE6p
	V2jX6rScI7lAhwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769652966;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiHottw9zoYs1jFLVmE3fBlSrWY+mCtETvmuulyrpyM=;
	b=LbQYSRUDWUfCEYjZOWFvlDYCG43N7mhNtH+wVfZW2+jkaQbFuIkjd0HcUoQtV3AWur2Co7
	BScEHykdT+YYaZ+0ofdBu1T3WACYWtG2H1Uz+G76wpCbJge9gL+7/HCCfGNEYD5ihLQiUJ
	vGWjQhAyW8LVb9e4elD+dZs1fVdkAH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769652966;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiHottw9zoYs1jFLVmE3fBlSrWY+mCtETvmuulyrpyM=;
	b=pUhOiByOpV/dQyKdGXFag9nZK6W0Nf0qfUqWC5spOkU8tXrRS6gbbJYrS3M3sQpnGd+E4/
	CKGOyOWo/MvbcHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943883EA61;
	Thu, 29 Jan 2026 02:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d0j8I+bCemnDEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Jan 2026 02:16:06 +0000
Date: Thu, 29 Jan 2026 03:16:05 +0100
From: David Sterba <dsterba@suse.cz>
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org, dsterba@suse.com,
	robbieko <robbieko@synology.com>
Subject: Re: [PATCH v4 4/4] btrfs: fix transaction commit blocking during
 trim of unallocated space
Message-ID: <20260129021605.GH26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260128070641.826722-1-jinbaohong@synology.com>
 <20260128070641.826722-5-jinbaohong@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128070641.826722-5-jinbaohong@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21206-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz]
X-Rspamd-Queue-Id: B145EAB127
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 07:06:41AM +0000, jinbaohong wrote:
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6493,6 +6493,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
>  	unpin_extent_range(fs_info, start, end, false);
>  }
>  
> +/* Maximum length to trim in a single iteration to avoid holding mutex too long. */
> +#define BTRFS_MAX_TRIM_LENGTH SZ_2G

We have such constants in fs.h so it's in one place and more visible,
I'll update the commit. Thanks.

