Return-Path: <linux-btrfs+bounces-15114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E511AEE428
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0593BB0FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB929827B;
	Mon, 30 Jun 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y96HeBAS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHVowxXX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y96HeBAS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHVowxXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23F2900A4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299946; cv=none; b=NFABU5RlmRnxS7FGYsaSDQObrnYpRpTGk8CpNeEcoQzahtMhe6zKFaAcvkABdGjduKXCexpnpiVWaYbrS7B5H+TrJPQml6i4AmfPCuuJwcE2j2CnpqEWECLgP9AL2MX9Z8W6n1q8tBlEZEEoCDmDR6hiiI5QNijhRmiNSayv5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299946; c=relaxed/simple;
	bh=FtbBCj4+GHpgu7Dy06vOabgNMTD5RmMVmwY1Sgx2QS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar+6H9YIo8w75SE614eCvF8hjd5Rr9GWVow4V5KmVZE4euWpitHrFo+JQUy0Sge1lpU6ti0fLqnHrwZe9H4vXbf+CHIJEsXXGvU0HFBiWsQ3S31C08OWezOtgw09oyMVFRZutV5b9mGqdTdF9qpV3hXieGvF0J2RN2iLLjmzRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y96HeBAS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHVowxXX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y96HeBAS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHVowxXX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE6251F393;
	Mon, 30 Jun 2025 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751299942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNV0eE/zlK0f8cOMVjqCFlky3boOzUCMdC2jqfFRIU=;
	b=y96HeBASLM1yYZoRZy72DEa8j7ntTocvEcul0i9At4pG0HzI64cSK3NxwCLjKMZBFTjTUK
	dKBBryXLGZC92Sv1hxfGJaDU+8GlrY40g2JfB2fVYP3PESmjkbruHdzP1rOsVvc07jLkcu
	9nJyQ0n451fNbnqad2RnPFzv3SCGSjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751299942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNV0eE/zlK0f8cOMVjqCFlky3boOzUCMdC2jqfFRIU=;
	b=VHVowxXXkEf3jn0rjGRMQNoy7jQgml0gkz4qcDBINEEhOPpWaBUVerpLxXsfuXVT+g8QtI
	SLa+Ko7n/Ge41yAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751299942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNV0eE/zlK0f8cOMVjqCFlky3boOzUCMdC2jqfFRIU=;
	b=y96HeBASLM1yYZoRZy72DEa8j7ntTocvEcul0i9At4pG0HzI64cSK3NxwCLjKMZBFTjTUK
	dKBBryXLGZC92Sv1hxfGJaDU+8GlrY40g2JfB2fVYP3PESmjkbruHdzP1rOsVvc07jLkcu
	9nJyQ0n451fNbnqad2RnPFzv3SCGSjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751299942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNV0eE/zlK0f8cOMVjqCFlky3boOzUCMdC2jqfFRIU=;
	b=VHVowxXXkEf3jn0rjGRMQNoy7jQgml0gkz4qcDBINEEhOPpWaBUVerpLxXsfuXVT+g8QtI
	SLa+Ko7n/Ge41yAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A6513983;
	Mon, 30 Jun 2025 16:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2EHI2a3Ymh2FAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 16:12:22 +0000
Date: Mon, 30 Jun 2025 18:12:21 +0200
From: David Sterba <dsterba@suse.cz>
To: George Hu <integral@archlinux.org>
Cc: wqu@suse.com, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace nested usage of min & max with clamp
 in btrfs_compress_set_level()
Message-ID: <20250630161221.GJ31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <669773b7-4428-43ca-ab80-d7ed1c71886c@suse.com>
 <20250628052130.36111-1-integral@archlinux.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628052130.36111-1-integral@archlinux.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 

On Sat, Jun 28, 2025 at 01:21:30PM +0800, George Hu wrote:
> Refactor the btrfs_compress_set_level() function by replacing the
> nested usage of min() and max() macro with clamp() to simplify the
> code and improve readability.
> 
> Signed-off-by: George Hu <integral@archlinux.org>

Reviewed-by: David Sterba <dsterba@suse.com>

