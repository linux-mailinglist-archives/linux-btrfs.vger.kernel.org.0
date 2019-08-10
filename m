Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C488CBF
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfHJSUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 14:20:41 -0400
Received: from know-smtprelay-omd-7.server.virginmedia.net ([81.104.62.39]:35180
        "EHLO know-smtprelay-omd-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfHJSUk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 14:20:40 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id wVyphES83wGUPwVyphafsB; Sat, 10 Aug 2019 19:20:39 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=fxjknjLLZrpoPLnu7bQA:9 a=8PiWrSa5Xndkd4v7:21
 a=J_HRZPAvmj1QwwHY:21 a=QEXdDO2ut3YA:10
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
 <99aea610-72f0-a213-a5b4-d30d799cc390@suse.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <fbdb1db6-570b-7689-dead-3278fe08e0c4@petezilla.co.uk>
Date:   Sat, 10 Aug 2019 19:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <99aea610-72f0-a213-a5b4-d30d799cc390@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC2upz3opzqVjZU8HYwoyfrgKOERH6slUqWia3oEmYVCUmU2uD/N5P8Y+7yopRTRUcM/C5mA/YrvjwgOrOtP81c1han3gpu5+nkUrI1w7zgS2n0dOiB8
 hFVmCM0vALQmBlaf6q/zcwnIrA0hU66xpzC8bX3OTPB+orZ3bUMu6EltSfqQHyNvxgKY7ow/V/S6u3DzocQ4JQeGLjq5fhqPYAY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/19 6:53 PM, Nikolay Borisov wrote:

> It seems you have triggered one of the enhanced checks. Looks like the
> generation (i.e transaction id) of inode 45745394 seems to be larger
> than the inode of the super block. This doesn't make sense. Looking at
> the number of this inode it seems to have overflown.
> 

OK, I'm not a dev so that is rather lost on me...

> 
> A possible work around will be to copy the file that this inode
> describes and delete the original(corrupted one) then your fs should be
> mountable on the newer kernel.

Thanks. I've searched how to find a file by inode number, I can try
that.  I presume I'll need to do this in 5.1.4 since 5.2.7 does not mount.




