Return-Path: <linux-btrfs+bounces-3373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235087F2F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEA628222F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D85A0E5;
	Mon, 18 Mar 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bt+GRtPN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YvONuX1H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4P+Kany";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aI7Adjko"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BB288B6;
	Mon, 18 Mar 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799784; cv=none; b=g+Jmvm5YPVH3ojpoNf++XNcxrmRTDFL+2k+osYA/L+4dQng0JUYvVQ7uqVRTUnqjFPUtPRhPDP/YBQV8OPDvjf9BBN4tcWQH+Bf7RJ+euC/brSsi9Ux+dJRyP+W/ndiu4K+aAGquxDWSghtsO78QmJh0LAKyLWSWhvB2CnxtLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799784; c=relaxed/simple;
	bh=0JU7lIbBllpV+QfOdizY7h7Mz17HL2b0SsTY0zpPSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCcPBEtVoYHdeFgSFinP6XXapKGPg6yvBApbF8lUiHyMoKVoljc9cM1ueuzHMPEYN4PNwhku/f0kxroSkbSpBTATXJKH1ZCTg16Vwmr6T1pK/FtcchZqpBUegjSqWyti0sHufdi99uN6TkznGmb7uheg7yUaKMf27AlIKWST9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bt+GRtPN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YvONuX1H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4P+Kany; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aI7Adjko; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3B735CBA4;
	Mon, 18 Mar 2024 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710799781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNGkMGuHL9aHt4JSRdTR3kkQlXvabMOIJAcijhXpVuI=;
	b=bt+GRtPNLYo08LJeueJ1jLKFGz4tGQ3qlY7mKzNP42JtqULElbhBRljZwDVl88KO1G0tFz
	YYATlWNLcIhxD5rit/hcCE9G3+HUdqC4ap0mtqU0ZUAiDY9TOiJWaPUMACRrg7rZVtpLSg
	CByP8HBmNSWSlj+loMQ0UabiUycb1Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710799781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNGkMGuHL9aHt4JSRdTR3kkQlXvabMOIJAcijhXpVuI=;
	b=YvONuX1HReGcMqRxSG5d+n8Wti9HYWG2pgypH//RsH+YnQvEi0l/PonN1uBd3obpotdAG0
	ymbsZ7y+kq5Kd5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710799780;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNGkMGuHL9aHt4JSRdTR3kkQlXvabMOIJAcijhXpVuI=;
	b=O4P+KanyS7KT6ccHspsm/pJVIDlqlr4pFwThsjLfZ64yme4CRhxnKm9gkUmT0m3XkLkIbm
	pzLhjI2sGkFrsyvAu6aOJon28/cz65LAzE3KIwsu95mOuvb2YVZnVuWZAPkX1ifRcYT3U7
	zEymbDdIXH9+fASn1CXb8+LsamEjBYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710799780;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNGkMGuHL9aHt4JSRdTR3kkQlXvabMOIJAcijhXpVuI=;
	b=aI7AdjkofUvloQYa2PQH3mio2poOPtyT+FG/VnqCr7r9k8ZFs2nTYZtt0F0sGCGOrZSUeC
	LKxUY1mweMYQumDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9EA41349D;
	Mon, 18 Mar 2024 22:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XZAvLaS7+GVUUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 22:09:40 +0000
Date: Mon, 18 Mar 2024 23:02:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <20240318220219.GI16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O4P+Kany;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aI7Adjko
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.33 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[67.02%]
X-Spam-Score: -1.33
X-Rspamd-Queue-Id: D3B735CBA4
X-Spam-Flag: NO

On Sat, Mar 16, 2024 at 10:32:33PM +0530, Anand Jain wrote:
> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> test case btrfs/312, which assesses the functionality of cloned filesystem
> support, can be refactored to be under the shared group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> Move to shared testcase instead of generic.

What's the purpose of shared/ ? We have tests that make sense for a
subset of supported filesystems in generic/, with proper _required and
other the checks it works fine.

I see that v1 did the move to generic/ but then the 'shared' got
suggested, which is IMHO the wrong direction. I remember some distant
past discussions about shared/ and what to put there. Right now there
are 3 remaining tests which I think is a good opportunity to make it 0.

