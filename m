Return-Path: <linux-btrfs+bounces-10005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA159E039E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B93281082
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B31FF5F4;
	Mon,  2 Dec 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZ8YeOCB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GUUmWvSL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tzwQcI8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nb1efb/x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118B487A7
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146583; cv=none; b=eEtRfJuNMWEPYeZqYoOSrmfy+89kDi/fKtEQgdtNTtP3rE/RAxfxpo6ZWA8J5eGZ99k40SbH8E87YdqGXJoOImtK2JGP/70xiBB0q/9sEvji/7+C0BrmriZxYDw7p//xLU3C+e6TytM43c23uaOFov0riCieIn2uqgOlMkAc5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146583; c=relaxed/simple;
	bh=IT0qEEvbg+a/TLPgzZ9kHKsScM7wtLA6TYGOLpgD4b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPqhfIXLDCotFwe65/iVis4d4XYaltcwlF4MMlcdFZwkLda/IhlY56WyReTXwC/yCVCQ/IXOZSihefIN9bDLOaT2JuqQAHBhAVAeXk7YifPBXyQHXsPntktb42zJQPrKg10OOBK3cvHRfr5Va9MM9yY5rfjSpNfGt+kFrobuQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZ8YeOCB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GUUmWvSL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tzwQcI8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nb1efb/x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D21A421175;
	Mon,  2 Dec 2024 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733146579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2TdmFco01BeDwftSq3BLWXddYdaOwqRbhohesYHKds=;
	b=RZ8YeOCBbgtGm6+cfhAl9MZFTAFI+iU4Xvv65JEZ/hdVqrFwkJK3Ci/fK4DCn/x1YAK7S5
	TOfCxzUSOfooiMXD5TOJS0cODDvYczz6gU5sHJdtofzHcGYFFGT0WR9C9MpMdLsiyPVvKZ
	u6VqpG20GlIf8EeodgeVi0uwJZ0eYNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733146579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2TdmFco01BeDwftSq3BLWXddYdaOwqRbhohesYHKds=;
	b=GUUmWvSLYCdj/As8FQkYIz0Txh7bGyI7t/8eKEeOtM5V6q4SwC/xGI442DyshuC5fyEDsJ
	RpxshSWiZvN9McAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733146576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2TdmFco01BeDwftSq3BLWXddYdaOwqRbhohesYHKds=;
	b=tzwQcI8MyCz59DmBiZ0AlnZhbZAZOHHPzDM3bDLyZRzIxzE8+TSK7fI99Jwi56VG/xQdkn
	loXRbbB+9j4hJLJLk1bBTWfaXuz8GZdNtiDjHT54ChS04v8eEHBjdLUWSnbSPBY6efQog1
	lfx05xYqZK8ZczLirWls0spKDaTY1lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733146576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2TdmFco01BeDwftSq3BLWXddYdaOwqRbhohesYHKds=;
	b=Nb1efb/x5Iq0/+E/zxrJAmQ+i/9Y7RZprvL2fOdlHUSPOa04p/rqqw5wKpgd8lPZDTnWeM
	ATSOjuSo6X/SdLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C9B139C2;
	Mon,  2 Dec 2024 13:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HJQALdC3TWfUDQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:36:16 +0000
Date: Mon, 2 Dec 2024 14:36:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <Z02337yqxrfeZxIn@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201093606.68993-2-zlang@kernel.org>
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
> This test need to skip test known filesystems, but according to below
> code logic (in lib/tst_test.c):
> 
>   if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
>         long fs_type = tst_fs_type(".");
>         const char *fs_name = tst_fs_type_name(fs_type);
> 
>         if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
>             tst_brk(TCONF, "%s is not supported by the test",
>             fs_name);
>         }
>
>         tst_res(TINFO, "%s is supported by the test", fs_name);
>   }
> 
> if all_filesystems is 1, the skip_filesystems doesn't work. So set
> all_filesystems to 0.

The code to skip filesystems in the case of all filesystems is in the
run_tcase_per_fs() function:

static int run_tcases_per_fs(void)
{
        int ret = 0;
        unsigned int i;
        const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);

The skip_filesystems array is passed to the tst_get_supporte_fs_types()
function which filters out them.

-- 
Cyril Hrubis
chrubis@suse.cz

