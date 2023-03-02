Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4F6A8D18
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCBXeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBXeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:34:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0401A65B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:34:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGW7-1pwxvq2PXB-00Pgc1; Fri, 03
 Mar 2023 00:34:12 +0100
Message-ID: <a0d08906-acb2-d5b4-9585-d43faf05227a@gmx.com>
Date:   Fri, 3 Mar 2023 07:34:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: improve type safety by passing struct btrfs_bio around
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BDk1jnwlD0WIZBvxfP0cQVvKeG+ft/HHG1Bmx72mW3o8voUaP5u
 OcRBsN5Jc6pV7PtMHj8vV9pTvr5JeZKEaNI97cARSummTde6aw2JL4OS97xMJPWqzLPOG1e
 5E1GgfzkbJbC7o/PlgyM2DZbJKxLfoyyoxGd/ln3Re/KPUUrpw7QW9do3idmdO9HSHmAdVM
 baTXcY4W73QKoZoAO8nLg==
UI-OutboundReport: notjunk:1;M01:P0:yzNlz4GJoTE=;NnAw1SbHafPi67necMmWllvZ71/
 3rOu8PmupdKisfPQhYwoi1AqPdel6Hrs+AaMFdcCibNLquzxGDiejnAAQMSbu9j+br0eps5Ct
 SMalDtVEgCFHoN0ocf+heAN9BIvccviV+FibAeWQgVjQyNrfdaHEV4kC10eLu1oNINPJbzlyK
 AC7YkSpDz4CzEjRSSpr4j3R9/4ty9JGM/wkjn+eEMO3av7MO7p8CLR+CxzaTceBBRaS3uhUkb
 JmwjNuA2uk6nimIEBYpUadvcRdlCqG5PRb9+WrnmlW6ftRA1xbTaI0iu6/GQ+3OQLqcSlK7ld
 ejAYC8kt+Z+pnWmO2FEdTtaxE2ZNPEcR/qA3+GLxAYI3ABdRcXwVsXeEGfOZedANtrf8FA+qI
 epW7PEk1p8yMTDQ8r5puINdRVq8kF6kdUjfqo/oTRyhi9Lh4lnOa+dGh0iB7gpl7rosmW82tk
 HXck5VjHiJZBexMRJnbNgf2kRVdymlQcbee+ZLLGVHkjnW53JLpd/tv4KgunN/kPEbk+dr4XB
 8OSnr+jQODbAYLu3juMGbF4zlZEezI6ssNvSyeEzGx53cmCT+ftxyH8EopfONWgVhrDLPH7QW
 aSh7djay8VZPdawnnLBOBwc/pzf3wjBdBe0EqkwAdDbGoXmFk5N92egYRLtpPixOeKgccozQ6
 FaiTAS9IVbrdqBF3wgav8zbtEuKbhMPcg2ayWGEafHvpAZUEmCpeEFAzY55uFWCyocZmSdLdU
 P8PclIRIua+7/odKzEwpU93jij1joYWpgSOv4uTN3W4NRPwQB4EAvbav5aKowsUNkTbwRJhXk
 vhR5Mq4yHEF44ASKCwVsp4zqH079CHbu//oQLmtVh0Y+dqpNI6VGvemvS8E1yyhh9p+W85Yov
 29jBKMQVkX30hJqDhzT8+uMBbHEEaiVKof2u5OWzeeJlhLDv5DpZhJgRzk1R4wY/AthEXk+Oy
 VXUu17TP4tW0FRJEV2xkSX7+zjk=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> Hi all,
> 
> much of the btrfs I/O path work on a struct btrfs_bio but passes pointers
> to the bio embedded into that around.  This series improves type safety
> by always passing the actual btrfs_bio instead.

The whole series looks good and commented for each one.

But I'm still a little concerned about possible rogue non-btrfs bios.
Is it possible to add one magic number member for btrfs_bio, and do 
extra magic number check in btrfs_bio() macro?

Or am I over concerning?

Thanks,
Qu

> 
> Diffstat:
>   bio.c         |   53 ++++++++++++++++++++++--------------------
>   bio.h         |    8 +++---
>   compression.c |   33 ++++++++++++++------------
>   compression.h |    4 +--
>   extent_io.c   |   72 ++++++++++++++++++++++++++--------------------------------
>   inode.c       |   57 +++++++++++++++++++--------------------------
>   lzo.c         |   14 ++++-------
>   zlib.c        |    2 -
>   zstd.c        |    1
>   9 files changed, 114 insertions(+), 130 deletions(-)
