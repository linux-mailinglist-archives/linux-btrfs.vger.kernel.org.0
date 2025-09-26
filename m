Return-Path: <linux-btrfs+bounces-17220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988CBA397E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3BA3B186B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C82EB866;
	Fri, 26 Sep 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8PlCzPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dtn4ltKb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8PlCzPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dtn4ltKb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA10E3
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889320; cv=none; b=Mfy8ryEQjJUEtEeRA152InDzqjbiZKM1xTfDFoVCKTAA1XMCtPm11520t7um3UKfpXnyvIeSz3UFyFlPEk4k9wR5irlsQw8vrDi1yeR/8JEHGPJLwvHQG0m4cOPcdERmZsjIHzT0/3tHMOJBO9iHb84ItGENywlzdfaH/LXODZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889320; c=relaxed/simple;
	bh=orupwksR+ykb81y4UOa4/9GDuF8u0Sfdu9DQia2Hdl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHkZFlwTuFdXsngGa9rBJzuqGZLDfmlEzItuKTDwIfN+gB8fPtTcavWzbSo4bzg+Q7XuNHuwCyLJxBIscMBTIvlK7jBjwpLXGXrnzXF6rQL8NEfFYn8/tuG4j0iINkA1cizrZUB090dR0F2iNQGEUiUjHFcnL7nJRSK2nJZD1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8PlCzPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dtn4ltKb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8PlCzPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dtn4ltKb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58CE124192;
	Fri, 26 Sep 2025 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758889317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIjntDj7e+A+0GU/YyHwT7E2W9ltIbbQ4jcGmPYSghw=;
	b=D8PlCzPjYS5GcBwufYDV+N2KcW/kKuwQ4Bj41EyRtq2Da5WweDCaJxRZyvbnSKOxh6rwpI
	d2Sd5VqBIbtJgwStruQbcmXRmCOmlD18+7LqVRkU+QiuKU8sAob8nQiXwaZRnJd8LumRCo
	gjYpWRPJenSlAN5FugIJpXHo4NPeQs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758889317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIjntDj7e+A+0GU/YyHwT7E2W9ltIbbQ4jcGmPYSghw=;
	b=Dtn4ltKbLG9Zup0jGOeVxweY8MnS5M20tXCOcH6qTz+e/ra2v2jQbinpnF/bxVAabXGaTw
	8EyrDrTgFfVS9ACA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758889317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIjntDj7e+A+0GU/YyHwT7E2W9ltIbbQ4jcGmPYSghw=;
	b=D8PlCzPjYS5GcBwufYDV+N2KcW/kKuwQ4Bj41EyRtq2Da5WweDCaJxRZyvbnSKOxh6rwpI
	d2Sd5VqBIbtJgwStruQbcmXRmCOmlD18+7LqVRkU+QiuKU8sAob8nQiXwaZRnJd8LumRCo
	gjYpWRPJenSlAN5FugIJpXHo4NPeQs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758889317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIjntDj7e+A+0GU/YyHwT7E2W9ltIbbQ4jcGmPYSghw=;
	b=Dtn4ltKbLG9Zup0jGOeVxweY8MnS5M20tXCOcH6qTz+e/ra2v2jQbinpnF/bxVAabXGaTw
	8EyrDrTgFfVS9ACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1AD1373E;
	Fri, 26 Sep 2025 12:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id afgwD2WF1mjdQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Sep 2025 12:21:57 +0000
Date: Fri, 26 Sep 2025 14:21:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: clm@fb.com, dsterba@suse.com, naohiro.aota@wdc.com,
	johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [RFC] btrfs: assume fs_info is non-NULL and drop ternary check
Message-ID: <20250926122152.GT5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250926121344.25706-1-antonio@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926121344.25706-1-antonio@mandelbit.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Fri, Sep 26, 2025 at 02:13:44PM +0200, Antonio Quartulli wrote:
> When assigning max_bytes, fs_info is checked for being non-NULL
> and a value is assigned accordingly.
> However, a few lines below we do dereference fs_info multiple
> times without checking whether it is non-NULL anymore.
> 
> This pattern has triggered Coverity Scan which thinks that
> we may hit a NULL-ptr-dereference.
> 
> If we know for sure that fs_info cannot be NULL (and this seems
> to be the case since various instructions assume so), we should
> drop the ternary check when assigning max_bytes in order to avoid
> confusing the casual reader or static analyzers.
> 
> Fixes: f7b12a62f008a ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> Address-Coverity-ID: 1659628 ("Null pointer dereferences (FORWARD_NULL)")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Thanks, the fix for that was sent yesterday and is now in for-next.

https://lore.kernel.org/linux-btrfs/686d2506851c2df8cb9ceab5241b15bb01737ebb.1758793968.git.wqu@suse.com/

