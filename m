Return-Path: <linux-btrfs+bounces-1939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE9842CC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC8E1C20BF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E7E7B3D4;
	Tue, 30 Jan 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ck+ppUjo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gd3rWab4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ck+ppUjo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gd3rWab4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026B7B3C2
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642977; cv=none; b=Q5sGVEL++ru+s3hv8tPKiY/vKNS2KjZZZlzZ3JjoVCpWlOBXTHgqACWwcQm0Xjd8J7yoo9p+LzWsPLitnqgXj4uBSZDwsO2iJMIAfCIKTpYr/G7KMEpNR8mQ8Y6JS69HUqVgL+sXjHowVqp7X8vlKdFo9XrlhU26XlKgQr2o7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642977; c=relaxed/simple;
	bh=SNJObDB7Bi7ZFXvmRQxBIUV06kp1XrAbAiZaFNCKv8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCRrUCYAcApo7aMcqa70tul+EgEpUBO9cbe0W9kD2hu00vcQA6VMEvBsnPt/u5UWKFqCeDt+Brjg8iMLqwXWF8XqPIB45gAdB3KdNsHlM82FhQ3hsxmdm2YGa1LbTWkBN7F18UqJbbE01FIV2WfqWjdDko7xZ2o2opcJ+Y7VarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ck+ppUjo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gd3rWab4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ck+ppUjo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gd3rWab4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB27F222FF;
	Tue, 30 Jan 2024 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706642973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cjrEgKRTchYKQWPW5akVKj90L5+i6D+krpQhIdAcas=;
	b=Ck+ppUjowae9Xswk0K2vsHZxVDnOUiHI6dX8rhszVgUSOBv3NqgJoS8elV1UCac+LGNpiG
	e+h15fC/TolOxNwcsswmuXNUNjSk9ta2ma98RRtOfTVkMFM9drZP0MM7GsZ3uKlXL6/qC/
	I3x9rLxldVphc1fC7xABWULRS1rBAb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706642973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cjrEgKRTchYKQWPW5akVKj90L5+i6D+krpQhIdAcas=;
	b=Gd3rWab4lkT3Ek4Z0+lrqNqDNIBa1TC0Rc1HUktbt1f+5WHjp+LeeULUGQ1iOPLb/HU0yA
	PJGBoho4uEbYXACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706642973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cjrEgKRTchYKQWPW5akVKj90L5+i6D+krpQhIdAcas=;
	b=Ck+ppUjowae9Xswk0K2vsHZxVDnOUiHI6dX8rhszVgUSOBv3NqgJoS8elV1UCac+LGNpiG
	e+h15fC/TolOxNwcsswmuXNUNjSk9ta2ma98RRtOfTVkMFM9drZP0MM7GsZ3uKlXL6/qC/
	I3x9rLxldVphc1fC7xABWULRS1rBAb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706642973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cjrEgKRTchYKQWPW5akVKj90L5+i6D+krpQhIdAcas=;
	b=Gd3rWab4lkT3Ek4Z0+lrqNqDNIBa1TC0Rc1HUktbt1f+5WHjp+LeeULUGQ1iOPLb/HU0yA
	PJGBoho4uEbYXACA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0DA913212;
	Tue, 30 Jan 2024 19:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eGieLh1OuWVPfwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jan 2024 19:29:33 +0000
Date: Tue, 30 Jan 2024 20:29:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Message-ID: <20240130192908.GC31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706553080.git.dsterba@suse.com>
 <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
 <f5b412f0-9c06-4c3a-af47-d3077b79c2f6@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b412f0-9c06-4c3a-af47-d3077b79c2f6@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.82%]
X-Spam-Flag: NO

On Tue, Jan 30, 2024 at 11:42:30AM +0000, Johannes Thumshirn wrote:
> On 29.01.24 19:33, David Sterba wrote:
> > diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> > index 40f2d9f1a17a..8be09234c575 100644
> > --- a/fs/btrfs/misc.h
> > +++ b/fs/btrfs/misc.h
> > @@ -8,6 +8,9 @@
> >   #include <linux/math64.h>
> >   #include <linux/rbtree.h>
> >   
> > +#define page_to_inode(page)	BTRFS_I((page)->mapping->host)
> > +#define folio_to_inode(folio)	BTRFS_I((folio)->mapping->host)
> > +
> 
> Why are you using a macro instead of an inline function here?

As said in the changelog so we don't have to include headers with full
definitions of page, folio, fs_info, ...

> Shouldn't inline function give us a bit more type safety, or are 
> compilers smart enough nowadays?

Yes type safety would be good but then it can't be an inline without
bloating misc.h (and the making include cycles).

I could do a type check in the macro using _Generic.

