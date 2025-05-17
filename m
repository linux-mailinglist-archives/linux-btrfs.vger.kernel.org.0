Return-Path: <linux-btrfs+bounces-14103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F5ABABF2
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 21:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB795189E848
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BA15624D;
	Sat, 17 May 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHzSJerG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LeESPEnC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHzSJerG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LeESPEnC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6E1F956
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747508538; cv=none; b=XJsWCXe5TLrr5ORDHAy6whii8huMXijb7/hfZWhZNpMNqSTowsoAPfrjqcgby/ka0xQF+BCmIwNsCJFkxX5gc2N+yKpTUqMqZjwWfdpCvIZcPxYhm0qLrFr7yL1tFo+zEZTK6aNGU+HbkWNltj9tsJiPSMLX+9lw4l5P7Okgn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747508538; c=relaxed/simple;
	bh=vsObvAXIrhtMsi4N+74Xb0Ybuk/nV3PyvhoFno5uBg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be9U/6h1575wNtvIzYc90YMQrzzXrksPjoviR78zJhObQL/5yUuygEYvdvCuljwA/jHZhgsxawGyYIYblObwfAU9n7aF7nexYEE/LJhnhR1maa9l0CkOiSqVSvv63X5nMECZEIS6qulbJqKwktqk+lY2R2TY5PeZQ2kfq0RPHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHzSJerG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LeESPEnC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHzSJerG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LeESPEnC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D3AA21FFF;
	Sat, 17 May 2025 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747508533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoQzragk4V0Z0Dh3qO9X3QT9KKHCK97ZZlaimm3SCn8=;
	b=xHzSJerGZmBjEqIn+0PyR6Pn//qiw80gq7Yp1pFJ9KiSSfrpJ0peVHZj/tbGN5A0iwMFfj
	+K+Uol2HusMVEWBVr/mjYRxq+/spil9E+O4/bKd9gaN/S1Z/6t5al54WCs40KhwE/xqzaM
	OLsJCqz1EL4RXIiwyCa0PasnCijbDCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747508533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoQzragk4V0Z0Dh3qO9X3QT9KKHCK97ZZlaimm3SCn8=;
	b=LeESPEnCmTxipgTMzhHlT2L+iNRjh/85oWowfe1wstshXBnWtQ9SoO6qOoS2pkWyY2pDlC
	187yW+zdX0Wlh6Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747508533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoQzragk4V0Z0Dh3qO9X3QT9KKHCK97ZZlaimm3SCn8=;
	b=xHzSJerGZmBjEqIn+0PyR6Pn//qiw80gq7Yp1pFJ9KiSSfrpJ0peVHZj/tbGN5A0iwMFfj
	+K+Uol2HusMVEWBVr/mjYRxq+/spil9E+O4/bKd9gaN/S1Z/6t5al54WCs40KhwE/xqzaM
	OLsJCqz1EL4RXIiwyCa0PasnCijbDCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747508533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoQzragk4V0Z0Dh3qO9X3QT9KKHCK97ZZlaimm3SCn8=;
	b=LeESPEnCmTxipgTMzhHlT2L+iNRjh/85oWowfe1wstshXBnWtQ9SoO6qOoS2pkWyY2pDlC
	187yW+zdX0Wlh6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 106E813991;
	Sat, 17 May 2025 19:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PC5/AzXdKGgvbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 17 May 2025 19:02:13 +0000
Date: Sat, 17 May 2025 21:02:11 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 clone_copy_inline_extent()
Message-ID: <20250517190211.GA25863@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <390968e8253cb5624145c3e2e84b784fe25cf522.1747420784.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390968e8253cb5624145c3e2e84b784fe25cf522.1747420784.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Fri, May 16, 2025 at 07:41:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

