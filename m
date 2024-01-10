Return-Path: <linux-btrfs+bounces-1364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED41829D97
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7961F273F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32B4C3AE;
	Wed, 10 Jan 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XC5Q+n1u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dQZmjrps";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c78yBY5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6Jp9edK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AC1D683
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 703A81F8BE;
	Wed, 10 Jan 2024 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704900771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CHiPt37nxsxJzlClB0CcH36DK5z4Td11jWvEUdsf/U=;
	b=XC5Q+n1uZLdRLN58UXqsLLAsTBTX/kx2an1Ygb+GkewP8W6mjIgH92olA2++dot4lOqE3t
	XoA9Y8TjtYxWkd63/Eatq9swevvPuVUPgSliN6TYv8XDul0MDJxwCO5tdaPKhhXgXNSeZS
	ieFyCccqzke78E4YWnqQryMkqjySg5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704900771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CHiPt37nxsxJzlClB0CcH36DK5z4Td11jWvEUdsf/U=;
	b=dQZmjrpssPkrcrFF74QJ/lyCfkWZcSCrdmoPSavVAh2crCPIyRJNmt04b5lcX1sYjEkyux
	UiWSrujPDylyAfDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704900769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CHiPt37nxsxJzlClB0CcH36DK5z4Td11jWvEUdsf/U=;
	b=c78yBY5HJQKdoikZTpSwB4WcwN7bdfPHBNS/ZTPI6PtjMPMYgmu1TfsZIqF6uDdbuYFqn7
	8CGHqrMh7bF90FdyHzCmlcYGRoTXG0NE6SI4rs9qvRS/CIyP5CaZxPKHRN4donwn/IoPLb
	5ETVKB0OzBN4vlkxMtQAhlDb67j1d5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704900769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CHiPt37nxsxJzlClB0CcH36DK5z4Td11jWvEUdsf/U=;
	b=X6Jp9edKIrXdvWTJi3KC5+VwMW/mQ3Y38S4LPr4us74TRoH+kb615BThr2o57AdU+H2rKj
	Y+lr/qmh1OaRwYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48D3313786;
	Wed, 10 Jan 2024 15:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qzGHEKG4nmW2cgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 15:32:49 +0000
Date: Wed, 10 Jan 2024 16:32:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 2/2] btrfs-progs: cli-tests: add test case for return
 value of "btrfs subvlume create"
Message-ID: <20240110153234.GV28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704855097.git.wqu@suse.com>
 <2df04d2266134948bdd6755b9dbeaf70f42908f3.1704855097.git.wqu@suse.com>
 <00ff505f-90db-4036-b8b5-a27dc6bcad14@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ff505f-90db-4036-b8b5-a27dc6bcad14@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c78yBY5H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X6Jp9edK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 703A81F8BE
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 05:27:17PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/10 13:23, Qu Wenruo wrote:
> > The test case would check if "btrfs subvolume create":
> > 
> > - Report error on an existing path
> > - Still report error if mulitple paths are given and one of them already
> >    exists
> > - For above case, still created a subvolume for the good parameter
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   .../025-subvolume-create-failures/test.sh     | 30 +++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >   create mode 100755 tests/cli-tests/025-subvolume-create-failures/test.sh
> > 
> > diff --git a/tests/cli-tests/025-subvolume-create-failures/test.sh b/tests/cli-tests/025-subvolume-create-failures/test.sh
> > new file mode 100755
> > index 000000000000..b268a069ba37
> > --- /dev/null
> > +++ b/tests/cli-tests/025-subvolume-create-failures/test.sh
> > @@ -0,0 +1,30 @@
> > +#!/bin/bash
> > +# Create subvolume failure cases to make sure the return value is correct
> > +
> > +source "$TEST_TOP/common" || exit
> > +
> > +setup_root_helper
> > +prepare_test_dev
> > +
> > +run_check_mkfs_test_dev
> > +run_check_mount_test_dev
> > +
> > +# Create one subvolume and one file as place holder for later subvolume
> > +# creation to fail.
> > +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
> > +run_check $SUDO_HELPER touch "$TEST_MNT/subv2"
> > +
> > +# Using existing path to create a subvolume must fail
> > +run_mustfail "should report error when target path already exists" \
> > +	$SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
> > +
> > +run_mustfail "should report error when target path already exists" \
> > +	$SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv2"
> > +
> > +# Using multiple subvolumes in one create go, the good one "subv3" should be
> > +# created
> > +run_mustfail "should report error when target path already exists" \
> > +	$SUDO_HELPER "$TOP/btrfs" subvolume create \
> > +	"$TEST_MNT/subv1" "$TEST_MNT/subv2" "$TEST_MNT/subv3"
> > +
> > +run_check $SUDO_HELPER stat "$TEST_MNT/subv3"
> 
> My bad, I forgot to unmount the test dev
> 
> David, mind to add the following line to clean it up?
> 
> run_check_umount_test_dev

Updated, thanks.

