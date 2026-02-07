Return-Path: <linux-btrfs+bounces-21455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDUAImKThmm6OwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21455-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 02:20:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6A10472F
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75426305A6CE
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B4258EDB;
	Sat,  7 Feb 2026 01:19:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BED23B62B
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427189; cv=pass; b=NuuYZ2no5iY53pkblhh+MhhWnTZoaFdubmk198GJtyJivtUFuQ+L6fWd5CNq7sAILPJR9V6Qs0FtqFURKy+kocyXk3WU9HaDcARICDH9YHX6TQ7U/q5KaQVu3N/GwG9oH7E7YQ4TXUBAznjgu3s2esqvBf7zB166rPhWBB8PqbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427189; c=relaxed/simple;
	bh=xiSoBuXmf9XzxW71qOb6rjMyzeMrKxBrqCjTw4boG7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzwH1hVfrnpkgZv+CSoGnAeqIE6Sk4XTq3CS9Rc8IE0W9Yrz1lpXs45T2qYdOJ8ACew7BW5uaX/2SWZLMy7RQSIPKU9QFTeDJzM/eByQr666qH8u05BnJ/bbZnhnVIbaBs57+gCe8eBj3UpUlQeuYtXJkzNknX67Ui6NDJJLzxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 521BC8A15E1;
	Sat, 07 Feb 2026 01:19:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-9.trex.outbound.svc.cluster.local [100.123.102.234])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 323E88A149E;
	Sat, 07 Feb 2026 01:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770427165;
	b=qQkXiNtL37tpV/vHaNwfBwpmzQNN+ZENHz0XxCWUBzkYt4TNirT2jfECGrslGWOugLdqBy
	H72BRy89+bZydQVPhmFzweekLg6edyAJlIji9W91bJtv/+dk7PXHlcicHeCFE2v/GSZjNG
	thrf7R8pwlwtFZSnVJOzKSwXANIUT7MFmV7gUuCnazgJTATimyKcqA32Cq6i+HXKs1MRLE
	aF2K2gXVMxM2OaRVFBAJwc/ruXqWNqSsCNVc1MSuRqkMR25ZKySLqCC5alrHu0veiWaSgL
	Id10Wkm74BLOuabJjRFUvgYCei5M9wv5dUQu0uHSDOFPA+AoDxe1Jkgxzl9UDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770427165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvrs3zlpUlHxy481xXJlHLher9JRz0yEk1JSG4zkrJs=;
	b=9TPLyxS9PZqtAbziAJJc8qJdbbEL5Wo6QMt1BNXs8jZq+rEy2AnsXHUKY6fkB+UF/rKLX4
	UVwvfjHgkA6fbafghUut37HteV7A0uIBukvMOnkfRbqaHj+nRRqYu7iL6iKHdh8NKNKypp
	EY8Ik6VKlzALNNx57UpAODxFCjZu6tIJb3TYkDUgxLYsINS9EetBI722lA0FutSa+6XDqB
	H5g+wIp9sobbEHXUDY7LiRJY+rL/Z1cXuuJvDfb9YxZzv1av7Q3tc6h1uTGAZc2hGtjrxR
	9qS3Yhr9PWvzfO3q/R9WvkmkQEwC/YOQ8NPIBbVpO7nQ9mP6O9fXmfOfwkMSIA==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-8qghm;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Eyes-Continue: 1687abab0eb6d647_1770427165201_2488817041
X-MC-Loop-Signature: 1770427165201:3275250368
X-MC-Ingress-Time: 1770427165200
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.102.234 (trex/7.1.3);
	Sat, 07 Feb 2026 01:19:25 +0000
Received: from [212.104.214.84] (port=43466 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1voWyp-00000009V5s-1h0q;
	Sat, 07 Feb 2026 01:19:22 +0000
Message-ID: <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Sat, 07 Feb 2026 02:19:19 +0100
In-Reply-To: <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
	 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
	 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
	 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
	 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
	 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
	 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
	 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
	 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
	 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
	 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
	 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21455-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scientia.org:mid]
X-Rspamd-Queue-Id: B3B6A10472F
X-Rspamd-Action: no action

On Fri, 2026-02-06 at 14:15 +1030, Qu Wenruo wrote:
> So it indeed means no changes to the space cache part.
> Then it's really weird now.

With a smaller fs (which contains less important data) that also
suffers from the issue (I guess all my filesystems do) I got this in
fsck:
   # btrfs check /dev/mapper/data-e ; echo $?
   Opening filesystem to check...
   Checking filesystem on /dev/mapper/data-e
   UUID: 1f346f85-af92-4025-8647-6d1ecb962bc1
   [1/8] checking log skipped (none written)
   [2/8] checking root items
   [3/8] checking extents
   [4/8] checking free space tree
   We have a space info key for a block group that doesn't exist
   [5/8] checking fs roots
   [6/8] checking only csums items (without verifying data)
   [7/8] checking root refs
   [8/8] checking quota groups skipped (not enabled on this FS)
   found 4950228389888 bytes used, error(s) found
   total csum bytes: 4815660532
   total tree bytes: 18992005120
   total fs tree bytes: 12893093888
   total extent tree bytes: 820494336
   btree space waste bytes: 2902119498
   file data blocks allocated: 14978660605952
    referenced 7649886547968
   1

I tried a few more things:

Frist:
- only -o clear_cache (which as per manpage should already rebuild the
  v2 tree, but apparently doesn't

Then:
- -o space_cache=3Dno,clear_cache
  =3D> also doesn't seem to clear the tree (when I mounted again, the
     "enabling free space tree" appeared)


Then I tried:
- btrfs check --clear-space-cache v2=20
  =3D> actually made the the "enabling free space tree" kernel log
     message no longer appear on the next mount
     (so I assume --clear-space-cache not only clears the cache but
     also disables it... Edit: or it's because nothing is printed for
     v1 cache?)
followed by:
- -o space_cache=3Dv2,clear_cache
  =3D> in order to get back the v2 tree, cause I assume after the
     --clear-space-cache v2 I really had no space cache at all.
  but the kernel log only printed:
    Feb 07 01:35:57 heisenberg kernel: BTRFS info (device dm-1): enabling f=
ree space tree
    Feb 07 01:35:57 heisenberg kernel: BTRFS info (device dm-1): force clea=
