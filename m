Return-Path: <linux-btrfs+bounces-7233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68A954835
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5B1F25635
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD171AE051;
	Fri, 16 Aug 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gLhf0OFO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4fkxBlEh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R1we6Nm0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJJy3eKC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D651A01AE
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808802; cv=none; b=XnOPKjlgMqy20wdnaF/tfBQu1PmyBTc57I72stb32NROPrHije45WRic6sonHHq6B5O9r8Hmixoqop5927nuNApmT0+3n1XqxfXkPNVVEYEkKIs+brfQKvY36IkrK6i+/nz3qEb75g7z7W8jqXycm57OEbaD3SWPlGcZ20kQZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808802; c=relaxed/simple;
	bh=aqXUjajT5WMddpqD7FQnzPjnkrDzzayU+/l856U5yxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYXTjentR7V0p9OH+xYrrAnEtw/Nh3RgV55Y6X6ZGcF4KK46a6+jxKXXFs8by+Uia8bNYKCXd4nTHP5LSf4CUM6t5xRRIVlqAwoUqr82KszI/46utoi5TzX1nBD0MvdQq6hFRUYDVbzwuit4+4zHYbVWZ8sMxeRFRlFos0gZprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gLhf0OFO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4fkxBlEh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R1we6Nm0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OJJy3eKC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23C93221EA;
	Fri, 16 Aug 2024 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723808798;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqXUjajT5WMddpqD7FQnzPjnkrDzzayU+/l856U5yxU=;
	b=gLhf0OFOcDIRKoE/LapneVMOTSdakKNkA24vNqzSubWppO8Z4+TjVgz9mijUOiyGnL8kKg
	Kpt8NK3AsvC1H+qvfysMRNrGj0thPpmHj2py7o12wqaaEjPqgIz5UeLxo9xXE2isR1kWpR
	hm/YlIG7l4VS5wwPGmRS77tINpoYps4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723808798;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqXUjajT5WMddpqD7FQnzPjnkrDzzayU+/l856U5yxU=;
	b=4fkxBlEhLP7TiNdDSscMCZvmXdg9ucWOq47EAxbMTBePPvqGO+Q3rlppADL6E20O9DYSRs
	cDhU1Fr+PBiqOPDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723808797;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqXUjajT5WMddpqD7FQnzPjnkrDzzayU+/l856U5yxU=;
	b=R1we6Nm0cLN7Dxqz6yQETHn9BQ3O37BpKagpOs78v/Wi3I15aRMaNmuJ/e1oCDeeEKrNYA
	6cLI7rn2YdTscAitURCruwvHAwUD3vxvWQ5yU78FACCHZbiufXhzyFXS+ubX9btFMdscGR
	meF1RI1MUT6g0ONw011HxwGU/kn1tZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723808797;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqXUjajT5WMddpqD7FQnzPjnkrDzzayU+/l856U5yxU=;
	b=OJJy3eKC4ZZ599nNo5f02ZFtlJiP4MvV6/6zRU5E8xdhW3y0AQ+Z48CFVxqw9xWDFvI6D2
	XBzzOuKWMCUp/2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A67F13A2F;
	Fri, 16 Aug 2024 11:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 86m0AR08v2ZaWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 16 Aug 2024 11:46:37 +0000
Date: Fri, 16 Aug 2024 13:46:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in
 add_delayed_ref().
Message-ID: <20240816114627.GH25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
 <20240813224433.GV25962@twin.jikos.cz>
 <CAHB1NahuscKz-4b7MTR2xzLSocswDFObXjKuqy9g=QL=QnKyRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NahuscKz-4b7MTR2xzLSocswDFObXjKuqy9g=QL=QnKyRQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Fri, Aug 16, 2024 at 11:36:29AM +0800, Julian Sun wrote:
> David Sterba <dsterba@suse.cz> 于2024年8月14日周三 06:44写道：
> >
> > On Fri, Jun 07, 2024 at 10:30:20PM +0800, Junchao Sun wrote:
> > > Clean up resources using goto to get rid of repeated code.
> > >
> > > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> >
> > I had the patches in my testing branches, no problems so far so I'm
> > adding it for 6.12. Thanks.
> I just noticed I missed a commit for a file. Sorry for the oversight.
> Should I send a new version of the patch?

No need to, I'll update the commit, thanks.

