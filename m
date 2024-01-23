Return-Path: <linux-btrfs+bounces-1648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2DC839721
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF31F221C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0D81218;
	Tue, 23 Jan 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUf8cFLb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFtgjJQN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQjaiAxz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tjyiFCXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A720811EF;
	Tue, 23 Jan 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032838; cv=none; b=VcujhaXh0+1EhFrebbRAMOkTug0+BTyZ42n88PvFWCa14E+ko11l6sIQqa3vyinCqFS6lDh/Qg2ZicMmVxYUyDKgb0CeKLTLMlNfIAkQjmNnPMRdhpmvEzPk8qNWI73ZFj0zAde6GBP0F4ON46kvKP4UMoq1RbqCWl2Hf+7bpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032838; c=relaxed/simple;
	bh=gB1SgnGfzm09XI+5LmFaivN86jXztQ5jJrCvuEAq17w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw8H0wBlIEDTVn3mvg2j7CP5JSwxAxOH5Fy4n4rqxIFOaP9lov9eYvKThctLaXN6A66xbTAn3v386nZeJV3jgf/8FVW0HRzSV5Oysm6Ne4ae5XN2Q5uXO3V4TYX63wtrFvGGWfmyVz7iwsF2ZuDX0D0sv8DWF/MTzpp4+029dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUf8cFLb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nFtgjJQN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQjaiAxz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tjyiFCXd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A21E91F79B;
	Tue, 23 Jan 2024 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73bOZ+zCkZyM30zC+DeYdYwK5c+ej+sHgFTKc3CTQW0=;
	b=sUf8cFLbTH+8c1EGMLVeUglSVuqPMhdySyU33HZYuBXMdQFa9ViEMeb8wxobTVA+Qjo6Aq
	CMXmWqX0DTaQ70kzfZjeKnP+znlN5WxE96E9rVT95Q7RPA5nRn+SUOyNDO03tnhhjlrj/i
	g0DgrMVCTEofdth+rri2pc5Q8KN9Uq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73bOZ+zCkZyM30zC+DeYdYwK5c+ej+sHgFTKc3CTQW0=;
	b=nFtgjJQNMmAgOaG4i+B1EwKCWfU4viFPX3mhc3MIRVZk/D4pWVPxBDKOW9dZ0ZlFXFIm7z
	aqkDvqDnwVyOCBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73bOZ+zCkZyM30zC+DeYdYwK5c+ej+sHgFTKc3CTQW0=;
	b=UQjaiAxzCYu7nvLsTwtYRK8T053Kvo3MrIoBY9kjBBvcAlXXMepZKflnfDHlA5ZfgYr0u4
	6USHVrNSNIHN55r5kJNoVW/zRoVCrPEPl7E8GNBsZl8DC5BseGgOB9DlPPGotkEsV80f8t
	LkaUbflIehKqq8kJa3I9XZ+hJO6Xm10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73bOZ+zCkZyM30zC+DeYdYwK5c+ej+sHgFTKc3CTQW0=;
	b=tjyiFCXdOlieg8/hb7BX6blMfZWZN+vk4dpxqGL5FzjT/q7adSBDels12x4Y1eVZBseKI+
	+6WplbpVZfMebDBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67DC113638;
	Tue, 23 Jan 2024 18:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4WgYGMD+r2XvCAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 23 Jan 2024 18:00:32 +0000
Date: Tue, 23 Jan 2024 19:00:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/82] btrfs: Refactor intentional wrap-around test
Message-ID: <20240123180010.GI31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-44-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-44-keescook@chromium.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UQjaiAxz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tjyiFCXd
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.36 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.60%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.36
X-Rspamd-Queue-Id: A21E91F79B
X-Spam-Flag: NO

On Mon, Jan 22, 2024 at 04:27:19PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David Sterba <dsterba@suse.com>