ring of disk cache
  i.e. no rebuilding message as you said would appear.

After that I did another real fsck:
   # btrfs check /dev/mapper/data-e ; echo $? ; beep
   Opening filesystem to check...
   Checking filesystem on /dev/mapper/data-e
   UUID: 1f346f85-af92-4025-8647-6d1ecb962bc1
   [1/8] checking log skipped (none written)
   [2/8] checking root items
   [3/8] checking extents
   [4/8] checking free space cache
   [5/8] checking fs roots
   [6/8] checking only csums items (without verifying data)
   [7/8] checking root refs
   [8/8] checking quota groups skipped (not enabled on this FS)
   found 4950226653184 bytes used, no error found
   total csum bytes: 4815660532
   total tree bytes: 18990268416
   total fs tree bytes: 12893093888
   total extent tree bytes: 820494336
   btree space waste bytes: 2901786702
   file data blocks allocated: 14978660605952
    referenced 7649886547968
   0


So... I'm a bit puzzled now...
a) it says now "free space cache" and isn't that v1? o.O
b) The
   - found 4950226653184 bytes used, no error found
   - total tree bytes: 18990268416
   - btree space waste bytes: 2901786702
   Is that because of the apparent switch from v2 to v1?
   Or got something broken?

It seem I cannot go back to v2 cache now...even after
  mount /data/e/ -o space_cache=3Dv2,clear_cache
which gives:
Feb 07 02:15:30 heisenberg kernel: BTRFS: device label data-e devid 1 trans=
id 12267 /dev/mapper/data-e (253:1) scanned by mount (20764)
Feb 07 02:15:30 heisenberg kernel: BTRFS info (device dm-1): first mount of=
 filesystem 1f346f85-af92-4025-8647-6d1ecb962bc1
Feb 07 02:15:30 heisenberg kernel: BTRFS info (device dm-1): using crc32c (=
crc32c-lib) checksum algorithm
Feb 07 02:15:45 heisenberg kernel: BTRFS info (device dm-1): enabling free =
space tree
Feb 07 02:15:45 heisenberg kernel: BTRFS info (device dm-1): force clearing=
 of disk cache
Feb 07 02:15:56 heisenberg kernel: BTRFS info (device dm-1): last unmount o=
f filesystem 1f346f85-af92-4025-8647-6d1ecb962bc1

Current state:
root@heisenberg:~# btrfs inspect-internal dump-super /dev/mapper/data-e=20
superblock: bytenr=3D65536, device=3D/dev/mapper/data-e
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xcfe69bb4 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			1f346f85-af92-4025-8647-6d1ecb962bc1
metadata_uuid		00000000-0000-0000-0000-000000000000
label			data-e
generation		12267
root			10491582857216
sys_array_size		129
chunk_root_generation	12265
root_level		1
chunk_root		26869760
chunk_root_level	1
log_root		0
log_root_transid (deprecated)	0
log_root_level		0
total_bytes		8000433553408
bytes_used		4950226653184
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	0
uuid_tree_generation	11253
dev_item.uuid		08616a39-ba1d-4b75-b525-bca63b34e4a8
dev_item.fsid		1f346f85-af92-4025-8647-6d1ecb962bc1 [match]
dev_item.type		0
dev_item.total_bytes	8000433553408
dev_item.bytes_used	5408466927616
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

root@heisenberg:~# btrfs inspect-internal dump-tree -t root /dev/mapper/dat=
a-e
btrfs-progs v6.17.1
root tree
node 10491582857216 level 1 items 2 free space 491 generation 12267 owner R=
OOT_TREE
node 10491582857216 flags 0x1(WRITTEN) backref revision 1
fs uuid 1f346f85-af92-4025-8647-6d1ecb962bc1
chunk uuid 6196926e-557c-47ec-8f80-2f41d435fcc1
	key (EXTENT_TREE ROOT_ITEM 0) block 10491582873600 gen 12267
	key (284 ROOT_BACKREF 5) block 10521605554176 gen 12214
leaf 10491582873600 items 49 free space 9669 generation 12267 owner ROOT_TR=
EE
leaf 10491582873600 flags 0x1(WRITTEN) backref revision 1
fs uuid 1f346f85-af92-4025-8647-6d1ecb962bc1
chunk uuid 6196926e-557c-47ec-8f80-2f41d435fcc1
	item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
		generation 12267 root_dirid 0 bytenr 10491582922752 byte_limit 0 bytes_us=
ed 820494336
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12267
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
		generation 12265 root_dirid 0 bytenr 447741952 byte_limit 0 bytes_used 45=
8752
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 1 generation_v2 12265
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
		index 0 namelen 7 name: default
	item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
		generation 12266 root_dirid 256 bytenr 446578688 byte_limit 0 bytes_used =
