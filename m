Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211B54EC61
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379070AbiFPVRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378629AbiFPVR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 17:17:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7260B80;
        Thu, 16 Jun 2022 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qT5M40xVA9YnszhgxwSPNtZNbPHFTpABYZWNZDdTHlI=; b=BQnYHJKQUoFq1xNokbxBotCcO6
        fyX8/6LmROrO9P++bZSv3kWeFXeZaugSW6NQmDIfxNF8lEhvvHaFfEJ412vfN2qShpy68qrAfbVWD
        VYapUQ8KpjH42R+a1yT+iOjZlKpXZqk/a95v3lJsgBYV3qmSRN4/+vuACmsP9lSj2LdoqHRosNHWs
        i4j/UveqfwOJk0K7CfX9G6VN5EcLjiJCu5JCbbT+xWw3liZRBsAy//H94/Ai0PouDtrSzAkj0yc+p
        3SEVjc0nAAEAISk1FZUUGzM/iHhbnx8ZI37z40tU+VtHw+BeZWW38OUStHwWNKXlfResq3o6eUQaI
        xOg3rZmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1wrX-002H7V-F4; Thu, 16 Jun 2022 21:17:11 +0000
Date:   Thu, 16 Jun 2022 22:17:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Sterba <dsterba@suse.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org
Subject: Re: [btrfs]  66a7a2412f: xfstests.btrfs.131.fail
Message-ID: <Yqud1/SooVDamiuP@casper.infradead.org>
References: <20220607154229.9164-1-dsterba@suse.com>
 <20220616143710.GF25633@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616143710.GF25633@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 10:37:10PM +0800, kernel test robot wrote:
> btrfs/131	- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/131.out.bad)
>     --- tests/btrfs/131.out	2022-06-13 17:10:24.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/131.out.bad	2022-06-15 18:54:06.505508542 +0000
>     @@ -2,9 +2,9 @@
>      Using free space cache
>      free space tree is disabled
>      Enabling free space tree
>     -free space tree is enabled
>     +free space tree is disabled

I think I know what's going on here:

        compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV"
 | \
                     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
        if ((compat_ro & 0x1)); then
                echo "free space tree is enabled"
        else
                echo "free space tree is disabled"
        fi

dump-super is reading the super block out of the page cache, but this
change makes the page cache incoherent with what's on disc.  We could
fix that by invalidating the page out of the page cache, but it may be
easier to just dump this patch and fix how we use the page cache to
write back the superblocks?

