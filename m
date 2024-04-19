Return-Path: <linux-btrfs+bounces-4436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983888AB46F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AB9285831
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309B13AA53;
	Fri, 19 Apr 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrWCkvS2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="emxBl+1q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fI+NeA3s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RaIqNoTX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DB139CE8
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547982; cv=none; b=s+9lMCJUqXOGvf3xfYpWs06WgUkctr2EVnxuSG6/BdeCFC/CwcTHCRlW7PjO6Gnu3YCETOdUWT/cIaOKSLsfmzyN2mlsc+9bt2Eq2GwmnWHBp+LEJQXox4rv1ZVQPX45FtP3/WAlcX88hkquDsMry7/CoxGWQlcBItsMTzbw5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547982; c=relaxed/simple;
	bh=kfut167eRcIIyw+Pj/q1uyUFD+XMY43Fb1kInMD8G4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOFVIKokh9OYZHy47DkuInK4+WpIEW+g2cjbKL2X5ESTpWviB9JXuU1isLhmU4N5KGVBvJmyrnwL8wu91NwuS2r1DvQACLZ8jlLym0pNowzUQu/7WNP+9rQEh19KnKI10I550ZV1Kw3NqVaHoS51GmNt7q6aZxi6dZTNWaY8DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrWCkvS2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=emxBl+1q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fI+NeA3s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RaIqNoTX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8D505C4DD;
	Fri, 19 Apr 2024 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfut167eRcIIyw+Pj/q1uyUFD+XMY43Fb1kInMD8G4s=;
	b=RrWCkvS2A6u12r48jAsWXGfsX3ad3NvcgGjQn1ZoZsik4anfKrT2hPPVcRfswSzoIJYY8S
	XzFgH7KsxT/+EFw0OFin0oGiC9Nkc3F1TKcTwyon4OiSs1QvXwzIh3BzxhVoQzePFYF26l
	QTzKMYkofK3TNinH8fIjOA+QNkx8UFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfut167eRcIIyw+Pj/q1uyUFD+XMY43Fb1kInMD8G4s=;
	b=emxBl+1qSjvzdJmaoSjVX3r095s6U2R6qxnPuIroYCVHz+VFaKIAxL5KgqlplESa6qIfzV
	JzASSN6F/H3ZZ3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfut167eRcIIyw+Pj/q1uyUFD+XMY43Fb1kInMD8G4s=;
	b=fI+NeA3sT363LdO9Xb7jBYvlGizNMv3qah5xPjl2P3oHuo8K+9fnDoBwvu5AM+2KvSRtNk
	ONp6EW7Kv8wlADVVaJjVTc4a8PR56NscGIufPehscy1xFqj6vJUVNdDre1JYKZpzZgmqO5
	sb2yVDtrV2MzA4IKuNSUBJthNm0ad5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfut167eRcIIyw+Pj/q1uyUFD+XMY43Fb1kInMD8G4s=;
	b=RaIqNoTXmv/1hc/aGLbFfcwhW/VH8u2wu7o+x/AsEAxeGE4aTn8UdQzKaVLscTjpYk/Gg/
	cEYxeP97qRhKbIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD862136CF;
	Fri, 19 Apr 2024 17:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7roEMsmqImYQKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 17:32:57 +0000
Date: Fri, 19 Apr 2024 19:25:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] part2 trivial adjustments for return variable
 coding style
Message-ID: <20240419172519.GB3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713370756.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.08 / 50.00];
	BAYES_HAM(-1.08)[87.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto]
X-Spam-Score: -2.08
X-Spam-Flag: NO

On Thu, Apr 18, 2024 at 03:08:32PM +0800, Anand Jain wrote:
> This is Part 2 of the series, following v1 as below. Changes includes
> optimizations on top of reorganizing the return variables in each function,
> as stated in the each patch, based on the received review feedback. Thank you.

Most of the patches are simple renames, so please add them to for-next
as before. For the commented patches we may need another round but we're
getting closer to fixing all cases.

