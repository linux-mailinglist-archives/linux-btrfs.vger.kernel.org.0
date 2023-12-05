Return-Path: <linux-btrfs+bounces-678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8098061FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 23:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFA1C2110C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF73FE36;
	Tue,  5 Dec 2023 22:46:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F8196
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 14:46:02 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18DA51FBF1;
	Tue,  5 Dec 2023 22:46:00 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC96213924;
	Tue,  5 Dec 2023 22:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3HdGOSeob2V5FAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 22:45:59 +0000
Date: Tue, 5 Dec 2023 23:39:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] btrfs: free qgroup pertrans rsv on trans abort
Message-ID: <20231205223910.GR2751@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701464169.git.boris@bur.io>
 <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
 <20231205142732.GE2751@twin.jikos.cz>
 <ZW998EXZnj4OwDqJ@devvm9258.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW998EXZnj4OwDqJ@devvm9258.prn0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.35 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_NA(1.20)[suse.cz];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(1.16)[0.388];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: 9.35
X-Rspamd-Queue-Id: 18DA51FBF1

On Tue, Dec 05, 2023 at 11:45:52AM -0800, Boris Burkov wrote:
> On Tue, Dec 05, 2023 at 03:27:32PM +0100, David Sterba wrote:
> > On Fri, Dec 01, 2023 at 01:00:11PM -0800, Boris Burkov wrote:
> > > If we abort a transaction, we never run the code that frees the pertrans
> > > qgroup reservation. This results in warnings on unmount as that
> > > reservation has been leaked. The leak isn't a huge issue since the fs is
> > > read-only, but it's better to clean it up when we know we can/should. Do
> > > it during the cleanup_transaction step of aborting.
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++++
> > >  fs/btrfs/qgroup.c  |  5 +++--
> > >  2 files changed, 31 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 9317606017e2..a1f440cd6d45 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -4775,6 +4775,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
> > >  	}
> > >  }
> > >  
> > > +static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
> > > +{
> > > +	struct btrfs_root *gang[8];
> > > +	int i;
> > > +	int ret;
> > > +
> > > +	spin_lock(&fs_info->fs_roots_radix_lock);
> > > +	while (1) {
> > > +		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
> > > +						 (void **)gang, 0,
> > > +						 ARRAY_SIZE(gang),
> > > +						 0); // BTRFS_ROOT_TRANS_TAG
> > 
> > What does the comment mean?
> 
> Oops, I forgot about this. BTRFS_ROOT_TRANS_TAG is a #define in
> transaction.c, so it wasn't visible here in disk-io.c. I should move it
> to some header they both include. Based on the other stuff in there,
> btrfs/fs.h looks reasonable?

Maybe transaction.h

