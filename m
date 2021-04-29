Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4605B36F0B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhD2T6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 15:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236659AbhD2T6B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 15:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67838B164;
        Thu, 29 Apr 2021 19:57:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1665ADA7D2; Thu, 29 Apr 2021 21:54:50 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:54:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: image: make restored image file to
 be properly enlarged
Message-ID: <20210429195449.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210429090658.245238-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429090658.245238-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 05:06:55PM +0800, Qu Wenruo wrote:
> Recent kernel will refuse to mount restored image, even the source fs is
> empty:
>  # mkfs.btrfs -f /dev/test/test
>  # btrfs-image /dev/test/test /tmp/dump
>  # btrfs-image -r /tmp/dump ~/test.img
>  # mount ~/test.img /mnt/btrfs
>  mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>  # dmesg -t | tail -n 7
>  loop0: detected capacity change from 10592 to 0
>  BTRFS info (device loop0): disk space caching is enabled
>  BTRFS info (device loop0): has skinny extents
>  BTRFS info (device loop0): flagging fs with big metadata feature
>  BTRFS error (device loop0): device total_bytes should be at most 5423104 but found 10737418240
>  BTRFS error (device loop0): failed to read chunk tree: -22
>  BTRFS error (device loop0): open_ctree failed
> 
> This is triggered by a recent kernel commit 3a160a933111 ("btrfs: drop never met disk total
> bytes check in verify_one_dev_extent").
> 
> But the root cause is, we didn't enlarge the output file if the source
> image only contains single device.
> 
> This bug won't affect restore to block device, or the destination file
> is already large enough.
> 
> This patchset will fix the problem, and with new test case to detect
> such problem.
> 
> Also remove one dead code exposed during the development.
> 
> Changelog:
> v2:
> - Comments word change
> - Only enlarge the file when the target file is smaller than expected
>   device size
> - Change the prefix of the 1st patch
>   From "btrfs" to "btrfs-progs"
> 
> Qu Wenruo (3):
>   btrfs-progs: image: remove the dead stat() call
>   btrfs-progs: image: enlarge the output file if no tree modification is
>     needed for restore
>   btrfs-progs: misc-tests: add test to ensure the restored image can be
>     mounted

Added to devel, thanks.
