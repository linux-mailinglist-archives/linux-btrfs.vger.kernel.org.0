Return-Path: <linux-btrfs+bounces-18345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B0C0B49D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5E24E992A
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEF283FE2;
	Sun, 26 Oct 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=archworks.co header.i=@archworks.co header.b="b1MLxiDl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from relay.archworks.co (relay.archworks.co [65.21.53.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9019539F
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.53.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761514628; cv=none; b=RzDWC+O47mneEIcGepFOfeIS5gDOtc0/Q57N9yvFJvXZedjUpHkAJQPQHvvSNrwPrYAqcOiVa+dPevQ5nWx67WeRJDv5ELafMyVmou27gwchOeDcdq25AEMMh60nL2HYDtww/kVk5z4Zrydcm5rRVZnz8d8Qh4l/vaWMKq0GgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761514628; c=relaxed/simple;
	bh=wM8Z2rtZ/8AXCROuOrrKDsRGMfeR+/S1YLNAalBxLXg=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:
	 In-Reply-To:Content-Type; b=lO/c4jt5hrXw+r1Azduc8PUJgMweZqwtElb+YFZH55H5MRO4R+AOdb1FT6vI+YOTzK8/vzXfc87XtqasvwgTilXdwRC7BTwwkWP3qtqK6MZAkaQcAoPe4iZ4LJVnmcKa0L74uAt31n7uJgHcqiLV32n05zzlp1itriJ3Pmh/0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=archworks.co; spf=pass smtp.mailfrom=archworks.co; dkim=pass (1024-bit key) header.d=archworks.co header.i=@archworks.co header.b=b1MLxiDl; arc=none smtp.client-ip=65.21.53.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=archworks.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archworks.co
