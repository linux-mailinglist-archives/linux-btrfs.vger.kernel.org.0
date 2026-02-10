Return-Path: <linux-btrfs+bounces-21618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIwrCeiBi2m+UwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21618-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:07:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D211E81A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFFB130715D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C230FC34;
	Tue, 10 Feb 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qWJAAR43";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dndhSP0N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qWJAAR43";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dndhSP0N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83311F03EF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750361; cv=none; b=OFK678LBxnbcH+GgW9qSluRYZ+3eqr9TLx+Vum9HdcCKAb0rW6PVKlxlIULPbUJd1eodjxFo9p6658KUFqP/8x16avkw6x+n6eQEIbAtC5LZtRIFsiqLOCYusTZnd65Kr622HuSjTaizwlauzn8i5mmHeW0nvy20Q1zhJvebnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750361; c=relaxed/simple;
	bh=E4y9NUuwR6a0ShDtsuaOOTE4mkyuIoktGLRMFWaWR9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUdMrrAAjF6s1TrirzMaChX2wJt9Gkx/hPTz3w+OAVCMssJB9yRs+3q8JSsIODHbezaNu3qDkUEwnhM6CJWeTyTjxSTFU4QU607Z/PJc3JTBrX46hexiDmgOB6cHxVOBj1g23SREsAEHBO5OWywPc314UzIpVG4S/TINnm/gXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qWJAAR43; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dndhSP0N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qWJAAR43; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dndhSP0N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 567DD3E71C;
	Tue, 10 Feb 2026 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJrIvtpzMBlejYcSp9HkYPx3HubPMBzlD6Yc6JLhuPY=;
	b=qWJAAR43G0TM1uVj8IUUztIeKogqwGN8ApBRBLhclePktRRBZUAaJY+aJXTgRCPyIgJCEO
	pefI/Y4f0Ae+tIvsKh8P3cCoASTNJfdA/Ru83hNH+LBXAt8wf1RFhYBORb7mdPUbq6ESlX
	ogSCIs++G54OrpztR9l9nT/OlKoPlew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJrIvtpzMBlejYcSp9HkYPx3HubPMBzlD6Yc6JLhuPY=;
	b=dndhSP0NcRtq8IP5u5LKwmw8XG2DOfYvFuJ/cjDUGFtN4QZJQIuYE0c8jeZbMghoTchYvA
	Yp3kJKwirWP19VAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJrIvtpzMBlejYcSp9HkYPx3HubPMBzlD6Yc6JLhuPY=;
	b=qWJAAR43G0TM1uVj8IUUztIeKogqwGN8ApBRBLhclePktRRBZUAaJY+aJXTgRCPyIgJCEO
	pefI/Y4f0Ae+tIvsKh8P3cCoASTNJfdA/Ru83hNH+LBXAt8wf1RFhYBORb7mdPUbq6ESlX
	ogSCIs++G54OrpztR9l9nT/OlKoPlew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJrIvtpzMBlejYcSp9HkYPx3HubPMBzlD6Yc6JLhuPY=;
	b=dndhSP0NcRtq8IP5u5LKwmw8XG2DOfYvFuJ/cjDUGFtN4QZJQIuYE0c8jeZbMghoTchYvA
	Yp3kJKwirWP19VAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E00F3EA62;
	Tue, 10 Feb 2026 19:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnsKC5aBi2l3ZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Feb 2026 19:05:58 +0000
Date: Tue, 10 Feb 2026 20:05:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] btrfs: tests: zoned: add tests cases for zoned code
Message-ID: <20260210190552.GG26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYrvqbjR7S0RtjSI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYrvqbjR7S0RtjSI@stanley.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21618-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A52D211E81A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:43:21AM +0300, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding. #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> Hello Naohiro Aota,
> 
> Commit df321b214f62 ("btrfs: tests: zoned: add tests cases for zoned
> code") from Feb 4, 2026 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	fs/btrfs/tests/zoned-tests.c:68 test_load_zone_info()
> 	warn: duplicate check 'zone_info' (previous on line 62)
> 
> fs/btrfs/tests/zoned-tests.c
>     40 static int test_load_zone_info(struct btrfs_fs_info *fs_info,
>     41                                const struct load_zone_info_test_vector *test)
>     42 {
>     43         struct btrfs_block_group *bg __free(btrfs_free_dummy_block_group) = NULL;
>     44         struct btrfs_chunk_map *map __free(btrfs_free_chunk_map) = NULL;
>     45         struct zone_info AUTO_KFREE(zone_info);
>     46         unsigned long AUTO_KFREE(active);
>     47         int ret;
>     48 
>     49         bg = btrfs_alloc_dummy_block_group(fs_info, test->bg_length);
>     50         if (!bg) {
>     51                 test_std_err(TEST_ALLOC_BLOCK_GROUP);
>     52                 return -ENOMEM;
>     53         }
>     54 
>     55         map = btrfs_alloc_chunk_map(test->num_stripes, GFP_KERNEL);
>     56         if (!map) {
>     57                 test_std_err(TEST_ALLOC_EXTENT_MAP);
>     58                 return -ENOMEM;
>     59         }
>     60 
>     61         zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
>     62         if (!zone_info) {
>     63                 test_err("cannot allocate zone info");
>     64                 return -ENOMEM;
>     65         }
>     66 
>     67         active = bitmap_zalloc(test->num_stripes, GFP_KERNEL);
> --> 68         if (!zone_info) {
> 
> s/zone_info/active/

Thanks for the report, fixed in git.

