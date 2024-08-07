Return-Path: <linux-btrfs+bounces-7021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FE94A704
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63B6B22572
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68F1E4842;
	Wed,  7 Aug 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O9U9f/7I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVdA/Qiz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtM2AQEs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNdQrip1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF291B86DB;
	Wed,  7 Aug 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030434; cv=none; b=qu1GLfORD3AjP7iS4XzKBZLlCRqvXMBgk/lVlFao4DhXhLoWwMSqwyZc7GiiltlXpD+VHskX9escYJ5J9PY0ePR0eG1ifTr5hNyuzuNWyYE2qv445D3oTO6Acbf/1k6pye5IJJ71jO3vkI2DBXJF7uSjNE4AgiHqDevhVrwwJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030434; c=relaxed/simple;
	bh=qHdq8uK7CaYm+5UIrukOAby1PbNwNDBkOZUeKLTQ+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfgByPMXF/HAGbVKZjp7LehRFdLMb8QLRH4rADIvxmwFvDC5YyYU8TrI+PqHpT/I/eqm3Pk+ia2ie0CYPChMPy8xDeAjoS5kkETlUAuPxlrhGjqWtUG5P4eMKc0zHTe/yfAaDcl8GQ2er/S3kXsaOS7mBJZ9caQelm+64CHO8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O9U9f/7I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVdA/Qiz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VtM2AQEs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNdQrip1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6480E1F8BD;
	Wed,  7 Aug 2024 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723030430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auzbwY05oqqgWgJJLy1IMQr25def4tJKwP5Bjp3x8a0=;
	b=O9U9f/7ITXXqs2jv71IkT2ys4u5sTWhQegG5WX6T78wSD8apTGg+zAF1B6FbDmVJVq+Wye
	Dq4Sx//Lq4rmkJSdKIWCUYmjGSfSi+lKUKYA0Py/2VL08NyogL/M5bATsmjNmKDHlWGGT0
	S8MuzzeSos/1EkU7Ezg/4PKophfoE74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723030430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auzbwY05oqqgWgJJLy1IMQr25def4tJKwP5Bjp3x8a0=;
	b=MVdA/QizJBf8aYIY1SboJnc4+OvKi2qYmb98H60Ip4MZd5yJKRS3qFYCrkM3W7F5Meh6tm
	IdnZd7BFT1hLXbCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723030429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auzbwY05oqqgWgJJLy1IMQr25def4tJKwP5Bjp3x8a0=;
	b=VtM2AQEsv+Kol9bCm67xTmXNH51FzdIgPTrR7aYTt1/e4L8eEQtqNlvCe7mSvme8ab1/6F
	y1kwjJTLpv1OSAerHkXGW6hFN/zBqrzdQqbQ4gnspkgFBMB4UlhQt6TYkY1QF3cHuU+k2L
	9xGb2mnQpKcrB7FnIGDjHvJELuuvZeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723030429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auzbwY05oqqgWgJJLy1IMQr25def4tJKwP5Bjp3x8a0=;
	b=lNdQrip1ttUDkywhDDywwOIxn75g4jQXSQO6H0umECwrdpdqkIxit75vianv3HVPG0Y0kY
	J5FTXYFHZDpg4rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 410CD13A7D;
	Wed,  7 Aug 2024 11:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KiiuD51bs2ZXMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Aug 2024 11:33:49 +0000
Date: Wed, 7 Aug 2024 13:33:48 +0200
From: David Sterba <dsterba@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>,
	boris@bur.io, clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	wqu@suse.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
Message-ID: <20240807113348.GC17473@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000000e082305eec34072@google.com>
 <0000000000001e43de061f08c0d4@google.com>
 <20240806221845.GA623904@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806221845.GA623904@frogsfrogsfrogs>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.50 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[b9d2e54d2301324657ed];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,syzkaller.appspot.com:url,goo.gl:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.50

On Tue, Aug 06, 2024 at 03:18:45PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 06, 2024 at 12:25:03PM -0700, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
> > Author: Boris Burkov <boris@bur.io>
> > Date:   Thu Jun 20 17:33:10 2024 +0000
> > 
> >     btrfs: preallocate ulist memory for qgroup rsv
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
> > start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> > 
> > #syz fix: btrfs: preallocate ulist memory for qgroup rsv
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> I don't get it, why am I being cc'd on some random btrfs bug?

Because for some reason bisection blames your patch

  Cause bisection: introduced by (bisect log) :
  commit 05fd9564e9faf0f23b4676385e27d9405cef6637
  Author: Darrick J. Wong <djwong@kernel.org>
  Date: Mon Mar 14 17:55:32 2022 +0000

    btrfs: fix fallocate to use file_modified to update permissions consistently


but this is wrong, the issue syzbot hits is an injected ENOMEM in a path
that does not handle it. This is known and we count on memory allocator
not to fail such cases. The subsystem for the syzbot issue is set
correctly, you got CCed because another automatic bisection round was
started after a year.

