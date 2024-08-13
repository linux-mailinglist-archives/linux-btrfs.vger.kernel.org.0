Return-Path: <linux-btrfs+bounces-7182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFBF95109C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E864E1C20C58
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E061AC42C;
	Tue, 13 Aug 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uYU1jTfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YsuEazD7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uYU1jTfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YsuEazD7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F432198E78
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591960; cv=none; b=g2SaZWvqP8rxZvboJCMGsv39OlMxv76LV00dhunhIZgUeZzpyF1Aq5XTBVyYPyjqvjZgH7DYfXfnfMyS/xnlhi41Hk+87+4dpxQ9MnFUDk7sslSF1GjTZH3O7wWq6vKehD/HKgZFCKxooN934VF0MFeovZgjwhdvXR9Ggy3CX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591960; c=relaxed/simple;
	bh=/YE1cexCGrRxv9dd1T2VgoqA28x1pM2dh29jCVkPzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlbov3vc4S98Z3Kd/34uEtoz0H+xAsyc2adrW//M2WMh/1wdMO0sLaXxh3W7q1hUDjSM1Gg+K7/1whOFmFry7n6gG/0QbEYx3dM6W+O6F7DVfLTj1tTBzv+adj8MEyRzcbEp6WYTV5OkrWOvCvhtAZ9k9gSIwDiQ0vmnHcgeRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uYU1jTfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YsuEazD7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uYU1jTfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YsuEazD7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8813226C4;
	Tue, 13 Aug 2024 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723591956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh92h/CduqTy7Yf9QqfzPm6he8qfhwxS87EYCJrR3Js=;
	b=uYU1jTfTaKJ2B+PAL1/fZsb4HWwI1/AkEhV89rZT81jw2VYT4A3bq0b2f+ctflgSNY2DxP
	ycvjlj5jNi6eFpJh7inIsy6cTleBFhJ8UrHmhge9zkZjyxJ/5gKL+feR6cTMfmhuXOXhrB
	Bg9RoskjGA71bpHC3ie3w6NbNYGztxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723591956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh92h/CduqTy7Yf9QqfzPm6he8qfhwxS87EYCJrR3Js=;
	b=YsuEazD77WOhBd9rBNnuVndnpZjCxnKpor4MvqFIuEwCiZF/s+EUy01YURMqxIv5GoBTja
	vbuQiglWVdfGmSBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723591956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh92h/CduqTy7Yf9QqfzPm6he8qfhwxS87EYCJrR3Js=;
	b=uYU1jTfTaKJ2B+PAL1/fZsb4HWwI1/AkEhV89rZT81jw2VYT4A3bq0b2f+ctflgSNY2DxP
	ycvjlj5jNi6eFpJh7inIsy6cTleBFhJ8UrHmhge9zkZjyxJ/5gKL+feR6cTMfmhuXOXhrB
	Bg9RoskjGA71bpHC3ie3w6NbNYGztxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723591956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh92h/CduqTy7Yf9QqfzPm6he8qfhwxS87EYCJrR3Js=;
	b=YsuEazD77WOhBd9rBNnuVndnpZjCxnKpor4MvqFIuEwCiZF/s+EUy01YURMqxIv5GoBTja
	vbuQiglWVdfGmSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5455136A2;
	Tue, 13 Aug 2024 23:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zofeJxTtu2Z+NQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 23:32:36 +0000
Date: Wed, 14 Aug 2024 01:32:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
Message-ID: <20240813233235.GX25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
 <20240813231146.GW25962@twin.jikos.cz>
 <0d1da382-8cf1-480d-941a-9e01298e466f@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1da382-8cf1-480d-941a-9e01298e466f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Aug 14, 2024 at 08:47:40AM +0930, Qu Wenruo wrote:
> > Looks like we missed some simple tree item checks indeed.
> 
> The original idea is, we have btrfs_verify_dev_extents() at mount time, 
> thus it's enough to reject bad dev extents, and no need for tree-checker 
> for dev-extents.
> 
> But this method doesn't prevent bitflip from sneaking in during runtime.

Yeah, the tree-checker is run before commit too, so the mount checks
won't catch that.

> So in the long run, our sanity checks should:
> 
> - Do cross-checks at mount time for critical infrastructure
>    To prevent corruption sneaking in undetected.

At mount we can afford to do more than the tree-checker can do in the
single leaf, like matching the dev extents and block groups.

> - Do in-leaf checks at tree-checker
>    To prevent corruption reach storage.
> 
> - Do extra read-time cross-checks
>    Just like the dir item checks we did.

Some values have a clear range, or a constraint like alignment to a
sectorsize. Beyond that I think it's quite limited, we can't read other
leaves but maybe other checks against existing in-memory structures can
be done. An example, a block group item is consistent but overlaps with
one in the tree. Similar to what you do in this patch, but the bg is
already handled because of how the data is tracked. The tree-checker
coverage is pretty good so it's hard to find what else to cross-check.

