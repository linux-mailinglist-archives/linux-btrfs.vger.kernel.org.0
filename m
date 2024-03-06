Return-Path: <linux-btrfs+bounces-3042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC55874310
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 23:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA68286278
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80561C2AF;
	Wed,  6 Mar 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpWTi6k6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mjV8Vewx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpWTi6k6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mjV8Vewx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CB1BC56;
	Wed,  6 Mar 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765986; cv=none; b=jdv0qwM+cvHnrw/q5j7plL5fv9PD3H4ZAZPxoAo6XN/t5H9jnyZJVYOgGYioWvHVc/ByyWCHrzt0TTGhVtz50KkO2kUhsGzMz8mLXT50jgitKBtEj8DwJdPjrAuXE4OA7y/22X4uBl+OWXTgDy9vIl2X/XZctYuZ9RvwvU761VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765986; c=relaxed/simple;
	bh=n9lp6KzgmSJZX15lATRUaJ4Y7gE2ttqa6DPS8e9OnWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU0fM67SMkEBsSPp2QQkDJ/90hUAzaTTxOY+PVFrUB+m3wi5L7MXNOwKv431lE8qHpusTUXgnrSYTGRU82gyJQJEJ/h0Nr63ti15DUWOZCtBg9GtFTI79WhSuE/t7gPix1+1B5boPf+pBTm4zxCsx18jLLQ+1SfiS9LipawTU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpWTi6k6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mjV8Vewx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpWTi6k6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mjV8Vewx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 140665271;
	Wed,  6 Mar 2024 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709765983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrop4YUdGRKvNQXA/6BgUnP3lgV2h11ozYJeVBha7MY=;
	b=gpWTi6k6T2tP5n18kwFvxQamMJ72+SAqsKIFsoDra5AqA9kQBCt8RyEbqMVp9poB+71r2Z
	TCvxDK3dD9qP3s0iNApYeg3QE05Jda+PgWrIuQ+C33k7/eGH/LNGU6kOvOrpGw8Q2S99Kb
	nLMeQkO0DF3yHIsZ2Mv59GY1PIfAuFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709765983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrop4YUdGRKvNQXA/6BgUnP3lgV2h11ozYJeVBha7MY=;
	b=mjV8VewxMKVH8OlLYZ17Z3Ti2XnjFCSRm9ClrYH2J0t2CWk+8vf1huPFTsqrhmYOo9iWbH
	QckUexC+TJ4VFvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709765983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrop4YUdGRKvNQXA/6BgUnP3lgV2h11ozYJeVBha7MY=;
	b=gpWTi6k6T2tP5n18kwFvxQamMJ72+SAqsKIFsoDra5AqA9kQBCt8RyEbqMVp9poB+71r2Z
	TCvxDK3dD9qP3s0iNApYeg3QE05Jda+PgWrIuQ+C33k7/eGH/LNGU6kOvOrpGw8Q2S99Kb
	nLMeQkO0DF3yHIsZ2Mv59GY1PIfAuFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709765983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrop4YUdGRKvNQXA/6BgUnP3lgV2h11ozYJeVBha7MY=;
	b=mjV8VewxMKVH8OlLYZ17Z3Ti2XnjFCSRm9ClrYH2J0t2CWk+8vf1huPFTsqrhmYOo9iWbH
	QckUexC+TJ4VFvAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E8C11377D;
	Wed,  6 Mar 2024 22:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5UZZMFz16GWzXAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Wed, 06 Mar 2024 22:59:40 +0000
Date: Thu, 7 Mar 2024 09:59:08 +1100
From: David Disseldorp <ddiss@suse.de>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana
 <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix grep warning at
 _require_btrfs_mkfs_uuid_option()
Message-ID: <20240307095908.34913ff0@echidna>
In-Reply-To: <ef2df19486ef71adccd14b3df0bf475ecc7f3b38.1709737287.git.fdmanana@suse.com>
References: <ef2df19486ef71adccd14b3df0bf475ecc7f3b38.1709737287.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gpWTi6k6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mjV8Vewx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.05 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.52%]
X-Spam-Score: -1.05
X-Rspamd-Queue-Id: 140665271
X-Spam-Flag: NO

On Wed,  6 Mar 2024 15:01:57 +0000, fdmanana@kernel.org wrote:
...
>  	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
> -				grep -E --count "\-\-uuid|\-\-device-uuid")
> +				grep -E --count -- "--uuid|--device-uuid")
>  	if [ $cnt != 2 ]; then
>  		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
>  	fi

Reviewed-by: David Disseldorp <ddiss@suse.de>


