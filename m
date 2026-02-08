Return-Path: <linux-btrfs+bounces-21510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d+mmDU4PiWnG1wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21510-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 23:33:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545C10A748
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 23:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0EEC30073D9
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3D37B40E;
	Sun,  8 Feb 2026 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta1qeBih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897E35E53E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770590022; cv=none; b=NaqKr/OFxreryiSWaD6rt73uEEKO9P1EZLlxi7kYjevWh0+0ns8Yq763UkkbUwHAMHd2U67H3rQfGTk/qPwI2MKQo3SrLzR0NAFe/jJKPx0lOeHAk5W/Qk+1d2jLJDWcvYLlM5iJxVfM/C/Jhixk3b1shtLlDumgKXJh+7kLo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770590022; c=relaxed/simple;
	bh=O56LrsmdJ+4cClzr6pGT2xUb8+ZIeP5/edXYJSYYAzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JqxFqpoZdi2BRzT9YBJHXfCHAkYJfkgBSefpw2g/hJ80ZpqF9+vFa79f1JKxZ04jcsctJxqVByLFHpzUsh2YJcWy9U+gEI1u4GlUEqIYeiNz9fY8I6tUXghERV/QhaWZjgvrtyMRhxckqHjFmyICfNgIGmd4I7VGQ1dUu21fdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta1qeBih; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso6950665e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770590020; x=1771194820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zp5vvK7sYLi/fobYWvN6nBALHwZtx2dynJcr2u92/7w=;
        b=Ta1qeBihNPYMA0HInNHyv31wbg0woDkiERHrzimFvaP3zGH/INnDU23GS4rEk+wOqV
         4/R8tW9TASyHIDD0SQqnttrnwA40qUrSA0CrGgdrrD6QAlxohQjpYwuq2YzJ4y2D28Mh
         gr9q5FkqFUaNn+6VViAQq5O6Sg0oeHOTp0QYNhj9Gl1/R4Qbn2HAK7xe/ImYViNtpf6E
         E8w56jeKww2aeWCzsYBOmgImDdwGkeXb/NpT+BihiS5HS66XC4bqLULuSPxEaJ9+lY9C
         N2ZvLXG2Hhzyr33345DWhd0HKlc+cP4lGutE+8nXLbBBsLgo3j9nVim9wy1tH6e66c5L
         0tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770590020; x=1771194820;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp5vvK7sYLi/fobYWvN6nBALHwZtx2dynJcr2u92/7w=;
        b=hzzuvoWIyKaVKRb6Z/rZ6CbNU73Y8Ytsz2JudKP3UqP7j9H5HGvyAPC6foFY9SvQPd
         tDUgj9jCYMb/XakQZwR1tpSDIP0/PWY28WlPqhoR+pC62IEGlN4dXui/H/jcYj4MYeZk
         RK3hYTp1muXtJZ52K4L0aijY4iIQp9MMtLvsXqnV7Fv3e8FrqI7jWHu7tYAghybrkpJv
         eUPKoPYFgfnee6D/Sf/nTAqYysl3k3g2CbNJYk12lC5J4Pc+t/Jlpk2kuP5aHs3dCSXH
         JYE0ti9HbH2/xzIFlA2RshsL/F80B1qHJhHovbtir1t54ZfrxBoMFTTCltz85SC/AfUb
         Xbug==
X-Gm-Message-State: AOJu0YwX6NhwYiNXm0eCCMj6hN8Tmwzu0TW5+39UBlbsYiLGzcR78aK/
	MfqsI5OewMgObuPxsQV+/qaoGFSc5K+aMuVaE6pl1rumaykFQigIX9Ft9kEpog==
