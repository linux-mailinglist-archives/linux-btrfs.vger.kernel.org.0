Return-Path: <linux-btrfs+bounces-13977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF1AB5A04
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 18:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEF3AFB0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C02BFC6F;
	Tue, 13 May 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRS4WeX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Alw44li";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRS4WeX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Alw44li"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686152BF3C3
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154095; cv=none; b=c3T2Rfb2ezM8VjIC38FcLfekQ1jPuEpVpifDoHyN3i2V0rm+xLW3tAta+XMlTCkzzpL5MsMner45e/zt21qBq/IfdwCekgDibkvEk7xH53woMc8lBQJ+eCcz75vj5Q7NO3GhW5HqXGaQbxNWTvYDh32WvTW8qPN+meG7UD0Td84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154095; c=relaxed/simple;
	bh=mmWvqiv2nM0rEUMNW0yFAypeCdb7CvFMus/oUjQEJvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM9wpO3zam8plomKF9pmtm8aGfj7NisJxqnvBOWdvg22R/BsoZLzIRx6s4MXbbO8yVkGJNcVg5eCjXJZX+T9LrJI9a5u8oxzh3WYho89BrWgKdFDCn33ssJyITgvsbEVOTfANrvv3+1jJ6aujwGxqQNvCG3xJStCuqf/HKghCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRS4WeX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Alw44li; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRS4WeX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Alw44li; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88C091F385;
	Tue, 13 May 2025 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747154091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjAqM3vN4NnbQDdgaCpQJnHRF5Y0RZhHuTwlo3xMno=;
	b=eRS4WeX+W9OwGsFYc+3t2Y/F8B46Ki1tuS6f65BYTGatTlJdW9xgas8JlMdPzHMq06Ds94
	GVLt5mQl96+CY8CJj2dCttTvNBRe9b8g4mygfHk4sTnPmednm5n1zyqWeaXyArwfSsgV9k
	IgkZHtaAAI9p6aQD+eyAH0lHqZPkDIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747154091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjAqM3vN4NnbQDdgaCpQJnHRF5Y0RZhHuTwlo3xMno=;
	b=9Alw44lisqNgyFt0GWUgJeDxBReRsvAGoo2z9NISPS4YeC3rhdvRRZu/ShheCMLSBIeRhd
	61Cbu0nVBOJFFRAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747154091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjAqM3vN4NnbQDdgaCpQJnHRF5Y0RZhHuTwlo3xMno=;
	b=eRS4WeX+W9OwGsFYc+3t2Y/F8B46Ki1tuS6f65BYTGatTlJdW9xgas8JlMdPzHMq06Ds94
	GVLt5mQl96+CY8CJj2dCttTvNBRe9b8g4mygfHk4sTnPmednm5n1zyqWeaXyArwfSsgV9k
	IgkZHtaAAI9p6aQD+eyAH0lHqZPkDIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747154091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjAqM3vN4NnbQDdgaCpQJnHRF5Y0RZhHuTwlo3xMno=;
	b=9Alw44lisqNgyFt0GWUgJeDxBReRsvAGoo2z9NISPS4YeC3rhdvRRZu/ShheCMLSBIeRhd
	61Cbu0nVBOJFFRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6180C137E8;
	Tue, 13 May 2025 16:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vysZF6t0I2jqGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 May 2025 16:34:51 +0000
Date: Tue, 13 May 2025 18:34:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
Message-ID: <20250513163446.GB9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250513070749.265519-1-wqu@suse.com>
 <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
 <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
 <760d5562-a9d2-4e64-9032-dd4008aeaf0e@oracle.com>
 <beee9078-8d6b-4788-9cb1-0d7ee6a6b78e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beee9078-8d6b-4788-9cb1-0d7ee6a6b78e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Tue, May 13, 2025 at 08:23:54PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/13 19:46, Anand Jain 写道:
> > On 13/5/25 16:56, Qu Wenruo wrote:
> [...]
> >> I'd say, if some option is deprecated, we should not use it at all.
> >>
> > 
> > It's marked as deprecated, but the code still needs testing.
> > Also, since fstests runs on stable LTS kernels too, it's better
> > not to remove it yet.
> 
> For older kernels without "rescue=" alias, it will not cause any problem 
> at all, because it will set "enable_rescue_nologreplay" to false and 
> completely skip anything related to "rescue=nologreplay"
> 
> But different vice-verse, as "rescue=nologreplay" still touches the 
> older one.
> I do not think we will keep the "nologreplay" support in the future very 
> soon.
> 
> In the past we had some problem relateds to "norecovery" mount option, 
> deprecated it and reverted back (some other projects still relies on 
> this mount option, and all other fses have exactly the same named one).
> 
> But "nologreplay" is btrfs specific, we can remove it any time in the 
> future.
> 
> I think this is the perfect time to considering removing "nologreplay" 
> completely.

Standalone 'nologreplay' yes. The warning has been there since
74ef00185eb86425215 5.9 from 2020, which is 5.10 stable. This should be
enough time.

