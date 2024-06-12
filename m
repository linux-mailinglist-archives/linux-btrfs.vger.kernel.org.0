Return-Path: <linux-btrfs+bounces-5669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D4905C04
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BED1F23C39
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF5839F3;
	Wed, 12 Jun 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yYPTlJ+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5sepXfQJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sTNjbc/d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TTcUrOyk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08682D72
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220725; cv=none; b=sYpJBkt9sqGkNEPtw2jcGbVo2llEFEGAKo+rL3Vq9y2d7upHPny3oQvlKfapeIXLqjdOT9PVscPqDeoSpFhEnlQq7N6c61oV/5Nip2EuC0A74SdLjRD4dZN9JxLoH0CfrO5+oFy4fkdIA4Sc3RCDaQ7ng+kpGxgmidXgpqzGptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220725; c=relaxed/simple;
	bh=PcJ512kUuCzX8ve3+2PE9J2nbw7BQrUeUTCTJWBXEDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBd7BYhshbU+VVwViZuhjxXxo8ZxQki0Lsen1z9UyPmRSpBaAFp0NDOC7tRh9QsptTcHWOPw4SVECxT2axT3sesadXNXTZ8LvjrbUaRnc2QeN6iGX3UnNO49AD7LtMOb3S3pC7wHG7apPvxnHYmwVy5cELVwVfa5U1FWWH7laBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yYPTlJ+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5sepXfQJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sTNjbc/d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TTcUrOyk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D275D5C653;
	Wed, 12 Jun 2024 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718220721;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VyZMYQFmCWzJOY6sSBxm4VXH1+ffc1vNZUyrqheCpq0=;
	b=yYPTlJ+YYvHZBmdPtXgRB6cRh/TLC47rAbDxEP8q32O7s/oaCS8umnHj1fi49eEobLMq/0
	fZ0t3MuXC1FlW+rdZi2jUVybSQFXQt/JmTiq85b+UUgokrsxouhTwS0n4aAEXKa+vyuIcJ
	aZAhyYglAOzWY2+bLgHrIm4Gt++8GZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718220721;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VyZMYQFmCWzJOY6sSBxm4VXH1+ffc1vNZUyrqheCpq0=;
	b=5sepXfQJQ4rehi0PkNfBaWOOAWof4Mg7dk33Vdyc7S3ciBL2VcS768YONNJ1B6/YZLa1gt
	VBcLptqVALpAeQCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718220720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VyZMYQFmCWzJOY6sSBxm4VXH1+ffc1vNZUyrqheCpq0=;
	b=sTNjbc/dMKEFyWh0F1Wx9iQNG+r9LnLcIazdcreAte942+9Yv01O4zDt4w8bV7xiMoGhRl
	FPvJ2c1A5dpyJB+EsHQupK7I2GZpRD7zxsLlknbdGJAS8Cdq+qUpODYJuIxlkWUHAYl4oA
	5K8mOzqHtRno0oWFYv3aanuLWgJwGN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718220720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VyZMYQFmCWzJOY6sSBxm4VXH1+ffc1vNZUyrqheCpq0=;
	b=TTcUrOykBncTJZRDiYnYcE9rYMb4OCdRUongXqDXUySVGIgdtsLjK5rOzLOsnG+fZDAvmB
	UhAFeAGrcVDgCbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B557D132FF;
	Wed, 12 Jun 2024 19:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nAzCK7D3aWYUHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:32:00 +0000
Date: Wed, 12 Jun 2024 21:31:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: remove unused Opt enums
Message-ID: <20240612193159.GJ18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718082585.git.wqu@suse.com>
 <f97d2899f6e701257b3304d553af79d39ea8e2f3.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97d2899f6e701257b3304d553af79d39ea8e2f3.1718082585.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Jun 11, 2024 at 02:51:35PM +0930, Qu Wenruo wrote:
> The following three Opt_* enums are not utilized at all:
> 
> - Opt_ignorebadroots
> - Opt_ignoredatacsums
> - Opt_rescue_all

They've been duplicated in the new mount API rewrite and the currently
used enums are in Opt_rescue_* group, like Opt_rescue_parameter_all.

> All those handling are inside "rescue=" mount option groups, and there
> is no corresponding token for them, so we can safely remove them.

Yes.

