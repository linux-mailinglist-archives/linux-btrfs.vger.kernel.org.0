Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BF69DDDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjBUK2Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 05:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBUK2P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 05:28:15 -0500
Received: from out28-62.mail.aliyun.com (out28-62.mail.aliyun.com [115.124.28.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E719766
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 02:28:13 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04445626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0242546-0.00499532-0.97075;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.RSfe4JR_1676975289;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RSfe4JR_1676975289)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 18:28:10 +0800
Date:   Tue, 21 Feb 2023 18:28:11 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz
Subject: Re: [PATCH] btrfs: restore assertion failure to the code line where it happens
Cc:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20230206181116.GB28288@twin.jikos.cz>
References: <4fd172e0-bfe5-681d-8e81-bc5955922456@oracle.com> <20230206181116.GB28288@twin.jikos.cz>
Message-Id: <20230221182810.B3E4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Tue, Jan 31, 2023 at 07:11:43PM +0800, Anand Jain wrote:
> > On 1/27/23 21:32, David Sterba wrote:
> > > In commit 083bd7e54e8e ("btrfs: move the printk and assert helpers to
> > > messages.c") btrfs_assertfail got un-inlined. This means that assertion
> > > failures would all report as messages.c:259 as below, so make it inline
> > > again.
> > > 
> > >    [403.246730] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
> > >    [403.247935] ------------[ cut here ]------------
> > >    [403.248405] kernel BUG at fs/btrfs/messages.c:259!
> > 
> > 
> > Hmm. We have the line number shown from the assert as block-group.c:4259 
> > here.
> > 
> > messages.c:259 is from the BUG() called by btrfs_assertfail().
> > 
> > Commit 083bd7e54e8e didn't introduce it. Here is some random example of 
> > calling the ASSERT() from 2015.
> 
> Right, after double checking the code only got moved, not uninlined.
> 
> > ------------------------
> > commit 67c5e7d464bc466471b05e027abe8a6b29687ebd
> > <snap>
> >      [181631.208236] BTRFS: assertion failed: 0, file: 
> > fs/btrfs/volumes.c, line: 2622
> >      [181631.220591] ------------[ cut here ]------------
> >      [181631.222959] kernel BUG at fs/btrfs/ctree.h:4062!
> > ------------------------
> > 
> > 
> > >   #ifdef CONFIG_BTRFS_ASSERT
> > > -void __cold btrfs_assertfail(const char *expr, const char *file, int line);
> > 
> > > +static inline void __cold __noreturn btrfs_assertfail(const char *expr,
> > 
> > Further, this won't make all the calls to btrfs_assertfail() as inline 
> > unless __always_inline is used.
> 
> The always_inline has a bit stronger semantics and it would be safer to
> use it here though the function is short enough to be considered for
> inlining.
> 
> If the inlining or not is useful would need to be measured, inlining
> grows the function code vs just a function call. I'll may be do that but
> for now the code can stay as is.

This patch is yet not in misc-next?

By the way , '__cold' is meanless for inline?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/21



