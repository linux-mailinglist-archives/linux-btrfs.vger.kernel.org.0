Return-Path: <linux-btrfs+bounces-16567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB9B3F14F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 01:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD83202A2E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 23:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655F21CC59;
	Mon,  1 Sep 2025 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhx0hrLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nzr/b02u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5DTLhTo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfBszQlD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544D32F771
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756768540; cv=none; b=IE3To7EzFxt9jE4NVu3xD2RgsBjVQ0OLMgkCPC1ErKOTONWn4QY//aS/d+aBNcitlmIY4SdAh1ra/5GtR9BuVyAtVT0BT9ITYh8CWih2dcOQ/q/mF+taG/hCvi+Q8wjQ1VShJwpsey2lTzufnAtjkWkQha1L2XxXvEoQp6YoTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756768540; c=relaxed/simple;
	bh=4loYJ3YwAINXrMNt8sykofdd5ooL3NfV1s6mDv+rh5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTfaMqwf10KJIUAQmWWT7m1js9FUf+BWg8VQOsFBUoHVZUk6dBksvp9wqehsYwDIGSyoTOUEziQLNa+Z8zm0ZOsws874qLwyXxtMizqq9iYoG5oOGbQtA/neNnd2edZ8ejjKef9AYBhP6DTFq4uP5RFxmxSua8ImejcswKNPwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhx0hrLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nzr/b02u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5DTLhTo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfBszQlD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B9171F395;
	Mon,  1 Sep 2025 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756768536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzam8byHsUvTgJFvJ2N8yzGVJ4cO9hYJHCrxOyLYYAc=;
	b=qhx0hrLo7RktLV9CJo0AhAZdfT332oey+HbRzUcAyWCA+wxtzL5H25tqVriCArWpfgJxxZ
	iE21tcye7ZVkpqOAeFvDw+bAIswV0GfuRU4qN7ox8kor09MC38lv/9GQ5/gBB4iejTv7rF
	F7Pljq3GPmTtA54oBM6KRTBL+NavqZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756768536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzam8byHsUvTgJFvJ2N8yzGVJ4cO9hYJHCrxOyLYYAc=;
	b=Nzr/b02uNrq1Pgbun+4Y5+fYTqTU8f1DiKezW0W787jHK55K6EghMbQ+Q0I+5Grf4zPocd
	k7MGWlIenMgNTyBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q5DTLhTo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DfBszQlD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756768535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzam8byHsUvTgJFvJ2N8yzGVJ4cO9hYJHCrxOyLYYAc=;
	b=Q5DTLhTo4a5gYnHWQv0DMhgo9J5YQDjhY5HyB6nsND13JZA25eCOgUuVbN2foeZMUJrrSq
	aFYT75g05eQrqWesH4e3FcxrhK8Uh4Aj/Mn++ofenle6/gkMpMDRTdbNDIBfJoaroJZeWn
	23gNUe+TEcVOpVMfpe2mEveCwjFsrNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756768535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzam8byHsUvTgJFvJ2N8yzGVJ4cO9hYJHCrxOyLYYAc=;
	b=DfBszQlDqU6gwPCpwhclbH1j8oRrHYl5K1fnvSLSU1k1IFs7Hc+jZjMwLmzEkjRypeNACO
	gIgkqg6WeeHd+gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A2811378C;
	Mon,  1 Sep 2025 23:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJS8DRcptmj7YQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Sep 2025 23:15:35 +0000
Date: Tue, 2 Sep 2025 01:15:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Message-ID: <20250901231528.GF5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250901073826.2776351-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901073826.2776351-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4B9171F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[wdc.com:email,suse.cz:dkim,suse.cz:replyto];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Mon, Sep 01, 2025 at 04:38:26PM +0900, Naohiro Aota wrote:
> We need to recow the stripe tree as well. If not, we leave the tree node in
> the temporally SINGLE profile block group, and we cannot remove that SINGLE
> metadata block group.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to devel, thanks.

