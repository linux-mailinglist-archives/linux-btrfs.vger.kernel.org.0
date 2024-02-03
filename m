Return-Path: <linux-btrfs+bounces-2088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42786848918
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 23:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42E6284203
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AB16419;
	Sat,  3 Feb 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMxiCfNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQOGILAR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMxiCfNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQOGILAR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A360134C6;
	Sat,  3 Feb 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997859; cv=none; b=VovvFEYmYbkKvd3vXc8IoIBmh7B4ON6uoI2jpUnBejLLVvnailajiPn8vyr3lP4TZqUjL1gN+4VPMzMhQOVqKEUMYnjMJCxJID3/vns/1/QK4YXSgjfYANPCCV7z1Jgsva8vVH8kSCnhk3WFb395A7J631YR+Z1oOeaNrTkMsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997859; c=relaxed/simple;
	bh=4oNJDfxh60asCYceTHnZ+3VxEbkaJ68cGNVxuKB1nZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfaQmUxJNmLeuR/ZkLlYbMbM8QE3BzD37wQFIcvKNhY9Kjt77uKE+C1wa9S0fA5aS35+NHZLyEa0uJcy/NBZ/+I1O9YXqGub0u200d/cesV+bntWIvb2RIBDKFvOnHvz7+wPzzfAv4NDQzOrwx5gaa3SIQ6ajgIwI3bfzJw2Bmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMxiCfNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQOGILAR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMxiCfNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQOGILAR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75FE621D58;
	Sat,  3 Feb 2024 22:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706997854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBP6rxsvCRGoqNDs3If3+DWyofv58n0zrUDxNRyJ2QA=;
	b=KMxiCfNBGDQ0KFkkd/hPqGhVI6AwK+pOSGKG0BPm2HjuBl/mPwviLKdEVQoP7cyRSs1VEH
	RKJtLdkdfaXNEJ07C89U8wdkRKSm+MCC+Pjh6DgfUA95n0J/Nehn1iIAVlZfsNFOleZkHp
	FaG78tS4ms5SUe198XxdUHXp4fPZ3UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706997854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBP6rxsvCRGoqNDs3If3+DWyofv58n0zrUDxNRyJ2QA=;
	b=kQOGILAR7b0NkZBOyQO7+HgAGAELb7WFLHpWhDNq4/ZH1TG1jfu4ITcOVjs+StPutHVNrd
	dcBwvsd1A0grT5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706997854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBP6rxsvCRGoqNDs3If3+DWyofv58n0zrUDxNRyJ2QA=;
	b=KMxiCfNBGDQ0KFkkd/hPqGhVI6AwK+pOSGKG0BPm2HjuBl/mPwviLKdEVQoP7cyRSs1VEH
	RKJtLdkdfaXNEJ07C89U8wdkRKSm+MCC+Pjh6DgfUA95n0J/Nehn1iIAVlZfsNFOleZkHp
	FaG78tS4ms5SUe198XxdUHXp4fPZ3UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706997854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBP6rxsvCRGoqNDs3If3+DWyofv58n0zrUDxNRyJ2QA=;
	b=kQOGILAR7b0NkZBOyQO7+HgAGAELb7WFLHpWhDNq4/ZH1TG1jfu4ITcOVjs+StPutHVNrd
	dcBwvsd1A0grT5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ECF1137FD;
	Sat,  3 Feb 2024 22:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2zEHE164vmXLCQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 03 Feb 2024 22:04:14 +0000
Date: Sat, 3 Feb 2024 23:03:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Anand Jain <anand.jain@oracle.com>, Alex Romosan <aromosan@gmail.com>,
	CHECK_1234543212345@protonmail.com, brauner@kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	dsterba@suse.cz
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Message-ID: <20240203220346.GA355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz>
 <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[oracle.com,gmail.com,protonmail.com,kernel.org,vger.kernel.org,fb.com,toxicpanda.com,suse.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.53%]
X-Spam-Flag: NO

On Thu, Feb 01, 2024 at 11:25:28AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Anand, what's the status wrt to below issue (which afaics seems to
> affect quite a few people)? Things look stalled, but I might be missing
> something, that's why I ask for a quick update.

Yeah it's affecting people and not stalled but we ran out of ideas.

I'll present the latest fix that works for me (similar setup as the
reporter), though not everybody may like it:

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2360,6 +2360,7 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
        struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
+       char real[4096] = { "/dev/" };
 
        /*
         * There should be always a valid pointer in latest_dev, it may be stale
@@ -2367,7 +2368,8 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
         * the end of RCU grace period.
         */
        rcu_read_lock();
-       seq_escape(m, btrfs_dev_name(fs_info->fs_devices->latest_dev), " \t\n\\");
+       scnprintf(real + 5, sizeof(real) - 5, "%pg", fs_info->fs_devices->latest_dev->bdev);
+       seq_puts(m, real);
        rcu_read_unlock();
 
        return 0;
---

The problem that was reported was a discrepancy in what show_devname
returned (/proc/self/mountinfo) and what eg. mount showed. Both resolve
the device name in a different way. The problem is that mountinfo relies
on what btrfs remembers as the device path that was passed during
scanning && at the mount time. Since then it's not updated due to
changes done in 6.7 for temp_fsid (single devices don't have any cached
representation of the device, so the new path is basically forgotten).

What the fix does: print the path of the same block device but not the
cached (possibly stale) value.

