Return-Path: <linux-btrfs+bounces-3432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56B880387
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714A71F24BA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3A2031D;
	Tue, 19 Mar 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iP0nw6BI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMd4X3Em";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iP0nw6BI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMd4X3Em"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC5111A1;
	Tue, 19 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869696; cv=none; b=NKqcH3EkmHN4lHXCWkA/V4KT0F/6rSfa/hy82TYc8u4sjHuGa4RHWsabNGDY99syAlXQSZmhjyASdc2UaAJlrV+/Q52ocRZPaJ+dDGdrePfCDOVx9SLlEkwCdSTCdjkOpqZzKnTQsFzCe1YKCJfzkUoT7RFvyoLAIPLGFkvDqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869696; c=relaxed/simple;
	bh=7X31+lPFKwhMRttPLK6DGq+jCF4aCz0K8HRx6n3mlFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H26m62D+0gT2hattQpDt/AnOITdpmKEZceJ3qEK8YbyIxBpZXwBGmUorTRun/Xo87MtGLRHOmkOZR4VlMS/a8iIGMixvrcnjCd5p2hmtka4I5y5nEIycQ2fF7qML/pjKfl5S1t7IHEguOql1dtRj9TX2RKpODn7MJEp043Hgqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iP0nw6BI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMd4X3Em; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iP0nw6BI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMd4X3Em; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38D3533686;
	Tue, 19 Mar 2024 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710869691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF1TJ7Dop84GWX5MtZJYEnfMgM805PlYbGLdDpCykPg=;
	b=iP0nw6BISdWVUuOsdy70GxmXoYslyV92MY/e2ctdzMEXTtMmgYy1eAHxkCRJWgdLMCTyIY
	xTnCtchW1k8tJtne1A2plvAr+px917DMtrW1KR/EgjxAZgFsmoopn2tl5QJJi/v9Qv5MPG
	2a7vKtxgsNsQmXsgPCd2ruUz827rwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710869691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF1TJ7Dop84GWX5MtZJYEnfMgM805PlYbGLdDpCykPg=;
	b=kMd4X3Em1V622xC0aqxZCix2YpLOysDFd3K4fUEhQnxgMjKmAnYT51rOjY+qSuu0tRdjDx
	Ox0+WGOH3zvWZoDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710869691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF1TJ7Dop84GWX5MtZJYEnfMgM805PlYbGLdDpCykPg=;
	b=iP0nw6BISdWVUuOsdy70GxmXoYslyV92MY/e2ctdzMEXTtMmgYy1eAHxkCRJWgdLMCTyIY
	xTnCtchW1k8tJtne1A2plvAr+px917DMtrW1KR/EgjxAZgFsmoopn2tl5QJJi/v9Qv5MPG
	2a7vKtxgsNsQmXsgPCd2ruUz827rwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710869691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF1TJ7Dop84GWX5MtZJYEnfMgM805PlYbGLdDpCykPg=;
	b=kMd4X3Em1V622xC0aqxZCix2YpLOysDFd3K4fUEhQnxgMjKmAnYT51rOjY+qSuu0tRdjDx
	Ox0+WGOH3zvWZoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10122136A5;
	Tue, 19 Mar 2024 17:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QxrCA7vM+WUyPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 19 Mar 2024 17:34:51 +0000
Date: Tue, 19 Mar 2024 18:27:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <20240319172733.GO16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
 <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 12:16:33PM +0800, Zorro Lang wrote:
> On Mon, Mar 18, 2024 at 11:02:19PM +0100, David Sterba wrote:
> > On Sat, Mar 16, 2024 at 10:32:33PM +0530, Anand Jain wrote:
> > > Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> > > test case btrfs/312, which assesses the functionality of cloned filesystem
> > > support, can be refactored to be under the shared group.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > > v2:
> > > Move to shared testcase instead of generic.
> > 
> > What's the purpose of shared/ ? We have tests that make sense for a
> > subset of supported filesystems in generic/, with proper _required and
> > other the checks it works fine.
> > 
> > I see that v1 did the move to generic/ but then the 'shared' got
> > suggested, which is IMHO the wrong direction. I remember some distant
> > past discussions about shared/ and what to put there. Right now there
> > are 3 remaining tests which I think is a good opportunity to make it 0.
> 
> I didn't suggest to make it a shared case directly, I asked if there's a
> _require_xxxx helper to make this case notrun on "not proper" fs, not
> just use "btrfs ext4" to be whitelist :
> 
> https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> In my personal opinion, the "shared" directory is a place to store the cases
> which are nearly to be generic, but not ready. It's a place to remind us
> there're still some cases use something likes "supported btrfs ext4" as the
> hard condition of _notrun, rather than a flexible _require_xxx helper. These
> cases in shared better to be moved to generic, if we can improve it in one day.

Well, I disagree with that, we don't need to track the nearly-generic
state in a different way than we have right now with the _supported_fs
and ^exceptions.

> It more likes a "TODO" list of generic. If we just write it in generic/
> directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.

A TODO for who? If I take the current state of shared/ as example, the
test 298, there's "_supported_fs ext4 xfs btrfs", this can live in
generic as it covers the current filesystems. If this does not apply to
NFS then it's IMHO fine to explicitly list the supported filesystems
rather than do long list of exceptions.

Support for btrfs to that test was added in 2019 in commit
0680ff2ea5313b3. If the state hasn't changed and is still in TODO then I
don't think this works (although back then the todo-status of the
shared/ was not defined as such).

> What do you think?

What I suggest:

- move everything from shared/ to generic
- document (as guidelines) what to do if there's a generic test that
  applies only to subset of filesystems, what helpers to use and
  possibly comment in the test cases why this canont be fully generic so
  that a new filesystems to add can be evaluated as needed
  - good example is shared/002, one could decide if eg. ext4 is missing
    or not
  - bad example is shared/032, there's xfs and btrfs but from the test
    it looks like it's relevant for any local filesystem

