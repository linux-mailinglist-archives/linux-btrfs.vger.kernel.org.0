Return-Path: <linux-btrfs+bounces-11974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB32A4BA81
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 10:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107033A921E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694C1F09B2;
	Mon,  3 Mar 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7m1w2cd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2k/coN83";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7m1w2cd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2k/coN83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549771E521B
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993150; cv=none; b=GU+yYI29agU0+QLWfvToVB8bIKtPVP5TtXtnVd2QB8dBnCkTy8chc5XtVzERTbOkYzPeYaH+HA1/TZaofysEJmGYvYC3k/LV24/10IFEj6hovnT5RQOqguM7EOalHELIUZ2BSHvifUuUULXKBzoJIiumU9F98OgLbHNmcjtHy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993150; c=relaxed/simple;
	bh=yrNA1kvGPDjGooL/hOiOpjs0xDl+mAjnk2TED9eqrmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiGPPoPPxInWkM4PKh7aozX2Pn3I0HSGLhm+wSigcS5hjtNdOJyUNs8i8l7daaX57Ln/cefN30EiAEEAMpeMiN4BenP8cH9Qqt5gbl1bpfve8oEgOqI2KRVsZsZI+JgJohwK8mSQfm4LpbtfECfAowynspNgIJi0bXtLzIXvadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7m1w2cd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2k/coN83; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7m1w2cd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2k/coN83; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5427A2117D;
	Mon,  3 Mar 2025 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740993147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D3xWdVuhOmBlH2C8QOmsCI9ycxLa78uhyFOU+NUMvs=;
	b=T7m1w2cd7GUaL0eud4EpFASzbsnpxZcpyuwe0s/RZWVWYAZW06sa5a3w8dHOn4S8flKuEM
	rS2fljpZ3/0VSORFxRFyZU5pG/FLj97+cpTOhm5zuLraSr9JtjAnDVx+AqHHnz646BxJ3O
	a55NLUc5gGqV4veh7EBAQ3phc9AgDKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740993147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D3xWdVuhOmBlH2C8QOmsCI9ycxLa78uhyFOU+NUMvs=;
	b=2k/coN83kvKy49FnfpNjJBEWWvccmhE1yzIxobVfdhM/Gc2RtRe3feZ+nHAH4SugrNVyfH
	aJbyvq13RVjKrBBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740993147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D3xWdVuhOmBlH2C8QOmsCI9ycxLa78uhyFOU+NUMvs=;
	b=T7m1w2cd7GUaL0eud4EpFASzbsnpxZcpyuwe0s/RZWVWYAZW06sa5a3w8dHOn4S8flKuEM
	rS2fljpZ3/0VSORFxRFyZU5pG/FLj97+cpTOhm5zuLraSr9JtjAnDVx+AqHHnz646BxJ3O
	a55NLUc5gGqV4veh7EBAQ3phc9AgDKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740993147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D3xWdVuhOmBlH2C8QOmsCI9ycxLa78uhyFOU+NUMvs=;
	b=2k/coN83kvKy49FnfpNjJBEWWvccmhE1yzIxobVfdhM/Gc2RtRe3feZ+nHAH4SugrNVyfH
	aJbyvq13RVjKrBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39F2C13A23;
	Mon,  3 Mar 2025 09:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ce/1DXtyxWdofQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 09:12:27 +0000
Date: Mon, 3 Mar 2025 10:12:26 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: sysfs: accept size suffixes for read policy
 values
Message-ID: <20250303091226.GV5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
 <3c4582c2ab0ac2537ab70bce3ac3270f81468139.1738163840.git.anand.jain@oracle.com>
 <20250205175810.GK5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205175810.GK5777@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: 1.00
X-Spam-Flag: NO

On Wed, Feb 05, 2025 at 06:58:10PM +0100, David Sterba wrote:
> On Wed, Jan 29, 2025 at 11:21:46PM +0800, Anand Jain wrote:
> > We now parse human-friendly size values (e.g. '1G', '2M') when setting
> > read policies.
> > 
> > Suggested-by: David Sterba <dsterba@suse.com>
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> v2 is ok, for simple updates like adding a comment you don't need to
> resend it. Please add the patch to for-next, thanks.

Now added to for-next.