Received: from [192.168.1.102] (mob-194-230-148-21.cgn.sunrise.net [194.230.148.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: norbert.morawski@archworks.co)
	by relay.archworks.co (Postfix) with ESMTPSA id BD25F3A8564
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 22:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archworks.co; s=k2;
	t=1761514625; bh=wM8Z2rtZ/8AXCROuOrrKDsRGMfeR+/S1YLNAalBxLXg=;
	h=Date:Subject:References:From:To:In-Reply-To;
	b=b1MLxiDleqGbSkPb/TyhXIolLl+PeKmQktxmPXgZBLsTTlduqSqpNxBuO+m3LdnSt
	 Xd6yQ2NFcRn+XZdYD2/0hKzRWZhqVLb5fWuighq5LOFOA0H+KZlzOVJeidtoDIGVbV
	 upReHGyH5SBMUTyyB+4oExAINJnCUr8I5Pa4iCbc=
Message-ID: <05308285-7660-4d9c-b1d5-0b59cf4f1986@archworks.co>
Date: Sun, 26 Oct 2025 22:37:02 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [btrfs] ENOSPC during convert to RAID6/RAID1C4 -> forced RO
Content-Language: de-AT, en-US
References: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
From: Sandwich <sandwich@archworks.co>
To: linux-btrfs@vger.kernel.org
In-Reply-To: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
X-Forwarded-Message-Id: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  hi,

i hit an ENOSPC corner case converting a 6-disk btrfs from data=single to data=raid6 and metadata/system=raid1c4. after the failure, canceling the balance forces the fs read-only. there's plenty of unallocated space overall, but metadata reports "full" and delayed refs fail. attempts to add another (empty) device also immediately flip the fs to RO and the add does not proceed.

i am aware RAID56 is not recommended.

how the filesystem grew:
i started with two disks, created btrfs (data=single), and filled it. i added two more disks and filled it again. after adding the final two disks i attempted the conversion to data=raid6 with metadata/system=raid1c4—that conversion is what triggered ENOSPC and the current RO behavior. when the convert began, usage was about 51 TiB used out of ~118 TiB total device size.

environment during the incident:

```
uname -r: 6.14.11-4-pve
btrfs --version: btrfs-progs v6.14
quotas: off
unclean shutdowns: none
disks: 2×20 TB (~18.19 TiB) + 4×18 TB (~16.37 TiB)
```

operation that started it:

```
btrfs balance start -v -dconvert=raid6 -mconvert=raid1c4 -sconvert=raid1c4 /mnt/Data --force
```

current state:
i can mount read-write only with `-o skip_balance`. running `btrfs balance cancel` immediately forces RO. mixed profiles remain (data=single+raid6, metadata=raid1+raid1c4, system=raid1+raid1c4). i tried clearing the free-space cache, afterward the free-space tree could not be rebuilt and subsequent operations hit backref errors (details below). adding a new device also forces RO and fails.

FS Info:

```
# btrfs fi df /mnt/Data
Data, single:   total=46.78TiB, used=44.72TiB
Data, RAID6:    total=4.35TiB,  used=4.29TiB
System, RAID1:  total=8.00MiB,  used=5.22MiB
System, RAID1C4: total=32.00MiB, used=352.00KiB
Metadata, RAID1: total=56.00GiB, used=50.54GiB
Metadata, RAID1C4: total=10.00GiB, used=9.97GiB
```

```
# btrfs fi usage -T /mnt/Data
Device size:       118.24TiB
Device allocated:   53.46TiB
Device unallocated: 64.78TiB
Used:               51.29TiB
Free (estimated):   64.20TiB (min: 18.26TiB)
Free (statfs, df):  33.20TiB
Data ratio:          1.04
Metadata ratio:      2.33
Multiple profiles:   yes (data, metadata, system)
```

```
# btrfs filesystem show /mnt/Data
Label: 'Data'  uuid: 7aa7fdb3-b3de-421c-bc86-daba55fc46f6
Total devices 6  FS bytes used 49.07TiB
devid 1 size 18.19TiB used 16.23TiB path /dev/sdf
devid 2 size 18.19TiB used 16.23TiB path /dev/sdg
devid 3 size 16.37TiB used 14.54TiB path /dev/sdc
devid 4 size 16.37TiB used  4.25TiB path /dev/sdb
devid 5 size 16.37TiB used  1.10TiB path /dev/sdd
devid 6 size 16.37TiB used  1.10TiB path /dev/sde
```
initial dmesg at first failure (before cache clear):

```
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info DATA has 68817772544 free, is not full
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info total=56215761584128, used=53883609358336, pinned=1023410176, reserved=0, may_use=0, readonly=2262311043072 zone_unusable=0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info METADATA has 4869275648 free, is full
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info total=70866960384, used=64968261632, pinned=33210368, reserved=5832704, may_use=990248960, readonly=131072 zone_unusable=0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info SYSTEM has 35307520 free, is not full
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): space_info total=41943040, used=5832704, pinned=802816, reserved=0, may_use=0, readonly=0 zone_unusable=0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): global_block_rsv: size 536870912 reserved 536870912
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): trans_block_rsv: size 0 reserved 0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): chunk_block_rsv: size 0 reserved 0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): delayed_block_rsv: size 0 reserved 0
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state A): delayed_refs_rsv: size 453378048 reserved 453378048
Oct 26 15:25:39 anthem kernel: BTRFS: error (device sdf state A) in __btrfs_free_extent:3211: errno=-28 No space left
Oct 26 15:25:39 anthem kernel: BTRFS info (device sdf state EA): forced readonly
Oct 26 15:25:39 anthem kernel: BTRFS error (device sdf state EA): failed to run delayed ref for logical 72899131047936 num_bytes 16384 type 176 action 2 ref_mod 1: -28
Oct 26 15:25:39 anthem kernel: BTRFS: error (device sdf state EA) in btrfs_run_delayed_refs:2160: errno=-28 No space left
Oct 26 15:33:16 anthem kernel: BTRFS info (device sdf state EA): last unmount of filesystem 7aa7fdb3-b3de-421c-bc86-daba55fc46f6
```

later dmesg around ENOSPC/RO:

```
BTRFS info (device sdf state A): space_info DATA has 9918180220928 free, is not full
BTRFS info (device sdf state A): space_info METADATA has 5322637312 free, is full
BTRFS: error (device sdf state A) in btrfs_run_delayed_refs:2160: errno=-28 No space left
BTRFS info (device sdf state EA): forced readonly
BTRFS: error (device sdf state EA) in reset_balance_state:3793: errno=-28 No space left
BTRFS info (device sdf state EA): balance: canceled
```

`btrfs.static check --readonly /dev/sdf` with 6.17 shows backref issues:

```
...
backpointer mismatch on [81544970633216 16384]
owner ref check failed [81544970633216 16384]
ref mismatch on [81544977776640 16384] extent item 1, found 0
tree extent[81544977776640, 16384] root 10 has no tree block found
incorrect global backref count on 81544977776640 found 1 wanted 0
...
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 53948588761088 bytes used, error(s) found
total csum bytes: 52620712264
total tree bytes: 64969162752
total fs tree bytes: 6759579648
total extent tree bytes: 3808886784
btree space waste bytes: 3059147492
file data blocks allocated: 53958044786688
  referenced 56765362577408
```

full check log:
https://pastebin.com/8tJWeBnM

after clearing the cache, the free-space tree cannot be rebuilt, kernel shows:

```
BTRFS: error (device sdf state A) in __btrfs_free_extent:3205: errno=-117 Filesystem corrupted
BTRFS info (device sdf state EA): forced readonly
BTRFS critical (device sdf state EA): unable to find ref byte nr 69983021023232 parent 0 root 10 owner 0 offset 0 slot 9
BTRFS error (device sdf state EA): failed to run delayed ref for logical 69983021023232 num_bytes 16384 type 176 action 2 ref_mod 1: -2
BTRFS: error (device sdf state EA) in btrfs_run_delayed_refs:2160: errno=-2 No such entry
BTRFS: error (device sdf state EA) in reset_balance_state:3793: errno=-2 No such entry
BTRFS info (device sdf state EA): balance: canceled
```

timeline is as follows:
first two disks were single and filled, then two more added and filled, then last two added and the convert attempted. usage at convert start was ~51 TiB used of ~118 TiB total.
exact command history around the incident:

```
Sat 25 Oct 2025 18:16:40 CEST  btrfs device add /dev/sdd /mnt/Data
Sat 25 Oct 2025 18:18:18 CEST  btrfs device add /dev/sde /mnt/Data
Sat 25 Oct 2025 18:18:21 CEST  mount -a
Sat 25 Oct 2025 18:19:01 CEST  tmux new-session -s raid6
Sat 25 Oct 2025 18:41:17 CEST  btrfs balance start -v -dconvert=raid6 -mconvert=raid1c4 -sconvert=raid1c4 /mnt/Data --force
Sat 25 Oct 2025 18:41:22 CEST  btrfs balance status /mnt/Data
Sat 25 Oct 2025 18:41:47 CEST  watch btrfs balance status /mnt/Data
Sat 25 Oct 2025 18:56:37 CEST  mount -o remount /dev/sdb /mnt/Data
Sun 26 Oct 2025 13:50:59 CET   mount -o remount /dev/sde /mnt/Data
Sun 26 Oct 2025 13:51:38 CET   mount /dev/sdb /mnt/Data
Sun 26 Oct 2025 13:52:33 CET   cd /mnt/Data/
Sun 26 Oct 2025 13:59:29 CET   touch /mnt/Data/test
Sun 26 Oct 2025 14:40:31 CET   vim /etc/fstab
Sun 26 Oct 2025 14:40:31 CET   vim /etc/exports
Sun 26 Oct 2025 14:41:05 CET   exportfs -arv
Sun 26 Oct 2025 14:44:15 CET   reboot
Sun 26 Oct 2025 14:47:27 CET   lsof +D /mnt/Data
Sun 26 Oct 2025 14:52:26 CET   mount -o rw,skip_balance,noatime,space_cache=v2 /dev/sdb /mnt/Data
Sun 26 Oct 2025 15:01:10 CET   btrfs fi df /mnt/Data
Sun 26 Oct 2025 15:04:58 CET   mount -o rw,skip_balance /dev/sdb /mnt/Data
Sun 26 Oct 2025 15:08:56 CET   btrfs device add -f /dev/sdh /mnt/Data
Sun 26 Oct 2025 15:10:34 CET   btrfs filesystem show /mnt/Data
Sun 26 Oct 2025 15:10:55 CET   btrfs rescue zero-log /dev/sdf
Sun 26 Oct 2025 15:14:32 CET   umount /mnt/Data
Sun 26 Oct 2025 15:23:56 CET   btrfs check --readonly /dev/sdf
Sun 26 Oct 2025 15:33:22 CET   btrfs rescue clear-space-cache v2 /dev/sdf
Sun 26 Oct 2025 15:53:35 CET   btrfs rescue clear-uuid-tree /dev/sdf
Sun 26 Oct 2025 16:12:17 CET   wipefs -af /dev/sdh
Sun 26 Oct 2025 16:51:20 CET   mount -o rw,skip_balance LABEL=Data /mnt/Data
Sun 26 Oct 2025 16:51:30 CET   btrfs device add -K -f /dev/sdh /mnt/Data
Sun 26 Oct 2025 17:04:36 CET   btrfs balance status -v /mnt/Data
Sun 26 Oct 2025 17:07:12 CET   umount /mnt/Data
Sun 26 Oct 2025 17:13:26 CET   btrfs check --readonly -s 1 /dev/sdb
Sun 26 Oct 2025 17:21:36 CET   mount -o rw,skip_balance,clear_cache,noatime LABEL=Data /mnt/Data
Sun 26 Oct 2025 18:51:27 CET   btrfs fi usage /mnt/Data
Sun 26 Oct 2025 18:59:52 CET   btrfs balance cancel /mnt/Data
Sun 26 Oct 2025 19:02:26 CET   touch /mnt/Data/test
Sun 26 Oct 2025 19:38:23 CET   wget https://github.com/kdave/btrfs-progs/releases/download/v6.17/btrfs.static
Sun 26 Oct 2025 19:40:53 CET   chmod +x btrfs.static
Sun 26 Oct 2025 19:41:09 CET   ./btrfs.static
Sun 26 Oct 2025 19:41:14 CET   umount -R /mnt/Data
Sun 26 Oct 2025 19:42:02 CET   ./btrfs.static check --readonly /dev/sdf
Sun 26 Oct 2025 21:16:09 CET   mount -o rw,skip_balance,noatime LABEL=Data /mnt/Data
Sun 26 Oct 2025 21:31:22 CET   ./btrfs.static balance cancel /mnt/Data
```

full incident kernel log:
https://pastebin.com/KxP7Xa3g

i’m looking for a safe recovery path. is there a supported way to unwind or complete the in-flight convert first (for example, freeing metadata space or running a limited balance), or should i avoid that and take a different route? if proceeding is risky, given that there are no `Data,single` chunks on `/dev/sdd` and `/dev/sde`, is it safe to remove those two devices to free room and try again? if that’s reasonable, what exact sequence (device remove/replace vs zeroing; mount options) would you recommend to minimize further damage?

thanks,
sandwich

—
note: this email’s formatting was prepared with the help of an LLM.