6471680
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 1 generation_v2 12266
		uuid 0426dfdb-b7fd-4cab-a7aa-4b770ba51058
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 12266 otransid 0 stransid 0 rtransid 0
		ctime 1770345814.603030878 (2026-02-06 03:43:34)
		otime 1669166038.0 (2022-11-23 02:13:58)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 4 key (FS_TREE ROOT_REF 258) itemoff 14919 itemsize 30
		root ref key dirid 181050 sequence 2 name 2022-11-25_1
	item 5 key (FS_TREE ROOT_REF 269) itemoff 14889 itemsize 30
		root ref key dirid 181050 sequence 10 name 2023-03-28_1
	item 6 key (FS_TREE ROOT_REF 281) itemoff 14859 itemsize 30
		root ref key dirid 181050 sequence 18 name 2023-08-28_1
	item 7 key (FS_TREE ROOT_REF 284) itemoff 14824 itemsize 35
		root ref key dirid 181050 sequence 21 name 2023-10-22_1_live
	item 8 key (FS_TREE ROOT_REF 289) itemoff 14789 itemsize 35
		root ref key dirid 181050 sequence 22 name 2023-11-29_1_live
	item 9 key (FS_TREE ROOT_REF 290) itemoff 14754 itemsize 35
		root ref key dirid 181050 sequence 23 name 2024-01-11_1_live
	item 10 key (FS_TREE ROOT_REF 291) itemoff 14719 itemsize 35
		root ref key dirid 181050 sequence 24 name 2024-02-10_1_live
	item 11 key (FS_TREE ROOT_REF 292) itemoff 14684 itemsize 35
		root ref key dirid 181050 sequence 25 name 2024-04-19_1_live
	item 12 key (FS_TREE ROOT_REF 293) itemoff 14654 itemsize 30
		root ref key dirid 181050 sequence 26 name 2024-05-22_1
	item 13 key (FS_TREE ROOT_REF 294) itemoff 14619 itemsize 35
		root ref key dirid 181050 sequence 27 name 2024-07-13_1_live
	item 14 key (FS_TREE ROOT_REF 295) itemoff 14584 itemsize 35
		root ref key dirid 181050 sequence 28 name 2024-08-02_1_live
	item 15 key (FS_TREE ROOT_REF 296) itemoff 14549 itemsize 35
		root ref key dirid 181050 sequence 29 name 2024-08-14_1_live
	item 16 key (FS_TREE ROOT_REF 297) itemoff 14514 itemsize 35
		root ref key dirid 181050 sequence 30 name 2024-08-22_3_live
	item 17 key (FS_TREE ROOT_REF 298) itemoff 14479 itemsize 35
		root ref key dirid 181050 sequence 31 name 2024-09-07_1_live
	item 18 key (FS_TREE ROOT_REF 299) itemoff 14457 itemsize 22
		root ref key dirid 256 sequence 9 name data
	item 19 key (FS_TREE ROOT_REF 300) itemoff 14422 itemsize 35
		root ref key dirid 181050 sequence 32 name 2024-10-22_1_live
	item 20 key (FS_TREE ROOT_REF 301) itemoff 14387 itemsize 35
		root ref key dirid 181050 sequence 33 name 2024-11-24_1_live
	item 21 key (FS_TREE ROOT_REF 302) itemoff 14352 itemsize 35
		root ref key dirid 181050 sequence 34 name 2024-12-21_1_live
	item 22 key (FS_TREE ROOT_REF 303) itemoff 14317 itemsize 35
		root ref key dirid 181050 sequence 35 name 2025-01-14_1_live
	item 23 key (FS_TREE ROOT_REF 304) itemoff 14282 itemsize 35
		root ref key dirid 181050 sequence 36 name 2025-01-20_1_live
	item 24 key (FS_TREE ROOT_REF 305) itemoff 14247 itemsize 35
		root ref key dirid 181050 sequence 37 name 2025-02-23_2_live
	item 25 key (FS_TREE ROOT_REF 306) itemoff 14212 itemsize 35
		root ref key dirid 181050 sequence 38 name 2025-03-16_1_live
	item 26 key (FS_TREE ROOT_REF 307) itemoff 14177 itemsize 35
		root ref key dirid 181050 sequence 39 name 2025-04-11_1_live
	item 27 key (FS_TREE ROOT_REF 308) itemoff 14142 itemsize 35
		root ref key dirid 181050 sequence 40 name 2025-04-27_1_live
	item 28 key (FS_TREE ROOT_REF 309) itemoff 14107 itemsize 35
		root ref key dirid 181050 sequence 41 name 2025-05-09_1_live
	item 29 key (FS_TREE ROOT_REF 310) itemoff 14072 itemsize 35
		root ref key dirid 181050 sequence 42 name 2025-05-18_1_live
	item 30 key (FS_TREE ROOT_REF 311) itemoff 14037 itemsize 35
		root ref key dirid 181050 sequence 43 name 2025-06-07_1_live
	item 31 key (FS_TREE ROOT_REF 312) itemoff 14002 itemsize 35
		root ref key dirid 181050 sequence 44 name 2025-07-27_1_live
	item 32 key (FS_TREE ROOT_REF 313) itemoff 13967 itemsize 35
		root ref key dirid 181050 sequence 45 name 2025-08-28_1_live
	item 33 key (FS_TREE ROOT_REF 314) itemoff 13932 itemsize 35
		root ref key dirid 181050 sequence 46 name 2025-09-05_1_live
	item 34 key (FS_TREE ROOT_REF 315) itemoff 13897 itemsize 35
		root ref key dirid 181050 sequence 47 name 2025-09-30_1_live
	item 35 key (FS_TREE ROOT_REF 316) itemoff 13862 itemsize 35
		root ref key dirid 181050 sequence 48 name 2025-11-03_1_live
	item 36 key (FS_TREE ROOT_REF 317) itemoff 13827 itemsize 35
		root ref key dirid 181050 sequence 49 name 2026-01-10_1_live
	item 37 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 13667 itemsize 160
		generation 3 transid 0 size 0 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 0 flags 0x0(none)
		atime 1669166039.0 (2022-11-23 02:13:59)
		ctime 1669166039.0 (2022-11-23 02:13:59)
		mtime 1669166039.0 (2022-11-23 02:13:59)
		otime 1669166039.0 (2022-11-23 02:13:59)
	item 38 key (ROOT_TREE_DIR INODE_REF 6) itemoff 13655 itemsize 12
		index 0 namelen 2 name: ..
	item 39 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 13618 itemsize 37
		location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
		transid 0 data_len 0 name_len 7
		name: default
	item 40 key (CSUM_TREE ROOT_ITEM 0) itemoff 13179 itemsize 439
		generation 12264 root_dirid 0 bytenr 102957056 byte_limit 0 bytes_used 52=
75500544
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 3 generation_v2 12264
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 41 key (UUID_TREE ROOT_ITEM 0) itemoff 12740 itemsize 439
		generation 12212 root_dirid 0 bytenr 10492531884032 byte_limit 0 bytes_us=
ed 16384
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 0 generation_v2 12212
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 42 key (258 ROOT_ITEM 0) itemoff 12301 itemsize 439
		generation 1254 root_dirid 256 bytenr 33210368 byte_limit 0 bytes_used 12=
55145472
		last_snapshot 1254 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 1254
		uuid 4475f931-57a1-cc4b-be12-469097a69c2a
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid dd4938ab-7692-8f48-84db-230779aef6b7
		ctransid 476 otransid 436 stransid 42506 rtransid 474
		ctime 1669417261.120548682 (2022-11-26 00:01:01)
		otime 1669412759.991539456 (2022-11-25 22:45:59)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1669417232.476973820 (2022-11-26 00:00:32)
	item 43 key (258 ROOT_BACKREF 5) itemoff 12271 itemsize 30
		root backref key dirid 181050 sequence 2 name 2022-11-25_1
	item 44 key (269 ROOT_ITEM 4828) itemoff 11832 itemsize 439
		generation 4835 root_dirid 256 bytenr 97468416 byte_limit 0 bytes_used 11=
