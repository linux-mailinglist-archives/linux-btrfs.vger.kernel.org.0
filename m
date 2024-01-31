Return-Path: <linux-btrfs+bounces-1967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CC8446E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C011C223AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132312FF77;
	Wed, 31 Jan 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P8qPXXRI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcJPgGwI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P8qPXXRI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcJPgGwI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A112C549
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724740; cv=none; b=ZS7Xz2sztvVvao4kGPYVvUGiWXr3Kic+wNUAiq9uqXfxHhdKuT+lN6DPh3lyB3A6kHhezElk2JDcaIYnn+y+3Jtnwh1oVZuipxb0/HBeJUlbIYcsxuot0DOaCgTirKMEUVy5dWi9LPSUAQKPVrIATpctY+Vm69W2zopUzycdcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724740; c=relaxed/simple;
	bh=W2oFtg2Mrth8V36nmVUFEvEYRYwMht1B6DxR74m2o98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iVgvLrjeZS41ItA3kmVKem4XMvBV2lAbyaNg9nYNXtosjzPyrk/aSU2mRv5n/MbAxKQlXWtLdt7zUNsSN9xtvSSEhzwdZ+NFLAUpAyCIQI6Mknjb+udshdV8kmabv0kGd/1nOZT7ECZY4KS8W2J2MrDgptuINy3nciN64G1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P8qPXXRI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcJPgGwI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P8qPXXRI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcJPgGwI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55A251FB8E;
	Wed, 31 Jan 2024 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLrwsok/Apczw8rbtiJB5NHVnOR+Sv0aBQPSopuMQVQ=;
	b=P8qPXXRI0gpykbsdPuYEPpmxWtxgpwNhTzNL2ZxrCJUaVpMrmf9KCmy4E8pqx60pfUsv88
	6Gr8ZC71cry3SN/qToONzgWDVIT10oSM5Ziv4tmWorVVDd8pnCVF5k1MzK/+wGw4EK9uX5
	KMlFZYfgeFJK4rk8pJFW6HLCqufUAuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLrwsok/Apczw8rbtiJB5NHVnOR+Sv0aBQPSopuMQVQ=;
	b=BcJPgGwI0x++NvJLmrhpKs9gqz8IlK/n38zi/yWR85f0c6k0PF/8NJWAbdFR1wchBWJeL4
	mUxXNqno2vTgrqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLrwsok/Apczw8rbtiJB5NHVnOR+Sv0aBQPSopuMQVQ=;
	b=P8qPXXRI0gpykbsdPuYEPpmxWtxgpwNhTzNL2ZxrCJUaVpMrmf9KCmy4E8pqx60pfUsv88
	6Gr8ZC71cry3SN/qToONzgWDVIT10oSM5Ziv4tmWorVVDd8pnCVF5k1MzK/+wGw4EK9uX5
	KMlFZYfgeFJK4rk8pJFW6HLCqufUAuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLrwsok/Apczw8rbtiJB5NHVnOR+Sv0aBQPSopuMQVQ=;
	b=BcJPgGwI0x++NvJLmrhpKs9gqz8IlK/n38zi/yWR85f0c6k0PF/8NJWAbdFR1wchBWJeL4
	mUxXNqno2vTgrqBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB7D139D9;
	Wed, 31 Jan 2024 18:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2TKeDoGNumVkIwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:12:17 +0000
Date: Wed, 31 Jan 2024 19:11:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Message-ID: <20240131181151.GM31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131071319.GH31555@twin.jikos.cz>
 <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
 <0ecad434-8a72-4528-aa1c-579a32044e1e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ecad434-8a72-4528-aa1c-579a32044e1e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Wed, Jan 31, 2024 at 07:04:19PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/31 18:37, Qu Wenruo wrote:
> >
> >
> > On 2024/1/31 17:43, David Sterba wrote:
> >> On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
> >>> [BUG]
> >>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
> >>> descriptors open during whole time"), there is still a bug report about
> >>> blkid failed to grab the FSID:
> >>>
> >>>   device=/dev/loop0
> >>>   fstype=btrfs
> >>>
> >>>   wipefs -a "$device"*
> >>>
> >>>   parted -s "$device" \
> >>>       mklabel gpt \
> >>>       mkpart '"EFI system partition"' fat32 1MiB 513MiB \
> >>>       set 1 esp on \
> >>>       mkpart '"root partition"' "$fstype" 513MiB 100%
> >>>
> >>>   udevadm settle
> >>>   partitions=($(lsblk -n -o path "$device"))
> >>>
> >>>   mkfs.fat -F 32 ${partitions[1]}
> >>>   mkfs."$fstype" ${partitions[2]}
> >>>   udevadm settle
> >>
> >> As mentioned in the issue 'udevadm lock <command>' can be used as a
> >> workaround until mkfs does the locking but we can also use that for
> >> testing, ie lock a device and then try mkfs.
> >
> > Indeed, that may be a cleaner way to solve the problem.
> >
> > Let me check if there is any API provided to do that, but still we will
> > need the same de-duplication check to prevent locking the same device
> > twice if we're making fs on all partition from the same disk.
> 
> Nope, the "udevadm lock" is just doing flock() on the target device,
> thus it's no difference than my implementation.

That was a misunderstanding, it's right to do just the flock() as it's
effectively what udevadm lock does and we don't need to add another
dependency.

What I meant:

udevadm lock --name=/dev/sdx sleep 20 &
mkfs.btrfs /dev/sdx

and expect mkfs to fail if it detects a locked device.

> The call chain looks like this:
> 
> udevadm-lock.c:
> lock_device()
> |- lock_generic(LOCK_BSD, LOCK_EX|LOCK_NB);
>     |- flock(fd, operation);
> 
> And the fd passed in is also the "wholedisk" fd, not the partition disk fd:
> 
> lock_main()
> |- find_devno()
>     |- path_get_whole_disk()
> 
> So in short, "udevadm lock" command is just doing:
> 
> - Convert the partition path to whole disk path
> - Make sure the whole disk is not yet locked
> - Then call flock() on it
>    There are some extra work like deadline, but it's not really
>    something we need to bother AFAIK.
> 
> And it also has the same de-duplication ability of my patch.
> Although udev is using binary search instead of my simpler but slower
> list based search.

That's all fine, thanks for double checking.

> Whether to utilize external "udevadm lock" command, or doing the same
> thing inside "mkfs.btrfs" is up to you to determine.
> 
> But at least, I'm doing the same thing as "udevadm lock".
> (Although this version has other problems, like using st_dev not
> st_rdev, and not properly making the parameter for
> btrfs_flock_one_device() const etc)

