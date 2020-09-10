Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC40264A1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIJQoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 12:44:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgIJQnv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 12:43:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04E7DB3E7;
        Thu, 10 Sep 2020 16:29:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78A84DA730; Thu, 10 Sep 2020 18:28:20 +0200 (CEST)
Date:   Thu, 10 Sep 2020 18:28:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: Switch seed device to list api
Message-ID: <20200910162820.GN18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-6-nborisov@suse.com>
 <09086e7f-a00d-a65f-e750-e833e7eba3cc@oracle.com>
 <2f98d441-ccb9-a2f0-2beb-eac7e526dee8@suse.com>
 <d3017c3a-62e3-d715-fee1-d23c7ce6ab57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3017c3a-62e3-d715-fee1-d23c7ce6ab57@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 05:33:26PM +0800, Anand Jain wrote:
> 
> 
> On 3/9/20 5:03 pm, Nikolay Borisov wrote:
> > 
> > 
> > On 2.09.20 г. 18:58 ч., Anand Jain wrote:
> >>
> >>
> >> The seed of the current sprout should rather be at the head instead of
> >> at the bottom.
> >>
> >>
> >>> @@ -2397,7 +2381,7 @@ static int btrfs_prepare_sprout(struct
> >>> btrfs_fs_info *fs_info)
> >>>        fs_devices->open_devices = 0;
> >>>        fs_devices->missing_devices = 0;
> >>>        fs_devices->rotating = false;
> >>> -    fs_devices->seed = seed_devices;
> >>> +    list_add_tail(&seed_devices->seed_list, &fs_devices->seed_list);
> >>
> >>   It should be list_add_head.
> > 
> > Generally yes, but in this case I don't think it makes any functional
> > differences so even adding at the tail is fine.
> > 
> 
>   Hm No. Adding to the head matches to the order of dependency. As it 
> was in the while loop.

Following the same order sounds like a better idea to me. If there's
really no differece and we want to add the entry to the tail, then it
would be another patch with proper reasoning. I'll update it to do
list_head.
