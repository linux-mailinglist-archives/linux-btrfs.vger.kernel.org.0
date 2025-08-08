Return-Path: <linux-btrfs+bounces-15937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D7B1EC01
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656F916CB5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE036284B4C;
	Fri,  8 Aug 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ira1VJwB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mVu8vIHf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ira1VJwB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mVu8vIHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D82284B2E
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666642; cv=none; b=Cevzja0/LkVNk7aJxtpJd+UiUdkAqG7v4HKdYgU6PLAiai3sF+nzX6Z7x6qP5LgvesB8A3jQ3osM6ZReTJOTLa4XmNoAojsIEhaWNC7KkB7NF5Dfgqbs1mWA9W19zYdldhLfZacDdKrwqkMMy8i4ECOngNtrJ3NNYGJhfk+s/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666642; c=relaxed/simple;
	bh=FTJAxz/wgh4vtamnk5N6ApZLNVUFpxKD7+dX8Tbz0+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWkdY5XmwvCh0M1VXSMORTAnDL0aoZrWjlmlb8lvYHV+ldknyYQNjYYkKQFttLWuyoJR0RjckIJIh6zoyUSWjO9SpXO6JMrLtf5NpHqtdz+Yf7XuQrxHe0da0gGICXCCEOnGDZcHEzUfpZlc2AoZ3EUOpXEqFmiNNHpGHioM7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ira1VJwB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mVu8vIHf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ira1VJwB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mVu8vIHf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5238F5BE1E;
	Fri,  8 Aug 2025 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpq2WlcLajkKF1FDqRsCnZpSoQRX9LuJvY6yeyYWnr8=;
	b=Ira1VJwBi/HTaz13tdFmhu9lQcDYY3KmpDCddJrBXnvH2A3AmQBgXK6bNS8XL59KY01pYN
	b4ecOAJ6vgRB/+agPiHaAyrFEmFCEPtNL//ggS8IjdSAw6brqA9P/diu05DUETQrzn/K2m
	dRhbsDIWhmvSQgoOSnPf4G5VmnCP+Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpq2WlcLajkKF1FDqRsCnZpSoQRX9LuJvY6yeyYWnr8=;
	b=mVu8vIHff/6M/fjtc1HoH9gWiE9+YpnioiC67uvjFfIUtXORbaXN2XQMMsBvWX8u0rWCkE
	nF4K0tN3ZCN/aSCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ira1VJwB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mVu8vIHf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpq2WlcLajkKF1FDqRsCnZpSoQRX9LuJvY6yeyYWnr8=;
	b=Ira1VJwBi/HTaz13tdFmhu9lQcDYY3KmpDCddJrBXnvH2A3AmQBgXK6bNS8XL59KY01pYN
	b4ecOAJ6vgRB/+agPiHaAyrFEmFCEPtNL//ggS8IjdSAw6brqA9P/diu05DUETQrzn/K2m
	dRhbsDIWhmvSQgoOSnPf4G5VmnCP+Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpq2WlcLajkKF1FDqRsCnZpSoQRX9LuJvY6yeyYWnr8=;
	b=mVu8vIHff/6M/fjtc1HoH9gWiE9+YpnioiC67uvjFfIUtXORbaXN2XQMMsBvWX8u0rWCkE
	nF4K0tN3ZCN/aSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B9C13A7E;
	Fri,  8 Aug 2025 15:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PzBoCY4WlmgLQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 15:23:58 +0000
Date: Fri, 8 Aug 2025 17:23:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	Zoltan Racz <racz.zoli@gmail.com>
Subject: Re: [PATCH v2 1/6] btrfs-progs: fix the wrong size from
 device_get_partition_size_sysfs()
Message-ID: <20250808152356.GU6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1754455239.git.wqu@suse.com>
 <2fa034e287a0b7deb5a1b436915426a696a10e71.1754455239.git.wqu@suse.com>
 <479f6581-b2de-445d-92b8-d8c3e03d5af0@oracle.com>
 <984aeb4a-dd52-4b60-9c0b-cbb86d02c6e8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <984aeb4a-dd52-4b60-9c0b-cbb86d02c6e8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5238F5BE1E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71

On Fri, Aug 08, 2025 at 03:35:53PM +0930, Qu Wenruo wrote:
> 在 2025/8/8 15:17, Anand Jain 写道:
> > On 6/8/25 12:48, Qu Wenruo wrote:
> >> From: Zoltan Racz <racz.zoli@gmail.com>
> >>
> >> [BUG]
> >> When an unprivileged user, who can not access the block device, run
> >> "btrfs dev usage", it's very common to result the following incorrect
> >> output:
> >>
> >>    $ btrfs dev usage /mnt/btrfs/
> >>    WARNING: cannot read detailed chunk info, per-device usage will not 
> >> be shown, run as root
> >>    /dev/mapper/test-scratch1, ID: 1
> >>       Device size:            20.00MiB <<<
> >>       Device slack:           16.00EiB <<<
> >>       Unallocated:                 N/A
> >>
> >> Note if the unprivileged user has read access to the raw block file, it
> >> will work as expected:
> >>
> >>    $ btrfs dev usage /mnt/btrfs/
> >>    WARNING: cannot read detailed chunk info, per-device usage will not 
> >> be shown, run as root
> >>    /dev/mapper/test-scratch1, ID: 1
> >>       Device size:            10.00GiB
> >>       Device slack:              0.00B
> >>       Unallocated:                 N/A
> >>
> >> [CAUSE]
> >> When device_get_partition_size() is called, firstly the function checks
> >> if we can do a read-only open() on the block device.
> >>
> >> However under most distros, block devices are only accessible by root
> >> and "disk" group.
> >>
> >> If the unprivileged user is not in "disk" group, the open() will fail
> >> and we have to fallback to device_get_partition_size_sysfs() as the
> >> fallback.
> >>
> >> The function device_get_partition_size_sysfs() will use
> >> "/sys/block/<device>/size" as the size of the disk.
> >>
> >> But according to the kernel source code, the "size" attribute is
> >> implemented by returning bdev_nr_sectors(), and that result is always in
> >> sector unit (512 bytes).
> >>
> >> So if device_get_partition_size_sysfs() returns the value directly, it's
> >> 512 times smaller than the original size, causing errors.
> >>
> >> [FIX]
> >> Just do the proper left shift to return size in bytes.
> >>
> >> Issue: #979
> >> ---
> > 
> > SOB is missing.
> 
> For progs, SOB really depends on the author.
> It's recommended for long time contributors, but for new contributors 
> it's fine to skip the SOB.
> 
> Unless you mean my SOB, but in this particular case since the author 
> didn't provide SOB, I didn't want to have only my SOB.
> This will give an impression that I'm the only one contributing to the 
> patch.
> 
> Thus I didn't leave my SOB either.

It's a bit of a gray area. For kernel the SOB line has some meaning, in
progs it's been inherited but not manadatory.

Please still add your s-o-b if you're handling patch on somebody else's
behalf. This means that you have verified that the contribution is ok
from the project perspective. I used to add Author: tag, same as the
commit author but it seems redundant. If there's an issue or pull
request it's good to add it as well and that's what we can do for the
attribution.

