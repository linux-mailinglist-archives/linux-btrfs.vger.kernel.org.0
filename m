Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E854203909
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFVOXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 10:23:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgFVOXc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 10:23:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3B69C1A3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jun 2020 14:23:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0D2BDA82B; Mon, 22 Jun 2020 16:23:19 +0200 (CEST)
Date:   Mon, 22 Jun 2020 16:23:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Message-ID: <20200622142319.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
 <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622140234.GA4512@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
> 
> > > > You need to check fstrim.timer, which in turn triggers fstrim.service.
> > >
> > > root@fex:~# cat /lib/systemd/system/fstrim.timer
> > >
> > > root@fex:~# cat /lib/systemd/system/fstrim.service
> 
> > I'm familiar with the contents of the files. Do you have a question?
> 
> 
> You have deleted my question, it have asked:
> 
> This means: an extra fstrim (via btrfsmaintenance script, etc) is
> unnecessary?

You need only one service, either from the fstrim or from
btrfsmaintenance.
