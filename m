Return-Path: <linux-btrfs+bounces-16131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476AFB2AF0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FE13B2712
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F432C325;
	Mon, 18 Aug 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJYLiCGR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz7G6amw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJYLiCGR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz7G6amw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFC32C316
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537052; cv=none; b=ZpzR+9RTUaewo5dtyzXQXo8OnzxPfQ5y+FgN0CAymNoUu82gRl5vvECPpM+Q5B5ARQC+bkjP3L7EJ2FztslCABtkhrQkAHl6nQyAyVmidXN0H++5NAZbyXWd3W5M6zBcrSA4yeutJRgRz4FpfJ+nH+lvvZS69b/IS6P/ZtG2Udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537052; c=relaxed/simple;
	bh=uxkqRd0Ce2wAxA1eKGNe4XSzbiGooszgPD7Z7hvNCMM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bfmN3CrAojhv0jdokNZq9eki/j5+j6vh7ELAuMSyfp+XfDb4zCh8MbOeZOWKFpbnYIhDHm6uHfFUojfgmR6Nku29wPuESef/YH1KKG90Hx6d+WljE6juNX2PaUjI9BxHDmL87wD7kSqm9DKlh2dO+HPqEVFI8dCvlkvqQSR5Ijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJYLiCGR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz7G6amw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJYLiCGR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz7G6amw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55D5D211ED;
	Mon, 18 Aug 2025 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755537049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uxkqRd0Ce2wAxA1eKGNe4XSzbiGooszgPD7Z7hvNCMM=;
	b=SJYLiCGRS2jZT+13N7fwEUTNbM8TuZXyb5JMCp/Ok0UNNbHLMbZMdM1TYM91xwOqOu5X7D
	tpYom0sLyvC3uj6wAk/r/01sZBBblQlNjhyz7xRbTlVTGLlrxwwfiwH5dEMJ4jhyfLrKuW
	rUSmNz1/uVlE+NzkGVLHtxSSZpk1gQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755537049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uxkqRd0Ce2wAxA1eKGNe4XSzbiGooszgPD7Z7hvNCMM=;
	b=Hz7G6amw+bIrGz+pMSbNLBR+2WQobleOLWC72VszKXPESZRig7GeqcjgyglN5Nd4+DZd3J
	q0mAY5AHPuujS8AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755537049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uxkqRd0Ce2wAxA1eKGNe4XSzbiGooszgPD7Z7hvNCMM=;
	b=SJYLiCGRS2jZT+13N7fwEUTNbM8TuZXyb5JMCp/Ok0UNNbHLMbZMdM1TYM91xwOqOu5X7D
	tpYom0sLyvC3uj6wAk/r/01sZBBblQlNjhyz7xRbTlVTGLlrxwwfiwH5dEMJ4jhyfLrKuW
	rUSmNz1/uVlE+NzkGVLHtxSSZpk1gQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755537049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uxkqRd0Ce2wAxA1eKGNe4XSzbiGooszgPD7Z7hvNCMM=;
	b=Hz7G6amw+bIrGz+pMSbNLBR+2WQobleOLWC72VszKXPESZRig7GeqcjgyglN5Nd4+DZd3J
	q0mAY5AHPuujS8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43C8C13686;
	Mon, 18 Aug 2025 17:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gxFhEJleo2jsTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 17:10:49 +0000
Date: Mon, 18 Aug 2025 19:10:47 +0200
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Subject: Remaining BTRFS_PATH_AUTO_FREE work
Message-ID: <20250818171047.GP22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Hi,

there are still possible conversions of struct btrfs_path to
BTRFS_PATH_AUTO_FREE(). As this is fairly easy it's approachable for beginners
or drive-by contributions.

The basic pattern is explained in patch 4c74a32ad323 ("btrfs: DEFINE_FREE for
struct btrfs_path").

Examples of previous work:

- e23541811877 ("btrfs: do more trivial BTRFS_PATH_AUTO_FREE conversions")
- 516748f584fd ("btrfs: use BTRFS_PATH_AUTO_FREE in may_destroy_subvol()")

IIRC files beginning with [p-z] haven't been converted yet, search for
btrfs_alloc_path() and look if it matches the pattern.

Whoever is interested please reply to this mail so the work is not
unnecessarily duplicated.

