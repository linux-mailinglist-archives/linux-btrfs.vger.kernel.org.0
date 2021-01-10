Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13E2F0708
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAJMJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 07:09:08 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:49601 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJMJH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 07:09:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AAE173F5AE;
        Sun, 10 Jan 2021 13:07:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.155
X-Spam-Level: 
X-Spam-Status: No, score=-2.155 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.255]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R-WvlTp_0y7F; Sun, 10 Jan 2021 13:07:56 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 534FE3F59D;
        Sun, 10 Jan 2021 13:07:55 +0100 (CET)
Received: from [192.168.0.10] (port=54357)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1kyZVu-000Mrh-Pn; Sun, 10 Jan 2021 13:08:06 +0100
Subject: Re: Reading files with bad data checksum
To:     David Woodhouse <dwmw2@infradead.org>, linux-btrfs@vger.kernel.org
References: <1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org>
From:   Forza <forza@tnonline.net>
Message-ID: <de013d75-7fa1-4cb6-ac1e-a67864c68bf3@tnonline.net>
Date:   Sun, 10 Jan 2021 13:08:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-01-10 12:52, David Woodhouse wrote:
> I migrated a system to btrfs which was hosting virtual machins with
> qemu.
> 
> Using it without disabling copy-on-write was a mistake, of course, and
> it became horribly fragmented and slow.
> 
> So I tried copying it to a new file... but it has actual *errors* too,
> which I think are because it was using the 'directsync' caching mode
> for block I/O in qemu.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1204569#c12
> 
> I filed https://bugzilla.redhat.com/show_bug.cgi?id=1914433
> 
> What I see is that *both* disks of the RAID-1 have data which is
> consistent, and does not match the checksum that btrfs expects:
> 
> [ 6827.513630] BTRFS warning (device sda3): csum failed root 5 ino 24387997 off 2935152640 csum 0x81529887 expected csum 0xb0093af0 mirror 1
> [ 6827.517448] BTRFS error (device sda3): bdev /dev/sdb3 errs: wr 0, rd 0, flush 0, corrupt 8286, gen 0
> [ 6827.527281] BTRFS warning (device sda3): csum failed root 5 ino 24387997 off 2935152640 csum 0x81529887 expected csum 0xb0093af0 mirror 2
> [ 6827.530817] BTRFS error (device sda3): bdev /dev/sda3 errs: wr 0, rd 0, flush 0, corrupt 9115, gen 0
> 
> It looks like an O_DIRECT bug where the data *do* get updated without
> updating the checksum. Which is kind of the worst of both worlds, I
> suppose, since I also did get the appalling performance of COW and
> fragmentation.

With O_DIRECT Btrfs shouldn't do checksum or compression. This is one of 
the issues with Direct IO for the moment. But it should not cause those 
dmesg errors. I believe it should show in scrub as no_csum:

# btrfs scrub status -R /mnt/6TB/
UUID:             fe0a1142-51ab-4181-b635-adbf9f4ea6e6
Scrub started:    Sun Nov 22 13:11:20 2020
Status:           finished
Duration:         9:37:39
         data_extents_scrubbed: 164773032
         tree_extents_scrubbed: 1113696
         data_bytes_scrubbed: 10570715316224
         tree_bytes_scrubbed: 18246795264
         read_errors: 0
         csum_errors: 0
         verify_errors: 0
         no_csum: 3120
         csum_discards: 0
         super_errors: 0
         malloc_errors: 0
         uncorrectable_errors: 0
         unverified_errors: 0
         corrected_errors: 0
         last_physical: 5823976701952


> 
> In the short term, all I want to do is make a copy of the file, using
> the data which are in the disk regardless of the fact that btrfs thinks
> the checksum doesn't match. Is there a way I can turn off *checking* of
> the checksum for that specific file (or file descriptor?).
> 
> Or is the only way to do it with something like FIBMAP, reading the
> offending blocks directly from the underlying disk and then writing
> them into the appropriate offset in (a copy of) the file? A plan which
> is slightly complicated by the fact that of course btrfs doesn't
> support FIBMAP.
> 
> What's the best way to recover the data?
> 

You can use GNU ddrescue to copy files. It can skip the offending blocks 
and replace the bad data with zeroes. Not sure how well qemu will handle 
that though.


I did some tests with qemu to try to avoid O_DIRECT. This worked, and 
also enabled compression and csums. It worked by emulating nvme with 
larger than 4KiB block size. I've tried with 8192 and 16384 sizes. 
Although it works, it may also be really slow. I have not done any 
benchmarks yet.


# qemu-system-x86_64 -D qemu.log \
-name fedora \
-enable-kvm -machine q35 -device intel-iommu \
-smp cores=4 -m 3072 \
-drive 
format=raw,file=disk2.img,cache=writeback,aio=io_uring,if=none,id=drv0 \
-device 
nvme,drive=drv0,serial=1234,physical_block_size=8192,logical_block_size=8192,write-cache=on 
\
-display vnc=192.168.0.1:0,to=100 \
-net nic,model=virtio,macaddr=00:00:00:00:00:01 -net tap,ifname=qemu0 \

Just a warning about cache=writeback. I have not checked how safe this 
is with regards to crashes and powerloss.

