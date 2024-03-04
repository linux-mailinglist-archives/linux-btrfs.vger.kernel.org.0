Return-Path: <linux-btrfs+bounces-2999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E5787084F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D289C1C2123B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A13612EF;
	Mon,  4 Mar 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GSo2nkQN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsyLO5wN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GSo2nkQN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsyLO5wN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF961677;
	Mon,  4 Mar 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573536; cv=none; b=XQiS7T7UoULCJ2oKyjYveXgSW149dbCQlFU4lriEd+cGy804bE9HK7su7yZfKAmiv0w7y4H3vLSXlKI5DJ0dk/3eWx4+ypeip/T71bvlwbDZ4B8uGcw0+SML6csPv1ULNaseg4PADXaSy1+va4dZ6N6UIbMIxbppHsyNZoW2Qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573536; c=relaxed/simple;
	bh=mLp0dR6ersKKmliuhWp/ktZUlkkHWwNj7i7viIpAOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0LE/KfcQJjqtzZsYKV14T5/J+D/+s+KhdTwWTH2lcaSJrfGDtgkLP7tzV6qpoc2RubnVX06eKnBXGS1s/LeueAQ5x6b7a23dOMkvB3IUhp4iVH5w4VVBSRvLrkKX+kPNNHJg1Ik8vswm/194Ne1Y9RQoDBIuY+rle3Ne2COpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GSo2nkQN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsyLO5wN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GSo2nkQN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsyLO5wN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13D8E3393F;
	Mon,  4 Mar 2024 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709573531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T5l97lx5gDM8mhAfnqC8zMQ315SMtT6LNM2AgQYNqI=;
	b=GSo2nkQNKLxq9PDwFG9cDBn7dq+dvh1P8olnpzcwhrG4y2Byhq2Zr1cp937SwJ5liQQ7Oh
	HuwuElhLMomGXn2UzpzmnVjbyXdU5OC3r8SIKWO/zIEgPL9zjZIAIoJNbLGJJ59uU+ojVL
	zJahxfQqGYu0tBb0+7VTMwCVHb9x31g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709573531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T5l97lx5gDM8mhAfnqC8zMQ315SMtT6LNM2AgQYNqI=;
	b=jsyLO5wNF7i9EpkPqF8F5nQMfkG+jZ104auQtxTkoxhkrLQQ/9T/OEpgRi/fzbk1pV+gps
	sgV5CUdV7c5uMwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709573531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T5l97lx5gDM8mhAfnqC8zMQ315SMtT6LNM2AgQYNqI=;
	b=GSo2nkQNKLxq9PDwFG9cDBn7dq+dvh1P8olnpzcwhrG4y2Byhq2Zr1cp937SwJ5liQQ7Oh
	HuwuElhLMomGXn2UzpzmnVjbyXdU5OC3r8SIKWO/zIEgPL9zjZIAIoJNbLGJJ59uU+ojVL
	zJahxfQqGYu0tBb0+7VTMwCVHb9x31g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709573531;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T5l97lx5gDM8mhAfnqC8zMQ315SMtT6LNM2AgQYNqI=;
	b=jsyLO5wNF7i9EpkPqF8F5nQMfkG+jZ104auQtxTkoxhkrLQQ/9T/OEpgRi/fzbk1pV+gps
	sgV5CUdV7c5uMwAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F113913419;
	Mon,  4 Mar 2024 17:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GW6nOpoF5mVZEAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 04 Mar 2024 17:32:10 +0000
Date: Mon, 4 Mar 2024 18:25:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: verify btrfs_qgroup_inherit parameter
Message-ID: <20240304172505.GL2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <bde2887da38aaa473ca60801b37ac735b3ab2d6d.1709003728.git.wqu@suse.com>
 <20240301120138.GJ2604@twin.jikos.cz>
 <19762dc9-2834-46fd-91ce-26a542356adb@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19762dc9-2834-46fd-91ce-26a542356adb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.68
X-Spamd-Result: default: False [-3.68 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-2.68)[98.58%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On Sat, Mar 02, 2024 at 06:51:58AM +1030, Qu Wenruo wrote:
> 在 2024/3/1 22:31, David Sterba 写道:
> > On Tue, Feb 27, 2024 at 01:45:35PM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> Currently btrfs can create subvolume with an invalid qgroup inherit
> >> without triggering any error:
> >>
> >>   # mkfs.btrfs -O quota -f $dev
> >>   # mount $dev $mnt
> >>   # btrfs subvolume create -i 2/0 $mnt/subv1
> >>   # btrfs qgroup show -prce --sync $mnt
> >>   Qgroupid    Referenced    Exclusive   Path
> >>   --------    ----------    ---------   ----
> >>   0/5           16.00KiB     16.00KiB   <toplevel>
> >>   0/256         16.00KiB     16.00KiB   subv1
> >>
> >> [CAUSE]
> >> We only do a very basic size check for btrfs_qgroup_inherit structure,
> >> but never really verify if the values are correct.
> >>
> >> Thus in btrfs_qgroup_inherit() function, we have to skip non-existing
> >> qgroups, and never return any error.
> >>
> >> [FIX]
> >> Fix the behavior and introduce extra checks:
> >>
> >> - Introduce early check for btrfs_qgroup_inherit structure
> >>    Not only the size, but also all the qgroup ids would be verifyed.
> >>
> >>    And the timing is very early, so we can return error early.
> >>    This early check is very important for snapshot creation, as snapshot
> >>    is delayed to transaction commit.
> >>
> >> - Drop support for btrfs_qgroup_inherit::num_ref_copies and
> >>    num_excl_copies
> >>    Those two members are used to specify to copy refr/excl numbers from
> >>    other qgroups.
> >>    This would definitely mark qgroup inconsistent, and btrfs-progs has
> >>    dropped the support for them for a long time.
> >>    It's time to drop the support for kernel.
> >>
> >> - Verify the supported btrfs_qgroup_inherit::flags
> >>    Just in case we want to add extra flags for btrfs_qgroup_inherit.
> >>
> >> Now above subvolume creation would fail with -ENOENT other than silently
> >> ignore the non-existing qgroup.
> >>
> >> CC: stable@vger.kernel.org
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Reviewed-by: David Sterba <dsterba@suse.com>
> >
> Just one thing to notice, this would cause certain test cases to fail,
> as previously any incorrect qgroup inherit would just be ignored, but
> now it would error out explicitly.

Ok, this is expected if we do fixes like that.

