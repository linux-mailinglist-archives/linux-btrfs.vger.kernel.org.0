Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCB27EFD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgI3Q7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 12:59:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgI3Q7S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 12:59:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 865BEABE3;
        Wed, 30 Sep 2020 16:59:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F9E0DA781; Wed, 30 Sep 2020 18:57:56 +0200 (CEST)
Date:   Wed, 30 Sep 2020 18:57:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
Message-ID: <20200930165756.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000001fe79005afbf52ea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001fe79005afbf52ea@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 20, 2020 at 07:12:14AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a8bb900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
> dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com

#syz fix: btrfs: fix overflow when copying corrupt csums for a message
