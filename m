Return-Path: <linux-btrfs+bounces-266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7F7F35CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED661C210E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76D51C20;
	Tue, 21 Nov 2023 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BC4Jt2OX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P6ZGPHQE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDAD76
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 10:16:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D75CD218EB;
	Tue, 21 Nov 2023 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700590560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4hluNgOFgQ4TZB9Mtav9msYneW5b8mfaz7D/NgHU8U=;
	b=BC4Jt2OXqsb2AIP5FkxZ7Yka+pSiaUFv+DHEZ53wm1k+oumw4E5mrT3pk2+A8qv5uSfzWX
	X8USsxaZFzEzAKD3irKTgiXb62iJcifjWyRtdpbpbTbt9XqvBc1uOc0BymaxetvBbLhl5D
	IsreQMKywLN4KLQHoIHUU0DBQ3D8wDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700590560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4hluNgOFgQ4TZB9Mtav9msYneW5b8mfaz7D/NgHU8U=;
	b=P6ZGPHQEgyilAuDUy9DmKnpsCHbIteZveaAY8AuoTPc1Jtv8EgwwaZ3dTyk1u0A3nO2LFK
	vPqBSEkC9hEi2pDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EE12139FD;
	Tue, 21 Nov 2023 18:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VqhNJeDzXGX6SAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 18:16:00 +0000
Date: Tue, 21 Nov 2023 19:08:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
Message-ID: <20231121180851.GT11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700573313.git.fdmanana@suse.com>
 <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
 <20231121151933.GR11264@twin.jikos.cz>
 <CAL3q7H6sb+N86AFiSuK1+qJU0LGBSGRM0LXHmdPGW_Ff5AMUyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6sb+N86AFiSuK1+qJU0LGBSGRM0LXHmdPGW_Ff5AMUyg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.05
X-Spamd-Result: default: False [-1.05 / 50.00];
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
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.05%]

On Tue, Nov 21, 2023 at 04:50:07PM +0000, Filipe Manana wrote:
> On Tue, Nov 21, 2023 at 3:26 PM David Sterba <dsterba@suse.cz> wrote:
> > On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >  fs/btrfs/disk-io.c                |   7 +-
> > >  fs/btrfs/extent_map.c             |  46 ---
> > >  fs/btrfs/extent_map.h             |   4 -
> > >  fs/btrfs/fs.h                     |   3 +-
> > >  fs/btrfs/inode.c                  |  25 +-
> > >  fs/btrfs/raid56.h                 |   2 +-
> > >  fs/btrfs/scrub.c                  |  39 +--
> > >  fs/btrfs/tests/btrfs-tests.c      |   3 +-
> > >  fs/btrfs/tests/btrfs-tests.h      |   1 +
> > >  fs/btrfs/tests/extent-map-tests.c |  40 +--
> > >  fs/btrfs/volumes.c                | 540 ++++++++++++++++++------------
> > >  fs/btrfs/volumes.h                |  45 ++-
> > >  fs/btrfs/zoned.c                  |  24 +-
> >
> > I see a lot of errors when compiling zoned.c, there are still map_lookup
> > structures. Do you have the zoned mode config option enabled?
> 
> It misses this hunk:   https://pastebin.com/raw/mr1KMZ8N
> 
> Do you want me to send a v2, or do you prefer to fix it up?

Simple enough to apply, no need to resend, thanks.

