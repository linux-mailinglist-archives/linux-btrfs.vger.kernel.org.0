Return-Path: <linux-btrfs+bounces-1630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210883792C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E595428A582
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96E252F7C;
	Mon, 22 Jan 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcXOglbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P0plIxg6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcXOglbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P0plIxg6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D950274
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967700; cv=none; b=khnDMyL6px/vxWXj25dSRnWUi/MWFG/QEJk+p7s2WAzl+u+cNrI4sczjBhLqmE+YU0uXoQFTJotjcs2WFmABDaSpvxw2Ep0RVUzcZXYjAdXS2kcnMx8KUQA5LHG61Wy3Eqz9lCRBn5sQNqR5eEH/jLF+LidR+231VGFzYgtZETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967700; c=relaxed/simple;
	bh=eKjufmjp02OU/BERmraJ4l16ebDfti4lelDT5Aylyic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnZOIHkOf/93RLWmAbzJlZL0xag0w8hBIM5TH99awsV7nK1lB7HC9qft6090sPC2xdU3Q+Ua00P1ySjPWjCM+qn2ydJawzZDn9pdXoH+tPbkDiT0KW8OA5au50pePdaZhkE75pTLZPmRfpl4sSAHGWYsZNIWrgc8QE/L82h7thE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcXOglbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P0plIxg6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcXOglbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P0plIxg6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84BFF1FD42;
	Mon, 22 Jan 2024 23:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705967694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDcHmx9nHfYOnrygmiCScv625tgf49plmINeIGaxr08=;
	b=tcXOglbgOCp91Dz8T2c7SHLDJnWJV2EuH56XbFdMdIlUXer1Tqi1ZzUqJ8MMJnfs0aeKco
	7F7FKFXyoBtqM96g1c9pBOu+F4YBuZo6McQ83/HuDQ1O8AfeS3yZeiND6Qbelvlv7PyQ64
	KBh9mncZK1h48MvFDJKYRS7mmOeLISY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705967694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDcHmx9nHfYOnrygmiCScv625tgf49plmINeIGaxr08=;
	b=P0plIxg6hDC/KkxFlM5RU/KzhvCxLN/DT/t1yAhWsJUb+viPoP/ZQ1S+JbPW9tXQw/FT1C
	avqVAxiyb983RlDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705967694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDcHmx9nHfYOnrygmiCScv625tgf49plmINeIGaxr08=;
	b=tcXOglbgOCp91Dz8T2c7SHLDJnWJV2EuH56XbFdMdIlUXer1Tqi1ZzUqJ8MMJnfs0aeKco
	7F7FKFXyoBtqM96g1c9pBOu+F4YBuZo6McQ83/HuDQ1O8AfeS3yZeiND6Qbelvlv7PyQ64
	KBh9mncZK1h48MvFDJKYRS7mmOeLISY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705967694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDcHmx9nHfYOnrygmiCScv625tgf49plmINeIGaxr08=;
	b=P0plIxg6hDC/KkxFlM5RU/KzhvCxLN/DT/t1yAhWsJUb+viPoP/ZQ1S+JbPW9tXQw/FT1C
	avqVAxiyb983RlDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DA751390F;
	Mon, 22 Jan 2024 23:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2XxXGk4Ar2VtEQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 23:54:54 +0000
Date: Tue, 23 Jan 2024 00:54:33 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Klara Modin <klarasmodin@gmail.com>, wqu@suse.com,
	linux-btrfs@vger.kernel.org, terrelln@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, clm@fb.com
Subject: Re: [PATCH 3/3] btrfs: zstd: fix and simplify the inline extent
 decompression
Message-ID: <20240122235433.GG31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com>
 <20240122205947.GB31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122205947.GB31555@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tcXOglbg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P0plIxg6
X-Spamd-Result: default: False [-0.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org,fb.com,toxicpanda.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.62%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.02
X-Rspamd-Queue-Id: 84BFF1FD42
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Jan 22, 2024 at 09:59:47PM +0100, David Sterba wrote:
> On Mon, Jan 22, 2024 at 09:45:42PM +0100, Klara Modin wrote:
> > Hi,
> > 
> > With this patch [1], small zstd compressed files on btrfs return
> > garbage when read on my x86_64 system. Reverting this on top of
> > next-20240122 resolves the issue for me.
> 
> Thanks for the report, this is serious. The patches have been in testing
> for some time but haven't uncovered the problems you mention.

Current status is that the commit is reverted in master branch as Linus
also hit the bug. The cause and a fix are known

https://lore.kernel.org/linux-btrfs/b55a95be-38e8-4db7-9653-f864788b475c@gmx.com/T/#m873962a3b205625045feb9a4f8db70e75f66e418

For the time being the bug described in the changelog will be present
(affecting the subpage case), with the fix for zstd revisited in the
future.

