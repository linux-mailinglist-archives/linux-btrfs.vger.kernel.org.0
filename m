Return-Path: <linux-btrfs+bounces-6860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E79401D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDB11C2200E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CDB18EFD9;
	Mon, 29 Jul 2024 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zD6i42wL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MoA5nKV3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W310e72W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/JInFd3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A1E49E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296836; cv=none; b=G+cW6J7VnPGzj5czkz5PETzy3VQGMQ5tLkrUtDQopbeekPZMVoRsOsCKFDOmvIJTauYmpWpgqBtMkPVcEcnq5sLpop9tcMWlPmKhljY45I0jMTLLq9tG7Afsxy0lnrWUGfIAkEOE9RgY+1fTY0AROBy3tBBbSSv/JvH5YbH2+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296836; c=relaxed/simple;
	bh=HwxYHS33fRxxC3/3k7WBJkgHnabtbFB6xXZXocm/zkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDtgMIHVNPnyHVnZ+ERHtC7ApXbHoS6uMo7x4ke2vXSjmJBOT2eDOrHLzdHneRtmkimYC7ZGbnqHj2NvFuNej2sf22+691ziHqGx1kNG0UW7B2qLByClKv+lErr2qTwPB+os8jQ0qkgV99h3X+N4OEjw0GJ5NRVDdCwyrF+P0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zD6i42wL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MoA5nKV3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W310e72W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/JInFd3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77CEC21B45;
	Mon, 29 Jul 2024 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722296832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N0EIX7Z0XuD8q6B0sqPg2VVLcE7DX7wDxiGblEeII=;
	b=zD6i42wLfUsKweLbSKUG8Z7zA92Zzlja7tP/cgoz1ZbZhBU+T+RirR+McFX14cOHy9JeSM
	Uowhn89mDUfg3yKzcvQIICO9ALGWGed/zPwh1HIvBukwiZDwqpG5AYx77PBzUClP27B6+d
	KZ4FsGSPq0DmwORtDQvgwqQsRZvBrCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722296832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N0EIX7Z0XuD8q6B0sqPg2VVLcE7DX7wDxiGblEeII=;
	b=MoA5nKV3aQC04e+E3KTZjVdsBqPWIcEtOZqyKGta09IBqT+Nllc7bgKLl3MHuXf7Bx9eNU
	0i5JAgwZChiDH1DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W310e72W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="k/JInFd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722296831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N0EIX7Z0XuD8q6B0sqPg2VVLcE7DX7wDxiGblEeII=;
	b=W310e72WK5p6jq/ZJUZvntmhGiYlnRxKg4Qmd2186Vxb1B/qSewwJ+Gpvq2tUdHqTfQn5U
	rhB3FFuzG2zeLDGDU9QFY9aYItSwKa3R3vqdWiWucxHfgF6REuUC3WhnVnVTMhOCfkqQiS
	rMXid1uwbPeRvdzlxfvNmMb3HIvJUTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722296831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N0EIX7Z0XuD8q6B0sqPg2VVLcE7DX7wDxiGblEeII=;
	b=k/JInFd3doOWBiRcz3wjUwV3DeE4YRWGCxeBw57Lcu5FZ/GuVVknRtIKvxy3rM73HqUqvN
	wfm84HRD/gwTuKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65D991368A;
	Mon, 29 Jul 2024 23:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+1hGP8pqGb9eQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 23:47:11 +0000
Date: Tue, 30 Jul 2024 01:47:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: simplify mkfs_main cleanup
Message-ID: <20240729234710.GX17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240722143235.1022223-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722143235.1022223-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 77CEC21B45
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,fb.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Jul 22, 2024 at 03:32:24PM +0100, Mark Harmstone wrote:
> mkfs_main is a main-like function, meaning that return and exit are
> equivalent. Deduplicate our cleanup code by moving the error label.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Added to devel, thanks. It adds more code but at least removes the exit
block duplication. The 'success' label can be further moved before the
'return !!ret' so we don't have two exit points.