03085568
		last_snapshot 4835 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 4835
		uuid b3adc0f6-caa5-bb48-9cb7-f385b51e0759
		parent_uuid 0c8f1208-203b-f841-a715-cb3aaf98ffdd
		received_uuid b5619830-21e2-0241-b492-72403cc1ada6
		ctransid 4833 otransid 4828 stransid 195315 rtransid 4831
		ctime 1680040359.271299647 (2023-03-28 23:52:39)
		otime 1680040211.625043933 (2023-03-28 23:50:11)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1680040318.567972706 (2023-03-28 23:51:58)
	item 45 key (269 ROOT_BACKREF 5) itemoff 11802 itemsize 30
		root backref key dirid 181050 sequence 10 name 2023-03-28_1
	item 46 key (281 ROOT_ITEM 8551) itemoff 11363 itemsize 439
		generation 8555 root_dirid 256 bytenr 2838577217536 byte_limit 0 bytes_us=
ed 1060388864
		last_snapshot 8555 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 8555
		uuid a28da772-4aa3-bc46-bc26-184bcd467688
		parent_uuid 7fe15ea9-8ce4-ad44-bad0-36b3a852a757
		received_uuid d01737a3-988c-d241-a301-a63bbf639e33
		ctransid 8553 otransid 8551 stransid 342695 rtransid 8552
		ctime 1693257299.284921657 (2023-08-28 23:14:59)
		otime 1693257194.150495183 (2023-08-28 23:13:14)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1693257238.270076048 (2023-08-28 23:13:58)
	item 47 key (281 ROOT_BACKREF 5) itemoff 11333 itemsize 30
		root backref key dirid 181050 sequence 18 name 2023-08-28_1
	item 48 key (284 ROOT_ITEM 9362) itemoff 10894 itemsize 439
		generation 10974 root_dirid 256 bytenr 5585959485440 byte_limit 0 bytes_u=
sed 1063043072
		last_snapshot 10974 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 10974
		uuid 390390e2-6e27-2b47-beab-20c90b11cfe5
		parent_uuid c1d88227-cdbe-0544-8460-66916c50d88f
		received_uuid 4ea20bd4-33ba-ed4c-9d09-08f69b825325
		ctransid 9371 otransid 9362 stransid 393039 rtransid 9368
		ctime 1697990824.260290979 (2023-10-22 18:07:04)
		otime 1697990394.603966780 (2023-10-22 17:59:54)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1697990765.697575667 (2023-10-22 18:06:05)
leaf 10521605554176 items 60 free space 581 generation 12214 owner ROOT_TRE=
E
leaf 10521605554176 flags 0x1(WRITTEN) backref revision 1
fs uuid 1f346f85-af92-4025-8647-6d1ecb962bc1
chunk uuid 6196926e-557c-47ec-8f80-2f41d435fcc1
	item 0 key (284 ROOT_BACKREF 5) itemoff 16248 itemsize 35
		root backref key dirid 181050 sequence 21 name 2023-10-22_1_live
	item 1 key (289 ROOT_ITEM 10974) itemoff 15809 itemsize 439
		generation 10986 root_dirid 256 bytenr 8027272773632 byte_limit 0 bytes_u=
sed 1089552384
		last_snapshot 10986 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 10986
		uuid af86fac2-e13e-364d-8e0c-a9b586288f7d
		parent_uuid 390390e2-6e27-2b47-beab-20c90b11cfe5
		received_uuid 9971aeab-b0ff-a240-8c9e-fc8b6df4450b
		ctransid 10984 otransid 10974 stransid 442097 rtransid 10982
		ctime 1701303295.792475019 (2023-11-30 01:14:55)
		otime 1701302074.458251120 (2023-11-30 00:54:34)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1701303258.632828916 (2023-11-30 01:14:18)
	item 2 key (289 ROOT_BACKREF 5) itemoff 15774 itemsize 35
		root backref key dirid 181050 sequence 22 name 2023-11-29_1_live
	item 3 key (290 ROOT_ITEM 10986) itemoff 15335 itemsize 439
		generation 11147 root_dirid 256 bytenr 30408704 byte_limit 0 bytes_used 1=
124057088
		last_snapshot 11147 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11147
		uuid d763b7c2-358f-3d42-901c-2aa93566b809
		parent_uuid af86fac2-e13e-364d-8e0c-a9b586288f7d
		received_uuid 83665abe-e231-c345-96fb-f43c5a9790b5
		ctransid 11003 otransid 10986 stransid 496155 rtransid 11000
		ctime 1704983696.700466711 (2024-01-11 15:34:56)
		otime 1704982746.519424331 (2024-01-11 15:19:06)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1704983659.157254433 (2024-01-11 15:34:19)
	item 4 key (290 ROOT_BACKREF 5) itemoff 15300 itemsize 35
		root backref key dirid 181050 sequence 23 name 2024-01-11_1_live
	item 5 key (291 ROOT_ITEM 11147) itemoff 14861 itemsize 439
		generation 11160 root_dirid 256 bytenr 30490624 byte_limit 0 bytes_used 1=
183809536
		last_snapshot 11160 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11160
		uuid 5a045669-c3e6-7f4e-a9cd-97ab129f326c
		parent_uuid d763b7c2-358f-3d42-901c-2aa93566b809
		received_uuid d08612b2-82c3-0a4a-84a7-de8e9c965c74
		ctransid 11158 otransid 11147 stransid 536794 rtransid 11156
		ctime 1707599767.237865245 (2024-02-10 22:16:07)
		otime 1707599014.123659576 (2024-02-10 22:03:34)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1707599728.821203799 (2024-02-10 22:15:28)
	item 6 key (291 ROOT_BACKREF 5) itemoff 14826 itemsize 35
		root backref key dirid 181050 sequence 24 name 2024-02-10_1_live
	item 7 key (292 ROOT_ITEM 11160) itemoff 14387 itemsize 439
		generation 11189 root_dirid 256 bytenr 30507008 byte_limit 0 bytes_used 1=
