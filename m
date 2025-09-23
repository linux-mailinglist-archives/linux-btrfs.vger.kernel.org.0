Return-Path: <linux-btrfs+bounces-17104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56602B9483B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0367A8FF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806330F549;
	Tue, 23 Sep 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dVJxJB93";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b6h7iibo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dVJxJB93";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b6h7iibo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97A30E834
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607909; cv=none; b=l1RmZP3mCqqDK5Mxf9XowBeK5vrrCVlV6mGZAhROPbS0IXbw/JAR+V2qgNtXZosJp0GH8+9tgJdbw5I02tNfpKuljwmipTEi0w4czxvjaK06fWHbW7qra5LX56JdlOce3cHmdHDMPCFXT7Ipq9voAV44yrM2qHReIAFSpOsglIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607909; c=relaxed/simple;
	bh=uzglp6EAm2VJxGeExDsM6Lofk/XPbxvh38qYQIKN0ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l21i1uuUbOME/LlllGKV5oTAB/RiBtsEq+jFeNIlAPlW8oiRmS4MsDxPkbbqw3oppN405E4LAy7GLh5vrnLdamchTmYrvnpoiNf33fxUnzjqU6bLgnFbIlrco0k/X9DzoUv1fPI0/bLl8XVuWf29/wdyoN1g6r4TkvI74PZ2W3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dVJxJB93; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b6h7iibo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dVJxJB93; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b6h7iibo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1901F387;
	Tue, 23 Sep 2025 06:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGtSjkxMwCbGyXXhAKcyUWrdApOh6OCerYImQ5KG7L8=;
	b=dVJxJB93RYCBsELw9gXGCQZupHxUv8oN+WzVS23QjgTxem24IRia4HMyAZhhUw/jztqE47
	gAdoBegRjCvJvtVALazsXCZXg+N+IC3RMq7dGecXwKnYYxXPJTHK0VDAQ/cIiRjQv2IAwp
	mFAZBNlLHfKNwCDsXYnm7DVeplbn1v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGtSjkxMwCbGyXXhAKcyUWrdApOh6OCerYImQ5KG7L8=;
	b=b6h7iiboFzd53P991SXknleuwTaNI8metAjCKUTW60p8tlE9PLgjZ6lYfX5qMh50Bre8qA
	pmDpgxgcR1S3v/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGtSjkxMwCbGyXXhAKcyUWrdApOh6OCerYImQ5KG7L8=;
	b=dVJxJB93RYCBsELw9gXGCQZupHxUv8oN+WzVS23QjgTxem24IRia4HMyAZhhUw/jztqE47
	gAdoBegRjCvJvtVALazsXCZXg+N+IC3RMq7dGecXwKnYYxXPJTHK0VDAQ/cIiRjQv2IAwp
	mFAZBNlLHfKNwCDsXYnm7DVeplbn1v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGtSjkxMwCbGyXXhAKcyUWrdApOh6OCerYImQ5KG7L8=;
	b=b6h7iiboFzd53P991SXknleuwTaNI8metAjCKUTW60p8tlE9PLgjZ6lYfX5qMh50Bre8qA
	pmDpgxgcR1S3v/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA76E132C9;
	Tue, 23 Sep 2025 06:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DwYWOSE60mjYFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 06:11:45 +0000
Date: Tue, 23 Sep 2025 08:11:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, clm@fb.com,
	dsterba@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: Prevent open-coded arithmetic on kmalloc
Message-ID: <20250923061144.GS5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250919145816.959845-1-mssola@mssola.com>
 <20250922103442.GM5333@twin.jikos.cz>
 <87bjn24pmk.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjn24pmk.fsf@>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Sep 22, 2025 at 02:51:15PM +0200, Miquel Sabaté Solà wrote:
> > On Fri, Sep 19, 2025 at 04:58:14PM +0200, Miquel Sabaté Solà wrote:
> >> The second patch is a small cleanup after fixing up my first patch, in
> >> which I realized that the __free(kfree) attribute would come in handy in a
> >> couple of particularly large functions with multiple exit points. This
> >> second patch is probably more of a cosmetic thing, and it's not an
> >> exhaustive exercise by any means. All of this to say that even if I feel
> >> like it should be included, I don't mind if it has to be dropped.
> >
> > Yes there are many candidates for the __free() cleanup annotation and
> > we'll want to fix them all systematically. We already have the automatic
> > cleaning for struct btrfs_path (BTRFS_PATH_AUTO_FREE). For the
> > kfree/kvfree I'd like to something similar:
> >
> > #define AUTO_KFREE(name)       *name __free(kfree) = NULL
> > #define AUTO_KVFREE(name)      *name __free(kvfree) = NULL
> >
> > This wraps the name and initializes it to NULL so it's not accidentally
> > forgotten.
> 
> Makes sense! I can take a look at this if nobody else is working on it,
> even if I think it should go into a new patch series.

Thanks, it's yours. Yes this should be in a separate patchset.

> Hence, if it sounds good to you, we can merge this patch as it is right
> now, and in parallel I work on this proposed AUTO_KFREE and AUTO_KVFREE
> macros in a new patch series (which will take more time to prepare).

I'd rather see all the changes done the same way so it's not __free and
then converted to AUTO_KFREE. Also the development branch is frozen
before 6.18 pull request so all that will be in the 6.19 cycle anyway.

