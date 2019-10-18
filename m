Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152F2DD097
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393907AbfJRUsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 16:48:47 -0400
Received: from mailfilter05-out31.webhostingserver.nl ([141.138.168.205]:15318
        "EHLO mailfilter05-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729259AbfJRUsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 16:48:47 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 16:48:46 EDT
X-Halon-ID: 4db2bc8e-f1e1-11e9-acf9-001a4a4cb933
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter05.webhostingserver.nl (Halon) with ESMTPSA
        id 4db2bc8e-f1e1-11e9-acf9-001a4a4cb933;
        Fri, 18 Oct 2019 19:55:58 +0000 (UTC)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1iLYvP-009hH1-0z; Fri, 18 Oct 2019 22:32:39 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190924081120.6283-1-wqu@suse.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
Date:   Fri, 18 Oct 2019 22:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20190924081120.6283-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 24-09-2019 om 10:11 schreef Qu Wenruo:
> We have at least two user reports about bad inode generation makes
> kernel reject the fs.

May I add my report? I just upgraded Ubuntu from 19.04 -> 19.10 so 
kernel went from 5.0 -> 5.3 (but I was using 4.15 too).

Booting 5.3 leaves me in initramfs as I have /boot on @boot and / on /@

In initramfs I can try to mount but get something like
btrfs critical corrupt leaf invalid inode generation open_ctree failed

Booting old kernel works just as before, no errors.

> According to the creation time, the inode is created by some 2014
> kernel.

How do I get the creation time?

> And the generation member of INODE_ITEM is not updated (unlike the
> transid member) so the error persists until latest tree-checker detects.
> 
> Even the situation can be fixed by reverting back to older kernel and
> copying the offending dir/file to another inode and delete the offending
> one, it still should be done by btrfs-progs.
> 
How to find the offending dir/file from the command line manually?

> This patchset adds such check and repair ability to btrfs-check, with a
> simple test image.
> 
> Qu Wenruo (3):
>    btrfs-progs: check/lowmem: Add check and repair for invalid inode
>      generation
>    btrfs-progs: check/original: Add check and repair for invalid inode
>      generation
>    btrfs-progs: fsck-tests: Add test image for invalid inode generation
>      repair
> 
>   check/main.c                                  |  50 +++++++++++-
>   check/mode-lowmem.c                           |  76 ++++++++++++++++++
>   check/mode-original.h                         |   1 +
>   .../.lowmem_repairable                        |   0
>   .../bad_inode_geneartion.img.xz               | Bin 0 -> 2012 bytes
>   5 files changed, 126 insertions(+), 1 deletion(-)
>   create mode 100644 tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
>   create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz
> 