278623744
		last_snapshot 11189 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11189
		uuid 6d6ce3f9-3c50-474c-a131-0fe622f56f11
		parent_uuid 5a045669-c3e6-7f4e-a9cd-97ab129f326c
		received_uuid 1f1e6931-2e0a-8043-8c6e-9580108d3ac9
		ctransid 11187 otransid 11160 stransid 614024 rtransid 11186
		ctime 1713711505.771909122 (2024-04-21 16:58:25)
		otime 1713708665.35527408 (2024-04-21 16:11:05)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1713711457.11415209 (2024-04-21 16:57:37)
	item 8 key (292 ROOT_BACKREF 5) itemoff 14352 itemsize 35
		root backref key dirid 181050 sequence 25 name 2024-04-19_1_live
	item 9 key (293 ROOT_ITEM 11189) itemoff 13913 itemsize 439
		generation 11204 root_dirid 256 bytenr 37109760 byte_limit 0 bytes_used 1=
328463872
		last_snapshot 11204 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11204
		uuid fff8ef56-d290-9c40-9a16-0a65a8ea0c2f
		parent_uuid 6d6ce3f9-3c50-474c-a131-0fe622f56f11
		received_uuid 88f47c74-e45a-1346-9696-e2801ff0dc27
		ctransid 11201 otransid 11189 stransid 653464 rtransid 11199
		ctime 1716411882.801896586 (2024-05-22 23:04:42)
		otime 1716410840.345571094 (2024-05-22 22:47:20)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1716411815.817777895 (2024-05-22 23:03:35)
	item 10 key (293 ROOT_BACKREF 5) itemoff 13883 itemsize 30
		root backref key dirid 181050 sequence 26 name 2024-05-22_1
	item 11 key (294 ROOT_ITEM 11204) itemoff 13444 itemsize 439
		generation 11225 root_dirid 256 bytenr 30621696 byte_limit 0 bytes_used 1=
357643776
		last_snapshot 11225 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11225
		uuid 8d7cefc1-0e8d-5043-b3da-5549bac8e03b
		parent_uuid fff8ef56-d290-9c40-9a16-0a65a8ea0c2f
		received_uuid c75875e5-f958-c045-ba96-d6e63b823407
		ctransid 11223 otransid 11204 stransid 711152 rtransid 11221
		ctime 1720823316.581643970 (2024-07-13 00:28:36)
		otime 1720821806.490259055 (2024-07-13 00:03:26)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1720823277.810475699 (2024-07-13 00:27:57)
	item 12 key (294 ROOT_BACKREF 5) itemoff 13409 itemsize 35
		root backref key dirid 181050 sequence 27 name 2024-07-13_1_live
	item 13 key (295 ROOT_ITEM 11225) itemoff 12970 itemsize 439
		generation 11240 root_dirid 256 bytenr 35897344 byte_limit 0 bytes_used 1=
371340800
		last_snapshot 11240 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11240
		uuid 3aa680ae-39ff-2749-b2eb-485000dd8d9a
		parent_uuid 8d7cefc1-0e8d-5043-b3da-5549bac8e03b
		received_uuid 799e61ee-57bf-a243-bcfc-43421fdaf5f4
		ctransid 11238 otransid 11225 stransid 731767 rtransid 11235
		ctime 1722562774.105533577 (2024-08-02 03:39:34)
		otime 1722562125.370202076 (2024-08-02 03:28:45)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1722562730.614554577 (2024-08-02 03:38:50)
	item 14 key (295 ROOT_BACKREF 5) itemoff 12935 itemsize 35
		root backref key dirid 181050 sequence 28 name 2024-08-02_1_live
	item 15 key (296 ROOT_ITEM 11240) itemoff 12496 itemsize 439
		generation 11249 root_dirid 256 bytenr 30785536 byte_limit 0 bytes_used 1=
375420416
		last_snapshot 11249 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11249
		uuid 2955b5a8-1bb0-aa44-9640-fd322df8e6b9
		parent_uuid 3aa680ae-39ff-2749-b2eb-485000dd8d9a
		received_uuid 3899eff4-e4c2-6b43-82f3-0b9fff5f0e33
		ctransid 11247 otransid 11240 stransid 743201 rtransid 11244
		ctime 1723672478.312473413 (2024-08-14 23:54:38)
		otime 1723672181.987422090 (2024-08-14 23:49:41)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1723672425.167552737 (2024-08-14 23:53:45)
	item 16 key (296 ROOT_BACKREF 5) itemoff 12461 itemsize 35
		root backref key dirid 181050 sequence 29 name 2024-08-14_1_live
	item 17 key (297 ROOT_ITEM 11249) itemoff 12022 itemsize 439
		generation 11255 root_dirid 256 bytenr 30638080 byte_limit 0 bytes_used 1=
334853632
		last_snapshot 11255 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11255
		uuid 666d2f6c-cb17-914a-b63b-e989f9727744
		parent_uuid 2955b5a8-1bb0-aa44-9640-fd322df8e6b9
		received_uuid 98cda6a1-57d0-ae4d-8792-ab5d6a97bfc6
		ctransid 11252 otransid 11249 stransid 752535 rtransid 11251
		ctime 1724360404.935084633 (2024-08-22 23:00:04)
		otime 1724360240.743433742 (2024-08-22 22:57:20)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1724360352.830596200 (2024-08-22 22:59:12)
	item 18 key (297 ROOT_BACKREF 5) itemoff 11987 itemsize 35
		root backref key dirid 181050 sequence 30 name 2024-08-22_3_live
	item 19 key (298 ROOT_ITEM 11255) itemoff 11548 itemsize 439
		generation 11887 root_dirid 256 bytenr 30867456 byte_limit 0 bytes_used 1=
566113792
		last_snapshot 11887 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11887
		uuid b99deb79-fca9-a94d-bafb-f60509fddfa9
		parent_uuid 666d2f6c-cb17-914a-b63b-e989f9727744
		received_uuid 14cd4187-7ca3-fb4b-9a4f-3a564ba983de
		ctransid 11267 otransid 11255 stransid 769059 rtransid 11264
		ctime 1725727508.422960451 (2024-09-07 18:45:08)
		otime 1725726115.249233281 (2024-09-07 18:21:55)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1725727463.13738574 (2024-09-07 18:44:23)
	item 20 key (298 ROOT_BACKREF 5) itemoff 11513 itemsize 35
		root backref key dirid 181050 sequence 31 name 2024-09-07_1_live
	item 21 key (299 ROOT_ITEM 0) itemoff 11074 itemsize 439
		generation 11977 root_dirid 256 bytenr 6863598534656 byte_limit 0 bytes_u=
