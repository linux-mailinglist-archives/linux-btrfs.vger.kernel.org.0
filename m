Return-Path: <linux-btrfs+bounces-7755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463396907F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D601F2290F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD1188007;
	Mon,  2 Sep 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/XijuMJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUtCU+SN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/XijuMJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUtCU+SN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318717C7C3
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725320631; cv=none; b=mrT93O7Gtd2E2UBFN2bUraIGqpZ45AS+1TVf/IqRKhDETPfvhP99odFWT7PWTBnk8r5UiRecWZ8241TRiT/MPiR7zgkggpTjJ4NrM3eJQAYYtvCPJ1ikwgVn08Og+KqeynS73rOu9sASD7bWSeEA/ZO8qtWdkW0QssO5q6f6XIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725320631; c=relaxed/simple;
	bh=jFe3+SKv5ief+BhaEwh5OigDGJpNWvMBmDbhdct4JTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG15clG5eZQMq53Wwx3stpOW5CRMk6y1euB3K5H2KzDk9uSRcLTsjRT/XOEgQCjQ8WlPGKbh6Ly7w2khLxS4XafhpHs+jLXof6uhkqKDNgXq+QqW1NNlx7GGgMXWFHp6tiKtQnmyinSKp8zvwh+XXpnqFXDcVL3wV/Q9fjSToH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/XijuMJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUtCU+SN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/XijuMJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUtCU+SN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FC7621B64;
	Mon,  2 Sep 2024 23:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725320628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFe3+SKv5ief+BhaEwh5OigDGJpNWvMBmDbhdct4JTE=;
	b=c/XijuMJVIx8PYbnt0gyoQRijXSQS16wXDsweh/uachXJKu7HQ9lMjje1rKsRp7CXYakHN
	dDOQphVIjK4D4uHGp2WNrmAyo6w9jdQCiHIOdXOuM5j5Nap7xOsuqAHFPvTt9VoGskBBEx
	1mGGh9ENYextqAFh/VZDSsdxbS6lQcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725320628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFe3+SKv5ief+BhaEwh5OigDGJpNWvMBmDbhdct4JTE=;
	b=NUtCU+SNf3a1/XgA3E4FFSGsszO78awQMBKFpyYGA76W2YWgt1WuVEZ1+nlMlW9d4goMyw
	3Howu+uZklKGF1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725320628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFe3+SKv5ief+BhaEwh5OigDGJpNWvMBmDbhdct4JTE=;
	b=c/XijuMJVIx8PYbnt0gyoQRijXSQS16wXDsweh/uachXJKu7HQ9lMjje1rKsRp7CXYakHN
	dDOQphVIjK4D4uHGp2WNrmAyo6w9jdQCiHIOdXOuM5j5Nap7xOsuqAHFPvTt9VoGskBBEx
	1mGGh9ENYextqAFh/VZDSsdxbS6lQcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725320628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFe3+SKv5ief+BhaEwh5OigDGJpNWvMBmDbhdct4JTE=;
	b=NUtCU+SNf3a1/XgA3E4FFSGsszO78awQMBKFpyYGA76W2YWgt1WuVEZ1+nlMlW9d4goMyw
	3Howu+uZklKGF1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF481398F;
	Mon,  2 Sep 2024 23:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlgtA7RN1mZ6SwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 23:43:48 +0000
Date: Tue, 3 Sep 2024 01:43:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs path auto free
Message-ID: <20240902234346.GH26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724792563.git.loemra.dev@gmail.com>
 <j1u38.er61zc06h8sh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j1u38.er61zc06h8sh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Aug 30, 2024 at 01:46:59PM -0700, Leo Martins wrote:
> I think the only feedback I haven't addressed in this patchset was
> moving the declaration to be next to the btrfs_path struct.
> However, I don't think moving the declaration makes sense because
> the DEFINE_FREE references btrfs_free_path which itself is only
> declared after the structure.

As long as the definition of btrfs_free_path() is not needed to
compile, because it's a macro, I'd really want to keep the auto freeing
defininion next to the structure because it's closely related to the
structure. So if I ever go to the definition of any structure I want to
see right away if it does or does not support the auto free.

> The other examples I've looked at also
> have DEFINE_FREE next to the freeing function as opposed to the
> structure being freed.

