Return-Path: <linux-btrfs+bounces-945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13841812187
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DF7282C6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648981831;
	Wed, 13 Dec 2023 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MSt5dQdV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+ramPYM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MSt5dQdV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+ramPYM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF23F7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 14:32:26 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5FF422388;
	Wed, 13 Dec 2023 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702506744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxWRvPs1mky6vAQPllCiusVf2PFFSDCc6DJ5VExyyo=;
	b=MSt5dQdVBW/CbeQfQNT5YFTpg7kt+F2vDR3Qi0TRFviyM4QknkTldSLqooqU4sACryIRvy
	oeQH5fH6rGq6u9HcEmXt9Iq+r46znlkKrcJmyPKNG9VwJ0JrvyF9b9gvGe4jF5cAKhMRdd
	wLAHTwcs/MaxOFA6wxfBowCCdio6OXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702506744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxWRvPs1mky6vAQPllCiusVf2PFFSDCc6DJ5VExyyo=;
	b=y+ramPYMPUQhwuerxiu5u+KS9LwlvoM9MEQ3a7liNqECUGXQiqWUOykWdS8nVKIAstVCdI
	TirJxFASlDLxLIBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702506744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxWRvPs1mky6vAQPllCiusVf2PFFSDCc6DJ5VExyyo=;
	b=MSt5dQdVBW/CbeQfQNT5YFTpg7kt+F2vDR3Qi0TRFviyM4QknkTldSLqooqU4sACryIRvy
	oeQH5fH6rGq6u9HcEmXt9Iq+r46znlkKrcJmyPKNG9VwJ0JrvyF9b9gvGe4jF5cAKhMRdd
	wLAHTwcs/MaxOFA6wxfBowCCdio6OXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702506744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxWRvPs1mky6vAQPllCiusVf2PFFSDCc6DJ5VExyyo=;
	b=y+ramPYMPUQhwuerxiu5u+KS9LwlvoM9MEQ3a7liNqECUGXQiqWUOykWdS8nVKIAstVCdI
	TirJxFASlDLxLIBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 762301391D;
	Wed, 13 Dec 2023 22:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TBUHHPgwemXZNQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 22:32:24 +0000
Date: Wed, 13 Dec 2023 23:25:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.cz>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>,
	Asahi Lina <lina@asahilina.net>,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
Message-ID: <20231213222529.GF3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231116160235.2708131-1-neal@gompa.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116160235.2708131-1-neal@gompa.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.01
X-Spamd-Result: default: False [-1.01 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.92%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,gmx.com,suse.com,suse.cz,marcan.st,svenpeter.dev,cavalca.name,fb.com,asahilina.net,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[]

On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
> The Fedora Asahi SIG[0] is working on bringing up support for
> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
> 
> Apple Silicon Macs are unusual in that they currently require 16k
> page sizes, which means that the current default for mkfs.btrfs(8)
> makes a filesystem that is unreadable on x86 PCs and most other ARM
> PCs.
> 
> This is now even more of a problem within Apple Silicon Macs as it is now
> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines to
> enable performant x86 emulation[2] and the host storage needs to be compatible
> for both environments.
> 
> Thus, I'd like to see us finally make the switchover to 4k sectorsize
> for new filesystems by default, regardless of page size.
> 
> The initial test run by Hector Martin[3] at request of Qu Wenruo
> looked promising[4], and we've been running with this behavior on
> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
> 
> === Changelog ===
> 
> v4: Fixed minor errors in the cover letter and patch subject
> 
> v3: Refreshed cover letter, rebased to latest, updated doc references for v6.7
> 
> v2: Rebased to latest, updated doc references for v6.6
> 
> Final v1: Collected Reviewed-by tags for inclusion.
> 
> RFC v2: Addressed documentation feedback
> 
> RFC v1: Initial submission
> 
> [0]: https://fedoraproject.org/wiki/SIGs/Asahi
> [1]: https://fedora-asahi-remix.org/
> [2]: https://sinrega.org/2023-10-06-using-microvms-for-gaming-on-fedora-asahi/
> [3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
> [4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
> 
> Neal Gompa (1):
>   btrfs-progs: mkfs: Enforce 4k sectorsize by default

FYI, current plan is to add the change to 6.7 release with ETA in
January. We've discussed this and given the increasing demand for that
from various distros and testing coverage so done far it seems that it's
sufficient.

