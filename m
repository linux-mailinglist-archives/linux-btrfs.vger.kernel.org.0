Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F56E481C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502031AbfJYKFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 06:05:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439297AbfJYKFv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 06:05:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CC25BA5D;
        Fri, 25 Oct 2019 10:05:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35AD2DA733; Fri, 25 Oct 2019 12:05:18 +0200 (CEST)
Date:   Fri, 25 Oct 2019 12:05:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: provide an estimated number of inodes for
 statfs
Message-ID: <20191025100518.GL3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191024154455.19370-1-jthumshirn@suse.de>
 <20191024154455.19370-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024154455.19370-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 24, 2019 at 05:44:55PM +0200, Johannes Thumshirn wrote:
> On the BeeGFS Mailing list there is a report claiming BTRFS is not usable
> with BeeGFS, as BeeGFS is using statfs output to determine the number of
> total and free inodes. BeeGFS needs the number of free inodes as it stores
> its meta-data either in extended attributes of the underlying file-system
> or directly in an inline inode. According to the BeeGFS Server Tuning
> Guide:
> 
> """
> BeeGFS metadata is stored as extended attributes (EAs) on the underlying
> file system to optimal performance. One metadata file will be created for
> each file that a user creates. About extended attributes usage: BeeGFS
> Metadata files have a size of 0 bytes (i.e. no normal file contents).

That's not really typical use of a files and the 'optimal performance'
claim would need some clarifications.

> Access to extended attributes is possible with the getfattr tool.
> 
> If the inodes of the underlying file system are sufficiently large, EAs
> can be inlined into the inode of the underlying file system.  Additional
> data blocks are then not required anymore and metadata disk usage will be
> reduced.  With EAs inlined into the inode, access latencies are reduced as
> seeking to an extra data block is not required anymore.

So this describes how it's implemented in EXT4 and the BeeGFS is
probably tuned to work 'optimally' there.

> """
> 
> Provide some estimated numbers of total and free inodes in statfs by
> dividing the number of blocks by the size of an inode-item for the total
> number of possible inodes and for the number of free inodes divide the
> number of free blocks by the size of an inode-item, similar to what other
> file-systems without a fixed number of inodes do.
> 
> This of is just an estimation and should not be relied upon.

This is the most problematic part. The inode counts cannot be calculated
exactly on btrfs, because of the dynamic nature of the space usage. We
can only give rough estimates "how the rest of unallocated space would
be used if [assumptions]". We have this problem with explaining 'df'
values and now somebody is asking for the same with 'df -i'.

The Inode/IFree numbers are intentionally zero, to avoid confusion of
monitoring tools to report low inode counts. Though I can't find a
documented and standardized interpretation of the numbers, manual page
of statfs only says

	fsfilcnt_t f_files;   /* Total file nodes in filesystem */
	fsfilcnt_t f_ffree;   /* Free file nodes in filesystem */

for the respective fields. And nothing else.

For traditional filesystems, and EXT2/3/4 in particular, the inodes are
preallocated at creation time so calculating the numbers is easy.

I believe XFS does that too without the option inode64, so users are
used to see non-zero value and nowadays it has to be faked. That makes
sense from backward compatibility POV. But still the numbers are made up
and can change unexpectedly.

Btrfs has reported 0/0/0 since the beginning to not cofuse monitoring
tools, yet this is exactly what can be seen at

https://groups.google.com/forum/#!msg/fhgfs-user/IJqGS5o1UD0/8ftDdUI3AQAJ

I'd say fix your monitoring tool not to interpret 0% free inodes in case
there's also 0 in total. This is not even btrfs-specific fix, IMHO this
is interpreting the numbers in the wrong way.

> Without the patch applied:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /mnt/test      btrfs         0     0     0     - /mnt/test
> 
> With the patch applied on an empty fs:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /dev/zram0     btrfs      1.6K     0  1.6K    0% /mnt/test
> 
> With the patch applied on a dirty fs:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /dev/zram0     btrfs      1.6K  1.5K   197   88% /mnt/test

At the moment I object against conjuring up numbers like that. It's
perhaps going to silence some tools but would cause lots of questions
because the numbers otherwise don't reflect reality, not even close.

We try hard to make the regular Allocated/Free space numbers to match
users' expectations, but it's not perfect and can't be made much better.
And I'm glad we have a simple answer to the inode counts.

Should the discussion continue, it would be good to have interested
people from BeeGFS on CC.
