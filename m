Return-Path: <linux-btrfs+bounces-3479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F9881551
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AD9B21D96
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82B54BE0;
	Wed, 20 Mar 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6/+IoCu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nK8udoqx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="leQ9rJRJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdv8ClF7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B047F6A;
	Wed, 20 Mar 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951323; cv=none; b=njEdEdZnSA1Nd+7cqTIh0gPUOqoHvtHyno4SAyQMcU8jtQZu0s7AeNcoBF00L5u7YLodJi8+97n19ifIBNduN0pEb6co8QgIAqo4Rtdz/kySIuZBvlhr4TnH8zHuSJJoimOI3RtviDGUgZ6eCB7LT1H0gGWAIu7+LfNAiiZ4zEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951323; c=relaxed/simple;
	bh=QiLoNhYk42JsFsGJW2UhTAMj+mU/WqecOvqKLL5xe9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afZ1Om75QRaUeZx+lDiY7wUBDhzPpuznj0t1Ly9IUpAhZrFCD6JQC9bkV4d8jjQynqNKG5wp/J76ZuvcY9vZBmeZ/J+CWVC1WIvB4XK+3cw/5bVqWgjTEEx54VkOIvQcsiptSfZuSf0qnD020uNK8O2lNm5Dljn4mWYk2pbLY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6/+IoCu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nK8udoqx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=leQ9rJRJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdv8ClF7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 576FA5BF0F;
	Wed, 20 Mar 2024 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710951317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPbBygRWzKlCxVl9w4t/F6sU43To74OwmLX0dcMtfk=;
	b=X6/+IoCulwi91lKHL+Ab2m4RT+Q3/W+iezfH9AZ88Zg95sE8ln8yixD1eAGTMbeiGpWxR7
	ONHzPEYSHejOdn6v8p97kkihPcuvtRTiNEZgRdKemFYCVLZ87M6OsbgB5dKhC6Pd+9u09X
	vLetbBRkUCjfEVmOL1vWGdXZisWq4XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710951317;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPbBygRWzKlCxVl9w4t/F6sU43To74OwmLX0dcMtfk=;
	b=nK8udoqxq54IZSRp9JTP5P8uVTx9DKSisJpOhnUmLVm3zoII2+e8mr9yL5NNYKYfCOSKcQ
	SVvpVGtie4FuFTDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710951316;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPbBygRWzKlCxVl9w4t/F6sU43To74OwmLX0dcMtfk=;
	b=leQ9rJRJF/g13nOUFNmG8F7ZnZ8ZWxV0r8wrnkwIsi4VIEzf5nEWahA95OeBsII3oeFRYB
	ZefVvJU3zmQya0YGfrUh/PgUI+J/fYhhXTck5Ql/K0K0YQ0s6TD3B65DGjJeDZ+wes2+G7
	oJfxj02Y8/bc+4VSkejR89nvqZjhoaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710951316;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPbBygRWzKlCxVl9w4t/F6sU43To74OwmLX0dcMtfk=;
	b=qdv8ClF7J9qmeTvubwdaYB56mf5+oMg/B5rDwkLstn1FEGcujp8dOsNnIn2eeifrqt7K/P
	R6G8r8kSP54uZnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33E08136D6;
	Wed, 20 Mar 2024 16:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ajx/DJQL+2VoZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Mar 2024 16:15:16 +0000
Date: Wed, 20 Mar 2024 17:08:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <20240320160802.GE14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
 <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Zfn412vXi8V7Sqd3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfn412vXi8V7Sqd3@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
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
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=leQ9rJRJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qdv8ClF7
X-Rspamd-Queue-Id: 576FA5BF0F

On Tue, Mar 19, 2024 at 01:43:03PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 19, 2024 at 12:16:33PM +0800, Zorro Lang wrote:
> > I didn't suggest to make it a shared case directly, I asked if there's a
> > _require_xxxx helper to make this case notrun on "not proper" fs, not
> > just use "btrfs ext4" to be whitelist :
> > 
> > https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > 
> > In my personal opinion, the "shared" directory is a place to store the cases
> > which are nearly to be generic, but not ready. It's a place to remind us
> > there're still some cases use something likes "supported btrfs ext4" as the
> > hard condition of _notrun, rather than a flexible _require_xxx helper. These
> > cases in shared better to be moved to generic, if we can improve it in one day.
> > 
> > It more likes a "TODO" list of generic. If we just write it in generic/
> > directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.
> > 
> > What do you think?
> 
> I like we're you're going, but I'd like to take it a step further:
> 
> I think we should just kill _supported_fs entirely.
> 
> tests/$FSTYPE is run for $FSTYP only, period.
> tests/generic/ is run for all file systems, and run/notrun deciѕions
> should be based on feature checks.  Where they can't happen without
> fs-sepcific infrastructure we need a _require/_have check that
> switches on $FSTYP like we already have in many places.

This could work, the number of exceptions is short:

tests/generic:
    547 _supported_fs generic
      4 _supported_fs ^nfs
      2 _supported_fs ^overlay
      1 _supported_fs ^xfs
      1 _supported_fs ^btrfs ^nfs
      1 _supported_fs ^btrfs

The example from generic/187:

# btrfs can't fragment free space. This test is unreliable on NFS, as it
# depends on the exported filesystem.
_supported_fs ^btrfs ^nfs

There are different reasons for the exclusion but at least for btrfs
could be transformed to e.g.

_require_can_fragment_free_space

Not sure about the NFS part, it can be either excluding remote
filesystems or mandating a local one.

