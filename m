Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3525127540D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWJJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 05:09:36 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:57077
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgIWJJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 05:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:subject:
         from:to:from;
        bh=DYNBs8mUbVpq7bZNbD3SF0WxO5tQ7OLtyvIVKFnPLOs=;
        b=dZlWVDQR0mpLUl9wnzlt2slaUDBxHxB+62pHXoQUNkOH3PyjLJrdliJG+l3WvQurnEEl5YB8YvSJZ
         7nQzpHh4fYNLPH45D6mT2N9KQDKCXSKs/DGRcfYm3w9AYZeGa6VdUXQLuqVSVDkgyx3CttF6K+VINI
         VaI+Tui0RKk1zRaSswbvqK2d/br88eGV9Gsfvje9i+6JiwcwfHnr9mSwX9WVDTdHQzMJch5TRRQpvQ
         bS1kLNoAHeJWoOScq7Wxa73iOpQbV6KvkihPvqeNmLyStukiwDuvHL55BBZxi7uAxkphry+8DUMatj
         QC/AdjZH3+6WdRdDJhZeAVRwed80Yxw==
X-HalOne-Cookie: f4f53ba8780f118bf324cc8360a8dfa20f6335fd
X-HalOne-ID: 7e87528f-fd7c-11ea-a2ae-d0431ea8bb10
Received: from [10.0.155.198] (unknown [98.128.186.110])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 7e87528f-fd7c-11ea-a2ae-d0431ea8bb10;
        Wed, 23 Sep 2020 09:09:33 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   A L <mail@lechevalier.se>
Subject: Loopback device ontop of Btrfs - no compression happening
Message-ID: <f53a13bf-36c2-1335-d073-b9f6064a549c@lechevalier.se>
Date:   Wed, 23 Sep 2020 11:09:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've seen several people having issues with compression not happening on 
VM images ontop of Btrfs, for example QEMU raw image format.

I did some local testing and it seems that also images for loop devices 
also do not get any compression.

Currently running kernel-5.8.10, but I believe this happens on many 
earlier versions too.

TEST-case to verify:
Created a file using ddrescue on a filesystem mounted with 
"noatime,compress=zstd:2,space_cache=v2"

# ls -laF
     drwxr-xr-x 3 root root        4096 Sep 22 18:03 loop/
     -rw-r--r-- 1 root root 10540285952 Sep 22 18:04 loop.bin

The file is compressed as expected:
# compsize loop.bin
     Type       Perc     Disk Usage   Uncompressed Referenced
     TOTAL        3%      314M         9.8G         9.8G
     zstd         3%      314M         9.8G         9.8G

Setup the loop-device. Make sure we do not use Direct-IO (it should be 
default, but still..)
# losetup -f --direct-io=off loop.bin

Create a filesystem on it.
# mkfs.ext4 -L loop /dev/loop0

I guess mkfs.ext4 did a full fstrim. However no data is compressed.
# compsize loop.bin
     Type       Perc     Disk Usage   Uncompressed Referenced
     TOTAL      100%       68M          68M          68M
     none       100%       68M          68M          68M

Lets mount it and add some compressible data to the new loop filesystem.
# mount /dev/loop0 loop
# ddrescue /dev/zero loop/bigfile.bin -s 2G
# compsize loop.bin
     Type       Perc     Disk Usage   Uncompressed Referenced
     TOTAL      100%      1.9G         1.9G         1.9G
     none       100%      1.9G         1.9G         1.9G

Nothing is compressed.

# lsattr loop.bin
     --------c----------- loop.bin
# ls -lsh loop.bin
     2.0G -rw-r--r-- 1 root root 9.9G Sep 23 11:00 loop.bin

# btrfs filesystem defragment loop.bin
# compsize loop.bin
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       87%      1.6G         1.9G         1.9G
none       100%      1.6G         1.6G         1.6G
zstd         3%      8.2M         263M         263M

Let's try again.
# btrfs filesystem defragment -t4G loop.bin
# compsize loop.bin
     Type       Perc     Disk Usage   Uncompressed Referenced
     TOTAL        4%       88M         1.9G         1.9G
     none       100%       27M          27M          27M
     zstd         3%       60M         1.9G         1.9G

However, as soon as we write to the looped filesystem the compression 
gets lost.
# ddrescue /dev/zero loop/bigfile.bin -s 2G -fv
# compsize loop.bin
     Type       Perc     Disk Usage   Uncompressed Referenced
     TOTAL       96%      1.8G         1.9G         1.9G
     none       100%      1.8G         1.8G         1.8G
     zstd         3%      2.1M          68M          68M



Am I missing some option to allow compression? I have a vague memory 
that looped devices used to be able to be compressed. Perhaps this is a 
regression last couple of years?


I think that using loop stored as compressed images is a valid use-case 
and it would be really nice to solve this.

Thanks.


