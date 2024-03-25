Return-Path: <linux-btrfs+bounces-3567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E788B301
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE96D1F255CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB326EB6B;
	Mon, 25 Mar 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9jxGXak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xonoCTwE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9jxGXak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xonoCTwE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F233995
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403014; cv=none; b=eUtpgO1z7AmDCgmrln0rdOVxdDHKDUgNBUU/+sT0HiUAnfKuzIylMUPyMStCws9N3F0hibQ1USfxjGS8KZipSoGMs1D4nAl6TWSNhzoFZIwth23/DJUgS5uuONfQaIA/u1zEcBafwfV3XwFWk2udSJLxoZkNc+APyVZ7R8w3m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403014; c=relaxed/simple;
	bh=LZv/cEqWG5+5BtA3lWOzOde2rHEeArsAtgjvzAZO7Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmY+Yt+RacO3mQsb2no7YrAFVLlDlSUoIl4QtzzC9Nm7nJKaULmy25KkJnX0+WgwENHERgacAyU5o1eHM9DU/HnxffJdxmp6+UU90bYvg/JziJ2QmQ+qTGDav0/qOxZE0nlQj+0NaJAqYJwd49oMblEP9ynwDvtmo/Q24LND+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9jxGXak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xonoCTwE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9jxGXak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xonoCTwE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 521C734BC5;
	Mon, 25 Mar 2024 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711403010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZv/cEqWG5+5BtA3lWOzOde2rHEeArsAtgjvzAZO7Ew=;
	b=g9jxGXaklHzEAACMACrOaSobqruh40nTtfovol6phFDiiqPKckvF2/kIkRUjc/YnrTqDPm
	KNbjhPERDp/2p+iesAo3/SIQzbKdJBUdyIChbcaIZ7PPGEU5sXyjX5jHjpGJXHOfR9foKF
	YwP+Qv+NWSejIWotpDlb1SOjwC+Mr4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711403010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZv/cEqWG5+5BtA3lWOzOde2rHEeArsAtgjvzAZO7Ew=;
	b=xonoCTwEbb418CtXdLT+uYndwxgbtmju4l796MfQVUbfrjPaPjmNsq/qmNJt1VzJ1lzeu7
	b/LuVvVq9fuqLACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711403010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZv/cEqWG5+5BtA3lWOzOde2rHEeArsAtgjvzAZO7Ew=;
	b=g9jxGXaklHzEAACMACrOaSobqruh40nTtfovol6phFDiiqPKckvF2/kIkRUjc/YnrTqDPm
	KNbjhPERDp/2p+iesAo3/SIQzbKdJBUdyIChbcaIZ7PPGEU5sXyjX5jHjpGJXHOfR9foKF
	YwP+Qv+NWSejIWotpDlb1SOjwC+Mr4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711403010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZv/cEqWG5+5BtA3lWOzOde2rHEeArsAtgjvzAZO7Ew=;
	b=xonoCTwEbb418CtXdLT+uYndwxgbtmju4l796MfQVUbfrjPaPjmNsq/qmNJt1VzJ1lzeu7
	b/LuVvVq9fuqLACA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 460E513A71;
	Mon, 25 Mar 2024 21:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 94zsEALwAWYyCgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 21:43:30 +0000
Date: Mon, 25 Mar 2024 22:36:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs-progs: snapshot fix user message
Message-ID: <20240325213608.GQ14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <207156d802739bf6225591450dfc19b710be0350.1710857220.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207156d802739bf6225591450dfc19b710be0350.1710857220.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.02
X-Spamd-Result: default: False [-1.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.949];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.33%]
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 07:41:29PM +0530, Anand Jain wrote:
> The fstests depend on the output message of the create snapshot command,
> and if it's changed, the tests fail. Bring back the original messages,
> as they are also grammatically correct.

I removed the 'a' for consistency with other messages. That fstests
depend too much on what applications return is not a new thing and the
breakage will happen once the user-facing error messages get updated as
they get the priority.

