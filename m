Return-Path: <linux-btrfs+bounces-4490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D048AE437
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC592846CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0689183CD3;
	Tue, 23 Apr 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ug1sRse4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lpzo6ny0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ug1sRse4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lpzo6ny0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0630E576
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872293; cv=none; b=llfAaYJK5wURpzLn08IBpT+0TLKFdsXLYbD7aW2l5m9EnV7P6pD0PYSe4GZLMZdEVHUArUdrkF82ePsqzrd50kUcdGDf7SgfrTpew+uezl9XV9qayxh50qV1VyoxtIh0oLOt8Q2Cw8DEBV2WXrc3avfFNSIAtPpQ6hQsXrvtYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872293; c=relaxed/simple;
	bh=CafVZ78nO84yZbOzi+qdZ7Tf6lWs3B8gSEm9pG0Av6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqC+NE5Xz/TZRBqcDtlS+3nhWctmlpe+T16wVRs2i4BjR2s6LOXuoYkOs/j1DSWcqtCWDl/rp53/yoi2U/jIcC+gWmiWhWS6OtQCyWTRJ3+PABhUy2q5FR0svDimMN/7vE363uuYDgoDbIiqYxBA9wkNl6ByxcrQXeo096X1BWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ug1sRse4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lpzo6ny0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ug1sRse4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lpzo6ny0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66A95FDF9;
	Tue, 23 Apr 2024 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDpCpim8Z0erUT17pD4+EeUZRiwoNPPTiZMmkhvIV+g=;
	b=ug1sRse4u6wiAwekarGtdiE/pPojk4KBIRGqNxFxQcK2uheDyjg1qTvyMT8r5qmM5Dnz/B
	T9VRKwWuE2kYZpZi+vfY3x3D1gMl8uTfGDNC3hMSNelxVS9NdIll1p9Lu6dsTONV+JyHrC
	4vinBqi3ChUeKBS+BsDpjDbVOU3yFGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDpCpim8Z0erUT17pD4+EeUZRiwoNPPTiZMmkhvIV+g=;
	b=Lpzo6ny04kWysojmN5DBGaX0U6fv98Ajf4vmFhCkkMU6C8fIVlH/ovTOXvLhCHP1PbwepH
	p6ilUmJ7tKonjIDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDpCpim8Z0erUT17pD4+EeUZRiwoNPPTiZMmkhvIV+g=;
	b=ug1sRse4u6wiAwekarGtdiE/pPojk4KBIRGqNxFxQcK2uheDyjg1qTvyMT8r5qmM5Dnz/B
	T9VRKwWuE2kYZpZi+vfY3x3D1gMl8uTfGDNC3hMSNelxVS9NdIll1p9Lu6dsTONV+JyHrC
	4vinBqi3ChUeKBS+BsDpjDbVOU3yFGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDpCpim8Z0erUT17pD4+EeUZRiwoNPPTiZMmkhvIV+g=;
	b=Lpzo6ny04kWysojmN5DBGaX0U6fv98Ajf4vmFhCkkMU6C8fIVlH/ovTOXvLhCHP1PbwepH
	p6ilUmJ7tKonjIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B03C213929;
	Tue, 23 Apr 2024 11:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sXeKKqGdJ2ayRAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Apr 2024 11:38:09 +0000
Date: Tue, 23 Apr 2024 06:38:09 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 14/17] btrfs: move can_cow_file_range_inline() outside of
 the extent lock
Message-ID: <nzj4naylvwpnxqusq722k4np342m2fa23qod5jxbft22e7gw6m@pflimv7rpixr>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <258a6eaf5c9b672fdadea6264e3fb9b795e1a179.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258a6eaf5c9b672fdadea6264e3fb9b795e1a179.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -3.19
X-Spam-Level: 
X-Spamd-Result: default: False [-3.19 / 50.00];
	BAYES_HAM(-2.39)[97.17%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email]

On 10:35 17/04, Josef Bacik wrote:
> These checks aren't reliant on the extent lock.  Move this up into
> cow_file_range_inline(), and then update encoded writes to call this
> check before calling __cow_file_range_inline().  This will allow us to
> skip the extent lock if we're not able to inline the given extent.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn

