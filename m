Return-Path: <linux-btrfs+bounces-3571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526788B489
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9712D1C3EA2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744580050;
	Mon, 25 Mar 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEpHq3ik";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ox4Wp72y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEpHq3ik";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ox4Wp72y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8F7FBDC
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407106; cv=none; b=piNGDqs9ix8ZAuBPypSdsqzZbmu3ncE4YZH0tEiMtZPMKik6QVlEzVIwHGAWLuvrH0TQZrt1e6ffQMa5hp5FKI6w9mdrJbga4CucwM6rkPpE8sxHiPdUyVpVe4z3tqKvG44u/mt0Scp40PxAuHPcNDeksQSEPccn+86hxt/f1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407106; c=relaxed/simple;
	bh=gqp2PqpTSJQt4fnSukt62d1NZ06PsGeNMYT/PyKuSG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RniPQN10tlFGIHFiTZG2CQWZQKfRbZ1RKmcOB9el9/WIapOvOE9LgFARNiOkEd4Hs39FrwGflHY5tZDNtTUCJY3f+yBSXRGLHdFOgcghgCWBvZeu+w/sLhyFHAEOt4IVlCYa9Jun+jWavvtYkflG9O9rby44PqwQpZ8gospFL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEpHq3ik; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ox4Wp72y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEpHq3ik; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ox4Wp72y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D93A3740B;
	Mon, 25 Mar 2024 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711407096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CFIeucB6ORAipk5uTQNHetvVoSuGBxWBhiGH7XtrGI=;
	b=UEpHq3iku3k0EHlS0lrlow1ZwI1s3bl94xSgWuwhBqq8IqSVZQmwK2yxWY48AcN0SQkCm/
	YHvbu+InhH0F+MEU+INrl3jE9z1R+y3Pq4QOLKVDRF+4hbF1M7ON8ufrxzU+l9q6k3HdlQ
	0RHcZdXe3mm634DIuHIbTUwG/3ED/0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711407096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CFIeucB6ORAipk5uTQNHetvVoSuGBxWBhiGH7XtrGI=;
	b=ox4Wp72ybCL2NG6JTfW11iDLYDK7tGx37yJHH9k5sZawgfi533Vvr+3KEUoID8Sa6zgR5t
	zLLQ9cRsggEPZ/Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711407096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CFIeucB6ORAipk5uTQNHetvVoSuGBxWBhiGH7XtrGI=;
	b=UEpHq3iku3k0EHlS0lrlow1ZwI1s3bl94xSgWuwhBqq8IqSVZQmwK2yxWY48AcN0SQkCm/
	YHvbu+InhH0F+MEU+INrl3jE9z1R+y3Pq4QOLKVDRF+4hbF1M7ON8ufrxzU+l9q6k3HdlQ
	0RHcZdXe3mm634DIuHIbTUwG/3ED/0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711407096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CFIeucB6ORAipk5uTQNHetvVoSuGBxWBhiGH7XtrGI=;
	b=ox4Wp72ybCL2NG6JTfW11iDLYDK7tGx37yJHH9k5sZawgfi533Vvr+3KEUoID8Sa6zgR5t
	zLLQ9cRsggEPZ/Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BA6313A2E;
	Mon, 25 Mar 2024 22:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vTW/Hfj/AWZ1FQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 22:51:36 +0000
Date: Mon, 25 Mar 2024 23:44:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	william.brown@suse.com
Subject: Re: [PATCH 0/3] btrfs-progs: subvolume-list: add qgroup sizes output
Message-ID: <20240325224415.GR14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701160698.git.wqu@suse.com>
 <8f062313-1d73-4bfd-9cf8-259ad0fe4fe0@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f062313-1d73-4bfd-9cf8-259ad0fe4fe0@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UEpHq3ik;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ox4Wp72y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.13 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
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
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.92)[99.64%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -4.13
X-Rspamd-Queue-Id: 8D93A3740B
X-Spam-Flag: NO

On Thu, Mar 21, 2024 at 01:51:16PM +1030, Qu Wenruo wrote:
> A gentle ping?
> 
> Any feedback on the new columns?

I sent my comment and reading it again I don't have anything to add, so
it would be better to continue there

https://lore.kernel.org/linux-btrfs/20231206213019.GT2751@twin.jikos.cz/

