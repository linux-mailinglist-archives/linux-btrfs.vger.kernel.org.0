Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A320F02A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgF3IHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 04:07:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgF3IHx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 04:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6C1AAAC3;
        Tue, 30 Jun 2020 08:07:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3709BDA732; Tue, 30 Jun 2020 10:07:36 +0200 (CEST)
Date:   Tue, 30 Jun 2020 10:07:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200630080735.GQ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com>
 <20200629213008.GO27795@twin.jikos.cz>
 <9af22db7-42f0-00fd-1a34-33d6a8cffc2f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9af22db7-42f0-00fd-1a34-33d6a8cffc2f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 30, 2020 at 07:17:25AM +0800, Qu Wenruo wrote:
> On 2020/6/30 上午5:30, David Sterba wrote:
> > On Sun, Jun 28, 2020 at 01:07:15PM +0800, Qu Wenruo wrote:
> >> +QGROUP_ATTR(rfer, reference);
> > 
> > Note that this is 'referenced'.
> > 
> >> +QGROUP_ATTR(excl, exclusive);
> >> +QGROUP_ATTR(max_rfer, max_reference);
> > 
> > And here max_referenced.
> > 
> >> +QGROUP_ATTR(max_excl, max_exclusive);
> >> +QGROUP_ATTR(lim_flags, limit_flags);
> >> +QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
> >> +QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
> >> +QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
> > 
> > The two above fixed but otherwise it's good, thanks.
> > 
> > The qgroup membership and relations could be added to the sysfs export
> > too, but we're limited by the PAGE_SIZE output buffer so the information
> > could be incomplete.
> > 
> Yep, PAGE_SIZE is one limitation.
> But we can also go another direction, just using a new dir for related
> qgroups, then we can workaround the limitation.
>
> But personally speaking, the main objective is still the rsv_* members
> for debug.
> I don't really want to turn the sysfs interface into a way to export all
> qgroup info yet.

Well, that's a bit of a problem, if you're designing a public interface
for your own needs and neglecting that it will be used as a way to read
qgroup information. Sooner or later someone will ask for the additional
information to be added.

If it's just for debugging then it should be under 'debug', but as the
bug reporter does not want to apply patches/change config you ask to
make it visible unconditionally. I'm ok with that as long as the
interface is done right because any mistake will be potentially much
harder to fix in the future.

We need to at lest have a solid idea how to extend it, not neccessarily
to implement it right now. Adding the group membership to qgroup
directories under the qgroup directory as symlinks between the kobjects
sounds ok-ish to me but it's a new idea and I need to think about it.
