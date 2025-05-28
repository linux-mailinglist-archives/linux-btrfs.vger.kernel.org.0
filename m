Return-Path: <linux-btrfs+bounces-14270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700AEAC6AD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F039189F06C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C82882A1;
	Wed, 28 May 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1Y/rjJF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnRTkbWb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1Y/rjJF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnRTkbWb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5D257440
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439830; cv=none; b=tKTuBfL4J/wPRJrCeidy+KliLgiGuG/ZnNAmY3Fl53Vn88mrThB4vkfrTScTUnKWC7ehpu0Gup0iBBj4LKeCVhefKRGgAQ5LVA9yrcGgwu4GrmwrvtBA45cc0aDT3XmOWbwluk5by+6aeCkJE75JN+JXh9kCE6DvDnm35gd4HL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439830; c=relaxed/simple;
	bh=mNAC+0Ss8DPuaj9OX1SiZu8CYmHgwn69lrE1D/Y1PLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeJgYoNPL5Xoqjn8vEH2RZW/vyZUAbZshy+qiE4w391M6heDNf5/Vn4IAjEglRuFqHXSJaBrhWz8FMmrlxZaT8GDgdTaWibNNwIwssS6EecPNkDdG0tAeFWfZDfOUERcqJZ2B+JYFs0qejr9MfEzzxsAeCxifN6AxFbcHA643A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1Y/rjJF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnRTkbWb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1Y/rjJF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnRTkbWb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9388B21AA5;
	Wed, 28 May 2025 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748439826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PFd+W5hMhu6f2gOq5+OmJJUofAwJaZLRO2Kro7RGg=;
	b=x1Y/rjJFuWInSRQNchFVBsRDCzP4MwlMeMLbQWZY+HCObx0i+x4RMoxkL9ezYs3ZmYUIQr
	9VQg9Jr00RjEi3O56x1ZD0rn9ssyouqePUdYIH52XR+aWozKcEMs0dwC/N/3I/QdK+BXHf
	Per0jJfEWu+irv4MAO5txnRMT8Xj8YA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748439826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PFd+W5hMhu6f2gOq5+OmJJUofAwJaZLRO2Kro7RGg=;
	b=cnRTkbWbkIYITNQDGAs6k0Rd/6/kWwME1vJHSXeHnezI2FtkpGO5RbysREqjaIrTcYvUN3
	ViVfuzJh5ShSKqCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="x1Y/rjJF";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cnRTkbWb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748439826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PFd+W5hMhu6f2gOq5+OmJJUofAwJaZLRO2Kro7RGg=;
	b=x1Y/rjJFuWInSRQNchFVBsRDCzP4MwlMeMLbQWZY+HCObx0i+x4RMoxkL9ezYs3ZmYUIQr
	9VQg9Jr00RjEi3O56x1ZD0rn9ssyouqePUdYIH52XR+aWozKcEMs0dwC/N/3I/QdK+BXHf
	Per0jJfEWu+irv4MAO5txnRMT8Xj8YA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748439826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PFd+W5hMhu6f2gOq5+OmJJUofAwJaZLRO2Kro7RGg=;
	b=cnRTkbWbkIYITNQDGAs6k0Rd/6/kWwME1vJHSXeHnezI2FtkpGO5RbysREqjaIrTcYvUN3
	ViVfuzJh5ShSKqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 862C0136E3;
	Wed, 28 May 2025 13:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kRCGIBITN2jLPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 13:43:46 +0000
Date: Wed, 28 May 2025 15:43:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add root id output for direct IO error messages
Message-ID: <20250528134344.GD4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <af31c7ae4ba5c76d57527f5a774f3816f69b54d8.1747695628.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af31c7ae4ba5c76d57527f5a774f3816f69b54d8.1747695628.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9388B21AA5
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, May 20, 2025 at 08:30:32AM +0930, Qu Wenruo wrote:
> When debugging a kernel warning caused by generic/475, the error
> messages from direct IO lacks the subvolume id, meanwhile th error
> messages from buffered IO contains both subvolume id and inode number.
> 
> This makes debugging much harder to grasp which inode (and its
> subvolume) is causing the problem.
> 
> Add the subvolume id for direct IO failure message.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

