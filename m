Return-Path: <linux-btrfs+bounces-15678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD6B12437
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FBE16E096
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF9253B7E;
	Fri, 25 Jul 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="11oSBoAp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UwMMlQW/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wao5VM+i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWRRdGqy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A624C664
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468900; cv=none; b=mknbO/Mn8cjYwzFm+x965kJS8jd9BOqXeqGqaj108xTfx0Vndwp167qqKj2m5uZe8Ik1lOacIB8dXwGgjN6hlMXRK21HIWzVLa3S0gM1bD8+9ZBMCsgv3wAALzS80kfZadHzhx90xXmY5OHayMLCHDKksKX8r33rMvJxyvVu0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468900; c=relaxed/simple;
	bh=vlCFY1+c/YQRlVemiItdmcSjVrUjDve39ibGDw757Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqS/iUc1XHmuU7daDX9Zvn9jrGbxKxGoNqrP77dxaxrQM9fxGnExBpaXxbexymevxwpn1lg+r4cTOVfvTw5ZzyFgGHSRg/z+CaJRedZc7iny1qL/b71fehIx61tmfKsa4UBIpg3rTGhvgXATFendBsou3lu4WnvBuUub44GPHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=11oSBoAp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UwMMlQW/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wao5VM+i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWRRdGqy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D46DA1F387;
	Fri, 25 Jul 2025 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753468897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLb3ZS1Lma0kMjsp4vlE6ge1CNxXdZcPoGs7g1gs1d8=;
	b=11oSBoAp6qgeCyd7ds5J0iakNZfy06CqeeBA8y1uVA3WxOeupSISyhORIo7AFIBcxcUnpI
	wfrOK7wlS8A4X3/mac6EBouMh+/Jp32wsa4TTXXFZhn8SVb/izs0Fl1Ofiktnm5yz15Y9K
	pJf1VkalmlbHUnqSP1Esd0p0EV+JvG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753468897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLb3ZS1Lma0kMjsp4vlE6ge1CNxXdZcPoGs7g1gs1d8=;
	b=UwMMlQW/kW9tjZ2Qi9kKU0Wd+eTwUwav5bz/qmhIyISeSzujtj5apv+jjo5A5PIIGAOELn
	QywpzO6/aZNzbJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753468896;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLb3ZS1Lma0kMjsp4vlE6ge1CNxXdZcPoGs7g1gs1d8=;
	b=wao5VM+iFlwF8nposRWjVo2q8STOOw6rfVHM50ZZjvi0s/2Sp3QMP/wxCb/Ai3vkGf8hRI
	t5MUTagoiTcYtJKBS2KJGB+c3O2M4UCatcwFp3RoEjd6mJCIu9kMOAItFZXcp9tSWaKyVU
	3JSKqJY/DewHF/1oya+tWeU9Mx0RbwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753468896;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLb3ZS1Lma0kMjsp4vlE6ge1CNxXdZcPoGs7g1gs1d8=;
	b=LWRRdGqyAXDvAPvC5mmm4tRorHLf5CmAtGPgdcQsFxEFn+nNuVfTObEVOhpC+IFe6gzhLR
	uuuDXFHxSEDaqxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC12D134E8;
	Fri, 25 Jul 2025 18:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q1C8LeDPg2iyHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Jul 2025 18:41:36 +0000
Date: Fri, 25 Jul 2025 20:41:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] btrfs: Remove duplicate linux/types.h header
Message-ID: <20250725184131.GI6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250725080705.1984011-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725080705.1984011-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jul 25, 2025 at 04:07:05PM +0800, Jiapeng Chong wrote:
> ./fs/btrfs/messages.h: linux/types.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22939
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Added to for-next, thanks.

