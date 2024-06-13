Return-Path: <linux-btrfs+bounces-5696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AEC90605B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A061F22215
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA165BE4E;
	Thu, 13 Jun 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E88F68
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241795; cv=none; b=KWxNJSCxXnBgS3A6yTON4CAvuqdLfi+Sm68k8bFKAam4EP4oF3oVT5f5iVBN/kSZVxr7AXzDTlFjkOx/lMbZYirffpuxY6ody0nTcEANnEInIhHTtEx7hQzrp+Yz+OXhWDmt5qJjg6FRLK1lR/kM1Y1TuP1Qry+XcpbTLmgjD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241795; c=relaxed/simple;
	bh=BnTvgCT2YTDpFbEVK+hSnXZ47pFcIWTRl6JGJX+rEgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coOAEemahCFqM1ILBZA0tDj9oet0kSoC7nydtbicU/2AoKLwRuAC5mmTxrkVMJiP06cnhdZ4HlzrzGC/XMUxRjT5UqGBK0/xXCZIN+6IyTrZczhr/QaxZgMRJdzIdpwX+XXXxUsIeKHKq8LRTMVI/BqqSP/ufFn/wbqbc3xn3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A1765CAC7;
	Thu, 13 Jun 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7412D13A9A;
	Thu, 13 Jun 2024 01:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R1ItHP9JambIcAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 01:23:11 +0000
Date: Thu, 13 Jun 2024 03:23:02 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Srivathsa Dara <srivathsa.d.dara@oracle.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Message-ID: <20240613012302.GV18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz>
 <20240613000200.GS18508@twin.jikos.cz>
 <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
 <20240613002301.GT18508@twin.jikos.cz>
 <2d1a8153-274b-481e-bb0a-63504d1cbe01@gmx.com>
 <20240613005255.GU18508@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613005255.GU18508@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9A1765CAC7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jun 13, 2024 at 02:52:55AM +0200, David Sterba wrote:
> On Thu, Jun 13, 2024 at 09:55:56AM +0930, Qu Wenruo wrote:
> > 
> > 
> > 在 2024/6/13 09:53, David Sterba 写道:
> > [...]
> > >>
> > >> Any good idea to go forward?
> > >> Update CI (which seems impossible) or make the mke2fs part as mayfail
> > >> and skip it?
> > >
> > > I think using mayfail for mke2fs is the best option, I don't want to
> > > check versions. The release of 1.46.5 is 2021-12-30, this is not that
> > > old and likely widely used. Skipping the particular case is not a big
> > > deal as it'll be covered on other testing instances.
> > 
> > Sounds good to me.
> > 
> > Just add an extra comment on the situation.
> > 
> > Although I really hope github CI can someday updates its infrastructures.
> 
> The updates happen from time to time, following Ubuntu LTS releases. The
> upstream repository is https://github.com/actions/runner-images.
> 
> Now that I'm looking there it seems that 24.04 has been made available a
> month ago but has to be selected explicitly, as ubuntu-latest is still
> pointing to 22.
> 
> Kernel version is 6.8 and e2fsprogs is 1.47 so the update can fix that
> and we don't have to do the workarounds. I'll do a test and update the
> CI files if everythings works.

It still fails with 1.47.0:

https://github.com/kdave/btrfs-progs/actions/runs/9492025265/job/26158483515

mke2fs 1.47.0 (5-Feb-2023)
mke2fs: Device size reported to be zero.  Invalid partition specified, or
	partition table wasn't reread after running fdisk, due to
	a modified partition being busy and in use.  You may need to reboot
	to re-read your partition table.


