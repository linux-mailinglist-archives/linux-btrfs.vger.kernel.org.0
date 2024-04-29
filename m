Return-Path: <linux-btrfs+bounces-4626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42578B5F3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329771F21460
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6313685C6F;
	Mon, 29 Apr 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9tdshhd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3qwR12a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9tdshhd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3qwR12a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DF85958
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408734; cv=none; b=m216xmSFPin6qMVdz0iRCLK0VSYb659Eqnr9C/27m3HKCSTQuNb2yppSeVEhYX/aZlhi7ZkypQdoiAjGpTSIK81fkW5dUTx0thS5LViQjPpcAgC80c+6wsyTX+Tgg5wWAkjd5hD+u2qKG8kbLvC3T+HZpSjOTIOyzGxCA+lpcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408734; c=relaxed/simple;
	bh=DXNWcvh0iTZOoRBqKps8nKB9k+i+l9We/Ugm+ot6u+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJsr0bc8hevFUUN/apibLcPT1VgrPD6thOlREmUhlPlE6QTfcuJR3P+GzzFqffnlCIMI1F4quUPN9t2sTdj0HLbBKi7El045kN7ztyoLg5RYzvR8k+DAQEdkV91O7Sj1pBeq2wHv7JkbBmmlxBc+d0U3RCFZK6r8rooslOtPXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9tdshhd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s3qwR12a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9tdshhd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s3qwR12a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7531033945;
	Mon, 29 Apr 2024 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714408730;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUZtbxBqHPUFFzjRtks3m43kfew5n2KX91K5+pp5pSM=;
	b=f9tdshhd/nCnLDIHq5BppAQ7wkow8jn43KrW4jlegVtXAx3SfE547DxtiflowiliL7daM1
	oGQiMmxqOqE/NYoVVOv2pSr3aTnoshTYH6fl6VQsdjY7piLLnhtn23/0hSInuNISG9+KUG
	Dvv7o431EDNDdU4MId0rKhMn4QoWmP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714408730;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUZtbxBqHPUFFzjRtks3m43kfew5n2KX91K5+pp5pSM=;
	b=s3qwR12abQLldNFKweDLgzdHsq3mlG6Nu9oaWY8vf8IxlgFMOnOHKVTCMFd+CsybZaCaru
	pib2aI/6gKCBkzBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714408730;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUZtbxBqHPUFFzjRtks3m43kfew5n2KX91K5+pp5pSM=;
	b=f9tdshhd/nCnLDIHq5BppAQ7wkow8jn43KrW4jlegVtXAx3SfE547DxtiflowiliL7daM1
	oGQiMmxqOqE/NYoVVOv2pSr3aTnoshTYH6fl6VQsdjY7piLLnhtn23/0hSInuNISG9+KUG
	Dvv7o431EDNDdU4MId0rKhMn4QoWmP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714408730;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUZtbxBqHPUFFzjRtks3m43kfew5n2KX91K5+pp5pSM=;
	b=s3qwR12abQLldNFKweDLgzdHsq3mlG6Nu9oaWY8vf8IxlgFMOnOHKVTCMFd+CsybZaCaru
	pib2aI/6gKCBkzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A9D5139DE;
	Mon, 29 Apr 2024 16:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zNH3FRrNL2ZsNgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 16:38:50 +0000
Date: Mon, 29 Apr 2024 18:31:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240429163136.GG2585@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429131333.GC21573@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
> I support the auto deletion in the kernel as you propose, I think it
> just makes sense. Who wants stale, empty qgroups around that aren't
> attached to any subvol? I suppose that with the drop_thresh thing, it is
> possible some parent qgroup still reflects the usage until the next full
> scan?

The stale qgroups have been out for a long time so removing them after
subvolume deletion is changing default behaviour, this always breaks
somebody's scripts or tools.

> Thinking out loud -- for regular qgroups, we could avoid this all if we
> do the reaping when usage goes to 0 and there is no subvol. So remove
> the qgroup as a consequence of the rescan, not the subvol delete. I
> imagine this is quite a bit messier, though :(
> 
> We could also just not auto-reap if that condition occurs (inconsistent
> qg with a parent), but I think that may be surprising for the same
> reasons that got you working on this in the first place...
> 
> Do we know of an explicit need to support --no-delete-qgroup? It feels
> like it is perfectly normal for us to improve the default behavior of
> the kernel or userspace tools without supporting the old behavior as a
> flag forever (without a user).

$ id=$(btrfs inspect rootid subvol)
$ btrfs subvolume delete subvol
$ btrfs qgroup remove 0/$id 1/1 .                   <---- fails
$ btrfs qgroup destroy 0/$id .                      <---- fails

> Put another way, I think it would be perfectly reasonable to term the
> stale qgroups a leaked memory resource and this patch a bug fix, if we
> are willing to get overly philosophical about it. We don't carry around
> eternal flags for bug fixes, unless it's some rather exceptional case.

The command line option does not do what I expected, if somebody would
have to update the scripts to add it then we can do the kernel
auto-remove and the document it. Eventually we can translate the -ENOENT
error code to be ignored.

> If we are on the hook for supporing that flag because we already added
> it to progs and don't want to deprecate it, then maybe we can think of
> something compatible with default auto-reap.

