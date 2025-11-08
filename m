Return-Path: <linux-btrfs+bounces-18814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA0C4364F
	for <lists+linux-btrfs@lfdr.de>; Sun, 09 Nov 2025 00:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97773B11C0
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Nov 2025 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8780273D77;
	Sat,  8 Nov 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P/3GL1yv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P/3GL1yv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404C19F137
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Nov 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643802; cv=none; b=T5mcEGG67WdhunNysQp9W4KqcTlNk9ZOHAEf3XaPIdWtH9kc9yRAos4ky7vHndyBXSTdJxc9a929aYhKOuziUIwHNZFAn0NXzVGpZc07VVb2JQW3fZ/1xqeUCPW65eVMALZzBTnDzwIOawJyViAz0O1R1ZV1LoTfCNkOOwYPeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643802; c=relaxed/simple;
	bh=D54bJKUOja/EmQtUZpFMefzmhURRwxzspq/cf5Yq0fs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iSnX2T1ZgXwrP26xwPR2SjyIK6utQnEcpfcQ1UHYYY6SJCV6jFHF0w0JhpV0Ji0N9CMESmDPLdvMTpHJevSAK4aML/T575IN+VAB/d07qVZ8IvFoEyQYJyBcYgVpoVYs7E3jZkBMT8E+hLO52nk7rINC4Qe/l165xqavCBWqvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P/3GL1yv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P/3GL1yv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38A3D33745
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Nov 2025 23:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762643793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5yddKKOvpY1bO25R+2cz3abcfHfnl3hlVR8jlWyeMY=;
	b=P/3GL1yv+jj7FpAhN2z5XpsdJtyZXYn9Aex+6zl9uixv1rVUk0TrXDKVx8zEkXrei7fef7
	F7NRQu0jddZ0bgUM5oJ0Zcc0otiSuzL72EqeJRkpYsEwZIsDR3srY/jGdPcFNTsAxpgHt5
	oecB4gPs9vf28Cq2OOsv18/39WUF9vU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="P/3GL1yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762643793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5yddKKOvpY1bO25R+2cz3abcfHfnl3hlVR8jlWyeMY=;
	b=P/3GL1yv+jj7FpAhN2z5XpsdJtyZXYn9Aex+6zl9uixv1rVUk0TrXDKVx8zEkXrei7fef7
	F7NRQu0jddZ0bgUM5oJ0Zcc0otiSuzL72EqeJRkpYsEwZIsDR3srY/jGdPcFNTsAxpgHt5
	oecB4gPs9vf28Cq2OOsv18/39WUF9vU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C1B4132DD
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Nov 2025 23:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fEGxA1HPD2kJLQAAD6G6ig
	(envelope-from <gabriel.niebler@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Nov 2025 23:16:33 +0000
Message-ID: <94f6f9ea-d65f-49db-9a20-a08cacdee7e7@suse.com>
Date: Sun, 9 Nov 2025 00:16:32 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Gabriel Niebler <gabriel.niebler@suse.com>
Subject: How to fix btrfs in inconsistent state after temp. disk removal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 38A3D33745
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:url,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

I have a btrfs configured as raid1 on top of several device-mapped LUKS volumes, which live on full HDDs.

There used to be 4 devices. Then I added a fifth disk, wiped and LUKS-encrypted it, unlocked and added it to the filesystem.

While the balance was running, one of the original four disks was disconnected from the system. To my surprise, the device file for the LUKS volume on that disk was not removed. So btrfs didn't notice anything and the balance finished "successfully".

The filesystem now has this structure:

# btrfs filesystem show /mnt2/Main
Label: 'Main'  uuid: 6a40d64e-ff83-4f08-a5b2-1236dd4add01
         Total devices 5 FS bytes used 8.69TiB
         devid    1 size 5.46TiB used 3.49TiB path /dev/mapper/luks-b52cf99d-e8f4-4193-9fe0-694ce5b2b6d7
         devid    2 size 5.46TiB used 3.49TiB path /dev/mapper/luks-06f1927d-7ace-4e73-ab1f-efa06970318b
         devid    3 size 5.46TiB used 3.49TiB path /dev/mapper/luks-e35e3681-c01d-44aa-9305-a5171f6da24f
         devid    4 size 5.46TiB used 3.49TiB path /dev/mapper/luks-d3295051-2128-4282-98ec-d138622a8c09
         devid    5 size 5.46TiB used 3.49TiB path /dev/mapper/luks-b3956446-40bd-4546-a103-0b12ba71a9e6

But obviously, one of the devices, luks-06f1927d-7ace-4e73-ab1f-efa06970318b, is not really there and btrfs can neither read from nor write to it.

This can be seen from the device stats:

# btrfs device stats -T /mnt2/Main
Id Path                                                  Write errors Read errors Flush errors Corruption errors Generation errors
-- ----------------------------------------------------- ------------ ----------- ------------ ----------------- -----------------
  1 /dev/mapper/luks-b52cf99d-e8f4-4193-9fe0-694ce5b2b6d7            0           0            0                 0                 0
  2 /dev/mapper/luks-06f1927d-7ace-4e73-ab1f-efa06970318b    175662803   116845708            0                 0                 0
  3 /dev/mapper/luks-e35e3681-c01d-44aa-9305-a5171f6da24f            0           0            0                 0                 0
  4 /dev/mapper/luks-d3295051-2128-4282-98ec-d138622a8c09            0           0            0                 0                 0
  5 /dev/mapper/luks-b3956446-40bd-4546-a103-0b12ba71a9e6            0           0            0                 0                 0

The underlying disk has been reconnected, but I have not unlocked the LUKS volume, because it is bound to be in an inconsistent state.

My question is how this can best be fixed.

I got the advice on the openSUSE forums to wipe the disk an re-encrypt it, creating a fresh new LUKS volume (with a different UUID) and run btrfs replace with the old, fault device as source and the new one as target.

It seems like that should work, but is it the best way to go about it? Or would you recommend something else?

Best,
gabe

-- 
Gabriel Niebler (he/him/his)
Senior Full-Stack Web Developer
gabriel.niebler@suse.com

SUSE Software Solutions Germany GmbH
Frankenstr. 146
90461 Nuernberg
Germany
www.suse.com

#ThePowerOfMany #HaveALotOfFun


