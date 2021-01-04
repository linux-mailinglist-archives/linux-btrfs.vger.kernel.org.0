Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A932E9CD2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbhADSKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 13:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhADSKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 13:10:33 -0500
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A9C061793
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 10:09:52 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 248C3603AC87;
        Mon,  4 Jan 2021 18:09:49 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
        tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
        by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavisd-new, port 10025)
        with LMTP id z4e0-PVMeQRv; Mon,  4 Jan 2021 18:09:46 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 72C27603AC97;
        Mon,  4 Jan 2021 18:09:46 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecnico.ulisboa.pt;
        s=mail; t=1609783786;
        bh=EfJb3aRQyLG8AO3VwMbyBtRyl3cZIDBAssr59lMdUmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=K+t5LbO9rflSvPBnOvxhJLQS7iMXY0jX8q+LU3fi6JsJOYmEk1OLVuehvSrBnFiF0
         vdVl63Fps2hdeHEB+OP+jD0NxcrPAPqz24T8IARLKFFi/MLPfnKI6X7fNoYHHA86zZ
         BiCKWKVxzP7IrNLBgiG32t3nSsmsbKkh+IISEkMk=
Received: from webmail.tecnico.ulisboa.pt (webmail3.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::912f:b135])
        (Authenticated sender: ist186945)
        by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 4894D360070;
        Mon,  4 Jan 2021 18:09:46 +0000 (WET)
Received: from vs1.ist.utl.pt ([2001:690:2100:1::33])
 by webmail.tecnico.ulisboa.pt
 with HTTP (HTTP/1.1 POST); Mon, 04 Jan 2021 18:09:46 +0000
MIME-Version: 1.0
Date:   Mon, 04 Jan 2021 18:09:46 +0000
From:   =?UTF-8?Q?Andr=C3=A9_Isidro_da_Silva?= 
        <andreisilva@tecnico.ulisboa.pt>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: tldr; no BTRFS on dev, after a forced shutdown, help
In-Reply-To: <CAJCQCtTm_zdyn7mXOgT6adaRgCU2-42hdSeADkh2T+dXo4nbag@mail.gmail.com>
References: <1bdca54c9a0c575288f2c509246e5a96@tecnico.ulisboa.pt>
 <CAJCQCtTMmU5oWbvY0vOpWgiS6UvH2ZrrLhnaDivC4o2FnbBvag@mail.gmail.com>
 <b694928becd337a5f57e6f459e5774d8@tecnico.ulisboa.pt>
 <CAJCQCtTm_zdyn7mXOgT6adaRgCU2-42hdSeADkh2T+dXo4nbag@mail.gmail.com>
Message-ID: <9c5093af29f2a1918829cfbdebec1103@tecnico.ulisboa.pt>
X-Sender: andreisilva@tecnico.ulisboa.pt
User-Agent: Roundcube Webmail/1.3.15
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm sure it used to be one, but indeed it seems that a TYPE is missing 
in /dev/sda10; gparted says it's unknown.
It seems there is no trace of the fs. I'm trying to recall any other 
operations I might have done, but if it was something else I can't 
remember what could have been. I used cfdisk, to resize another 
partition, also tried to do a 'btrfs device add' with this missing one 
(to solve the no space left in another one), otherwise it was mount /, 
mount /home (/dev/sda10), umount, repeat. Oh well.

[sudo blkid]

/dev/sda1: UUID="03ff3132-dfc5-4dce-8add-cf5a6c854313" BLOCK_SIZE="4096" 
TYPE="ext4" PARTLABEL="LINUX" 
PARTUUID="a6042b9f-a3fe-49e2-8dc5-98a818454b6d"

/dev/sdb4: UUID="5c7201df-ff3e-4cb7-8691-8ef0c6c806ed" 
UUID_SUB="bb677c3a-6270-420f-94ce-f5b89f2c40d2" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="be4190e4-8e09-4dfc-a901-463f3e162727"

/dev/sda10: PARTLABEL="HOME" 
PARTUUID="6045f3f0-47a7-4b38-a392-7bebb7f654bd"

[sudo btrfs insp dump-s -F /dev/sda10]

superblock: bytenr=65536, device=/dev/sda10
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x00000000 [DON'T MATCH]
bytenr                  0
flags                   0x0
magic                   ........ [DON'T MATCH]
fsid                    00000000-0000-0000-0000-000000000000
metadata_uuid           00000000-0000-0000-0000-000000000000
label
generation              0
root                    0
sys_array_size          0
chunk_root_generation   0
root_level              0
chunk_root              0
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             0
bytes_used              0
sectorsize              0
nodesize                0
leafsize (deprecated)   0
stripesize              0
root_dir                0
num_devices             0
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x0
cache_generation        0
uuid_tree_generation    0
dev_item.uuid           00000000-0000-0000-0000-000000000000
dev_item.fsid           00000000-0000-0000-0000-000000000000 [match]
dev_item.type           0
dev_item.total_bytes    0
dev_item.bytes_used     0
dev_item.io_align       0
dev_item.io_width       0
dev_item.sector_size    0
dev_item.devid          0
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

This as nothing to do with btrfs anymore, but: do you think a tool like 
foremost can recover the files, it'll be a mess, but better then nothing 
and I've used it before in a ntfs.

Thanks

A 2021-01-04 17:36, Chris Murphy escreveu:
> On Mon, Jan 4, 2021 at 5:14 AM André Isidro da Silva
> <andreisilva@tecnico.ulisboa.pt> wrote:
>> 
>> Thankyou for helping,
>> 
>> I have already tried to run check, and.. check --repair. I bet that's
>> bad, yesterday snowballed downhill really quick haha.
>> 
>> ERROR: no btrfs on /dev/sda10
> 
> Are you sure there's a btrfs file system on /dev/sda10? What do you get 
> for:
> 
> sudo blkid
> sudo btrfs insp dump-s -F /dev/sda10
> 
> 
> 
>> 
>> dmesg reported nothing for a simple mount,
>> and for a 'mount -o subvolid':
>>       [  +3.754839] fuseblk: Unknown parameter 'subvolid'
> 
> subvol and subvolid need a parameter to work; but that you're getting
> back a message from fuseblk suggests this is not a btrfs file system
> (anymore) so without knowing the full history, it's just guessing.
> LIke, is it possible you accidentally reformatted with this partition?
> There's not much to go on.
