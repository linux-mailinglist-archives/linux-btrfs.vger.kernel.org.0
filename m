Return-Path: <linux-btrfs+bounces-13496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F85AA0691
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 11:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D901B64D8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B08284694;
	Tue, 29 Apr 2025 09:03:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972F2BD5B3
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917389; cv=none; b=A2avgUlIZnR1ClsaGpZ+xZ4YpVkcHOdXwREQayFM7aj+Fb5xPZoGNuaGJYHYYgpdoevi/Tz+y08hfKqV5gUNcRFhkm7GG+DvzPcS8SLIClH1T90aBH6AFLanK/QrKHDLK8eojL9kwuI3VxluZQZSBlzSs2sewcnbmLKXfyT65w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917389; c=relaxed/simple;
	bh=F6iS2mwFYp/q8BKbeFfF6m6YjwNXICI4/bbfHAWBx9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aue2mOKDf+zaZXRwe16AAfrSfJOH24+Ng436IHh7ZltmpHpkBg9h7PM3l3MSEXTNgED9bST/Bjgz2YCfKKv1qUchYC7GMFGnY5Stlp4N9VpWesTBr7U6xsYpm/5pm0zDQ1eFXqrUywa76FbSlH4hQy7eB8mdkeSZZO/xWC8sZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBB74211CF;
	Tue, 29 Apr 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D701A1340C;
	Tue, 29 Apr 2025 09:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X09JNMmVEGi/EQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 09:03:05 +0000
Date: Tue, 29 Apr 2025 11:03:00 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: track current commit duration in commit_stats
Message-ID: <20250429090300.GB9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
 <20250429082711.GA9140@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429082711.GA9140@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: EBB74211CF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, Apr 29, 2025 at 10:27:11AM +0200, David Sterba wrote:
> On Thu, Apr 24, 2025 at 04:56:34PM -0700, Boris Burkov wrote:
> > When debugging/detecting outlier commit stalls, having an indicator that
> > we are currently in a long commit critical section can be very useful.
> > Extend the commit_stats sysfs file to also include the current commit
> > critical section duration.
> > 
> > Since this requires storing the last commit start time, use that rather
> > than a separate stack variable for storing the finished commit durations
> > as well.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/fs.h          |  2 ++
> >  fs/btrfs/sysfs.c       |  8 ++++++++
> >  fs/btrfs/transaction.c | 17 +++++++++--------
> >  3 files changed, 19 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index bcca43046064..1f375170cdcb 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -419,6 +419,8 @@ struct btrfs_commit_stats {
> >  	u64 last_commit_dur;
> >  	/* The total commit duration in ns */
> >  	u64 total_commit_dur;
> > +	/* Start of the last critical section in ns. */
> > +	u64 start_time;
> >  };
> >  
> >  struct btrfs_fs_info {
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index b9af74498b0c..4e35b4bfffaa 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1138,13 +1138,21 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> >  				       struct kobj_attribute *a, char *buf)
> >  {
> >  	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> > +	u64 now = ktime_get_ns();
> > +	u64 start_time = fs_info->commit_stats.start_time;
> > +	u64 pending = 0;
> > +
> > +	if (start_time)
> > +		pending = now - start_time;
> >  
> >  	return sysfs_emit(buf,
> >  		"commits %llu\n"
> > +		"cur_commit_ms %llu\n"
> >  		"last_commit_ms %llu\n"
> >  		"max_commit_ms %llu\n"
> >  		"total_commit_ms %llu\n",
> >  		fs_info->commit_stats.commit_count,
> > +		div_u64(pending, NSEC_PER_MSEC),
> >  		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
> >  		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
> >  		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 39e48bf610a1..02e6926d53bd 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -2164,13 +2164,19 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
> >  	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
> >  }
> >  
> > -static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t interval)
> > +static void update_commit_stats(struct btrfs_fs_info *fs_info)
> >  {
> > +	ktime_t now = ktime_get_ns();
> > +	ktime_t interval = now - fs_info->commit_stats.start_time;
> > +
> > +	ASSERT(fs_info->commit_stats.start_time);
> 
> [ 2469.533069] assertion failed: fs_info->commit_stats.start_time :: 0, in fs/btrfs/transaction.c:2172

Quite reliably (2/2) in btrfs/028 so I'll remove the patch from
for-next for now.

