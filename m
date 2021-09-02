Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4082E3FF32E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIBSX2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 14:23:28 -0400
Received: from mail57.us4.mandrillapp.com ([205.201.136.57]:11915 "EHLO
        mail57.us4.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241841AbhIBSXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 14:23:25 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 14:23:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexedi.com;
        s=mandrill; t=1630605863; i=jm@nexedi.com;
        bh=nQ6uIJALnoFytDZD1bWNUGrHYCSOC0cFQlM1kGbnzk0=;
        h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=jmFMd/4QUfkCIEa8FfOrIVqhmlZPfW/5O+BDCuOBSuUv7ULDKoLqCFE8OjJ6hElEo
         Iw9UpU25eEYkTc32RGC6EMI+9SXo/2KQcprcszzZ0fK9GTnByNGDsr/vkZw4MchmP6
         SzprbC+nW51eqsE1cvmmdnlcPHISXewKEMqGqaqw=
Received: from pmta15.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
        by mail57.us4.mandrillapp.com (Mailchimp) with ESMTP id 4H0pj33vqzz35hcjD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 18:04:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1630605863; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=nQ6uIJALnoFytDZD1bWNUGrHYCSOC0cFQlM1kGbnzk0=; 
 b=lLu/rmUzcDUyC70Od72lUQrXZJ3zxZxvzZeyg9j2o95xnELnd7FAA2RIuEJpCuCIFygKN9
 8rC2YwqvbI1fHWOhEP3QdlI29aTw9gJkO91+bGtuV9eoSPzY98L5FVPO+ciWPJ3NtErKeBo4
 /Fvo8gf0ouy3c/l6gctsKeqo0qHzE=
From:   Julien Muchembled <jm@nexedi.com>
Subject: fallocate + ftruncate
Received: from [87.98.221.171] by mandrillapp.com id 539f960afd6b473ab2bd29241ad79c24; Thu, 02 Sep 2021 18:04:23 +0000
To:     linux-btrfs@vger.kernel.org
Cc:     Vincent Pelletier <vincent@nexedi.com>
Message-Id: <ed3642c2-682e-08a1-f18d-2d63409b7631@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.539f960afd6b473ab2bd29241ad79c24
X-Mandrill-User: md_31050260
Feedback-ID: 31050260:31050260.20210902:md
Date:   Thu, 02 Sep 2021 18:04:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd like to report what seems to be a Btrfs bug. XFS does not have this issue.

On a machine (kernel 4.19.181) that has several RocksDB databases, some on XFS and other on Btrfs, we noticed that disk usage increases significantly faster on Btrfs. RocksDB pattern for SST files is:

1. fallocate(A)
2. write(B) with B < A
3. fruncate(B)
4. close

And no more modification after that.

It took us a while to understand what's going on because strangely, even 'btrfs filesystem du' does not report the actual disk usage. compsize does, e.g.

  # stat mariadb/#rocksdb/164719.sst
    File: mariadb/#rocksdb/164719.sst
    Size: 8127109         Blocks: 15880      IO Block: 4096   regular file
  Device: 33h/51d Inode: 24913       Links: 1
  ...
  # compsize -b mariadb/#rocksdb/164719.sst
  Type       Perc     Disk Usage   Uncompressed Referenced
  TOTAL      100%     147640320    147640320    8130560
  none       100%     147640320    147640320    8130560

Almost 140MB wasted.

compsize is a bit old but btrfs-search-metadata confirms there's only 1 extent:
  inode objectid 24913 generation 184524 transid 184524 size 8127109 nbytes 8130560 block_group 0 mode 0100640 nlink 1 uid 982 gid 1019 rdev 0 flags 0x10(PREALLOC)
  inode ref list objectid 24913 parent_objectid 283 size 1
    inode ref index 24528 name utf-8 '164719.sst'
  extent data at 0 generation 184524 ram_bytes 147640320 compression none type regular disk_bytenr 1210397491200 disk_num_bytes 147640320 offset 0 num_bytes 8130560

I could reproduce the issue on kernel 5.13.9, with the following program:

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  char buf[4096];
  int fd = open(argv[1], O_CREAT|O_WRONLY|O_EXCL, 0666);
  if (fd < 0 || fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, 1<<24) < 0)
    return -1;
  size_t n = 0;
  for (ssize_t i; i = read(0, buf, sizeof buf);) {
    if (i < 0 || write(fd, buf, i) != i)
      return -1;
    n += i;
  }
  if (ftruncate(fd, n) < 0 ||
      close(fd) < 0)
    return -1;
  return 0;
}

$ ./tst dst < src # src size should be < 16MiB

$ stat dst 
  File: dst
  Size: 19374           Blocks: 40         IO Block: 4096   regular file
Device: 3eh/62d Inode: 2253170     Links: 1
...

$ compsize -b dst 
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced  
TOTAL      100%     16777216     16777216     20480       
prealloc   100%     16777216     16777216     20480       

'btrfs fi defrag dst' does nothing, probably because there's only 1 extent.

While trying to fix the file, I found what may be another bug. I tried many options of /usr/bin/fallocate without success. But the strangest is:

$ fallocate -p -o 19374 -l 16777216 dst

I hoped that deallocation shrinks the extent but instead it appends a second one:

$ compsize -b dst 
Processed 1 file, 2 regular extents (2 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced  
TOTAL      100%     16781312     16781312     20480       
none       100%     16781312     16781312     20480       

Ironically, now that I have a second extent:

$ btrfs fi defrag dst

$ compsize -b dst 
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced  
TOTAL      100%     20480        20480        20480       
none       100%     20480        20480        20480       

Julien
