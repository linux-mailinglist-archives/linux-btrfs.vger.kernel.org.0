Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A4B0810
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 06:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfILEiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 00:38:11 -0400
Received: from hawking.davidnewall.com ([203.20.69.83]:47435 "EHLO
        hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILEiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 00:38:11 -0400
Received: from [172.30.0.109] (ppp14-2-96-129.adl-apt-pir-bras32.tpg.internode.on.net [::ffff:14.2.96.129])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by hawking.rebel.net.au with ESMTPSA; Thu, 12 Sep 2019 14:08:08 +0930
  id 0000000000064FBC.5D79CBB0.00007FDF
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     Nikolay Borisov <nborisov@suse.com>,
        David Newall <btrfs@davidnewall.com>,
        linux-btrfs@vger.kernel.org
References: <c00dfaf7-81a4-5e79-6279-b4af53f7f928@davidnewall.com>
 <1a651f17-ba40-2f17-403e-69999e927b2d@suse.com>
 <cfc872b2-ea1e-57b4-f548-48679daad069@davidnewall.com>
 <133d5657-a045-ad53-31f0-75714d983255@suse.com>
From:   David Newall <btrfs@davidnewall.com>
Message-ID: <d83709b8-7c0f-d3dd-7d6e-3bdbe08e144a@davidnewall.com>
Date:   Thu, 12 Sep 2019 14:08:07 +0930
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <133d5657-a045-ad53-31f0-75714d983255@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/9/19 8:22 pm, Nikolay Borisov wrote:
>> I saved it tohttps://davidnewall.com/kern.1
> Nothing useful in that log, everything seems normal.

Thank you, again, for your help.  I am grateful.

If I understand the output, both df and mount are waiting for 
show_mountinfo which is waiting for btrfs_show_devname which is waiting 
to get a lock.  They have to wait to find the devname for ten minutes.  
Is that really normal?

I'm not saying that btrfs is behind it, but it does seem like something 
is not right.

I notice that there's a waiting btrfs-transation, too.  I don't know 
what the transaction would be, and no doubt it's completely appropriate, 
even though the use of btrfs at that point is merely one mount (and one 
mount of ext2 over a sub-directory, probably no involvement by btrfs.)

I see, too, that systemd is waiting for btrfs_show_devname.  It's a 
pattern.

I take your point about the kernel being somewhat old and accept that 
I'm unlikely to get far without confirming the problem on a recent kernel.

