Return-Path: <linux-btrfs+bounces-11244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAFA25CF9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316703A817F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77C208964;
	Mon,  3 Feb 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b="nXNT2Nzk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from pmg-pub-smtp2.teksavvy.com (pmg-pub-smtp2.teksavvy.com [76.10.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7A20767D
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592834; cv=none; b=pKmN2zJLzeafe8lzF30ZbxYuQPweCnNuBGNYN4R/Z8FpH2GkPGLUAexfpKpKBGnbm+p+dXP1yBsmZrj7tALcC0HLZagO9wczFZRG8MEbfhsWCZbezX3EMm2WzbsSrrVMlirOEbW9azC9oINNV8tPYkxvrCRAJd0SodNZFyJMnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592834; c=relaxed/simple;
	bh=t3PtP2ZOP0b0kw7gRIKmReLWVFmUdFbBxKxW/rhdTKI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Oay6XKi7vrUbf5S/goezsMQWBC/rwBDcWl4dS8RYmhsEcrrjDR9QV6PAvZ6X7IzJ2z3zOpaYQCqu9+outsnEAuTjpY/d6IIW0TtXLKe0F8elWtj7zSAid1uvvoVtRE2kmoPfLWg7NosubAuqTq1BvLx3rX42PuuJQspCjd5VEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name; spf=pass smtp.mailfrom=siddall.name; dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b=nXNT2Nzk; arc=none smtp.client-ip=76.10.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddall.name
Received: from pmg-pub-smtp2.teksavvy.com (localhost.localdomain [127.0.0.1])
	by pmg-pub-smtp2.teksavvy.com (Proxmox) with ESMTP id 0FA2A34C2CAB;
	Mon,  3 Feb 2025 09:27:11 -0500 (EST)
Received: from siddall.name (206-248-137-23.dsl.teksavvy.com [206.248.137.23])
	by pmg-pub-smtp2.teksavvy.com (Proxmox) with ESMTP id 08ED734C30C2;
	Mon,  3 Feb 2025 09:27:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 siddall.name 115F17292AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siddall.name;
	s=siddall; t=1738592829;
	bh=mpkWO91OU9VW12JoVSTakbnx/gzYvgjmX31y30mvh/U=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=nXNT2NzkdGhE8gKB6v2hp59lRIZQLnibZto3oREt9i8zUFFVEWNA4d1seKPTdNxQI
	 y4amfscFY84DxLQFpPWCTHVKEaiRMSbUDtudH3ZngLg1MwpFRkXNF84WwzAhJRv2Oq
	 WBf9x/Ch1tOmrD8YaaNJZ9bRZFIOjDqHQDzw/lZY=
Received: from [192.168.0.2] (siddall-2.internal.siddall.name [192.168.0.2])
	by siddall.name (Postfix) with ESMTPS id 115F17292AC;
	Mon,  3 Feb 2025 09:27:09 -0500 (EST)
Message-ID: <93e25dd4-da69-4e66-a8ec-0d502d11ca60@siddall.name>
Date: Mon, 3 Feb 2025 09:27:08 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Siddall <news@siddall.name>
Subject: Re: [PATCH] btrfs-progs: balance: add extra delay if converting with
 a missing device
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c5f42e2e31ffc95f93e62eef7d51a01bfbc9471f.1738556153.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <c5f42e2e31ffc95f93e62eef7d51a01bfbc9471f.1738556153.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Qu!

This, and the associated doc update, seems like a good start. Had I 
known this process was known not to work I wouldn't have gone ahead in 
the first place.

Strangely, filesystem show did state that the device was missing so it 
must have done some kind of detection.  If it knew it was missing then 
certainly any attempt to write to that device would fail so perhaps that 
logic could be leveraged here.

Jeff

