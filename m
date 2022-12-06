Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C664431F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 13:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiLFM3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 07:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFM3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 07:29:02 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FBB80
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 04:28:57 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E45E3240104
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 13:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1670329735; bh=JgyUBn6zaKw3g4D389vsbR/0zyMnnnmPqbzkvf4QVGo=;
        h=Date:From:To:Subject:From;
        b=o9ZYVRLeBAehWMLitHUKDNk/xavJwpsV0ZgP1YzejipSmTnEb8Mu6D2zk1FC91IIc
         IlUIEByTGD3BBpsCzg5FCFgAc8zu0mnF4acAqw2s/0v7QwX6hfgm+SfDXJMs6sPDs7
         RG+K1wIkBHDkk35SpbWdRmZYpARUGuWze6VtSxR+xYMs4O+y+f7HWkHU+dqnZYDVTi
         HEz5021bdQ2GEDIr87kWuo8BJeJgiwn6JLu+gPU5HbDa+rAw0TjBDuPW+twhFhtwXI
         /Z05EuweTJTDThD432hB+uUCW+LZ6q1KoFFD+VuK2yMZptQSTQWIfQm6I6zREBam/s
         2QzA7mYTyKEmQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NRKTf6WPGz6tnq
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 13:28:54 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Dec 2022 12:28:54 +0000
From:   Thomas Michael Engelke <thomas.engelke@posteo.de>
To:     linux-btrfs@vger.kernel.org
Subject: No boot or access of single NVME SSD with BTRFS possible
Organization: Wehlmann Marketing GmbH
Message-ID: <a17f42cd16d3948e5d581507a7c508e0@posteo.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This morning I booted my system up, and I found this message:

Starting systemd-udevd, version 252.2-3-arch
mount: /new_root: mount(2) system call failed: File exists.
dmesg(1) may have more information after failed mount system call
You are now dropped into an emergency shell
sh: can't access tty: job control turned off

I have regular snapshots, but booting into any of them results in the 
same message. I therefor booted a live USB and tried to access the BTRFS 
volume, but no luck:

[liveuser@eos-2021.12.17 ~]$ time sudo mount -t btrfs /dev/nvme0n1p2 
/mnt
mount: /mnt: mount(2) system call failed: File exists.

real	0m1.415s
user	0m0.006s
sys	0m0.179s
[liveuser@eos-2021.12.17 ~]$

Note the hang time, I'm not sure it is relevant.

/mnt is not mounted at the moment:

[liveuser@eos-2021.12.17 ~]$ sudo umount /mnt
umount: /mnt: not mounted.
[liveuser@eos-2021.12.17 ~]$ sudo mount -t btrfs /dev/nvme0n1p2 /mnt -o 
subvol=@
mount: /mnt: mount(2) system call failed: File exists.
[liveuser@eos-2021.12.17 ~]$

A check reports everything in order:

[liveuser@eos-2021.12.17 ~]$ sudo btrfs check --check-data-csum -p 
/dev/nvme0n1p2
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 21b3cc23-6e76-45bf-acd2-d99dc24cc0d8
[1/7] checking root items                      (0:00:02 elapsed, 2083036 
items checked)
[2/7] checking extents                         (0:00:13 elapsed, 244780 
items checked)
[3/7] checking free space cache                (0:00:00 elapsed, 1148 
items checked)
[4/7] checking fs roots                        (0:00:29 elapsed, 147302 
items checked)
[5/7] checking csums against data              (0:10:28 elapsed, 712198 
items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 30 
items checked)
[7/7] checking quota groups                    (0:00:24 elapsed, 1843328 
items checked)
found 1174419738624 bytes used, no error found
total csum bytes: 1141823932
total tree bytes: 4009918464
total fs tree bytes: 2423521280
total extent tree bytes: 225329152
btree space waste bytes: 732619798
file data blocks allocated: 2454781140992
  referenced 1403791265792
[liveuser@eos-2021.12.17 ~]$

I have not done any writes to the device, I wanted to wait with that 
until I have a clearer picture of what is wrong.

Required information for the live USB boot:

uname -a: Linux EndeavourOS 5.15.8-arch1-1 #1 SMP PREEMPT Tue, 14 Dec 
2021 12:28:02 +0000 x86_64 GNU/Linux
btrfs --version: btrfs-progs v5.15.1
sudo btrfs fi show:

Label: none  uuid: 21b3cc23-6e76-45bf-acd2-d99dc24cc0d8
	Total devices 1 FS bytes used 1.07TiB
	devid    1 size 1.83TiB used 1.12TiB path /dev/nvme0n1p2

Link to the dmesg parts I though were relevant (from the live USB): 
https://forum.endeavouros.com/t/btrfs-file-system-unmountable-no-boot-and-access-possible/34586?u=dromundkaas

