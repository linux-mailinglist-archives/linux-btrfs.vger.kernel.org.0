Return-Path: <linux-btrfs+bounces-1526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24A830BD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465621F2296B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F82374A;
	Wed, 17 Jan 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DVB8XvkT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vkzviPRf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DVB8XvkT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vkzviPRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068F23741
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511860; cv=none; b=dZ6E2ufwrr6dBOHGmqdC2ExmIgO1MR1qwPfeGJ57rJ014poQRMKnhg8i57lazOSqteizBJrsmEBSHyzSIKlg8Gl1L+mVVlQc1sF85LCzJaUL/7lciIXya+2ds09gAHmWHW1+MiGlc+YnUgWlSFnLJyuy3REc8divleW2TrMAWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511860; c=relaxed/simple;
	bh=YYnkfHZnvcHJJQpIaSiWq8rsmZqubUJ1Nq/OGIZyth8=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 User-Agent:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=fMyR7hpwlmdr+dvVn34sGGhDWOQnoZf9ZmL5wEu6yuKj2pbG9Gt6SZPnzAY7+mTPZ4+C2RS4UbFOV+ykqLMS1ZkXZm8yU/Dt7Q/3/fzkBGEC+rkhRcTU3XSISca2GDtsufMa0C55r0faFB8R56TVcRCV8HTST5oPixJy09XMfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DVB8XvkT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vkzviPRf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DVB8XvkT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vkzviPRf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13A21FCDC;
	Wed, 17 Jan 2024 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705511855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ZOwishzs2tK7mOPS9pJSOWFMpoV8BMJ7nNfTaU6Ik=;
	b=DVB8XvkT0gbeuGxRdg29j4Y1XLye3B5bT56hxsfeMjU0iHKB/7Yxa1FGX0YPUiJ4Lgzhp8
	1z6Hp8nLcAY8TwMa99EJ8Kjpw9C+isVVH2e6KLKfz2lD3Ls1CN8OHeEEARby8FB+FzGbtX
	cR4KYBeUmIgkXJXp8wzoTso7F9PxdCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705511855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ZOwishzs2tK7mOPS9pJSOWFMpoV8BMJ7nNfTaU6Ik=;
	b=vkzviPRfZxuiyu0c+Z+FBqNOzz3Y4OYdBISd8ujZsByqlOEA31Eos8GX2JLp4QeNOset8S
	WUI0xxyAtvInhkBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705511855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ZOwishzs2tK7mOPS9pJSOWFMpoV8BMJ7nNfTaU6Ik=;
	b=DVB8XvkT0gbeuGxRdg29j4Y1XLye3B5bT56hxsfeMjU0iHKB/7Yxa1FGX0YPUiJ4Lgzhp8
	1z6Hp8nLcAY8TwMa99EJ8Kjpw9C+isVVH2e6KLKfz2lD3Ls1CN8OHeEEARby8FB+FzGbtX
	cR4KYBeUmIgkXJXp8wzoTso7F9PxdCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705511855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ZOwishzs2tK7mOPS9pJSOWFMpoV8BMJ7nNfTaU6Ik=;
	b=vkzviPRfZxuiyu0c+Z+FBqNOzz3Y4OYdBISd8ujZsByqlOEA31Eos8GX2JLp4QeNOset8S
	WUI0xxyAtvInhkBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C44613482;
	Wed, 17 Jan 2024 17:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ed2lIa8LqGUjVAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 17:17:35 +0000
Date: Wed, 17 Jan 2024 18:17:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Message-ID: <20240117171717.GK31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705449249.git.wqu@suse.com>
 <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
 <7fec99a2-1eae-403e-a95a-32314f46b8dd@suse.com>
 <a83de224-623c-4370-82f2-45c8c6d5f134@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a83de224-623c-4370-82f2-45c8c6d5f134@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DVB8XvkT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vkzviPRf
