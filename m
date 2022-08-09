Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5358D7FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiHILXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHILXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 07:23:11 -0400
Received: from mail-out-02.servage.net (mail-out-02.servage.net [93.90.146.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53F1EC65
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 04:23:08 -0700 (PDT)
X-Halon-ID: a2914f3e-17d5-11ed-a59e-005056913d2d
Authorized-sender: u1m2114@blauwurf.info
Received: from [10.2.10.3] (firewall1a.robinson.cam.ac.uk [193.60.93.97])
        by mail-out-01.servage.net (Halon) with ESMTPSA
        id a2914f3e-17d5-11ed-a59e-005056913d2d;
        Tue, 09 Aug 2022 13:23:06 +0200 (CEST)
Message-ID: <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
Date:   Tue, 9 Aug 2022 12:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Michael Zacherl <ubu@bluemole.com>
Subject: Re: Corrupted btrfs (LUKS), seeking advice
To:     linux-btrfs@vger.kernel.org
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
Content-Language: en-US
Cc:     wqu@suse.com
Reply-To: linux-btrfs@vger.kernel.org
In-Reply-To: <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/22 01:22, Qu Wenruo wrote:
> You can try "mount -o ro,rescue=all", which will skip the block group
> item search, but still there will be other corruptions.
>
> I'm more interested in how this happened.
> The main point here is, the found transid is newer than the on-disk
> transid, which means metadata COW is not working at all.
>
> Are you using unsafe mount options like disabling barriers?

No, this upgraded setup is fairly new and completely stock.
(and most of that terminology I have to look up anyway)
Btrfs is new to me and I don't experiment on systems I need for work.

I think what happened is having had mounted the FS twice by accident:
The former system (Mint 19.3/ext4) has been cloned to a USB-stick which I can boot from.
In one such session I mounted the new btrfs nvme on the old system for some data exchange.
I put the old system to hibernation but forgot to unmount the nvme prior to that. :(

So when booting up the new system from the nvme it was like having had a hard shutdown.
So that in itself wouldn't be the problem, I'd think.
But the other day I again booted from the old system from its hibernation with the forgotten nvme mounted.
And that was the killer, I'd say, since a lot of metadata has changed on that btrfs meanwhile.

On top of it, btrfs is v4.15.1 on the old system, many things just don't exits on this version, AFAICT.
If that made things worse, I can't say.

On 8/9/22 01:24, Qu Wenruo wrote:
> Try this mount option "-o ro,rescue=all,rescue=nologreplay".

Oh, I thought "nologgreplay" would be included in "all"?

>> Is this FS repairable to a usable state?
> 
> Definitely no.

Ouch. But meanwhile I can see the damage I did to it.
I'm currently abroad, so no access to my regular backup infrastructure.

However, since I've to re-install the new system when I'm back:
There would be enough space on the new ssd for a second partition, which I'd like not to go for.
Or is there an option for additional redundancy within the same btrfs to help in case of such a bad mistake (I'd dearly try to avoid anyway, but ...)?

Thanks a lot for your time, Michael.