sed 58343424
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11977
		uuid 39e76b16-08b0-dc43-8f88-59fc5f0dcf44
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 11977 otransid 11297 stransid 0 rtransid 0
		ctime 1736813732.196888069 (2025-01-14 01:15:32)
		otime 1729261833.52283456 (2024-10-18 16:30:33)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 22 key (299 ROOT_BACKREF 5) itemoff 11052 itemsize 22
		root backref key dirid 256 sequence 9 name data
	item 23 key (300 ROOT_ITEM 11887) itemoff 10613 itemsize 439
		generation 11905 root_dirid 256 bytenr 30818304 byte_limit 0 bytes_used 1=
596915712
		last_snapshot 11905 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11905
		uuid f0720250-4bd4-5f45-ab0b-292872917769
		parent_uuid b99deb79-fca9-a94d-bafb-f60509fddfa9
		received_uuid b0dae321-8f29-2a40-819a-8c66340ebe0d
		ctransid 11904 otransid 11887 stransid 803143 rtransid 11902
		ctime 1729601895.557672431 (2024-10-22 14:58:15)
		otime 1729600815.208956725 (2024-10-22 14:40:15)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1729601862.707780060 (2024-10-22 14:57:42)
	item 24 key (300 ROOT_BACKREF 5) itemoff 10578 itemsize 35
		root backref key dirid 181050 sequence 32 name 2024-10-22_1_live
	item 25 key (301 ROOT_ITEM 11905) itemoff 10139 itemsize 439
		generation 11917 root_dirid 256 bytenr 32047104 byte_limit 0 bytes_used 1=
625456640
		last_snapshot 11917 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11917
		uuid 1ae7b240-f385-624e-ac7a-9effb2ff6ebd
		parent_uuid f0720250-4bd4-5f45-ab0b-292872917769
		received_uuid 52854293-e7ad-6144-8b0c-d747c435035c
		ctransid 11916 otransid 11905 stransid 844110 rtransid 11914
		ctime 1732407446.581779544 (2024-11-24 01:17:26)
		otime 1732406827.838922021 (2024-11-24 01:07:07)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1732407397.286418289 (2024-11-24 01:16:37)
	item 26 key (301 ROOT_BACKREF 5) itemoff 10104 itemsize 35
		root backref key dirid 181050 sequence 33 name 2024-11-24_1_live
	item 27 key (302 ROOT_ITEM 11917) itemoff 9665 itemsize 439
		generation 11973 root_dirid 256 bytenr 396476416 byte_limit 0 bytes_used =
1635565568
		last_snapshot 11973 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 11973
		uuid 374cb2fb-1345-f448-b68c-e678f82d4a83
		parent_uuid 1ae7b240-f385-624e-ac7a-9effb2ff6ebd
		received_uuid 5eb822eb-ed50-b846-b3b7-ee71680a870b
		ctransid 11927 otransid 11917 stransid 874501 rtransid 11925
		ctime 1734819246.267936179 (2024-12-21 23:14:06)
		otime 1734818457.270484582 (2024-12-21 23:00:57)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1734819212.182854836 (2024-12-21 23:13:32)
	item 28 key (302 ROOT_BACKREF 5) itemoff 9630 itemsize 35
		root backref key dirid 181050 sequence 34 name 2024-12-21_1_live
	item 29 key (303 ROOT_ITEM 11973) itemoff 9191 itemsize 439
		generation 12063 root_dirid 256 bytenr 32342016 byte_limit 0 bytes_used 1=
663008768
		last_snapshot 12063 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12063
		uuid b12cc9ba-c7da-5045-a6d4-5f69de9b59b6
		parent_uuid 374cb2fb-1345-f448-b68c-e678f82d4a83
		received_uuid 2bec8139-bb0b-7745-98e2-f5e2b44ffff6
		ctransid 11982 otransid 11973 stransid 899043 rtransid 11979
		ctime 1736814078.860057860 (2025-01-14 01:21:18)
		otime 1736813325.31015706 (2025-01-14 01:08:45)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1736814035.870082609 (2025-01-14 01:20:35)
	item 30 key (303 ROOT_BACKREF 5) itemoff 9156 itemsize 35
		root backref key dirid 181050 sequence 35 name 2025-01-14_1_live
	item 31 key (304 ROOT_ITEM 12063) itemoff 8717 itemsize 439
		generation 12069 root_dirid 256 bytenr 37093376 byte_limit 0 bytes_used 1=
671905280
		last_snapshot 12069 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12069
		uuid 5a0dbe49-3898-354b-a5f6-7bd8c72bd347
		parent_uuid b12cc9ba-c7da-5045-a6d4-5f69de9b59b6
		received_uuid f091c29b-c9ca-e143-a4dc-d97c1a9f4640
		ctransid 12068 otransid 12063 stransid 904819 rtransid 12066
		ctime 1737334320.714994089 (2025-01-20 01:52:00)
		otime 1737334070.901663483 (2025-01-20 01:47:50)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1737334292.768204788 (2025-01-20 01:51:32)
	item 32 key (304 ROOT_BACKREF 5) itemoff 8682 itemsize 35
		root backref key dirid 181050 sequence 36 name 2025-01-20_1_live
	item 33 key (305 ROOT_ITEM 12069) itemoff 8243 itemsize 439
		generation 12078 root_dirid 256 bytenr 33603584 byte_limit 0 bytes_used 1=
679589376
		last_snapshot 12078 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12078
		uuid c9948512-a1e6-c04d-b77b-347593fddf98
		parent_uuid 5a0dbe49-3898-354b-a5f6-7bd8c72bd347
		received_uuid df08f225-2c47-e14e-8d3a-e1b6958df9f5
		ctransid 12077 otransid 12069 stransid 936026 rtransid 12076
		ctime 1740331902.687866929 (2025-02-23 18:31:42)
		otime 1740331183.321789435 (2025-02-23 18:19:43)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1740331825.780664410 (2025-02-23 18:30:25)
	item 34 key (305 ROOT_BACKREF 5) itemoff 8208 itemsize 35
		root backref key dirid 181050 sequence 37 name 2025-02-23_2_live
	item 35 key (306 ROOT_ITEM 12078) itemoff 7769 itemsize 439
		generation 12087 root_dirid 256 bytenr 39436288 byte_limit 0 bytes_used 1=
