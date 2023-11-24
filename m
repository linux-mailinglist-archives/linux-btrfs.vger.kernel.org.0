Return-Path: <linux-btrfs+bounces-342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98867F7654
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E9D1C21059
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F72D61D;
	Fri, 24 Nov 2023 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gXW/zJIs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYYjjWoj"
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 06:26:40 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A619A5
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 06:26:40 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 691EE21A25;
	Fri, 24 Nov 2023 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700835999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqCARvyeQDhmu1LCLApgXiCzHExHPufpfccKha+uLqo=;
	b=gXW/zJIs0qH9nhqn7Czvdz6pOWYfwjzSEzmnFiHpF/YOrvKK6N2TAQ0btlywaaCnXK+Vri
	uj/LawV27VdUCMMLUAcFIcMgwjBNLb3iEx+SyJ+bCMoA1ZOAa9U7qhPHObxpkKW67shJUk
	f9TTs5oxtULDZO9BlF4R4nwvP+wUvZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700835999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqCARvyeQDhmu1LCLApgXiCzHExHPufpfccKha+uLqo=;
	b=TYYjjWojhk0ZRSt6+O5OkcPA1KUg2vB9D41crh4nqJTuzkR+0VxKXAOKaVLGf3pBBGi3TK
	8c9MZsLuRngVuTDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3770E132E2;
	Fri, 24 Nov 2023 14:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id trh7C5+yYGVDIwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 14:26:39 +0000
Date: Fri, 24 Nov 2023 15:19:28 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove no longer used EXTENT_MAP_DELALLOC block
 start value
Message-ID: <20231124141928.GB18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <29f711318957b5efb2005d5cf9a50fd7755cc4a9.1700783554.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f711318957b5efb2005d5cf9a50fd7755cc4a9.1700783554.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.42
X-Spam-Level: 
X-Spamd-Result: default: False [-2.42 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.42)[91.08%]

On Thu, Nov 23, 2023 at 11:53:51PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit ac3c0d36a2a2 ("btrfs: make fiemap more efficient and accurate
> reporting extent sharedness") we no longer need to create special extent
> maps during fiemap that have a block start with the EXTENT_MAP_DELALLOC
> value. So this block start value for extent maps is no longer used since
> then, therefore remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