X-Spamd-Result: default: False [-3.01 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B13A21FCDC
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed, Jan 17, 2024 at 08:09:20AM +0000, Johannes Thumshirn wrote:
> On 17.01.24 08:57, Qu Wenruo wrote:
> > 
> > 
> > On 2024/1/17 18:24, Johannes Thumshirn wrote:
> >> On 17.01.24 01:33, Qu Wenruo wrote:
> >>> [Changelog]
> >>> v2:
> >>> - Split out the RST code change
> >>>     So that backport can happen more smoothly.
> >>>     Furthermore, the RST specific part is really just a small 
> >>> enhancement.
> >>>     As RST would always do the btrfs_map_block(), even if we have a
> >>>     corrupted extent item beyond chunk, it would be properly caught,
> >>>     thus at most false alerts, no real use-after-free can happen after
> >>>     the first patch.
> >>>
> >>> - Slight update on the commit message of the first patch
> >>>     Fix a copy-and-paste error of the number used to calculate the chunk
> >>>     end.
> >>>     Remove the RST scrub part, as we won't do any RST fix (although
> >>>     it would still sliently fix RST, since both RST and regular scrub
> >>>     share the same endio function)
> >>>
> >>> There is a bug report about use-after-free during scrub and crash the
> >>> system.
> >>> It turns out to be a chunk whose lenght is not 64K aligned causing the
> >>> problem.
> >>>
> >>> The first patch would be the proper fix, needs to be backported to all
> >>> kernel using newer scrub interface.
> >>>
> >>> The 2nd patch is a small enhancement for RST scrub, inspired by the
> >>> above bug, which doesn't really need to be backported.
> >>>
> >>> Qu Wenruo (2):
> >>>     btrfs: scrub: avoid use-after-free when chunk length is not 64K
> >>>       aligned
> >>>     btrfs: scrub: limit RST scrub to chunk boundary
> >>>
> >>>    fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++++++-------
> >>>    1 file changed, 29 insertions(+), 7 deletions(-)
> >>>
> >>
> >> For the series,
> >> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> One more thing I personally would add (as a 3rd patch that doesn't need
> >> to get backported to stable) is this:
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 0123d2728923..046fdf8f6773 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -1641,14 +1641,23 @@ static void scrub_reset_stripe(struct
> >> scrub_stripe *stripe)
> >>           }
> >>    }
> >>
> >> +static unsigned int scrub_nr_stripe_sectors(struct scrub_stripe *stripe)
> >> +{
> >> +       struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> >> +       struct btrfs_block_group *bg = stripe->bg;
> >> +       u64 bg_end = bg->start + bg->length;
> >> +       unsigned int nr_sectors;
> >> +
> >> +       nr_sectors = min(BTRFS_STRIPE_LEN, bg_end - stripe->logical);
> >> +       return nr_sectors >> fs_info->sectorsize_bits;
> >> +}
> >> +
> >>    static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> >>                                               struct scrub_stripe 
> >> *stripe)
> >>    {
> >>           struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> >>           struct btrfs_bio *bbio = NULL;
> >> -       unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, 
> >> stripe->bg->start +
> >> -                                     stripe->bg->length -
> >> stripe->logical) >>
> >> -                                 fs_info->sectorsize_bits;
> >> +       unsigned int nr_sectors = scrub_nr_stripe_sectors(stripe);
> >>           u64 stripe_len = BTRFS_STRIPE_LEN;
> >>           int mirror = stripe->mirror_num;
> >>           int i;
> >> @@ -1718,9 +1727,7 @@ static void scrub_submit_initial_read(struct
> >> scrub_ctx *sctx,
> >>    {
> >>           struct btrfs_fs_info *fs_info = sctx->fs_info;
> >>           struct btrfs_bio *bbio;
> >> -       unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, 
> >> stripe->bg->start +
> >> -                                     stripe->bg->length -
> >> stripe->logical) >>
> >> -                                 fs_info->sectorsize_bits;
> >> +       unsigned int nr_sectors = scrub_nr_stripe_sectors(stripe);
> >>           int mirror = stripe->mirror_num;
> >>
> >>           ASSERT(stripe->bg);
> >>
> >> Sorry for the complete whitespace damage, but I think you get the point.
> > 
> > That's what I did before the v1, but it turns out that just two call 
> > sites, and I open-coded them in the final patch.
> > 
> > Just a preference thing, I'm fine either way.
> 
> Yeah of cause, I just hate the overly long line and code duplication :D

In this case the expression is not trivial so a helper makes sense,
using it twice is enough. For something even more complicated to
calculate a helper makes sense even for one time use. If one is not able
to grasp what the expression does, like "pick bigger of the two", the
helper should be used, or at least a comment added.

