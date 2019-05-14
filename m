Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2161D10B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENVLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 17:11:48 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:60041 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENVLr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 17:11:47 -0400
Received: from localhost ([::1] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.91)
        id 1hQei6-0006HM-2k; Tue, 14 May 2019 22:11:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 May 2019 22:11:42 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH V9] Btrfs: enhance raid1/10 balance heuristic
In-Reply-To: <20190513185250.GJ3138@twin.jikos.cz>
References: <20190506143740.26614-1-timofey.titovets@synesis.ru>
 <20190513185250.GJ3138@twin.jikos.cz>
Message-ID: <6ff64ec41e6b6d72cc37c1221c984e17@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-13 19:52, David Sterba wrote:
> I'd rather see a generic mechanism that would spread the load than 
> doing
> static checks if the device is or is not rotational. Though this is a
> significant factor, it's not 100% reliable, eg. NBD or iscsi or other
> layers between the physical device and what the fs sees.

Is there perhaps a way to measure, or access existing statistics for, 
average read times for each device, and use that to hint at suggested 
devices to read from?

> Regarding the patches to select mirror policy, that Anand sent, I think
> we first should provide a sane default policy that addresses most
> commong workloads before we offer an interface for users that see the
> need to fiddle with it.

Is it necessary to let users choose a (read) mirror policy if the 
options follow a logical progression? For now we could say:

choose_mirror():
   read_mirrors = list_available_read_mirrors() (Anand's patch series)
   if read_mirrors.length == 1 //User specified only one device to read 
from
     return read_mirrors[0]
   if read_mirrors is empty
     read_mirrors = all_available_mirrors()
   return fastest_mirror_from(read_mirrors) (Timofey's patch)

Any other algorithms can be added into the stack in a logical position. 
Perhaps if it gets more complicated then there can be an fs 
property/mount option/tunable to disable one or more algorithms.

-- 
Steven Davies
