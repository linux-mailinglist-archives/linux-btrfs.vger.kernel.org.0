Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63314E6E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 02:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAaBxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 Jan 2020 20:53:09 -0500
Received: from mail.as397444.net ([69.59.18.99]:37646 "EHLO mail.as397444.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbgAaBxJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 20:53:09 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 20:53:08 EST
Received: from [IPv6:2620:6e:a000:1000:cdd8:f4d8:d566:51e3] (unknown [IPv6:2620:6e:a000:1000:cdd8:f4d8:d566:51e3])
        by mail.as397444.net (Postfix) with ESMTPSA id 5C3D118EB07;
        Fri, 31 Jan 2020 01:43:11 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Matt Corallo <kernel@bluematt.me>
Mime-Version: 1.0 (1.0)
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Thu, 30 Jan 2020 20:43:10 -0500
Message-Id: <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
References: <1746386.HyI1YD2b7T@merkaba>
Cc:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <1746386.HyI1YD2b7T@merkaba>
To:     Martin Steigerwald <martin@lichtvoll.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a pretty critical regression for me. I have a few applications that regularly check space available and exit if they find low available space, as well as a number of applications that, eg, rsync small files, causing this bug to appear (even with many TB free). It looks like the suggested patch isn’t moving towards stable, is there some other patch we should be testing?

> On Jan 30, 2020, at 18:12, Martin Steigerwald <martin@lichtvoll.de> wrote:
> 
> ﻿Remi Gauvin - 30.01.20, 22:20:47 CET:
>>> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
>>> I am done with re-balancing experiments.
>> 
>> It should be pretty easy to fix.. use the metadata_ratio=1 mount
>> option, then write enough to force the allocation of more data
>> space,,
>> 
>> In your earlier attempt, you wrote 500MB, but from your btrfs
>> filesystem usage, you had over 1GB of allocated but unused space.
>> 
>> If you wrote and deleted, say, 20GB of zeroes, that should force the
>> allocation of metatada space to get you past the global reserve size
>> that is causing this bug,, (Assuming this bug is even impacting you. 
>> I was unclear from your messages if you are seeing any ill effects
>> besides the misreporting in df.)
> 
> I thought more about writing a lot of little files as I expect that to 
> use more metadata, but… I can just work around it by using command line 
> tools instead of Dolphin to move data around. This is mostly my music, 
> photos and so on filesystem, I do not change data on it very often, so 
> that will most likely work just fine for me until there is a proper fix.
> 
> So do need to do any more things that could potentially age the 
> filesystem. :)
> 
> -- 
> Martin
> 
> 

