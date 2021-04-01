Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D651B35189F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhDARq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 13:46:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234906AbhDARni (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E8FFB242;
        Thu,  1 Apr 2021 15:18:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE3F8DA790; Thu,  1 Apr 2021 17:16:43 +0200 (CEST)
Date:   Thu, 1 Apr 2021 17:16:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove useless call "zlib_inflateEnd"
Message-ID: <20210401151643.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1617099421-58511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617099421-58511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 06:17:01PM +0800, Jiapeng Chong wrote:
> Fix the following whitescan warning:
> 
> Calling "zlib_inflateEnd(&workspace->strm)" is only useful for its
> return value, which is ignored.

According to the zlib API documentation in include/linux/zlib.h

301 extern int zlib_deflateEnd (z_streamp strm);
302 /*
303      All dynamically allocated data structures for this stream are freed.
304    This function discards any unprocessed input and does not flush any
305    pending output.
306
307      deflateEnd returns Z_OK if success, Z_STREAM_ERROR if the
308    stream state was inconsistent, Z_DATA_ERROR if the stream was freed
309    prematurely (some input or output was discarded). In the error case,
310    msg may be set but then points to a static string (which must not be
311    deallocated).
312 */

The first paragraph says it could free data, so the call needs to be
there. The return value could have some meaning as it could point out to
some inconsistency in zlib internal state but just deleting is IMO
wrong.
