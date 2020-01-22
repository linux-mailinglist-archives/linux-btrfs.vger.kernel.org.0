Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998211458FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVPub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 10:50:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVPub (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 10:50:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91DB1B2DB;
        Wed, 22 Jan 2020 15:50:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02B39DA738; Wed, 22 Jan 2020 16:50:12 +0100 (CET)
Date:   Wed, 22 Jan 2020 16:50:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
Message-ID: <20200122155012.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
 <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 14, 2020 at 03:21:14PM +0800, Anand Jain wrote:
> On 14/1/20 2:54 PM, Qu Wenruo wrote:
> > On 2020/1/14 下午2:09, Anand Jain wrote:
> >> The first argument to btrfs_printk() wrappers such as
> >> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some
> >> context like scan and assembling of the volumes there isn't fs_info yet,
> >> so those code generally don't use the btrfs_printk() wrappers and it
> >> could could still use NULL but then it would become hard to distinguish
> >> whether fs_info is NULL for genuine reason or a bug.
> >>
> >> So introduce a define NO_FS_INFO to be used instead of NULL so that we
> >> know the code where fs_info isn't initialized and also we have a
> >> consistent logging functions. Thanks.
> > 
> > I'm not sure why this is needed.
> > 
> > Could you give me an example in which NULL is not clear enough?
> 
> The first argument in btrfs_info_in_rcu() can be NULL like for example.. 
> btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..
> 
>     BTRFS info (device <unknown>):
> 
>   Lets say due to some bug local copy of the variable fs_info wasn't 
> initialized then we end up printing the same unknown <unknown>.
> 
>    So in the context of device_list_add() as there is no fs_info 
> genuinely and be different from unknown we use 
> btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..
> 
>   BTRFS info (device ...):

With the fixup to set fs_info to NULL on a device that's unmounted, do
we still need the NO_FS_INFO stub?  The only difference I can see is a
to print "..." instead of "<unknown>" that I don't find too useful or
improving the output.

My idea about the stub fs info was to avoid any access to fs_info inside
device_list_add in case we can't reliably close the race where scan can
read device::fs_info during mount that sets it up, but as I'm told it's
not a problem anymore.
