Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56048FD4E
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 15:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiAPOBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 09:01:11 -0500
Received: from mout02.posteo.de ([185.67.36.66]:38357 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbiAPOBL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 09:01:11 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0F32A240104
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 15:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1642341670; bh=zrlebYHKHruHmUP8DeS0n7f5vJlvHgeFGKSZeBU7W3I=;
        h=Subject:To:From:Date:From;
        b=MZr+3DGW0MBIxHMHpSVaDIMGjoCuGUOQmEOE0csQSmmqEMe5BV/8fRhKD0NkXOIiz
         y81UVwVyNKCymw6LilOEV+ciU8p7UqcNvzmWFEBPe6XwI2ApBd4RiFDeBRQYJiDdAe
         jimJuM/JSJMdOJgsjV/XUWDpQ67f1xBmM4iaSFXu4PSjYM0hQswxqNULR8+FT5zL2g
         snkuR/8D9LodVd/OLjP/YgdfHV40r2wZS1DsQZGFLMeykHCmGdlvl/r/rqBs6y3rf1
         e2Pga7Zje6ROZtn94ImqjO4XByZz4YPv0NIZJrmeHbWsGNycXi/ORltVHSift+WxMt
         vcNkIdMF+Kfew==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JcGsd3XZGz9rxP;
        Sun, 16 Jan 2022 15:01:09 +0100 (CET)
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
To:     quwenruo.btrfs@gmx.com, lists@colorremedies.com,
        linux-btrfs@vger.kernel.org
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
 <0aed5133-5768-f9c5-492f-3218fbc3bb46@gmx.com>
 <b949dfae-1ff2-1ff4-1f1f-0c778a5f2458@posteo.de>
 <089bc046-9936-3cb7-ea8c-b6ff563dce77@gmx.com>
 <c81eb4b8-f820-d819-612c-ba034e6594c5@gmx.com>
From:   Stickstoff <stickstoff@posteo.de>
Message-ID: <c906e9f3-395d-ad07-fb64-aa13be544699@posteo.de>
Date:   Sun, 16 Jan 2022 14:01:08 +0000
MIME-Version: 1.0
In-Reply-To: <c81eb4b8-f820-d819-612c-ba034e6594c5@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 1/16/22 1:49 PM, Qu Wenruo wrote:
[..]
> 
> This is your special fix:
> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
> 
> What you need is firstly setup your btrfs-progs compiling environment, 
> then compile btrfs-corrupt-block (make btrfs-corrupt-block).
> 
> Then inside your compiled btrfs-progs directory
> 
> # ./btrfs-corrupt-block -X <device>
> 
> If it runs correctly, it should show something like:
> 
>    reseted offending key
> 
> If something wrong happened, it would not write the modified metadata 
> back to disk (using the same metadata CoW mechanism as kernel).
> 
> Thanks,
> Qu
> 

Thank you so much, Qu, for this tool!

I got it to compile and run after a quick refresh of git syntax :-)
(..and a slight hesitation to run a "corruptor" tool haha)

./btrfs-corrupt-block -X /dev/mapper/123
extent buffer leak: start 934285934592 len 16384
extent buffer leak: start 934314885120 len 16384
extent buffer leak: start 934323601408 len 16384
reseted offending key

This seems to have done its magic then.
I unmounted, mounted, and am scrubbing the filesystem. It didn't abort 
yet, so far so good!
If scrub goes through, I'll recreate the btrfs from scratch just to be 
safe. With removing one drive from raid, btrfs-send to a fresh btrfs, 
then adding the other drive to form a raid-1 again.

I am really grateful for your help, Qu and all! This saved me a lot of 
time and effort, and I learned some more internals on the way too.
Thank you!

Stickstoff
