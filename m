Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78FD113EF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 11:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfLEKAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 05:00:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:40580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728955AbfLEKAz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 05:00:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F05FEB322;
        Thu,  5 Dec 2019 10:00:53 +0000 (UTC)
Date:   Thu, 5 Dec 2019 11:00:47 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com, clm@fb.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
Message-ID: <20191205100047.GA11438@Johanness-MacBook-Pro.local>
References: <00000000000096009b056df92dc1@google.com>
 <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 04, 2019 at 03:59:01PM +0100, Johannes Thumshirn wrote:
> #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> close_fs_devices

Ok this doesn't look like it worked, let's retry w/o line wrapping

#syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git close_fs_devices

