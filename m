Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB5613865
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJaNuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaNun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 09:50:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506921007D;
        Mon, 31 Oct 2022 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=90l0xMDfoydDKFAg0A7yI5g7blQBB1Ycz7ypF56IvPI=; b=JZ1wlGEucLk4wUUQtrFa+KZtxR
        rYuuKI/gQZOMXZkXU9Nj197NwMbtUAypqolSFHnd/MW649uEqnKbdz1TQsCM/esQcFTGMhdcUOg1e
        3TA5pRZGSc7SCqnYKNoUZEs7v3yicIKM8CUjyW7vJhfbrmwkOrIET31YJrrXKJuA+xI6DApj98rYJ
        iky1b4L667KN/KACCfaSHcVBkmWf/yoVCWtkqk/YphO+uAKCO2fnJUIhXcMLAs0wV/R7vtdhNiqan
        hPGoVHNyTTOxtgXfNEdi3Lyi0ZPPGn7tU/UAGWL8a5oNKMsDRzPSW4qahlPAYiUDyjD1mekrfdtbq
        iiPrqOOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opVBQ-003ih3-Vx; Mon, 31 Oct 2022 13:50:33 +0000
Date:   Mon, 31 Oct 2022 13:50:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linmiaohe@huawei.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: [syzbot] WARNING in btrfs_space_info_update_bytes_may_use
Message-ID: <Y1/SqIuP4tbszPAW@casper.infradead.org>
References: <0000000000000d9d6f05ec498263@google.com>
 <000000000000fa42c105ec5339ec@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fa42c105ec5339ec@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dmitry, I don't see a way to tell syzbot that its bisection has gone
astray.  Can you add one or document it if it already exists?

On Mon, Oct 31, 2022 at 04:51:22AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0c7c575df56b957390206deb018c41acbb412159
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Wed Feb 24 20:01:52 2021 +0000
> 
>     mm/filemap: remove dynamically allocated array from filemap_read

This change affects the read path.  The crash happens in the unmount
path.  The data structure that's being checked is modified in the write
path.  I just can't see how this commit is in any way related.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119e21b6880000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=139e21b6880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=159e21b6880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db9ab1880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e21b6880000
> 
> Reported-by: syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com
> Fixes: 0c7c575df56b ("mm/filemap: remove dynamically allocated array from filemap_read")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
