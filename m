Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928D54A1E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFRNTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 09:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfFRNTt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 09:19:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AFF1B011
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:19:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C071DA871; Tue, 18 Jun 2019 15:20:36 +0200 (CEST)
Date:   Tue, 18 Jun 2019 15:20:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: GCC9 fixes
Message-ID: <20190618132036.GO19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190617075936.12113-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617075936.12113-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 17, 2019 at 03:59:32PM +0800, Qu Wenruo wrote:
> This patchset will address the remaining warning when compiling
> btrfs-progs devel branch with GCC9.
> 
> It's based on the following commit:
> commit 9a1d86a9ac7384b332db498822585a2255f7d3e6 (david/devel)
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu Jun 13 20:45:49 2019 +0200
> 
>     btrfs-progs: build: disable -Waddress-of-packed-member by default
> 
> 
> Please note that the 2nd patch mostly replace commit 691656abdc9a
> ("btrfs-progs: fix gcc9 warning and potentially unaligned access to dev stats") by
> backporing kernel btrfs_dev_stats_value() to btrfs-progs.
> Thus the original fix can be removed.

Yeah, the backport is better, patch replaced.

> The remaining warning is -Warray-boundary, but that one looks pretty
> strange. The code looks good, and I backported an easy version:
> 
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <stddef.h>
>   
>   struct test_struct {
>   	long long off_0_7;
>   	int	offset_8_11;
>   	unsigned char offset_12_12;
>   } __attribute__ ((packed));
>   
>   void reset_values(struct test_struct *ptr)
>   {
>   	memset(&ptr->offset_8_11, 0, sizeof(struct test_struct) - offsetof(struct test_struct, offset_8_11));
>   }
>   
>   int main()
>   {
>   	struct test_struct my_struct = { 0xffff, 0xff, 0xff};
>   
>   	printf("struct=0x%llx start=0x%llx len=0x%x\n",
>   		&my_struct, &my_struct.offset_8_11, sizeof(struct test_struct) - offsetof(struct test_struct, offset_8_11));
>   	reset_values(&my_struct);
>   	printf("0x%lx 0x%x 0x%x\n", my_struct.off_0_7, my_struct.offset_8_11, my_struct.offset_12_12);
>   	return 0;
>   }
> 
> Which doesn't reproduce the warning.
> Thus looks like a false warning and a bug in gcc.


> 
> Qu Wenruo (4):
>   btrfs-progs: constify extent buffer reader
>   btrfs-progs: Fix -Waddress-of-packed-member warning in
>     btrfs_dev_stats_values callers
>   btrfs-progs: Remove unnecessary fallthrough attribute in
>     test_num_disk_vs_raid()
>   btrfs-progs: Fix Wformat-overflow warning in cmds-receive.c

1-4 applied, thanks.
