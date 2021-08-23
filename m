Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AAE3F4A95
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhHWMYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 08:24:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbhHWMYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 08:24:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA30E1FFBA;
        Mon, 23 Aug 2021 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629721405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xu1lsH1Nfh8DnebxIOaftiomcQ/F6rl640oPpPVxw98=;
        b=Al8s59rgvJ+YPBab/5TRqbsmBujxLAaoQo9Ox7mSrois81kviVJTsGymcGc68qPQt/+47W
        yTx+SbHZNTfBu8p0Ua8y3+zJKrmGMWSwPlqOXJMM28iKgSN9SEgpGK117FueIRHGYLYt3q
        hoJc/0jRljk2N957K77uk8u+IGgaLu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629721405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xu1lsH1Nfh8DnebxIOaftiomcQ/F6rl640oPpPVxw98=;
        b=zF3FKE7Vvnb4xkRPMwTUEooWJr7HRgPTIaKRx2IhxfBpsJI5cwCK2xohOTgUcYwIlkOSZH
        tp8/ffiwVfIw3OCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D019AA3BB4;
        Mon, 23 Aug 2021 12:23:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7392FDA725; Mon, 23 Aug 2021 14:20:26 +0200 (CEST)
Date:   Mon, 23 Aug 2021 14:20:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <20210823122026.GZ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su>
 <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
 <sfz2etf4.fsf@damenly.su>
 <pmu6eta9.fsf@damenly.su>
 <82c756a2-bd1a-9b11-a39e-525105ba65c8@oracle.com>
 <953bdec3-4698-6faa-04b0-d1b71a75477d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <953bdec3-4698-6faa-04b0-d1b71a75477d@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 06:54:04PM +0800, Anand Jain wrote:
> 
> 
> On 23/08/2021 18:34, Anand Jain wrote:
> > On 21/08/2021 23:00, Su Yue wrote:
> >>
> >> On Sat 21 Aug 2021 at 22:57, Su Yue <l@damenly.su> wrote:
> >>
> >>> On Fri 20 Aug 2021 at 16:53, Anand Jain <anand.jain@oracle.com>
> >>> wrote:
> >>>
> >>>>>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct
> >>>>>> btrfs_fs_info *fs_info)
> >>>>>>      u64 super_flags;
> >>>>>>
> >>>>>>      lockdep_assert_held(&uuid_mutex);
> >>>>>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
> >>>>>> +
> >>>>>>
> >>>>> Just a reminder: clone_fs_devices() still takes the mutex in
> >>>>> misc-next.
> >>>>    As I am checking clone_fs_devices() does not take any lock.
> >>>>   Could you pls recheck?
> >>>>
> >>>
> >>> Hmmmm... misc-next:
> >>>
> >>> https://github.com/kdave/btrfs-devel/blob/e05983195f31374ad51a0f3712efec381397f3cb/fs/btrfs/volumes.c#L381 
> >>>
> >>
> >> Sorry, it should be
> >>
> >> https://github.com/kdave/btrfs-devel/blob/misc-next/fs/btrfs/volumes.c#L995 
> >>
> > 
> > 
> >   Some of the Git commands stopped working. I had to run git fsck.
> >   Now I see mutex in close_fs_devices(), not sure if I was blind to it 
> > before.
> >   Anyway, this is a bad patch. I am working to fix it.
> > 
> 
>   Git errors were distracting. But why I didn't see the 
> device_list_mutex is because I had the following patch [1] in my 
> workspace, which is not yet integrated to the misc-next / commented.
> 
>   [1] btrfs: fix lockdep warning while mounting sprout fs
>  
> https://lore.kernel.org/linux-btrfs/8325002d-f8a6-a9b7-a27d-4cf62cbbc672@oracle.com/
> 
>   So as of now, I can say this patch needs the above patch.
> 
>   Could you please apply the above patch before this patch for tests?

So if there's a dependency I'd apply the whole series.
