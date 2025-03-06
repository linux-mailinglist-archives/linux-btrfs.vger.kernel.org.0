Return-Path: <linux-btrfs+bounces-12045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C4A544DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 09:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5C6188D423
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05269205E36;
	Thu,  6 Mar 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XXfwkgA3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jCH9fmmo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XXfwkgA3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jCH9fmmo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70B1EA7E5
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249786; cv=none; b=RVqoSP7RSKopwtgXsM/SYOMOBRrl9u7EUdS3AaJLgYq9+cvFkl5WkkW70n+Xlp730FYJu6usVXSOC13Kr8Og4QWT+/3Vxb4K4WbjPFRKm419vjuiyKwJnw00r2nO1LXR/YCmixf+FOqPum0gw1Xl9JYU9DHJCfJ/lIA0iv1h8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249786; c=relaxed/simple;
	bh=wtG1oKSJAOuDknBTbFDOoeKnnb40g7SgXZ5I9FQ0WCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMAlawYNMxD9+Je1RwB6fwjiJ/2kkoF45FeiznJl/ssdy0shnkCQrd2l85B5vtiil0sOg899svfzeZzHLmnKQ5HAC3pJdzRTKhpEst1qa2UfagsalR4Ovy1ZDmPgNrpkThNaEVOVd8AS78ucSw6ld1rQkTCICY0dv4+0PDIuG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XXfwkgA3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jCH9fmmo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XXfwkgA3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jCH9fmmo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1414521197;
	Thu,  6 Mar 2025 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741249777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Tq6YPS4TftQq9OwgBOkmkBhHIrJU5fJDLp1YsnDHk=;
	b=XXfwkgA3V1md+yLWuDDYcrCfZPU2FlZQM0HrJAnUFJpxJw2ysLw0Ay0HfS2j8BjMATo3DU
	HiF8WayCzKvJPqM1O5/cK8TyM4mUTHKwkC2voLGKAzUhvBrkCjF36KcUwtG212huJ0k7V9
	FLWz/eWB304EBzh/SMjT3iURrxJa0sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741249777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Tq6YPS4TftQq9OwgBOkmkBhHIrJU5fJDLp1YsnDHk=;
	b=jCH9fmmoR1GVrCee03hxs45BZ4FPx7wytHtV17jaaOIikaXom3jnD/wEQqkXIKrMeETKoz
	oJcYMk/OnPC9xAAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741249777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Tq6YPS4TftQq9OwgBOkmkBhHIrJU5fJDLp1YsnDHk=;
	b=XXfwkgA3V1md+yLWuDDYcrCfZPU2FlZQM0HrJAnUFJpxJw2ysLw0Ay0HfS2j8BjMATo3DU
	HiF8WayCzKvJPqM1O5/cK8TyM4mUTHKwkC2voLGKAzUhvBrkCjF36KcUwtG212huJ0k7V9
	FLWz/eWB304EBzh/SMjT3iURrxJa0sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741249777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Tq6YPS4TftQq9OwgBOkmkBhHIrJU5fJDLp1YsnDHk=;
	b=jCH9fmmoR1GVrCee03hxs45BZ4FPx7wytHtV17jaaOIikaXom3jnD/wEQqkXIKrMeETKoz
	oJcYMk/OnPC9xAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E680213676;
	Thu,  6 Mar 2025 08:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MTIEN/BcyWePAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 08:29:36 +0000
Date: Thu, 6 Mar 2025 09:29:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: return a literal instead of a variable
Message-ID: <20250306082935.GH5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 06:01:57PM +0300, Dan Carpenter wrote:
> This is just a small clean up, it doesn't change how the code works.
> Originally this code had a goto so we needed to set "ret = 0;" but now
> it returns directly and so we can simplify it a bit by doing a
> "return 0;" and removing the assignment.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Added to for-next, thanks.

