Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C7112FCE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfLDQRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 11:17:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:33134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbfLDQRa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 11:17:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF5A2AECB;
        Wed,  4 Dec 2019 16:17:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D67A5DA786; Wed,  4 Dec 2019 17:17:23 +0100 (CET)
Date:   Wed, 4 Dec 2019 17:17:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-progs: misc/016 hangs at ioctl
Message-ID: <20191204161723.GE2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <3b8f824f-0c55-b54b-e23d-257ad1b2f239@gmx.com>
 <0a3fa957-b551-022b-8f6a-129e117626a7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a3fa957-b551-022b-8f6a-129e117626a7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 04, 2019 at 02:08:14PM +0800, Qu Wenruo wrote:
> On 2019/12/4 下午2:06, Qu Wenruo wrote:
> > Found a strange failure at btrfs-progs selftest misc/016.
> > 
> > It hangs at current master 63de37476ebd ("Merge tag
> > 'tag-chrome-platform-for-v5.5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux").
> > 
> > What makes it even more mysterious is, misc-5.5 passes.
> > 
> > Since there is no other btrfs pull, it's caused by some upstream
> > non-btrfs commits.
> 
> BTW, no blocked kernel thread, no CPU usage.
> 
> And the hang can be canceled with a signal.
> 
> > 
> > Doing bisecting, but any clue will be appreciated.

This looks like a problem caused by recent merge of updates to pipe
(commit 6a965666b7e7475c2f8c8e724703db58b8a8a445). I can reproduce that
and now building test kernel before that commit. As this also blocks all
fstests that use send, we have to wait until it's fixed in master
branch.
