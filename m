Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E525624A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 22:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH1U4o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 Aug 2020 16:56:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35832 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH1U4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:37 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BC0387D7B8E; Fri, 28 Aug 2020 16:56:36 -0400 (EDT)
Date:   Fri, 28 Aug 2020 16:56:36 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Eric Wong <e@80x24.org>, kreijack@inwind.it,
        linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200828205636.GF8346@hungrycats.org>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org>
 <20200828023412.GA308@dcvr>
 <20200828043627.GE8346@hungrycats.org>
 <0efae4eb-30dd-4d5a-d5fa-eac7ffc1fad8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0efae4eb-30dd-4d5a-d5fa-eac7ffc1fad8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 08:09:26AM +0300, Andrei Borzenkov wrote:
> 28.08.2020 07:36, Zygo Blaxell пишет:
> > 
> > Replace just computes the contents of the filesystem the same way scrub
> > does:  except for the occasional metadata seek, it runs at wire speeds
> > because it reads blocks in order from one disk and writes in order on
> > the other disk, 99.999% of the time.
> > 
> 
> Does it write them to the same absolute disk locations? IOW - is it
> possible to use smaller disk for replace or it must be at least as large
> as original disk?

Replace writes data to the locations recorded in the chunk tree, i.e. the
original disk locations on the missing disk.

In theory, you can resize the offline disk to be smaller than the
replacement disk, then run btrfs replace.  In practice, only some of
the methods work (e.g. you must specify device ID and not device name
when replacing) and only on recent kernel versions.

btrfs dev remove is equivalent to 'btrfs fi resize <devid>:0' followed by
"remove empty device <devid>" so the performance will be very similar
for the portion of the data that is resized; however, a combination of
resize and replace is still much faster than device remove, which does
it the slow way for all of the data.
