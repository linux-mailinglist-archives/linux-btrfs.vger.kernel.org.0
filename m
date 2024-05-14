Return-Path: <linux-btrfs+bounces-4978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930928C5A30
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A416282A9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116E17F39E;
	Tue, 14 May 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QC5P8KkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlK3m1ew";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QC5P8KkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlK3m1ew"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8651C42
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707252; cv=none; b=gSpJyldq8B0h354HDgcLxBldukMvs/vIE01/ZCALyNzjtXnbtOomnXK98EFNvd61Eou7nY9PTiydgKy/V2O+WpBJjHPG0gn3+wpigqSRDoDGlpR+BRlWnLedXp8f08ttVjQsV+VNDoGjNeWttCks1IJ04lmmdY1Hc8CL4k6xx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707252; c=relaxed/simple;
	bh=D+1RdbpjG9BkWcgrtgL0wnuW5fOiVdGggzB2emVBBAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3sDbpiIB47lu4SoT3QihM2jzOkGQEDIrmTkrDHp+IgUNwDTfiDk+2+bMZLVMbv5W7tiKLXUxdgMbvDjJ9v4nAdXjZvraeFO36CKsfsH5BosT12oBDEbXe80xQEIg2wu6CIY/pt1K9Ty2dm0dImvptMrjyZWjDEig6vhQQx5SbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QC5P8KkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlK3m1ew; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QC5P8KkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlK3m1ew; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BEDA33690;
	Tue, 14 May 2024 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715707248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ6ivy5grAIhQ26jRNdbYBWUSiRGzKPsE+YNBFOHQs4=;
	b=QC5P8KkWotQ/N5Y6sBA0S9l72SSHye7J/8KXa9US7vPza8zGuJFDZLB/IG+gG24YXdXD+K
	qP+qc7fM40HmpCt8AQ6TsoEj7A4A7OwJXSiNVEs4BXppC76pqs5GAclHT+phlrMizs7d0r
	TpNXbFP6/VKEecbC1iOk40ozi/e8gtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715707248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ6ivy5grAIhQ26jRNdbYBWUSiRGzKPsE+YNBFOHQs4=;
	b=zlK3m1ewRsHerRZYZcUrnsngFxkybtOmqWui3BvTN0cQHkqZ9tTb4fhFM04ysvpGqGtcnw
	3B2DZj0giJdl8aAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715707248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ6ivy5grAIhQ26jRNdbYBWUSiRGzKPsE+YNBFOHQs4=;
	b=QC5P8KkWotQ/N5Y6sBA0S9l72SSHye7J/8KXa9US7vPza8zGuJFDZLB/IG+gG24YXdXD+K
	qP+qc7fM40HmpCt8AQ6TsoEj7A4A7OwJXSiNVEs4BXppC76pqs5GAclHT+phlrMizs7d0r
	TpNXbFP6/VKEecbC1iOk40ozi/e8gtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715707248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ6ivy5grAIhQ26jRNdbYBWUSiRGzKPsE+YNBFOHQs4=;
	b=zlK3m1ewRsHerRZYZcUrnsngFxkybtOmqWui3BvTN0cQHkqZ9tTb4fhFM04ysvpGqGtcnw
	3B2DZj0giJdl8aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A85137C3;
	Tue, 14 May 2024 17:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OSVTHHCdQ2ZQbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 17:20:48 +0000
Date: Tue, 14 May 2024 19:13:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Julian Taylor <julian.taylor@1und1.de>
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] btrfs: do not wait for short bulk
 allocation" failed to apply to 6.6-stable tree
Message-ID: <20240514171331.GK4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2024041951-sports-hula-f2a5@gregkh>
 <bdeef163-e099-4b70-953e-248bf44ee37f@1und1.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdeef163-e099-4b70-953e-248bf44ee37f@1und1.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.961];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Mon, May 06, 2024 at 10:41:14AM +0200, Julian Taylor wrote:
> Hello,
> 
> thank you for swiftly fixing the issue.
> 
> As the problem affects the stable releases 6.1 and 6.6 would it be 
> possible to backport the fix to these versions so it can make its way 
> into distributions?

6.1 and 6.6 backports sent, thanks.

