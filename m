Return-Path: <linux-btrfs+bounces-4532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6468B1165
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE471C24D28
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69716D4E7;
	Wed, 24 Apr 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z7UIhN4C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOvDdEZ+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z7UIhN4C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOvDdEZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9115B55C
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980727; cv=none; b=biLK70KEcjYR0uHlOzZxH3bARzLIWCuxhImTXt++/I8FWA5tM5X7pM5WzXTDmTE0inL63QvfAVRbhOe1a+zq8nZ+9coPO/ZKI8aQXEyeRqdVWPHv9O4NgouUxYn+b/DFlFtETmkX8ShWuRhWUzOLyAGFDRv9wioVs5qx1u0QqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980727; c=relaxed/simple;
	bh=ALYcTEYDcG2hUxc1aWNxY3+grYIiOf5sl/WgpH8ADbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQlHiriJvjAr79+9zg1bQKTajp09stHkkw3vDVYrKlviF/laq8zmomQKr3mlnjwizfw+CKQRXQx6tLK1LWo6/jpH/0pzrd6i8yeETWTSgpJ26W1KO9bjJ8hGbjRR5YsKOB92u46suVrEQaQMifb248H1zWhK08u7GqUd1pKXb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z7UIhN4C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOvDdEZ+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z7UIhN4C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOvDdEZ+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 005DD219F7;
	Wed, 24 Apr 2024 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NOk4++yD9VxbZB35GDZdHh3DjlyqTDGAzlYCjoWYm8=;
	b=Z7UIhN4C6ZYGaoV5y5vCG+9h3xXzvesc7dQne64zwQ47V48EuJUWPeQB62i8FXdNwPbXm1
	fqYO6+/aYJTVZ9LKu/rp7gof78ll4KwN+1v7ylJaPmhVWzv5/OL4+gr8QY/YtmOdfFZsYt
	uDl51RMCbKrLeJ+BIJ+SrFd0dvS4JgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NOk4++yD9VxbZB35GDZdHh3DjlyqTDGAzlYCjoWYm8=;
	b=qOvDdEZ+nHbSiI8eRZQPRPFFKXimt+BC+S3p6cXVNzCnOaU/1tf8xGl6uDUolfTAz5pdf5
	nl5wOwDadYOiYbAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z7UIhN4C;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qOvDdEZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NOk4++yD9VxbZB35GDZdHh3DjlyqTDGAzlYCjoWYm8=;
	b=Z7UIhN4C6ZYGaoV5y5vCG+9h3xXzvesc7dQne64zwQ47V48EuJUWPeQB62i8FXdNwPbXm1
	fqYO6+/aYJTVZ9LKu/rp7gof78ll4KwN+1v7ylJaPmhVWzv5/OL4+gr8QY/YtmOdfFZsYt
	uDl51RMCbKrLeJ+BIJ+SrFd0dvS4JgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NOk4++yD9VxbZB35GDZdHh3DjlyqTDGAzlYCjoWYm8=;
	b=qOvDdEZ+nHbSiI8eRZQPRPFFKXimt+BC+S3p6cXVNzCnOaU/1tf8xGl6uDUolfTAz5pdf5
	nl5wOwDadYOiYbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E91A913690;
	Wed, 24 Apr 2024 17:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UhRdODNFKWbOTQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:45:23 +0000
Date: Wed, 24 Apr 2024 12:45:15 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 11/17] btrfs: push extent lock into run_delalloc_cow
Message-ID: <53tcimxz7vjohcvv77d6plkejgipiela2z3tgkkow4szidfy6h@l7xy7pqajwcg>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <139e8e88fb6e8eb6203ae211b0e7056729e6ed81.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139e8e88fb6e8eb6203ae211b0e7056729e6ed81.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 005DD219F7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,toxicpanda.com:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 10:35 17/04, Josef Bacik wrote:
> This is used by zoned but also as the fallback for uncompressed extents
> when we fail to compress the ranges.  Push the extent lock into
> run_dealloc_cow(), and adjust the compression case to take the extent
> lock after calling run_delalloc_cow().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

