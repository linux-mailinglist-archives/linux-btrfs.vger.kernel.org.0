Return-Path: <linux-btrfs+bounces-127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7457EB01E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5751C20AB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5323FB14;
	Tue, 14 Nov 2023 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t5GsxkJ0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rO0gB+/w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD263168CF
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 12:46:02 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8D130
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 04:46:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C5CF1F88C;
	Tue, 14 Nov 2023 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699965960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k8jHQg56CSX3W7YeoGeO6D8JKD5EwNkHRqRD2u8Q8I=;
	b=t5GsxkJ0fKk9F2EpSFmIVFW1QDfzUBJfqo6Xi/rXSI3R7h2IgKUfPsiBr8fQSO6qVe+N7s
	WupJnIpg89UQNKTm2kM9WL1KlkBzjf/B2H+WpVvy3wHxLN+IoyzocTb8AXTWB9of/jvRIh
	4GffdIuQwxm9cjmTRuN3AePvfSnW7T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699965960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k8jHQg56CSX3W7YeoGeO6D8JKD5EwNkHRqRD2u8Q8I=;
	b=rO0gB+/wBpQbvQtdBwnhz5AbzRHUNSVxYTCo+e5U5cJ8qGrBtszQf3O54qtS6XFoKKrSfQ
	6HyARZAaPvXXS1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 020DA13416;
	Tue, 14 Nov 2023 12:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id salXOwdsU2VsdAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 12:45:59 +0000
Date: Tue, 14 Nov 2023 13:38:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: do not abort transaction if there is already an
 existing qgroup
Message-ID: <20231114123854.GA11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
 <64b1dc37-4286-4e42-8074-0be96315efcf@oracle.com>
 <79fd5ac9-5a06-4305-85d9-25481d621eb0@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79fd5ac9-5a06-4305-85d9-25481d621eb0@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.97
X-Spamd-Result: default: False [-2.97 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[4d81015bc10889fd12ea];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.67)[82.91%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Tue, Nov 14, 2023 at 06:25:03PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/14 15:43, Anand Jain wrote:
> > 
> > 
> >> [CAUSE]
> >> The error number is -EEXIST, which can happen for qgroup if there is
> >> already an existing qgroup and then we're trying to create a subvolume
> >> for it.
> >>
> > 
> > We were able to create a qgroup for which the snapshot ID did not exist.
> > Shouldn't that have failed in the first place?
> 
> We allowed it from the very beginning, even had interfaces to allow end 
> users to modify them directly.
> 
> But nowadays, you can no longer change the numbers out of the kernel, 
> thus the newly created 0 level qgroups can only have 0 as their rfer/excl.
> 
> Thus it won't cause any problem, some may even consider it as a way to 
> "preallocate" qgroups.

Is this based on a real world use case or only that the functionality
allows that? Preallocating could be hard as the subvolume numbers are
unpredictable in general, in practice it's +1 from the last one created
so with some luck the new subvolume could match the preallocated qgroup.

Preallocating qgroups might make sense to put them to some higher level
qgroup for accounting and setting limits, but this is again artifical
and unstable when using so I wonder who and how would use it that way.

