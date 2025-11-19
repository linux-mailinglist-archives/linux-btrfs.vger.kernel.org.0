Return-Path: <linux-btrfs+bounces-19129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F457C6D8EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F38BE387443
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63740330B07;
	Wed, 19 Nov 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5GcAeKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qN7IKcO7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5GcAeKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qN7IKcO7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BA32ED5B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542796; cv=none; b=enpEoqMIhZodfU1aB3ceC72Vwh7MfS/hRztE0lh1MGHtWiTNoN8CnY4zjZUDFYMwv39XDxiHwonl507TNuzd/z3g/x+YCf9TsZsXHQ5w/4eKT+f28GI6A0JPCqgYjaRnKFXHIGIPcoZL0DlQ+DlJiVwhheghma3FEyuLPAKeXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542796; c=relaxed/simple;
	bh=iu8pqDAAcVim5zqksVl+yK6mngAm7KhZIuIh4LP3EeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=einvnj6diKP47ahFA8gQfiiYKHxm04ie+WGTgQElGoT9VPDKoL8/VoFgGhF2QQAgDuKVi+HsXwEBA0zI1LXQzmipnmMjPWk3p/JjYZhOtN5pBXa1PfbRjyu+RlL17Q17VCXBJwK80iya2roslIvyZWy8tTsBZm7Ts0pi98Sq03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5GcAeKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qN7IKcO7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5GcAeKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qN7IKcO7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55D51211C8;
	Wed, 19 Nov 2025 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763542786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu8pqDAAcVim5zqksVl+yK6mngAm7KhZIuIh4LP3EeI=;
	b=u5GcAeKEr+MqqMUtCoL4knNSi4UREwyGlMmyl+x8eEx0NGyFmEikU3BGIxTc2JEyoDp5Xl
	7CvOnT0jaq0vBUuFNHsdwfay1bQFU8wR5RnjEfmMPgh5zyiX5Gxa67etwaZPh+ZdZyOLDR
	/WE9Y7MpdU6P2EatYBgbWhY78yQxHgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763542786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu8pqDAAcVim5zqksVl+yK6mngAm7KhZIuIh4LP3EeI=;
	b=qN7IKcO7WOXCD5tRv7y4vm16C4ZiLcYSyElAslNR99AmDU3OoAKta0jURY44C1Fn7U8ysK
	R57n5XeVplEKWGDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u5GcAeKE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qN7IKcO7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763542786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu8pqDAAcVim5zqksVl+yK6mngAm7KhZIuIh4LP3EeI=;
	b=u5GcAeKEr+MqqMUtCoL4knNSi4UREwyGlMmyl+x8eEx0NGyFmEikU3BGIxTc2JEyoDp5Xl
	7CvOnT0jaq0vBUuFNHsdwfay1bQFU8wR5RnjEfmMPgh5zyiX5Gxa67etwaZPh+ZdZyOLDR
	/WE9Y7MpdU6P2EatYBgbWhY78yQxHgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763542786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu8pqDAAcVim5zqksVl+yK6mngAm7KhZIuIh4LP3EeI=;
	b=qN7IKcO7WOXCD5tRv7y4vm16C4ZiLcYSyElAslNR99AmDU3OoAKta0jURY44C1Fn7U8ysK
	R57n5XeVplEKWGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BD023EA61;
	Wed, 19 Nov 2025 08:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mN1oDgKHHWn4MwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 08:59:46 +0000
Date: Wed, 19 Nov 2025 09:59:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Message-ID: <20251119085941.GC13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251118160845.3006733-1-neelx@suse.com>
 <aR1-h75CvzMHmsJQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR1-h75CvzMHmsJQ@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 55D51211C8
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Wed, Nov 19, 2025 at 12:23:35AM -0800, Christoph Hellwig wrote:
> Patches 1 to 3 just add dead code without the actual fscrypt support,
> which you've not even posted anywhere never mind having queued it up.
> Please don't add this kind of code without the user in the same series.

The fscrypt series is about 50 patches, last v5 iteration is at [1] and
I suggested to pick any independent patches we could ahead of time.

[1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/

