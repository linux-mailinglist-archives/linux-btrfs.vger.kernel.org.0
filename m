Return-Path: <linux-btrfs+bounces-15164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BDAEFCF4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D04E12DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B1277C88;
	Tue,  1 Jul 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQ9t/tTc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dr2oRw6H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSidycpQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R867c9AO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E0274651
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381243; cv=none; b=KuWLG6Eaaiv/+K8OqHw+UiUJQnZGoHXCvCgo06ZgnD0b/vVM3Mdpx8086Gpwj7eOGS/LywHQBs8riDt8eHe8e8AB8ysdjAsRj+tO+3eM+Zv4tLDYX7o9+3bCCYzsQShOXcXCvzuTy9Hu4mpQ7ORyBOIHXhUEdwSdTsvgoZClrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381243; c=relaxed/simple;
	bh=uchl4TGvvyLRgfOwa5G9aycJuKhnA6wXIY2x/ruZW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvcLgVr7Si9rkEsSPCS30+v6455fhfMcN0Hy6Te7Gey32kibwzeZAeysU3bAHtudhHjpxstWKd+6QN3IUV24PS9G2M/7rO+Qbhnw/GuUpC7Gpq9sy9CS+35uWZ2EzBNGD4DeuMq/gF3BDDvmsmweZHyfslm+Z5Bun+EJUJfY4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aQ9t/tTc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dr2oRw6H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSidycpQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R867c9AO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB8C621163;
	Tue,  1 Jul 2025 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN7z/yeF3LcTIzNe8/TQinambjWMr2qn8pR9N92vzOc=;
	b=aQ9t/tTcfunEujHmvWtebAPpm874r5WVQqTV1dF4/KdIEoK3ypbv98c4mQeiI877lklZfD
	cXltI3YZw1/pr1ldMHww8eCT0wSyxHRiC33tG5xmkyp2XSV9pQBMaEZe2Afxbl/uBcX6Zr
	eii9DGDXdazxJO7HN20qNchH+11YGF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN7z/yeF3LcTIzNe8/TQinambjWMr2qn8pR9N92vzOc=;
	b=dr2oRw6H4oh1uQ2J1mOkKYO4Rc+84yEgJ2wW6euVrCr1HFfGIbQLWLvLE6RgqV1cmFYycw
	vYZmEl+R2notJyBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tSidycpQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R867c9AO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN7z/yeF3LcTIzNe8/TQinambjWMr2qn8pR9N92vzOc=;
	b=tSidycpQsR+ApheSoSF1IL1x1wW9xG4lfVfhjilCYRjoRNuDLZBSAph3kUhi7+QvU6O0qD
	mZ4hjgmP8enfTzNMiMHMJIdxgqZsrZbc2WN/Fiw7KXldncYhssY4QgWuD5ez2IEGEINuhH
	67+du1C3IAKSnyOdEes2dtEhfjtwfWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN7z/yeF3LcTIzNe8/TQinambjWMr2qn8pR9N92vzOc=;
	b=R867c9AOsjvsM6bohetmPZ1Dhx50Xy6FfS9C83dQLPzyce4sE5loUfhm8hBVNjtvceN0yq
	Xa2GtO7Kl+yRPwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B09721364B;
	Tue,  1 Jul 2025 14:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqTnKvb0Y2iOFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Jul 2025 14:47:18 +0000
Date: Tue, 1 Jul 2025 16:47:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Alan Huang <mmpgouride@gmail.com>
Cc: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Message-ID: <20250701144717.GR31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750858539.git.dsterba@suse.com>
 <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
 <20250630102457.BFB9.409509F4@e16-tech.com>
 <20250630162130.GK31241@twin.jikos.cz>
 <20250630164328.GL31241@twin.jikos.cz>
 <5D89E5E9-6F7B-432F-89F4-4632A51511EC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5D89E5E9-6F7B-432F-89F4-4632A51511EC@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CB8C621163
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jul 01, 2025 at 01:07:06AM +0800, Alan Huang wrote:
> >        WARN_ON(!list_empty(&device->post_commit_list));
> > -       /* No need to call kfree_rcu(), nothing is reading the device name. */
> > -       kfree(device->name);
> > +       /*
> > +        * No need to call kfree_rcu() or do RCU lock/unlock, nothing is
> > +        * reading the device name but the checkers complain.
> > +        */
> > +       rcu_read_lock();
> > +       name = rcu_dereference(device->name);
> 
> Since it’s safe here, can we use rcu_dereference_raw without  rcu_read_lock() ?

Right, thanks for the hint.

