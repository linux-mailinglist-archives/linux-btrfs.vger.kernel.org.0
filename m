Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415943A4404
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFKO2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:28:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhFKO2N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:28:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE5A32199B;
        Fri, 11 Jun 2021 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623421574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4adyuLTnStUYKANwbhJkMxTn3XLkCvf7SXHOESTut0=;
        b=XpFuCnnN7O9gmCqg/VrZ3ztJGyg5JTXkHKy/1bVN5aPRzgmTkrZu3kvBHesqIvY9g1MfNp
        KKz9o8Kbh+NKH41oJAyGcYnhGcwmXufd0nddqR+vI+wD2ANMYdvqYw/TVCBtodFLB7p124
        gDokqVxSKToItB4BTiOWKrsJUTC/Ths=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623421574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4adyuLTnStUYKANwbhJkMxTn3XLkCvf7SXHOESTut0=;
        b=VqWHxSUResnSZz0uz5jfXgxEpk+r4FVqhd6f4wOAfmAeta8flC/+0MKKB+fKO0csRs5QL+
        3CxIDcej19pBWnBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B80DBA3BB1;
        Fri, 11 Jun 2021 14:26:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6DDADA7B4; Fri, 11 Jun 2021 16:23:29 +0200 (CEST)
Date:   Fri, 11 Jun 2021 16:23:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
Message-ID: <20210611142329.GH28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
 <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
 <20210518160623.GA38825@realwakka>
 <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 08:09:45AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/19 上午12:06, Sidong Yang wrote:
> > On Sun, May 16, 2021 at 07:55:25AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/5/15 下午9:35, David Sterba wrote:
> >>> On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
> >>>> On 2021/5/15 上午10:36, Sidong Yang wrote:
> >>>>> This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> >>>>> the option is enabled, delete subvolume command destroies associated
> >>>>> qgroup together. This patch make it as default option. Even though quota
> >>>>> is disabled, it enables quota temporary and restore it after.
> >>>>
> >>>> No, this is not a good idea at all.
> >>>>
> >>>> First thing first, if quota is disabled, all qgroup info including the
> >>>> level 0 qgroups will also be deleted, thus no need to enable in the
> >>>> first place.
> >>>>
> >>>> Secondly, there is already a patch in the past to delete level 0 qgroups
> >>>> in kernel space, which should be a much better solution.
> >>>
> >>> I've filed the issue to do it in the userspace because it gives user
> >>> more control whether to do the deletion or not and to also cover all
> >>> kernels that won't get the patch (ie. old stable kernels).
> >>>
> >>> Changing the default behaviour is always risky and has a potential to
> >>> break user scripts. IMO adding the option to progs and changing the
> >>> default there is safer in this case.
> >>>
> >> Then shouldn't it still go through ioctl options?
> >>
> >> Doing it completely in user space doesn't seem correct to me.
> >
> > Yes, It still use ioctl calls for destroying qgroup.
> 
> What I mean is to add new ioctl flags for the existing destory subvolume.

Which is what I don't want to do. Why: it's doing more than operation so
the error code is unclear what it's related to. Either subvolume
deletion or qgroup deletion.

A similar suggestion was in for subvolume creation to force quota rescan,
https://lore.kernel.org/linux-btrfs/20210525162054.GE7604@twin.jikos.cz/333
same reason why not.