X-Gm-Gg: AZuq6aLB4TZDwwS/lDKwoncbmSmIZTySfHrXujzsQLzdZL7ewpmnL7yvfCdM69wdRIr
	5ljbJyDvlHaNYR3SEI7PyPmS5t7QhaWUB+8W7aJsFnxcrB7BNJHMTwmapRIIy/5QlZERRcBccc1
	hRrUxs0CRBjDQnanuzouLrEcyxayLvYSbFHn5XHMQgNMKOx1gze/xKjQdUt9d5znDTdZBhxGnIW
	RW6FvQyhMyQJ6zR/E/xW3dDn/jZqckQvPvdiYs1pJ1M0P2p6ib9sKUIW6mEum7Lf72BUPN+/TkZ
	yH/Ur0+Vqj0MNDT7TlCDccVPU9uQw/uzFTBytvpiesRu+px41Tet1WvjooxmzbnG/1KMohHVlpQ
	AyntrKvUqYFH4zpAgaSHqqndWzK0t6hjURHdOsgk5K5TTukH5aq3At99ifmxIFd0NUt05EHbpaZ
	42B2j2PlsYlg6biOtlzr6p3KqgVOvRSAJWf4QIbKup+p2+pIMNhWL6tdTnvbfV
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr132200875e9.14.1770590019715;
        Sun, 08 Feb 2026 14:33:39 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1978:7401:8935:e471:7003:e5cc? ([2a0a:ef40:1978:7401:8935:e471:7003:e5cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203f529bsm80365765e9.4.2026.02.08.14.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 14:33:39 -0800 (PST)
Message-ID: <ace58685-2d84-4f84-a88f-d4a0358ff316@gmail.com>
Date: Sun, 8 Feb 2026 22:33:38 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [BUG] btrfs_commit_transaction error -11 on ZONED device
From: Qiyu Yan <yanqiyu01@gmail.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0c33ef9a-24b1-43a6-9f93-72249b1cceac@gmail.com>
 <5c1a41f2-e8fc-417e-87a0-debca44b56ec@gmail.com>
 <8da0df04-0dfb-4eb8-a3af-4f06a0eba01f@gmail.com>
Content-Language: en-US
Autocrypt: addr=yanqiyu01@gmail.com; keydata=
 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
 0/GqXYttz/srV15jCiDuGPfZQbeDq0BQ3sM=
In-Reply-To: <8da0df04-0dfb-4eb8-a3af-4f06a0eba01f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21510-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanqiyu01@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9545C10A748
X-Rspamd-Action: no action

Those errors in vm seems to be due to configuration issue, but after 
those test, the filesystem now mounts and can properly be written to on 
6.18.7-200.fc43.x86_64 host. I suspect the modification done during the 
test made some difference. And the issue is related to some modification 
between 6.17 - 6.17

A recap of the story:
  1. On 6.18.7-200.fc43.x86_64, I copy files to the zoned device, 
triggers -11 from btrfs_commit_transaction
  2. Unmount and re-mount rw, same error happens after leaving the 
system alone (both 6.18.7-200.fc43.x86_64 and git latest)
  3. Tried mount in vm with various version, 6.17 gets same result as 
host (6.18.7-200.fc43.x86_64), 6.16 mount and writes succeed, starting 
copying files in VM
  4. Write in VM failed, but might be related to the cache mode set in 
QEMU, I am seeing
             Buffer I/O error on dev sdg, logical block 1509206440, lost 
async page write
         on host.
  5. Confused, I mount again on the host, and now I can again, write to it.

Now doing more tests (the files on the filesystem have backup so I am 
not afraid of making it worse.

在 2026/2/8 21:54, Qiyu Yan 写道:
> failed with different reason after some writing
>
> [  624.632595] I/O error, dev vda, sector 0 op 0x1:(WRITE) flags 0x800 
> phys_seg 0 prio class 0
> [  624.642790] BTRFS error (device vda): bdev /dev/vda errs: wr 0, rd 
> 0, flush 1, corrupt 0, gen 0
> [  624.645172] BTRFS warning (device vda): chunk 536870912 missing 1 
> devices, max tolerance is 0 for writable mount
> [  624.645189] BTRFS: error (device vda) in write_all_supers:4037: 
> errno=-5 IO failure (errors while submitting device barriers.)
> [  624.648010] BTRFS info (device vda state E): forced readonly
> [  624.648016] BTRFS warning (device vda state E): Skipping commit of 
> aborted transaction.
> [  624.648019] BTRFS error (device vda state EA): Transaction aborted 
> (error -5)
> [  624.649789] BTRFS: error (device vda state EA) in 
> cleanup_transaction:2021: errno=-5 IO failure
> [  626.360832] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3248 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.362794] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3249 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.364833] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3250 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.366758] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3251 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.370235] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3254 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.372178] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3255 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.374828] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3257 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.377104] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3258 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.379755] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3260 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
> [  626.382389] BTRFS error (device vda state EA): failed to run 
> delalloc range, root=257 ino=3262 folio=0 submit_bitmap=0 start=0 
> len=4096: -30
>
> cat /sys/fs/btrfs/02b4934e-9807-43d3-b28b-f9ca7d055391/commit_stats
> commits 5
> last_commit_ms 34011
> max_commit_ms 34011
> total_commit_ms 45217
>
> 在 2026/2/8 21:51, Qiyu Yan 写道:
>> The same issue did not happen with kernel 6.16 (mainline, I tried 
>> 6.17 and the issue happens), I tried to mount with the 6.16 kernel 
>> and can observe that at least one commit made it through
>>
>> cat /sys/fs/btrfs/02b4934e-9807-43d3-b28b-f9ca7d055391/commit_stats
>> commits 1
>> last_commit_ms 70
>> max_commit_ms 70
>> total_commit_ms 70
>>
>> And I am trying to copy file via rsync and check what happens. But 
>> anyway, this issue looks like a regression since 6.17
>


