Return-Path: <linux-btrfs+bounces-1905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F0840CEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F9928DC95
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9515705A;
	Mon, 29 Jan 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPqtB3iJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5RNfrBnJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPqtB3iJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5RNfrBnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C83157031;
	Mon, 29 Jan 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547940; cv=none; b=h57nyKQXn2nX1nSD6W60WT02wuVVH+uoGB5mc1lOkGvmOJYvhxNvSvU47cdBS0oZlAxJoCMTnzUGVm040e0XBAInnoBpPlZEolbcpMFyyr+bIWX31iytbE6MslLsHQZOkSOdZ6IKBojNBay8EtUetAOQ8+ykdH3WzkRfFreVNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547940; c=relaxed/simple;
	bh=rERO+/yQtl/nHDrfNQnEmcHb7JpBOTk2E72PamhWOk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ2ANeNDM3fckmcSDbNsWJAMuouxziSUGoBpKqYO5MAY9R85gnI6UpwRFcct2luwRS0HHmrPrQome7gPRewqAKb4tmz2zD+1XQQNV+vvFdk14sgKQAeMkKxs+5dnJjxryxI5/kjAhtgRcH4oixUCVUCHWTTE8lBlj75cxGJggb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPqtB3iJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5RNfrBnJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPqtB3iJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5RNfrBnJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F3E421DD4;
	Mon, 29 Jan 2024 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706547936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efB/d60MkyHxkJEqZjgD4eKY0KSSrNZEfVPlBctpJKo=;
	b=tPqtB3iJZ9dNRYyl7maxX+1ckEGxLv5yepNr4i3ZShE91Cv8EkH6IEI7rEXR/6mVV4yJSC
	4QvbqYlCRHHEM63nNv5oN5CgQzEBmwVJne2iVwMzvcW4xgwIbvsFXjSEMl9lWBgiFAGcA5
	XF+/AgG3Y8YFlBjjQ21PEA+PWOC6nvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706547936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efB/d60MkyHxkJEqZjgD4eKY0KSSrNZEfVPlBctpJKo=;
	b=5RNfrBnJ6PwpIDBd1EFUEyKGdAKFm1+3IL8aj/JXrFhHLr6G0R0+ynCVk45cYafwvrno+P
	SF882JaACtjiafCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706547936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efB/d60MkyHxkJEqZjgD4eKY0KSSrNZEfVPlBctpJKo=;
	b=tPqtB3iJZ9dNRYyl7maxX+1ckEGxLv5yepNr4i3ZShE91Cv8EkH6IEI7rEXR/6mVV4yJSC
	4QvbqYlCRHHEM63nNv5oN5CgQzEBmwVJne2iVwMzvcW4xgwIbvsFXjSEMl9lWBgiFAGcA5
	XF+/AgG3Y8YFlBjjQ21PEA+PWOC6nvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706547936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efB/d60MkyHxkJEqZjgD4eKY0KSSrNZEfVPlBctpJKo=;
	b=5RNfrBnJ6PwpIDBd1EFUEyKGdAKFm1+3IL8aj/JXrFhHLr6G0R0+ynCVk45cYafwvrno+P
	SF882JaACtjiafCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 40B0D13911;
	Mon, 29 Jan 2024 17:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oEThDuDat2UNMgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 17:05:36 +0000
Date: Mon, 29 Jan 2024 18:05:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: zlib: Fix spelling mistake "infalte" ->
 "inflate"
Message-ID: <20240129170507.GB31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240122130102.3157773-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122130102.3157773-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-1.79)[93.74%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon, Jan 22, 2024 at 01:01:02PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a warning message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to for-next, thanks.

