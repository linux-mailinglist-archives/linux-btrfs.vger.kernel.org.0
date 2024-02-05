Return-Path: <linux-btrfs+bounces-2117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747584A2A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 19:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ADA1F22694
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E119482DB;
	Mon,  5 Feb 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cse12MEv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpuT5GRF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cse12MEv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpuT5GRF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32D482C4
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158713; cv=none; b=BGFGh5DI3lIzIg6MrTLKd6scKgGVteT9bFNLgDFNQpbq79IuL04HHg1vaGwZTNGpQr+98v/6KL2rX18/Lsl88t4Cm+7c0FxrFg1SmvBg8QZmvZPywcBTat9slQ4abNcBu5I0CjXCSxzsSCORI5ol2fHD+YL6bHUy8oNH5x8JLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158713; c=relaxed/simple;
	bh=VbncW1MOEb5glZ2I9OrM2xJ1sD6DKwv+/cEKdlR0Mxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVL3/QManYJTPpOP8r3nmsSD4L7nMg2yKxbsc2jJC3eXooJwP0FqK4O3SGWhgELO9UW5BqkfnaZz6TIemGIMYmNrEIB/Dk4gVCiSJxZ0ecZoGCqKF1lz6W2rrchZI6ARUWmq8UFajwIiTDsQQX+O6p/xMJlqPbj5tMGIYogK4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cse12MEv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpuT5GRF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cse12MEv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpuT5GRF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC9341FB47;
	Mon,  5 Feb 2024 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707158709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpuPxwfp/wM04GXSl6fuV/0DiP72X0SGWEPHaGZhwsU=;
	b=Cse12MEvE6W5FP/BqDyaKaO9lNxc8FpVHOfIUsq0crBiaukSIceqOqUdquY0Cjbzhk1HHt
	8ISvlDvWTiHW6MKseN0aSXBEkyseGdS8Sp4Ek/vKf8IiZbIP3OoePhYzav1WsQCOLNEmR1
	rAR9r06OoVr8+cls8doUNzNeLTqv22E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707158709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpuPxwfp/wM04GXSl6fuV/0DiP72X0SGWEPHaGZhwsU=;
	b=LpuT5GRFYpNcVy76HUNHXIyC1GI7IfdNPws3G2C8f0ncY+zvaL5zcjYrlEOWjWRl4AtxdY
	QWroOkYLaeePeYBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707158709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpuPxwfp/wM04GXSl6fuV/0DiP72X0SGWEPHaGZhwsU=;
	b=Cse12MEvE6W5FP/BqDyaKaO9lNxc8FpVHOfIUsq0crBiaukSIceqOqUdquY0Cjbzhk1HHt
	8ISvlDvWTiHW6MKseN0aSXBEkyseGdS8Sp4Ek/vKf8IiZbIP3OoePhYzav1WsQCOLNEmR1
	rAR9r06OoVr8+cls8doUNzNeLTqv22E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707158709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpuPxwfp/wM04GXSl6fuV/0DiP72X0SGWEPHaGZhwsU=;
	b=LpuT5GRFYpNcVy76HUNHXIyC1GI7IfdNPws3G2C8f0ncY+zvaL5zcjYrlEOWjWRl4AtxdY
	QWroOkYLaeePeYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACFF8132DD;
	Mon,  5 Feb 2024 18:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EZILKrUswWVwMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 18:45:09 +0000
Date: Mon, 5 Feb 2024 19:44:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com, clm@meta.com,
	hch@lst.de
Subject: Re: [PATCH v3] btrfs: introduce offload_csum_mode to tweak checksum
 offloading behavior
Message-ID: <20240205184436.GJ355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cse12MEv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LpuT5GRF
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.46%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: BC9341FB47
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Feb 05, 2024 at 10:01:16PM +0900, Naohiro Aota wrote:
> We disable offloading checksum to workqueues and do it synchronously when
> the checksum algorithm is fast. However, as reported in the link below,
> RAID0 with multiple devices may suffer from the sync checksum, because
> "fast checksum" is still not fast enough to catch up RAID0 writing.
> 
> To measure the effectiveness of sync checksum and checksum offloading for
> developers, it would be better to have a switch for the checksum offloading
> under CONFIG_BTRFS_DEBUG hood.
> 
> This commit introduces fs_devices->offload_csum_mode for
> CONFIG_BTRFS_DEBUG, so that a btrfs developer can change the behavior by
> writing to /sys/fs/btrfs/<uuid>/offload_csum. The default is "auto" which
> is the same as the previous behavior. Or, you can set "on" or "off" (or "y"
> or "n" whatever kstrtobool() accepts) to always/never offload checksum.
> 
> More benchmark should be collected with this knob to implement a proper
> criteria to enable/disable checksum offloading.
> 
> Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Thanks. Now to find a good heuristic for the auto mode.