772961792
		last_snapshot 12087 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12087
		uuid fac3800e-eb82-bf49-bf3e-3f383d31a493
		parent_uuid c9948512-a1e6-c04d-b77b-347593fddf98
		received_uuid 71a95349-dff9-1d44-912c-4b118a1faeae
		ctransid 12085 otransid 12078 stransid 959982 rtransid 12085
		ctime 1742100638.221162113 (2025-03-16 05:50:38)
		otime 1742100037.906943966 (2025-03-16 05:40:37)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1742100573.991532037 (2025-03-16 05:49:33)
	item 36 key (306 ROOT_BACKREF 5) itemoff 7734 itemsize 35
		root backref key dirid 181050 sequence 38 name 2025-03-16_1_live
	item 37 key (307 ROOT_ITEM 12087) itemoff 7295 itemsize 439
		generation 12095 root_dirid 256 bytenr 35061760 byte_limit 0 bytes_used 1=
677901824
		last_snapshot 12095 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12095
		uuid 01a0af83-fda3-9d4e-8fe3-fcf8ce8a6114
		parent_uuid fac3800e-eb82-bf49-bf3e-3f383d31a493
		received_uuid 62a31ba2-cd5c-404f-ae1d-9a38ad62aa25
		ctransid 12094 otransid 12087 stransid 986390 rtransid 12093
		ctime 1744329002.917772808 (2025-04-11 01:50:02)
		otime 1744328289.221313317 (2025-04-11 01:38:09)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1744328949.346275696 (2025-04-11 01:49:09)
	item 38 key (307 ROOT_BACKREF 5) itemoff 7260 itemsize 35
		root backref key dirid 181050 sequence 39 name 2025-04-11_1_live
	item 39 key (308 ROOT_ITEM 12095) itemoff 6821 itemsize 439
		generation 12105 root_dirid 256 bytenr 49676288 byte_limit 0 bytes_used 1=
687470080
		last_snapshot 12105 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12105
		uuid cb571e94-ff3c-2c4a-9404-278fdae7fd4f
		parent_uuid 01a0af83-fda3-9d4e-8fe3-fcf8ce8a6114
		received_uuid b50b1ae1-55f5-c74d-868e-47f495fa2329
		ctransid 12104 otransid 12095 stransid 995238 rtransid 12102
		ctime 1745717591.777941950 (2025-04-27 03:33:11)
		otime 1745717002.202782690 (2025-04-27 03:23:22)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1745717556.442982480 (2025-04-27 03:32:36)
	item 40 key (308 ROOT_BACKREF 5) itemoff 6786 itemsize 35
		root backref key dirid 181050 sequence 40 name 2025-04-27_1_live
	item 41 key (309 ROOT_ITEM 12105) itemoff 6347 itemsize 439
		generation 12111 root_dirid 256 bytenr 50036736 byte_limit 0 bytes_used 1=
685651456
		last_snapshot 12111 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12111
		uuid 826d6ee1-18eb-a142-b7f3-d26b077e59ef
		parent_uuid cb571e94-ff3c-2c4a-9404-278fdae7fd4f
		received_uuid ac7b5b54-fcb2-5041-8fb0-e4ca1c891a94
		ctransid 12110 otransid 12105 stransid 1005789 rtransid 12108
		ctime 1746747493.182081558 (2025-05-09 01:38:13)
		otime 1746747071.395580926 (2025-05-09 01:31:11)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1746747460.505601751 (2025-05-09 01:37:40)
	item 42 key (309 ROOT_BACKREF 5) itemoff 6312 itemsize 35
		root backref key dirid 181050 sequence 41 name 2025-05-09_1_live
	item 43 key (310 ROOT_ITEM 12111) itemoff 5873 itemsize 439
		generation 12123 root_dirid 256 bytenr 56524800 byte_limit 0 bytes_used 1=
710735360
		last_snapshot 12123 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12123
		uuid 585ae5ce-3f06-0149-8e82-66c42beebcbe
		parent_uuid 826d6ee1-18eb-a142-b7f3-d26b077e59ef
		received_uuid 0a51589a-91c0-4246-a4c3-38f79df02344
		ctransid 12122 otransid 12111 stransid 1015291 rtransid 12119
		ctime 1747602706.619716771 (2025-05-18 23:11:46)
		otime 1747602187.991054941 (2025-05-18 23:03:07)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1747602663.244124216 (2025-05-18 23:11:03)
	item 44 key (310 ROOT_BACKREF 5) itemoff 5838 itemsize 35
		root backref key dirid 181050 sequence 42 name 2025-05-18_1_live
	item 45 key (311 ROOT_ITEM 12123) itemoff 5399 itemsize 439
		generation 12134 root_dirid 256 bytenr 55574528 byte_limit 0 bytes_used 1=
867628544
		last_snapshot 12134 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12134
		uuid 6b0f0fe5-1364-6d46-895f-6bb7b313f88d
		parent_uuid 585ae5ce-3f06-0149-8e82-66c42beebcbe
		received_uuid 38acbd40-4a17-bb4b-a111-86b77a2e41b4
		ctransid 12133 otransid 12123 stransid 1032437 rtransid 12130
		ctime 1749263470.565612482 (2025-06-07 04:31:10)
		otime 1749262776.160901015 (2025-06-07 04:19:36)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1749263427.52384367 (2025-06-07 04:30:27)
	item 46 key (311 ROOT_BACKREF 5) itemoff 5364 itemsize 35
		root backref key dirid 181050 sequence 43 name 2025-06-07_1_live
	item 47 key (312 ROOT_ITEM 12134) itemoff 4925 itemsize 439
		generation 12143 root_dirid 256 bytenr 65486848 byte_limit 0 bytes_used 1=
