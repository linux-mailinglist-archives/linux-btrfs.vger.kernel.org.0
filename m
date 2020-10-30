Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7232A0551
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 13:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgJ3M1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 08:27:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgJ3M1A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 08:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C9C8ABAE;
        Fri, 30 Oct 2020 12:26:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8BFF9DA80D; Fri, 30 Oct 2020 13:25:23 +0100 (CET)
Date:   Fri, 30 Oct 2020 13:25:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in close_fs_devices (2)
Message-ID: <20201030122523.GY6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dmitry Vyukov <dvyukov@google.com>,
        Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000008fbadb05af94b61e@google.com>
 <01bcf380-c806-02fa-67ac-ff66fd0100c7@oracle.com>
 <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 11:10:58AM +0100, Dmitry Vyukov wrote:
> On Tue, Sep 22, 2020 at 2:37 PM Anand Jain <anand.jain@oracle.com> wrote:
> > On 18/9/20 7:22 pm, syzbot wrote:
> > #syz fix: btrfs: fix rw_devices count in __btrfs_free_extra_devids
> 
> Is it the correct patch title? It still does not exist anywhere
> including linux-next...

The patch hasn't been merged yet, the title should be still correct.
