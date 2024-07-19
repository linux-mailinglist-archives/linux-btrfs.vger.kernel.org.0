Return-Path: <linux-btrfs+bounces-6610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F280937BC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836FB1C2159B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39E146D78;
	Fri, 19 Jul 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9gxKBro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DVDsbkGy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9gxKBro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DVDsbkGy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B871B86D5;
	Fri, 19 Jul 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411026; cv=none; b=LLf9CIemLQftVOkk++sbfryfjonIQaKcf29loS0+37+DAnB9bHS4Vw69FFEwd60usF0sCRUr22LW2fXK2UkzFpo/SFem6uoTY9sA4LEkGEFDLP3yQLpAb2dvX4YfCfbG21NcV1ao1XhlAvbrRen70U6OvtCxo/Rkb8fPTrLepdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411026; c=relaxed/simple;
	bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=axS7B3+LCaTdBqS5rpi++n2+J6zxKd7sMga5iGW63IBtqz8q9/+Y3TsXzb+gLjf7taDYrW0j4N8KvFum/YrXWKI6/BU/ZHEhsTBGiBlH9gynsVjisf/23teJDRwUAL9FMy2+ZpvYsqyhqQzJAp3si8wa+IgiYYYw+oUkxEFjvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9gxKBro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DVDsbkGy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9gxKBro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DVDsbkGy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D19A71F7A5;
	Fri, 19 Jul 2024 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721411022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
	b=W9gxKBromI/sNsrKIOevP2RIcbkC+BCV1at+g2SUEg543FAXNyzS+atZV0v9A+c9GFghPm
	RhMLb5gPDGoWSw6zxnhWMptQX4D81Aw13IMWI33kXHMRtJn04fMTrChOK0mCPav711Fqcy
	OM7wFyhX33jHrWNNKjtGkg9F9Ey6Gbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721411022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
	b=DVDsbkGyUEW9DxctpXXrcSxh/3o9uwW4tcwZzPoPvfBvN9PwuDrOhpt1E3T1xaCc+GonZQ
	DnIz4j3tolsM9PCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721411022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
	b=W9gxKBromI/sNsrKIOevP2RIcbkC+BCV1at+g2SUEg543FAXNyzS+atZV0v9A+c9GFghPm
	RhMLb5gPDGoWSw6zxnhWMptQX4D81Aw13IMWI33kXHMRtJn04fMTrChOK0mCPav711Fqcy
	OM7wFyhX33jHrWNNKjtGkg9F9Ey6Gbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721411022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
	b=DVDsbkGyUEW9DxctpXXrcSxh/3o9uwW4tcwZzPoPvfBvN9PwuDrOhpt1E3T1xaCc+GonZQ
	DnIz4j3tolsM9PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05F2B13808;
	Fri, 19 Jul 2024 17:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOZaO82lmmaiJwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 19 Jul 2024 17:43:41 +0000
Date: Fri, 19 Jul 2024 19:43:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
Message-ID: <20240719174325.GA775414@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: 0.70
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.dk,suse.cz,suse.com,gmail.com,suse.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 

Hi all,

LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
16 other processes reads the buffer and check only zero is there.

Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
(Non default parameter creates much smaller file, thus the change is not that
obvious).

Because the slowdown has been here for few kernel releases I suppose nobody
complained and the test is somehow artificial (nobody uses this in a real world).
But still it'd be good to double check the problem. I can bisect a particular
commit.

Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
performance" [4] block layer change somehow related?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
[2] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/dio_sparse.c
[3] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/common.h
[4] https://kernelnewbies.org/Linux_6.6#Block_layer