867366400
		last_snapshot 12143 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12143
		uuid 25f74539-7fb3-2849-ad39-cfe7ad8fe49e
		parent_uuid 6b0f0fe5-1364-6d46-895f-6bb7b313f88d
		received_uuid f69333e9-f276-074c-814d-2a12e31d2a42
		ctransid 12142 otransid 12134 stransid 1095168 rtransid 12140
		ctime 1753650413.251310827 (2025-07-27 23:06:53)
		otime 1753649829.552110546 (2025-07-27 22:57:09)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1753650379.175938086 (2025-07-27 23:06:19)
	item 48 key (312 ROOT_BACKREF 5) itemoff 4890 itemsize 35
		root backref key dirid 181050 sequence 44 name 2025-07-27_1_live
	item 49 key (313 ROOT_ITEM 12143) itemoff 4451 itemsize 439
		generation 12157 root_dirid 256 bytenr 63242240 byte_limit 0 bytes_used 1=
836613632
		last_snapshot 12157 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12157
		uuid d291361b-e3db-f14e-892a-a10ceea4e9b7
		parent_uuid 25f74539-7fb3-2849-ad39-cfe7ad8fe49e
		received_uuid d9bd3978-1c57-624a-a004-b427d98d98b4
		ctransid 12156 otransid 12143 stransid 1136363 rtransid 12154
		ctime 1756427498.228874947 (2025-08-29 02:31:38)
		otime 1756426608.187130486 (2025-08-29 02:16:48)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1756427466.493333687 (2025-08-29 02:31:06)
	item 50 key (313 ROOT_BACKREF 5) itemoff 4416 itemsize 35
		root backref key dirid 181050 sequence 45 name 2025-08-28_1_live
	item 51 key (314 ROOT_ITEM 12157) itemoff 3977 itemsize 439
		generation 12165 root_dirid 256 bytenr 63422464 byte_limit 0 bytes_used 1=
551351808
		last_snapshot 12165 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12165
		uuid 633095eb-e0d2-1a46-8443-b848f58668f3
		parent_uuid d291361b-e3db-f14e-892a-a10ceea4e9b7
		received_uuid cb33ae2b-2945-dc46-859b-aab6b635ad1b
		ctransid 12164 otransid 12157 stransid 1147542 rtransid 12162
		ctime 1757092152.796296137 (2025-09-05 19:09:12)
		otime 1757091804.659587829 (2025-09-05 19:03:24)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1757092112.969543595 (2025-09-05 19:08:32)
	item 52 key (314 ROOT_BACKREF 5) itemoff 3942 itemsize 35
		root backref key dirid 181050 sequence 46 name 2025-09-05_1_live
	item 53 key (315 ROOT_ITEM 12165) itemoff 3503 itemsize 439
		generation 12175 root_dirid 256 bytenr 107069440 byte_limit 0 bytes_used =
1589166080
		last_snapshot 12175 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12175
		uuid a90d8540-52de-3347-9d2e-295f35a68b98
		parent_uuid 633095eb-e0d2-1a46-8443-b848f58668f3
		received_uuid 46887243-8712-9f42-a0c3-b7bf05b75ecd
		ctransid 12174 otransid 12165 stransid 1178903 rtransid 12171
		ctime 1759260184.863212672 (2025-09-30 21:23:04)
		otime 1759259515.264607243 (2025-09-30 21:11:55)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1759260110.182301942 (2025-09-30 21:21:50)
	item 54 key (315 ROOT_BACKREF 5) itemoff 3468 itemsize 35
		root backref key dirid 181050 sequence 47 name 2025-09-30_1_live
	item 55 key (316 ROOT_ITEM 12175) itemoff 3029 itemsize 439
		generation 12189 root_dirid 256 bytenr 131252224 byte_limit 0 bytes_used =
1674493952
		last_snapshot 12189 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12189
		uuid ea8c8eec-a309-4a4e-81de-4756b7c6f26c
		parent_uuid a90d8540-52de-3347-9d2e-295f35a68b98
		received_uuid 03a6ac27-c8eb-6f45-ab10-2ef6b552db85
		ctransid 12188 otransid 12175 stransid 1216590 rtransid 12187
		ctime 1762195091.489035174 (2025-11-03 19:38:11)
		otime 1762191633.208415216 (2025-11-03 18:40:33)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1762194938.805473757 (2025-11-03 19:35:38)
	item 56 key (316 ROOT_BACKREF 5) itemoff 2994 itemsize 35
		root backref key dirid 181050 sequence 48 name 2025-11-03_1_live
	item 57 key (317 ROOT_ITEM 12189) itemoff 2555 itemsize 439
		generation 12213 root_dirid 256 bytenr 10521906233344 byte_limit 0 bytes_=
used 1714307072
		last_snapshot 12189 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 12213
		uuid 59a5475d-20f0-be48-b4b4-6143f4d4b5fd
		parent_uuid ea8c8eec-a309-4a4e-81de-4756b7c6f26c
		received_uuid 9c384712-5927-9846-8711-3904802d9f41
		ctransid 12213 otransid 12189 stransid 1280199 rtransid 12212
		ctime 1768013363.803134336 (2026-01-10 03:49:23)
		otime 1768009842.875933335 (2026-01-10 02:50:42)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1768013291.727341436 (2026-01-10 03:48:11)
	item 58 key (317 ROOT_BACKREF 5) itemoff 2520 itemsize 35
		root backref key dirid 181050 sequence 49 name 2026-01-10_1_live
	item 59 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 2081 itemsize 439
		generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 16384
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 0 generation_v2 5
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)



Is:
> - automatic removal of accidentally leftover chunks when free-space-
> tree
>   is enabled since mkfs.btrfs v6.16.1

from David's PR for 6.20/7.0 from earlier the kernel mount time fix
you've mentioned?



> Or you can try this btrfs-progs branch, which provides the free space
> tree repair functionality:
>=20
> https://github.com/adam900710/btrfs-progs/tree/repair_fst
>=20
> However I won't really recommend that, because you have to run the
> full=20
> btrfs check --repair, which can be very time consuming for large
> fses.

Admittedly, I'm a bit reluctant trying that out ;-)
I mean --repair is always advertised as potentially not safe... and the
data on this fs (although I do have 2 btrfs and 1 ext4 backup of it) is
very important... and even only recovering would take extremely long
(nearly 15 TB or so).


Could it be an issue with too old btrfsprogs (Debian has only 6.17.1)?


Thanks,
Chris.

