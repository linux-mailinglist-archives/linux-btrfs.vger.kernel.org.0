Return-Path: <linux-btrfs+bounces-4780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501F8BD2F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C707328261F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F10156960;
	Mon,  6 May 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNrjozCL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCsYhaJN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNrjozCL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCsYhaJN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002BF1E4A6
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013549; cv=none; b=tMzv2xG3K1Gfj/5sIiCv7FdxsInPVEAAXB04Em3A/TcIT2khZ5Z2pI1kTfL8HyZCHSOmdfMd7jgMcJLgBYeeKBfAZQ8LErcLjm/0Mh+s2IZ5NFtPvmSwR4wiHgVO9xevAq+FF53jeeIcnxphZp0p5WvT9gVWa/giqSh/r7xdC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013549; c=relaxed/simple;
	bh=rUYfZYOA2zkNnc3zGGoMTanDTf5QntngTEkW7CyCm2o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EbPJT5/JGXGSh4nLsSKoCFsPfqywtqqGQCCbvNONv59I8Sr8Rj/YW6mgHdfOGsmC/91HfJXNy7HLVYuBA6xLRJy49x4ZQHogRlRuB4fcN+11/mEFlABmaLYYrBy4StyIZLsGh+MSLsAvCJhjiudbsWnuTc0u/C8DPtZXENMdEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNrjozCL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCsYhaJN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNrjozCL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCsYhaJN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30DF521A8D;
	Mon,  6 May 2024 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715013546;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fTJbk0xHF0vK6DLbREXTS2wpFN7q2Ohn2BPQIe9q4hg=;
	b=mNrjozCLMXKuQfVRC2JCFr6LPNDXKtDassEP2K3Cz+HjbKyywd09Vza9aDOEdNFpwThfi6
	e1WsTAnm0UsEQUtfHJuH6mB7m7QXaUuNxgXkcDT4DugGo7Eg0oyV4LGvo5FmOMuXzYTLcX
	Qyo+tcfI7v70KBCEhKXidrKGxR6B3kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715013546;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fTJbk0xHF0vK6DLbREXTS2wpFN7q2Ohn2BPQIe9q4hg=;
	b=wCsYhaJNlbujz5ApNEJ+bVj4Tin9vOoqt4x9/L+9u+3v4ZdoCQ7tYK8HLA217n5C4y+3KW
	XRUZemjlkHQfNJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715013546;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fTJbk0xHF0vK6DLbREXTS2wpFN7q2Ohn2BPQIe9q4hg=;
	b=mNrjozCLMXKuQfVRC2JCFr6LPNDXKtDassEP2K3Cz+HjbKyywd09Vza9aDOEdNFpwThfi6
	e1WsTAnm0UsEQUtfHJuH6mB7m7QXaUuNxgXkcDT4DugGo7Eg0oyV4LGvo5FmOMuXzYTLcX
	Qyo+tcfI7v70KBCEhKXidrKGxR6B3kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715013546;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fTJbk0xHF0vK6DLbREXTS2wpFN7q2Ohn2BPQIe9q4hg=;
	b=wCsYhaJNlbujz5ApNEJ+bVj4Tin9vOoqt4x9/L+9u+3v4ZdoCQ7tYK8HLA217n5C4y+3KW
	XRUZemjlkHQfNJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BFC1386E;
	Mon,  6 May 2024 16:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JnCXCKoHOWZqHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 May 2024 16:39:06 +0000
Date: Mon, 6 May 2024 18:31:44 +0200
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Subject: Btrfsmaintenance 0.5.1
Message-ID: <20240506163144.GF13977@twin.jikos.cz>
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
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-2.21)[96.22%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.21
X-Spam-Flag: NO

Hi,

after a long time there's a new release of btrfsmaintenance package.
There have been some fixes pending in the devel branch but I completely
forgot to do a release.

- fix handling of OnCalendar timer directive in the drop-in
  configuration file that reads the periods from the sysconfig
- fix use of --verbose option of fstrim, not available on util-linux < 2.27
- ship manual page of README, also available as 'systemctl help servicename'

https://github.com/kdave/btrfsmaintenance
https://github.com/kdave/btrfsmaintenance/releases/tag/v0.5.1

