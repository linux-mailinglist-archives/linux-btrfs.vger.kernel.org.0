Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8942FF10D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 17:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbhAUQvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 11:51:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:39194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbhAUP5u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 10:57:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90E5DAB7A;
        Thu, 21 Jan 2021 15:56:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1211FDA6E3; Thu, 21 Jan 2021 16:54:18 +0100 (CET)
Date:   Thu, 21 Jan 2021 16:54:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 13/14] lib/zstd: Convert constants to defines
Message-ID: <20210121155418.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210120102526.310486-1-nborisov@suse.com>
 <20210120102526.310486-14-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120102526.310486-14-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 12:25:25PM +0200, Nikolay Borisov wrote:
> Those constants are really used internally by zstd and including
> linux/zstd.h into users results in the following warnings:
> 
> In file included from fs/btrfs/zstd.c:19:
> ./include/linux/zstd.h:798:21: warning: ‘ZSTD_skippableHeaderSize’ defined but not used [-Wunused-const-variable=]
>   798 | static const size_t ZSTD_skippableHeaderSize = 8;
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/zstd.h:796:21: warning: ‘ZSTD_frameHeaderSize_max’ defined but not used [-Wunused-const-variable=]
>   796 | static const size_t ZSTD_frameHeaderSize_max = ZSTD_FRAMEHEADERSIZE_MAX;
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/zstd.h:795:21: warning: ‘ZSTD_frameHeaderSize_min’ defined but not used [-Wunused-const-variable=]
>   795 | static const size_t ZSTD_frameHeaderSize_min = ZSTD_FRAMEHEADERSIZE_MIN;
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/zstd.h:794:21: warning: ‘ZSTD_frameHeaderSize_prefix’ defined but not used [-Wunused-const-variable=]
>   794 | static const size_t ZSTD_frameHeaderSize_prefix = 5;
> 
> So fix those warnings by turning the constants into defines.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  include/linux/zstd.h | 8 ++++----

That's not our file and you haven't CCed the maintainer, we can't modify
that code without an ack.
