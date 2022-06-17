Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE42054F568
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381534AbiFQKcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381084AbiFQKcu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:32:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A930F18B02;
        Fri, 17 Jun 2022 03:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69EFAB82967;
        Fri, 17 Jun 2022 10:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BCBC3411D;
        Fri, 17 Jun 2022 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655461967;
        bh=i9jJsMaMcHwPUAYOS2hcoM3x0+hTlHXBOYcA3WInnYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP+Nz0SlbXslcMXXiBEpjBrwMXjdao84fZw+fbMhK07JRFp+CtqxhS5WV5Bd+7d9t
         FfY1KHhZ1enA5XOc6z/kAOV0vwoWVrdT0/zCfW/62DE4wfXndlwWIfJq1zlPYnbdQF
         T5+OznROi1kwu59eg/PRK+USTCNGzlq1CJGuQpX3oKX+xFuEF2vQ47+8WjfNWbwrvC
         oVJsah7VJp0w+YKxH4e0Numv9Vbf5QWyxpG0wJdJGWbfMWNgm4IRh4ev33883cUhMc
         MUF9JviPq0XZtfb3i0lVPG+86VqmwJkfbP1EEOo053sFM7l4sjY76a4iSQyuk7+iWP
         24l4sn27+KnLg==
Date:   Fri, 17 Jun 2022 11:32:44 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [btrfs] 62bd8124e2:
 WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
Message-ID: <20220617103244.GA4042635@falcondesktop>
References: <bf924988687205627604f36cbd8ff13936e938ab.1654009356.git.fdmanana@suse.com>
 <20220608152303.GB31193@xsang-OptiPlex-9020>
 <20220609094652.GB3668047@falcondesktop>
 <20220610012659.GA6844@xsang-OptiPlex-9020>
 <20220612143646.GA35020@xsang-OptiPlex-9020>
 <CAL3q7H6mD=i_xBJbYD2JsK5EuHHKirbU8-9jtDoDjMqK2jKsjQ@mail.gmail.com>
 <20220616024204.GA25633@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616024204.GA25633@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 10:42:04AM +0800, Oliver Sang wrote:
> hi, Filipe Manana,
> 
> On Mon, Jun 13, 2022 at 11:50:05AM +0100, Filipe Manana wrote:
> > 
> > Thanks for running the test again Oliver.
> > Running the fxmark test on my machines, I can't trigger anything.
> > 
> > May I ask you to run again the test but with the attached debug patch
> > on top of it?
> 
> I reran the test by applied your patch upon 62bd8124e2. one dmesg is attached.
> 
> not sure if it supplies enough information? we need some extra effort to
> enable below ftrace in our auto-test framework. so if dmesg is good enough,
> please let us know, then we can save some efforts :) Thanks a lot!

Thanks Oliver.

In the meanwhile I found a way to reproduce the issue with a test case
from fstests, so I now have everything I need to debug and fix the issue.

Thanks!

> 
> > 
> > Also, if possible, with ftrace enabled like this:
> > 
> > modprobe btrfs
> > echo 0 > /sys/kernel/debug/tracing/tracing_on
> > echo > /sys/kernel/debug/tracing/trace
> > echo $((1 << 24)) > /sys/kernel/debug/tracing/buffer_size_kb
> > echo nop > /sys/kernel/debug/tracing/current_tracer
> > echo 1 > /sys/kernel/tracing/events/btrfs/btrfs_space_reservation/enable
> > 
> > echo 1 > /sys/kernel/debug/tracing/tracing_on
> > 
> > <run the test>
> > 
> > echo 0 > /sys/kernel/debug/tracing/tracing_on
> > 
> > Then collect the trace to a file and send it over to me:
> > 
> > cat /sys/kernel/debug/tracing/trace | xz -9 > trace.txt.xz
> > 
> > And of course, the dmesg result as well.
> > 
> > Thanks!
> > 
> > 
> > 
> > >
> > > >
> 