On 2025-02-02 23:16, Qu Wenruo wrote:
> [BUG]
> There is a reproducer that can trigger btrfs to flips RO:
>
> # mkfs.btrfs -f -mraid1 -draid1 /dev/sdd /dev/sde
> # mount /dev/sdd /mnt/btrfs
> # echo 1 > /sys/block/sde/device/delete
> # btrfs balance start -mconvert=dup -dconvert=single /mnt/btrfs
> ERROR: error during balancing '.': Input/output error
> There may be more info in syslog - try dmesg | tail
>
> Then btrfs will flip read-only with the following errors:
>
> btrfs: attempt to access beyond end of device
> sde: rw=6145, sector=21696, nr_sectors = 32 limit=0
> btrfs: attempt to access beyond end of device
> sde: rw=6145, sector=21728, nr_sectors = 32 limit=0
> btrfs: attempt to access beyond end of device
> sde: rw=6145, sector=21760, nr_sectors = 32 limit=0
> BTRFS error (device sdd): bdev /dev/sde errs: wr 1, rd 0, flush 0, 
> corrupt 0, gen 0
> BTRFS error (device sdd): bdev /dev/sde errs: wr 2, rd 0, flush 0, 
> corrupt 0, gen 0
> BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 0, 
> corrupt 0, gen 0
> BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 1, 
> corrupt 0, gen 0
> btrfs: attempt to access beyond end of device
> sde: rw=145409, sector=128, nr_sectors = 8 limit=0
> BTRFS warning (device sdd): lost super block write due to IO error on 
> /dev/sde (-5)
> BTRFS error (device sdd): bdev /dev/sde errs: wr 4, rd 0, flush 1, 
> corrupt 0, gen 0
> btrfs: attempt to access beyond end of device
> sde: rw=14337, sector=131072, nr_sectors = 8 limit=0
> BTRFS warning (device sdd): lost super block write due to IO error on 
> /dev/sde (-5)
> BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 1, 
> corrupt 0, gen 0
> BTRFS error (device sdd): error writing primary super block to device 2
> BTRFS info (device sdd): balance: start -dconvert=single -mconvert=dup 
> -sconvert=dup
> BTRFS info (device sdd): relocating block group 1372585984 flags 
> data|raid1
> BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 2, 
> corrupt 0, gen 0
> BTRFS warning (device sdd): chunk 2446327808 missing 1 devices, max 
> tolerance is 0 for writable mount
> BTRFS: error (device sdd) in write_all_supers:4044: errno=-5 IO 
> failure (errors while submitting device barriers.)
> BTRFS info (device sdd state E): forced readonly
> BTRFS warning (device sdd state E): Skipping commit of aborted 
> transaction.
> BTRFS error (device sdd state EA): Transaction aborted (error -5)
> BTRFS: error (device sdd state EA) in cleanup_transaction:2017: 
> errno=-5 IO failure
> BTRFS info (device sdd state EA): balance: ended with status: -5
>
> [CAUSE]
> The root cause is that, deleting devices using sysfs interface normally
> will trigger the shutdown callback for the fs.
>
> But btrfs doesn't handle that callback at all, thus it can not really
> know that device is no longer avaialble, thus btrfs will still try to do
> usual read/write on that device.
>
> This is fine if the user do nothing, as RAID1 can handle it properly.
>
> But if we try to convert to SINGLE/DUP, btrfs will still use that device
> to allocate new data/metadata chunks.
> And if a new metadata chunk is allocated to the removed device, all the
> write will be lost, and trigger the super block write/barrier errors
> above.
>
> [USER SPACE ENHANCEMENT]
> For now, add extra missing devices check at btrfs-balance command.
> If there is a missing devices, `btrfs balance` will add a 10 seconds
> delay and warn the possible dangerous.
>
> The root fix is to introduce a failing/removed device detection for
> btrfs, but that will be a pretty big feature and will take quite some
> time before landing it upstream.
>
> Reported-by: Jeff Siddall <news@siddall.name>
> Link: 
> https://lore.kernel.org/linux-btrfs/2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> cmds/balance.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 87 insertions(+)
>
> diff --git a/cmds/balance.c b/cmds/balance.c
> index 4c73273dfdc3..5c17fbc1acb5 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -376,6 +376,45 @@ static const char * const 
> cmd_balance_start_usage[] = {
> NULL
> };
> +/*
> + * Return 0 if no missing device found for the fs at @mnt.
> + * Return >0 if there is any missing device for the fs at @mnt.
> + * Return <0 if we hit other errors during the check.
> + */
> +static int check_missing_devices(const char *mnt)
> +{
> + struct btrfs_ioctl_fs_info_args fs_info_arg;
> + struct btrfs_ioctl_dev_info_args *dev_info_args = NULL;
> + bool found_missing = false;
> + int ret;
> +
> + ret = get_fs_info(mnt, &fs_info_arg, &dev_info_args);
> + if (ret < 0)
> + return ret;
> +
> + for (int i = 0; i < fs_info_arg.num_devices; i++) {
> + struct btrfs_ioctl_dev_info_args *cur_dev_info;
> + int fd;
> +
> + cur_dev_info = (struct btrfs_ioctl_dev_info_args *)&dev_info_args[i];
> +
> + /*
> + * Kernel will report the device path even if we can no
> + * longer access it anymore. So we have to manually check it.
> + */
> + fd = open((char *)cur_dev_info->path, O_RDONLY);
> + if (fd < 0) {
> + found_missing = true;
> + break;
> + }
> + close(fd);
> + }
> + free(dev_info_args);
> + if (found_missing)
> + return 1;
> + return 0;
> +}
> +
> static int cmd_balance_start(const struct cmd_struct *cmd,
> int argc, char **argv)
> {
> @@ -387,6 +426,7 @@ static int cmd_balance_start(const struct 
> cmd_struct *cmd,
> bool enqueue = false;
> unsigned start_flags = 0;
> bool raid56_warned = false;
> + bool convert_warned = false;
> int i;
> memset(&args, 0, sizeof(args));
> @@ -481,6 +521,53 @@ static int cmd_balance_start(const struct 
> cmd_struct *cmd,
> args.flags |= BTRFS_BALANCE_TYPE_MASK;
> }
> + /*
> + * If we are using convert, and there is a missing/failed device at
> + * runtime (e.g. mounted then remove a device using sysfs interface),
> + * btrfs has no way to avoid using that failing/removed device.
> + *
> + * In that case converting the profile is very dangerous, e.g.
> + * converting RAID1 to SINGLE/DUP, and new SINGLE/DUP chunks can
> + * be allocated to that failing/removed device, and cause the
> + * fs to flip RO due to failed metadata writes.
> + *
> + * Meanwhile the fs may work completely fine due to the extra
> + * duplication (e.g. all RAID1 profiles).
> + *
> + * So here warn if one is trying to convert with missing devices.
> + */
> + for (i = 0; ptrs[i]; i++) {
> + int delay = 10;
> + int ret;
> +
> + if (!(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT) || convert_warned)
> + continue;
> +
> + ret = check_missing_devices(argv[optind]);
> + if (ret < 0) {
> + errno = -ret;
> + warning("skipping missing devices check due to failure: %m");
> + break;
> + }
> + if (ret == 0)
> + continue;
> + convert_warned = true;
> + printf("WARNING:\n\n");
> + printf("\tConversion with missing device(s) can be dangerous.\n");
> + printf("\tPlease use `btrfs replace` or `btrfs device remove` 
> instead.\n");
> + if (force) {
> + printf("\tSafety timeout skipped due to --force\n\n");
> + continue;
> + }
> + printf("\tThe operation will continue in %d seconds.\n", delay);
> + printf("\tUse Ctrl-C to stop.\n");
> + while (delay) {
> + printf("%2d", delay--);
> + fflush(stdout);
> + sleep(1);
> + }
> + }
> +
> /* drange makes sense only when devid is set */
> for (i = 0; ptrs[i]; i++) {
> if ((ptrs[i]->flags & BTRFS_BALANCE_ARGS_DRANGE) &&


