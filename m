Return-Path: <linux-btrfs+bounces-13784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7FAAADECE
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966904A230F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C925DCFE;
	Wed,  7 May 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzYmo5Dg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="opQa5CfL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzYmo5Dg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="opQa5CfL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25212259CB0
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620284; cv=none; b=u6da513xxD4R8xz0nmk7t84gFm5Db+KOk/4NZjv7laivoGeIWJxFeZg+dVQz3inmOJ4/AHLkiWWh/1v/584d4NvxVAA1Ud/TBwWoe+2SeBjvuJBvUzXxvgyfwu39Y/olpwga8NGRdAAXY+U+vpBKFxeoyj67SDwxsTlDuTEJMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620284; c=relaxed/simple;
	bh=sjx1VvUpuZrn+f6R/06NXyWAQK3tB66xsabSMlG8sdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCip/8ywuOC7+83IsQB2yvsSeFpKFJl/B+JwB5mLa/9wn0AYO3KWh9lBFngcbgsPILIhUbcjqDEIYplhQu1QY1WnWIe7WZ/LuOzrp/vzbQG99ghBiQN6zxWMsL7lIoRMLQsdo/1aUKq+/J9MXEL+IY6emNgHTZPKm8kBemWOsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzYmo5Dg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=opQa5CfL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzYmo5Dg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=opQa5CfL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C28121182;
	Wed,  7 May 2025 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746620281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvOWlFAVt6TAvCtF4cImf0T8NPcrWiIu0vrJDICQFGg=;
	b=pzYmo5Dg2eULpKSBZT1qM2AtK9D5BQKgROqca6j1NnfDn4tce7Q0jpONPbT3ogXGswFBVz
	D+++nnfA6xoX2jtej3oXOs5NfqunvTMxAhDsf4XfAmsmhEqRhbitBtR8BK81/HnvGckAhh
	4IvbxknUg35Dc2jsMDlgAJOJy70Nc5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746620281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvOWlFAVt6TAvCtF4cImf0T8NPcrWiIu0vrJDICQFGg=;
	b=opQa5CfLRquzhQR1vW7jSrSk77f7UBQcOCMK5QOltOZFn+Gk8Fg5X7JHNCkFtbLoMbWHN6
	o7I6Q8HSeS+/H6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746620281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvOWlFAVt6TAvCtF4cImf0T8NPcrWiIu0vrJDICQFGg=;
	b=pzYmo5Dg2eULpKSBZT1qM2AtK9D5BQKgROqca6j1NnfDn4tce7Q0jpONPbT3ogXGswFBVz
	D+++nnfA6xoX2jtej3oXOs5NfqunvTMxAhDsf4XfAmsmhEqRhbitBtR8BK81/HnvGckAhh
	4IvbxknUg35Dc2jsMDlgAJOJy70Nc5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746620281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvOWlFAVt6TAvCtF4cImf0T8NPcrWiIu0vrJDICQFGg=;
	b=opQa5CfLRquzhQR1vW7jSrSk77f7UBQcOCMK5QOltOZFn+Gk8Fg5X7JHNCkFtbLoMbWHN6
	o7I6Q8HSeS+/H6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08552139D9;
	Wed,  7 May 2025 12:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z1ROAXlPG2j/LQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 12:18:01 +0000
Date: Wed, 7 May 2025 14:17:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20250507121754.GE9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Wed, May 07, 2025 at 10:23:53AM +0800, Herbert Xu wrote:
> On Tue, May 06, 2025 at 04:38:11PM +0100, Cabiddu, Giovanni wrote:
> >
> > > We'd have to enhance the compression format specifier to make it
> > > configurable in the sense: if accelerator is available use it, otherwise
> > > do CPU and synchronous compression.
> > For usability, wouldn't it be better to have a transparent solution? If
> > an accelerator is present, use it, rather than having a configuration
> > knob.
> 
> If you go through the Crypto API you won't need to add a new knob
> at all.
> 
> The Crypto API is already configurable and comes with a knob
> pre-installed.  Just download crconf and you can configure which
> algorithm will be used by default:
> 
> https://git.code.sf.net/p/crconf/code

First time I hear about such tool and given what it does I think it
should have better visibility and presence also in "the other" git
sources. It's not mentioned in linux Documentation either.

SourceForge is not taken seriously for quite some time and the project
landing page https://sourceforge.net/projects/crconf/ matches the
pattern of abandoned SF projects, last commit 5 years ago.

The first hit on gihub is https://github.com/Thermi/crconf and at least
it matches the SF commits.

The command line interface follows the iproute2 style that is
arguably hard to navigate:

  $ ./crconf
  Usage: crconf add { ALG | DRIVER } TYPE [ PRIORITY ]
	 crconf del DRIVER TYPE
	 crconf update DRIVER TYPE [ PRIORITY ]
	 crconf show { DRIVER TYPE | all }
	 crconf help
  ALG := alg <alg-name>
  DRIVER := driver <driver-name>
  TYPE := type ALGO-TYPE
  PRIORITY := priority <number>
  ALGO-TYPE := { 1 | 2 | 3 | 5 | 8 | 10 | 11 | 12 | 13 | 14 | 15 }
		 1 == alg type cipher
		 2 == alg type compress
		 3 == alg type aead
		 5 == alg type skcipher
		 8 == alg type kpp
		10 == alg type acompress
		11 == alg type scompress
		12 == alg type rng
		13 == alg type akcipher
		14 == alg type hash
		14 == alg type shash
		15 == alg type ahash

The manual page lacks any useful examples and figuring out how to set
the priority took me a few minutes of grepping in /proc/crypto, trial
and error to end up with:

  sudo ./crconf update driver sha256-generic type 14 priority 1000

The usability has a lot of room for improvement.

Anyway, assuming there will be a maintained, packaged in distros and
user friendly tool to tweak the linux crypto subsystem I agree we don't
have to do it in the filesystem or other subsystems.

