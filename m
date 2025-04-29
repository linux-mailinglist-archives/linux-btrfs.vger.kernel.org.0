Return-Path: <linux-btrfs+bounces-13520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA5BAA1078
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193E79208A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC8221572;
	Tue, 29 Apr 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CniI86bJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KrZwFs4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CniI86bJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KrZwFs4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725821ABA6
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940484; cv=none; b=Y3tA6uj/92n+rL86JzTcieuaHu8r3mTdBWqXjdsxXPzAlksV0YwHkcfta/NQk3SpuioSHl/Vt/cTPOGj+OCz82bntkHR+yYK3shZFyo1byxFg3e5rcF2014K8PT1JtHntpXh8dJM5zyVJHA5Pz5ECvNgUoRWN0NYzZDxmqXBlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940484; c=relaxed/simple;
	bh=PPROJbug7IttGTdurYFHeS3PyYQv4ZIYBXqZIgtiSzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IywszwrYwRYXDfRW8opKFg6Ez0ZMY8VkzenJFLuImqoM8pxxvEucrFV/Zf3i1b0uSJjSwGgssojlQb7DwNOXhuiB+Y8x0btePTAaVacaMtfArxu9DV85fsbVdhiOfhU8qH5tmt1x9Pk4JCwM+RSqB6ugMyBt+qSaa+wkuQ5B9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CniI86bJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KrZwFs4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CniI86bJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KrZwFs4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 065AA1F7A3;
	Tue, 29 Apr 2025 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745940481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaJdZP1h0YiSfZW3MRmJgX14ORWSFhQbqRzBxkkdk4o=;
	b=CniI86bJWxWVutBvQOFG/2ho8VcsTU/ZINvKF0x4lZ0Nxzl6UjPLXB0dJX34P6TXeACmZR
	pgMawYfxx2eGqad4rWJj0LTwhcxZ72JNfcXGvmW457HwNBVbrZ/iHcpEt+sLsX4IOs6dvU
	EZUqGk7g7Y4atYOzzWk+1CAr0d0Uc/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745940481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaJdZP1h0YiSfZW3MRmJgX14ORWSFhQbqRzBxkkdk4o=;
	b=2KrZwFs4SAOnraDPhtx2/PA6gy8tzg7Vn429nTi5kMxOgTD1TbEP4VTcbKsZkOZlNP8GFm
	Syzg+dxs/sJk49DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745940481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaJdZP1h0YiSfZW3MRmJgX14ORWSFhQbqRzBxkkdk4o=;
	b=CniI86bJWxWVutBvQOFG/2ho8VcsTU/ZINvKF0x4lZ0Nxzl6UjPLXB0dJX34P6TXeACmZR
	pgMawYfxx2eGqad4rWJj0LTwhcxZ72JNfcXGvmW457HwNBVbrZ/iHcpEt+sLsX4IOs6dvU
	EZUqGk7g7Y4atYOzzWk+1CAr0d0Uc/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745940481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaJdZP1h0YiSfZW3MRmJgX14ORWSFhQbqRzBxkkdk4o=;
	b=2KrZwFs4SAOnraDPhtx2/PA6gy8tzg7Vn429nTi5kMxOgTD1TbEP4VTcbKsZkOZlNP8GFm
	Syzg+dxs/sJk49DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E847F1340C;
	Tue, 29 Apr 2025 15:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0bsIOADwEGiGEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 15:28:00 +0000
Date: Tue, 29 Apr 2025 17:27:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix nonzero lowest level handling in
 btrfs_search_forward()
Message-ID: <20250429152759.GD9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250422125807.30218-1-sunk67188@gmail.com>
 <4649867.LvFx2qVVIh@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4649867.LvFx2qVVIh@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 29, 2025 at 02:57:02PM +0800, Sun YangKai wrote:
> Hi maintainers and community,
> 
> I'd like to request some feedback on this issue.
> 
> Is this behavior not considered a bug, or does it require further work?
> 
> Given that this issue never seems to be triggered in the current code base,
> perhaps we could consider cleaning up and removing the lowest_level related 
> logic altogether?

I've looked at this a few times and I'm not decided what to do. It's an
old code and works given that we haven't seen any problems so removing
dead code makes sense. OTOH that one function does not pass some
values of parameters does not mean want to remove the implementation
completely. At least some assertions should be added to handle the
case(s) for the removed code if there's a new use.

