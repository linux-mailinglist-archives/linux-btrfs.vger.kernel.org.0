Return-Path: <linux-btrfs+bounces-5467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6A8FCDFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23D81F24396
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE2196D80;
	Wed,  5 Jun 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PG/XpEXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F6dVmNmT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PG/XpEXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F6dVmNmT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9F188CCC;
	Wed,  5 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589464; cv=none; b=HJhJIyp47qaRBHRuaxag5xWsLy81kTz1dOD1u1UoZ8oGMCwfPsYmVhQ2Jw+nHoIRXrpwShdQtO2Ki8oRDoJm/K01168NCxXbhKl6Ic+a8k+AVTZaIDkj3M9quVz9ud0eGEnJQkQ2doiLFpfSUif9T/b2ytd2HmmZZEB4Uuezioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589464; c=relaxed/simple;
	bh=zPkQe2wqSX8kUN6Fj5BB/QeZ+HTSulkPzDCDAD24RHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSD1IqRMkJqe4IqypcxugTwI9BtCViG8E0T+a2AtcWBpXgv3NvGdODsmtetiiURDhgANZRTJG9YshV503N0Szn5TTQvIffnGx9AGvdgnBj4zsYSBMa5Gisnva+hIZ4gy28YhZwe+5+jHWPXx8ppP81N/hR7zb7RrUdmB58cXVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PG/XpEXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6dVmNmT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PG/XpEXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6dVmNmT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFF8C21A73;
	Wed,  5 Jun 2024 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717589458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN+w/TovSrwissg57QG60IwNp9Hctvf70xSk1rwT/Pg=;
	b=PG/XpEXZzNz1Js+hS0AYEQq6wF/mlmEydGp9Z3IhKAr2klDI6015Sb88MUK7J2BVzUZrYx
	92pLlKLC8EUAeDvI3W8dKK/t73kfshWA9/h6E3pC+QZi2CfN+deekcQAHWFSz8+oSCcvTS
	zAG87iCLmtDzkZYvBOQ81rb5JbRqK1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717589458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN+w/TovSrwissg57QG60IwNp9Hctvf70xSk1rwT/Pg=;
	b=F6dVmNmTojHNhFFG5s17JpEV5mI+u0DzSYJj/wQ4IbG2ok1H1olajB0CYxKZ66ZkSVrtJA
	t1NagGvHpWT6mNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717589458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN+w/TovSrwissg57QG60IwNp9Hctvf70xSk1rwT/Pg=;
	b=PG/XpEXZzNz1Js+hS0AYEQq6wF/mlmEydGp9Z3IhKAr2klDI6015Sb88MUK7J2BVzUZrYx
	92pLlKLC8EUAeDvI3W8dKK/t73kfshWA9/h6E3pC+QZi2CfN+deekcQAHWFSz8+oSCcvTS
	zAG87iCLmtDzkZYvBOQ81rb5JbRqK1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717589458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN+w/TovSrwissg57QG60IwNp9Hctvf70xSk1rwT/Pg=;
	b=F6dVmNmTojHNhFFG5s17JpEV5mI+u0DzSYJj/wQ4IbG2ok1H1olajB0CYxKZ66ZkSVrtJA
	t1NagGvHpWT6mNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB1FD13A24;
	Wed,  5 Jun 2024 12:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3iRQItBVYGbWAwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Jun 2024 12:10:56 +0000
Date: Wed, 5 Jun 2024 22:10:19 +1000
From: David Disseldorp <ddiss@suse.de>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana
 <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/280: run defrag after creating file to get
 expected extent layout
Message-ID: <20240605220949.69701b2b@echidna>
In-Reply-To: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
References: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed,  5 Jun 2024 12:26:20 +0100, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> The test writes a 128M file and expects to end up with 1024 extents, each
> with a size of 128K, which is the maximum size for compressed extents.
> Generally this is what happens, but often it's possibly for writeback to
> kick in while creating the file (due to memory pressure, or something
> calling sync in parallel, etc) which may result in creating more and
> smaller extents, which makes the test fail since its golden output
> expects exactly 1024 extents with a size of 128K each.
> 
> So to work around run defrag after creating the file, which will ensure
> we get only 128K extents in the file.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks fine.
Signed-off-by: David Disseldorp <ddiss@suse.de>

> ---
>  tests/btrfs/280 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> index d4f613ce..0f7f8a37 100755
> --- a/tests/btrfs/280
> +++ b/tests/btrfs/280
> @@ -13,7 +13,7 @@
>  # the backref walking code, used by fiemap to determine if an extent is shared.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick compress snapshot fiemap
> +_begin_fstest auto quick compress snapshot fiemap defrag
>  
>  . ./common/filter
>  . ./common/punch # for _filter_fiemap_flags

_require_defrag might be worth calling, but it doesn't really do
anything for btrfs, so I'm fine either way.

