Return-Path: <linux-btrfs+bounces-5529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D290009F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB1C1C21B2E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052EC15D5CA;
	Fri,  7 Jun 2024 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AKWEqUlu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AB1yOlD2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y4RWIL1x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/68G+rY/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01E15AAD7;
	Fri,  7 Jun 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755696; cv=none; b=IqGRpGceyA+a7kP5q+XxIEStyy+IyuaaDSEljLEBQtu30MPZr3A3Lo82hMfL648HFBhe85Qz/XuLDw2KV77z9IVtwHAzdjocGLMJ1wCzI0XHRFnvJbO6vUkkxAz3RP7GUo2TiZGpd/UGlI8WHfZR8Jfs++pRM9/mU0M46v/DcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755696; c=relaxed/simple;
	bh=rdcO5P3p1q+aGRQG1HyTdUqvPTYsvBhNR9De+UokZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwd8ZKMNPT7dDH9I3nWp8Z0npvODqtoPrPCtI7iJ2b75AFZb34LbPbbD/qKlhgubF9vrQJj7GqlGhx1XLgxiW+DeY48qp1EWmq35bHEmD0tv1CI8RQZC3FwlvtbN13mKczI1pd6w+vNTfJjw1IY2SfU+qYSk42yYnoYWXD/7ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AKWEqUlu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AB1yOlD2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y4RWIL1x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/68G+rY/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 450A021B51;
	Fri,  7 Jun 2024 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717755692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwwUjrfYHeKJR25zNAWaALfIvFi2mlcgpz8K9v+4OAs=;
	b=AKWEqUlu0HdtiZQvLw9Fl4zjcEWfZVIg7oRByZEoij0qXjtlQJns9ARlvDTOw7PziHiJnv
	eEkmYGhxS/au4OrGcWiAZGFqvdmgiTHmSOao8T46cm4kPlwJxjQ3KUrb2iNzVl6OVAh9he
	OOfLEB6OtJbiTk1HrKMVDCqhNHuEeNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717755692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwwUjrfYHeKJR25zNAWaALfIvFi2mlcgpz8K9v+4OAs=;
	b=AB1yOlD2EmOtm7pUf/vRpZiFZn26ExqGqW+iKMCk6KeZje3km6VktM5CkY4yZW7tw6NWel
	xbn4aW0M6BLUDUBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y4RWIL1x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/68G+rY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717755691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwwUjrfYHeKJR25zNAWaALfIvFi2mlcgpz8K9v+4OAs=;
	b=Y4RWIL1xbcdxxeToHExAMtY4lKopSJ0gZkBzwfINSXstE5UeyMx6dBuZoXtmHjRkjrmDe9
	jp8D27AVsGp9vfJLIvF1M046VoLiQdDmeQBwBdD/3z59T1tuvL+m0LXQZHBo0py5nwT28a
	rjPuOCE5u7UBsfLDmy7yX6ijwFlv+2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717755691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwwUjrfYHeKJR25zNAWaALfIvFi2mlcgpz8K9v+4OAs=;
	b=/68G+rY/dVQyJmNNrW9lrbb/HfREYp7oH+K1B8lw7f6AOtu6OKo3Fuod0/FUvroKAKxCxc
	gcMLWmGCPahDQnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E66F133F3;
	Fri,  7 Jun 2024 10:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M87dDijfYmbLMgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 07 Jun 2024 10:21:28 +0000
Date: Fri, 7 Jun 2024 20:21:20 +1000
From: David Disseldorp <ddiss@suse.de>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, Omar Sandoval <osandov@osandov.com>,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607202120.2b6ad335.ddiss@suse.de>
In-Reply-To: <CAL3q7H6Un3j+BbqHc82D68R3rwmT6Y0XfpOadWxdV=DbSN-hmQ@mail.gmail.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
	<d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
	<CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
	<20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>
	<20240607100422.w7k7spmyg7s6xfv4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<CAL3q7H6Un3j+BbqHc82D68R3rwmT6Y0XfpOadWxdV=DbSN-hmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.48 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 450A021B51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.48

On Fri, 7 Jun 2024 11:11:34 +0100, Filipe Manana wrote:
...
> > > As a Signed-off-by tag for David Disseldorp instead of Reviewed-by.  
> >
> > Oh, this Signed-off-by tag is generated automatically by:
> >
> > https://lore.kernel.org/fstests/c9e54af5-4370-4d45-a8ed-4098b06b2629@suse.com/T/#m8fc24d233b2cf3a323c94c2b8039c0f043e09023
> >
> > if it's a mistake, I'll change it to Reviewed-by:  
> 
> That I didn't notice, odd that David replied with Signed-off-by and
> not Reviewed-by.
> (cc'ing him)

Oops, yes that should have been a Reviewed-by, sorry.
Please change it.

Thanks, David

