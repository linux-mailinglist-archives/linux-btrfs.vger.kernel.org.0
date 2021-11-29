Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C14462109
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 20:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379957AbhK2Txm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352011AbhK2Tvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:41 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32DC08EA76
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 08:13:07 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id DA8CD9B8C5; Mon, 29 Nov 2021 16:13:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1638202382;
        bh=dcQ2R7drXZzKoOCmocqrx+yHr5lMWJCYDcJdYAW87eM=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=ffap8ljnJSd/RI2TMNiRoA7D02GKBz8WD3kiJovHrfYgLvEIwHNFGATdLdfyGa3HA
         I4z3QRRPgbcixs4BBDLUXXI7m5GU42K2UJT+pc2X7CSJCsbG5p2+GEAcoPT+YlqgB7
         NTuPg1zfCcLU2CeMEmPSBp/fgtde84Nq1fc17hmp8LjRWfNZwMSNbi546kVlqzIe83
         0+NZi+QaG+muBa94qnG2PwvB/q133o+1V61QxTGD9qD947ay5K2SYEdKOBwBno0k2r
         /EMDsoMFtU1faZhEyG3EF1uzWDDWkp9InWh9mZZp3lmS0rNhZQDZNJFWIUI4GH5wUI
         u+VEjSEQ0dTmg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.2 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 245A79B871;
        Mon, 29 Nov 2021 16:12:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1638202324;
        bh=dcQ2R7drXZzKoOCmocqrx+yHr5lMWJCYDcJdYAW87eM=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=FJ2BAhV8IF25syfqJvpEERc8KNXKT78Ee8AIPr6fX80QTy81iv3DiI+lvngu8k2B5
         vq3pTW2DNmEA3mCDLNU2DRQzXsm+1gzF5mk4mfqObf2rZXAd15mKm8uRZhGifpw4Vw
         cbIuD53EK3853ucqo3cc7nDwTH9ufbRWKnGda8da+ESwy/a0VZy3eZ6CeHBUnA2QiT
         t4b4Vo1DSBnquRJucxV+b9SjUKWFlOqm71rqUeiFS+U4xlqOEPoTLugMs45VgZY5yz
         kwxDOrMFIwMy+49bkyIiTlFhfjaB+Ad9IKlFoEddzGP3rxoDJqL7ktXZqLxHuivh+F
         XNofbocrIHPzg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id DF3562C928B;
        Mon, 29 Nov 2021 16:12:03 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Borden <borden_c@tutanota.com>, Phillip Susi <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net>
 <MpgNwtq--3-2@tutanota.com>
Subject: Re: Connection lost during BTRFS move + resize
Message-ID: <75c33ef6-af1a-43cc-6732-ce4b298a7337@cobb.uk.net>
Date:   Mon, 29 Nov 2021 16:12:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <MpgNwtq--3-2@tutanota.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/11/2021 15:50, Borden wrote:
> 29 Nov 2021, 10:26 by phill@thesusis.net:
>> The only tool I know of that can do this is gparted, so I assume you are
>> using that.  In this case, it has to umount the filesystem and manually
>> copy data from the old start of the partition to the new start.  Being
>> interrupted in the middle leaves part of the filesystem in the wrong
>> place ( and which parts is unknowable ), and so it is toast.  This is
>> one area where LVM has a significant advantage as its moves are
>> interruption safe and automatically resumed on the next activation of
>> the volume.
>>
> This is the answer that I anticipated, and it's good to know now so I don't destroy data that I _cannot_ afford to lose later. So thank you.
> 
> For my own education/curiosity/intellectual banter: ddrescue, badblocks, rsync and other utilities have log files that track progress and allow it to resume if it's interrupted. Since resize operations work in the linear process you described, how hard would it be, theoretically, to implement a "needle position" in a move operation to allow a move to pick up where it left off?
> 
> Obviously, it wouldn't be 100% perfect, but if a recovery utility could look at the disk and say "partition starts here, skip a bit somewhere in the middle, continue here, stop there," surely that would be more efficient than trying to recover files with a low-level utility?
> 

I can't comment on that, and I don't know how the utility you were using
works, but if it was copying blocks from higher disk addresses to lower
ones, starting at the bottom, it is *possible* that it hadn't got beyond
the first 1TB before it failed and the original filesystem is still
untouched.

Did you try just resetting the original partition parameters manually
(forcing them using something like GNU parted's mkpart - not a resize
operation) to see whether the original filesystem could be mounted? It's
just a long shot, of course.

Graham
