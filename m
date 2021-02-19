Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A930931F98E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBSMp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 07:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:38288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSMp6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 07:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5759AAC6E;
        Fri, 19 Feb 2021 12:45:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6658DA813; Fri, 19 Feb 2021 13:43:19 +0100 (CET)
Date:   Fri, 19 Feb 2021 13:43:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: --init-extent-tree if extent tree is
 unreadable
Message-ID: <20210219124319.GZ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200728021224.148671-1-dxu@dxuuu.xyz>
 <bb0881e6-0301-2e03-8ad2-ad24055c4351@gmx.com>
 <20200812171444.GD2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812171444.GD2026@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 07:14:44PM +0200, David Sterba wrote:
> On Wed, Aug 12, 2020 at 09:29:18AM +0800, Qu Wenruo wrote:
> > On 2020/7/28 上午10:12, Daniel Xu wrote:
> > > This change can save the user an extra step of running `btrfs check
> > > --init-extent-tree ...` if the user was already trying to repair the
> > > filesystem.
> > 
> > This looks too aggressive to me.
> > 
> > Extent tree repair, not only --init-extent-tree, is not considered safe
> > overall.
> > 
> > In fact, we could hit cases with things like completely sane fs trees,
> > but corrupted extent and csum trees.
> > 
> > In that case, I'm not sure --init-extent-tree would solve or just worse
> > the situation.
> > 
> > Thus --init-extent-tree should only be triggered by users who know what
> > they are doing.
> > (In that case, I would call them developers other than users)
> 
> I have basically the same answer, just did not get to writing it.  I'll
> have another look after the merge window is over.
> 
> This touches on the higher level topic what shoud check do, we can't
> trade convenience for safety. The extra step to specify the option on
> the command line can be actually the difference between repairing and
> not repairing.

To answer that, favoring safety over convenience here, so the option
needs to be specified manually if needed.
