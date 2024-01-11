Return-Path: <linux-btrfs+bounces-1398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D384482B269
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5BD287949
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66C4F60B;
	Thu, 11 Jan 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay0tUeY2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z4D6kAWC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay0tUeY2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z4D6kAWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254104F5E9
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A76DF21E2A;
	Thu, 11 Jan 2024 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704989179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=av/S77/OH95AHnFb28rlwKnaA4Kf0pK3A7Gtj01YuU0=;
	b=Ay0tUeY29ybXAvi1xJ33Msztg+VpyyaUVHUUScFsadiFkz/w0w5W2DVZGEfOwVXxUnY5od
	CEniTfrbE/5Sq0MIYf4dCC8z8yMvY5NFgHQvE0i/HLNzm0vP2SnsNC72NAkZCeOApbers3
	TJ6ZbhpHVI2Mm3hnWLxLGYvXZp0HWe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704989179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=av/S77/OH95AHnFb28rlwKnaA4Kf0pK3A7Gtj01YuU0=;
	b=Z4D6kAWCvBsL/xMpWV4uAjXpDcXno92WY4lPmkcTVHhGjfhEt+HqZJxmRKwAbZvhXHF3Rl
	LNY85hOyEocPutBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704989179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=av/S77/OH95AHnFb28rlwKnaA4Kf0pK3A7Gtj01YuU0=;
	b=Ay0tUeY29ybXAvi1xJ33Msztg+VpyyaUVHUUScFsadiFkz/w0w5W2DVZGEfOwVXxUnY5od
	CEniTfrbE/5Sq0MIYf4dCC8z8yMvY5NFgHQvE0i/HLNzm0vP2SnsNC72NAkZCeOApbers3
	TJ6ZbhpHVI2Mm3hnWLxLGYvXZp0HWe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704989179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=av/S77/OH95AHnFb28rlwKnaA4Kf0pK3A7Gtj01YuU0=;
	b=Z4D6kAWCvBsL/xMpWV4uAjXpDcXno92WY4lPmkcTVHhGjfhEt+HqZJxmRKwAbZvhXHF3Rl
	LNY85hOyEocPutBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F55138E5;
	Thu, 11 Jan 2024 16:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PrC6HvsRoGW7fAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 16:06:19 +0000
Date: Thu, 11 Jan 2024 17:05:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fixup: v2 Documentation: placeholder for
 contents.rst file
Message-ID: <20240111160556.GI31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704906806.git.anand.jain@oracle.com>
 <adb208f0750fdbca06594f775eb0a81f886574c7.1704942814.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb208f0750fdbca06594f775eb0a81f886574c7.1704942814.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ay0tUeY2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z4D6kAWC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.96 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.25)[73.35%]
X-Spam-Score: -2.96
X-Rspamd-Queue-Id: A76DF21E2A
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 12:21:00PM +0800, Anand Jain wrote:
> We don't need touch Documentation/contents.rst in the Makefile when
> Documentation/Makefile.in is doing it. Fix the devel commit 7479e750ba65
> ("btrfs-progs: docs: placeholder for contents.rst file on older sphinx version").

Thanks, I was not sure if the file should be in the toplevel directory
too. Updated in devel.

