Return-Path: <linux-btrfs+bounces-2944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FC86D3A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D40E285FDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52911350C9;
	Thu, 29 Feb 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ceIxmeb5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9dn6pwSn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="THp5s5wg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ymqVR50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618213C9D5;
	Thu, 29 Feb 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236092; cv=none; b=r8ZDMNlWXIqeBZ4lSb+h9dzTjkoKWdYsfGvBBeRJDG7sCmHAdHBojvgoo78pui12rOE5ShWtDt38gfYDl3nE0sgYZW/KBkYcUAg9rMIttSN85KEyBDyF1ZRdZz3K0cqJE3N0JOj5RRs/N1h5Pa4VHIGc9YI7TGlpsyTGjjY9Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236092; c=relaxed/simple;
	bh=DZfc0jcucjAXJEl0NBJPZr9xKMQAiv1ZGKz+suOqMoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4mCgeEB3WHZRftbHaRN8HrIh4IMx9kUsRHaKtSY6Vi4wTirwmbYCV8xyQA6CGYrthdKFFCVnoitPx+7nS3bGu2a7lHxY/qou9kKgg25NAfs5dIRSJnoesEcZ8R403ydE+5Y/E5+qJxV94QVG/F8qmqOoKocbinS2tVK/JowgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ceIxmeb5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9dn6pwSn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=THp5s5wg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ymqVR50; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D64C221C54;
	Thu, 29 Feb 2024 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udyHSS1C9B2fKVmEXwRQ/ir9SjpEwHdWjZ3YEgMGnXk=;
	b=ceIxmeb5Fg0tsbSZXcWrhSp1w/vFXaZBXKEwGo7xuI6YjqbxVUcvZed73NBKTEyfURvFjK
	jRxhjcToxorldksg5ffW9Io5hQ4n5u6qED1J8h0+SnZ3zPt025gqmCVrpwIvKx4mgmZU3h
	o68J/JD9bLqzGXCJHG/Xby9/x4kimx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udyHSS1C9B2fKVmEXwRQ/ir9SjpEwHdWjZ3YEgMGnXk=;
	b=9dn6pwSnfmkjEjRiBeHWW0Ed3b3YRVtQS/Wr0AAwQmQmc1/aKb4qNxxFjbeF8cPix3AXMU
	HKboapMIQJ8XDKDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udyHSS1C9B2fKVmEXwRQ/ir9SjpEwHdWjZ3YEgMGnXk=;
	b=THp5s5wgzsjkN9cV+b62DUTStASRyqbzaJZdyCFIfYZwjDsy8/ildL3mkhuPD48Hji6QM3
	nsrMQZPqoZmBzSqverXJxOEnrxQvq7IJjBFOAXa8xLuQ/6MK629olRbus3b8WyI+BokHpV
	N5pbe+lEWvEYWEXjszrAgmo0X60MoX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udyHSS1C9B2fKVmEXwRQ/ir9SjpEwHdWjZ3YEgMGnXk=;
	b=7ymqVR505ZyBvshcdlMFZiwqcNOZAaoj5jMEqmv7Kzgsc8daz7L3sac48AWtOPjRQ4ztie
	dErzvKV7ThPzM5Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEF613451;
	Thu, 29 Feb 2024 19:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6URrLnjf4GUSfQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 19:48:08 +0000
Date: Thu, 29 Feb 2024 20:41:01 +0100
From: David Sterba <dsterba@suse.cz>
To: lilijuan@iscas.ac.cn
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: Re: [PATCH] btrfs: mark btrfs_put_caching_control static
Message-ID: <20240229194101.GE2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240229083007.679804-1-lilijuan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229083007.679804-1-lilijuan@iscas.ac.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=THp5s5wg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7ymqVR50
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.46 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.25)[73.20%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -1.46
X-Rspamd-Queue-Id: D64C221C54
X-Spam-Flag: NO

On Thu, Feb 29, 2024 at 04:30:07PM +0800, lilijuan@iscas.ac.cn wrote:
> From: Lijuan Li <lilijuan@iscas.ac.cn>
> 
> btrfs_put_caching_control is only used in block-group.c,
> so mark it static.
> 
> Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>

Added to for-next, thanks.

