Return-Path: <linux-btrfs+bounces-1363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB96829CC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 15:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372F61F24E8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3834B5DD;
	Wed, 10 Jan 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpTDEOJ6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xV5YMlIQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpTDEOJ6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xV5YMlIQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2574B5C3;
	Wed, 10 Jan 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C46AD21D9D;
	Wed, 10 Jan 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704897894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC8zfz/Zwa3NkgOgPIMKEffZwfLAu4VG7cxo5rHi9TA=;
	b=bpTDEOJ63wxQJJG9dqNcCv8Z5gnozlU8oDYjh8CWS8ho8DVXyc0yZiA0CVQGQbHuyndjYx
	+jZgZbbP20TLrr8Rj7qX9l1a0KxZAo9jR098WikQ6EhrxjNLfvLyvVMageB10iXvRbG5ye
	X4rIg8tKuk0qn2kjkmQCzO0mxwELgGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704897894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC8zfz/Zwa3NkgOgPIMKEffZwfLAu4VG7cxo5rHi9TA=;
	b=xV5YMlIQs46Kz09APbMCdUAhECqoTRQCjF0fBKAqhU4yePW30CiEDw45nhVJN0X8JSqNoA
	57p3dJej0XipNJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704897894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC8zfz/Zwa3NkgOgPIMKEffZwfLAu4VG7cxo5rHi9TA=;
	b=bpTDEOJ63wxQJJG9dqNcCv8Z5gnozlU8oDYjh8CWS8ho8DVXyc0yZiA0CVQGQbHuyndjYx
	+jZgZbbP20TLrr8Rj7qX9l1a0KxZAo9jR098WikQ6EhrxjNLfvLyvVMageB10iXvRbG5ye
	X4rIg8tKuk0qn2kjkmQCzO0mxwELgGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704897894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC8zfz/Zwa3NkgOgPIMKEffZwfLAu4VG7cxo5rHi9TA=;
	b=xV5YMlIQs46Kz09APbMCdUAhECqoTRQCjF0fBKAqhU4yePW30CiEDw45nhVJN0X8JSqNoA
	57p3dJej0XipNJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1AED1398A;
	Wed, 10 Jan 2024 14:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ApQJ2atnmUNJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 14:44:54 +0000
Date: Wed, 10 Jan 2024 15:44:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: defrag: reject unknown flags of
 btrfs_ioctl_defrag_range_args
Message-ID: <20240110144434.GU28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
 <20240110005428.GN28693@twin.jikos.cz>
 <CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Jan 10, 2024 at 11:43:39AM +0000, Filipe Manana wrote:
> On Wed, Jan 10, 2024 at 12:55 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jan 10, 2024 at 08:58:26AM +1030, Qu Wenruo wrote:
> > > Add extra sanity check for btrfs_ioctl_defrag_range_args::flags.
> > >
> > > This is not really to enhance fuzzing tests, but as a preparation for
> > > future expansion on btrfs_ioctl_defrag_range_args.
> > >
> > > In the future we're adding new members, allowing more fine tuning for
> > > btrfs defrag.
> > > Without the -ENONOTSUPP error, there would be no way to detect if the
> > > kernel supports those new defrag features.
> > >
> > > cc: stable@vger.kernel.org #4.14+
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Added to misc-next, thanks.
> >
> > > ---
> > >  fs/btrfs/ioctl.c           | 4 ++++
> > >  include/uapi/linux/btrfs.h | 2 ++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index a1743904202b..3a846b983b28 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -2608,6 +2608,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
> > >                               ret = -EFAULT;
> > >                               goto out;
> > >                       }
> > > +                     if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
> > > +                             ret = -EOPNOTSUPP;
> >
> > This should be EINVAL, this is for invalid parameter values or
> > combinations, EOPNOTSUPP would be for the whole ioctl as not supported.
> 
> I'm confused now.
> We return EOPNOTSUPP for a lot of ioctls when they are given an
> unknown flag, for example
> at btrfs_ioctl_scrub():
> 
> if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
>     ret = -EOPNOTSUPP;
>     goto out;
> }
> 
> Or at btrfs_ioctl_snap_create_v2():
> 
> if (vol_args->flags & ~BTRFS_SUBVOL_CREATE_ARGS_MASK) {
>    ret = -EOPNOTSUPP;
>    goto free_args;
> }
> 
> We also do similar for fallocate, at btrfs_fallocate():
> 
> if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>         FALLOC_FL_ZERO_RANGE))
>     return -EOPNOTSUPP;
> 
> I was under the expectation that EOPNOTSUPP is the correct thing to do
> in this patch.
> So what's different in this patch from those existing examples to
> justify EINVAL instead?

Seems that we indeed do EOPNOTSUPP for unsupported flags while EINVAL is
for invalid parameters, altough there's

btrfs_ioctl_send()

8113         if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
8114                 ret = -EINVAL;
8115                 goto out;
8116         }
8117

Either way it should be consistent, so the send flag check is a mistake.
I'll update the patch from Qu back to EOPNOTSUPP. Thanks.

