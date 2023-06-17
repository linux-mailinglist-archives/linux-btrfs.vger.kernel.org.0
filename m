Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D886733E2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjFQFMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQFMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:12:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA80DB5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686978735; x=1687583535; i=quwenruo.btrfs@gmx.com;
 bh=rFExnVYxWRP2npGChqXe6mF+TisSS5AuOm6A++/OSqo=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=Ow01/L4x29dwB7tDo3KY04WiV4U/zTaMjWiRj8/e3aubY9NNNE2GW2ILbzth/GPSdsGymOO
 ZnZSF++K/i9s6gqFWvd+dGGDs4DRhVEliG+RlXz3l9kqUxR64z2efaQGW9zkX5KCzqzWuJQGS
 rwk7Y8d0CODnT94lOgiq74VHAhxbErpvCHvM/lSrmWrrJ1Mf/6fs5LIaiv73WSXCWnQcWsVq2
 PKlIGvkfU2dihUa4NfNzmhYlkoxuNj0+8bqutGR6ykYDjNPoHiMkRf6TsDgPfAtaDGIljWhwm
 yn4+aMoi/JiZFZERSG+5/eqlGs1AOa9oN1zUppFl9sUun1iJYoDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1porFd0cnz-00nPT3 for
 <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 07:12:15 +0200
Message-ID: <16c5495c-9a73-b747-52ee-c4d010d169ed@gmx.com>
Date:   Sat, 17 Jun 2023 13:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/5] btrfs: scrub: introduce SCRUB_LOGICAL flag
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1686977659.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <cover.1686977659.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tqOfBC8E4r0PCnJ9jijL8o3G678DquVIstqgQmxfjx+iquKUHnc
 F9cXvsJTExQDNtYwT2ioT0w2ghg9/drXFpeD6lLgBhspS1bOQxAbx2oADbTwKnIlDwKs+yY
 FoV75HLiaRS/OZKr29z7a0ZtQJe1+1pc3t+mFTT/tisV4hQ3XrRoPxUmI4F0voGEBQ9VOkw
 suNjnqD/lexBpq0Sj55JA==
UI-OutboundReport: notjunk:1;M01:P0:t4dPZCwOpec=;89dioRsg+Pgm0jqQHVix5w+DuAT
 jdxm1K66LHDdP9dWHXSmbgPBLxIVQAgORmMvrtmQUcbSe9LvsY4+bU7SaZXF7AUubIYwW7EW+
 KYSDzaHHG1MMpE6sONvbwb8ygE/llyBlz5xR3fUrIa4UGLyAGJ92Qq6xs5ecz5PrwmvxqHPGB
 NrCALYCPbQicFgTirVcyyAKcx2lK03+V3iGMDl1KqyJzh0UrBuBd3ysIwFML+xxmbz4cIQAzv
 +aM0fzzFkheLyYY4MmBrct6Mp+L7dhorQikukQBQ1QxIwm5598LBHyIrmI5tO9wJ4Hd3zY9t7
 asPvM9D/Sqy4Hm9Ht7mILWQwFtTSCrHxEp1XOWcRzgUwn/rAth+5AoFdJyizjsOhCHDp6OrWb
 gHQpxGSHBk/ndONycday6NjBnAlCJPUKUwlakOqgGfjWTZjY9QPbfxJXoUD9HuBXLoLWObN43
 Afkihif/Jcjk5DBgQ3QEOnvGUbM4HOCU2iXy8P5Mjz6JqsCSJz3ZV8UgJqy3h3+N4MSVXxOem
 awYKRu43b9svJbYSvJmKe14e7G9PH0wf8m0jenx0mbQV06TkqiY6iFmHuEZPkFSCmThWz+Rz+
 ZrDIpUTbhMfGaljYvK0aiHwsYp9A9deUv4044VpvQJxC0gZ6eeHJYgFR/uZaDsAMQiK8tP8FH
 PA5gNhcGoLdKOrg6TgMEG7kt52RaHUUCkgzy7RW35KOKeAkC7EG7D2ZIC+rdmK2NQEwvxUI/m
 zxpEsYbIb4+uJbrABrTUZMpw5bycz5g2hg6CqPEtjwhPvh5966iSHgaXdp1DOt12iXaFsrDSA
 IlO6I93JMhiwCp2gQR2EjJNU4OtCHVXUCkoIeZ+Ins0/CqjAkvzLaTbBm5GVG+s6M1JTLn27P
 Cd2/2msugb3ejtOYJP70TjDnrhguzwWDsuUKA6Ib+8gdHwea2EDT07dggTR5nAFkMAidP3PYh
 9gztWTjta3ecRsVYeFlRLNNYQhY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/17 13:07, Qu Wenruo wrote:
> [BACKGROUND]
> Scrub originally works in a per-device basis, that means if we want to
> scrub the full fs, we would queue a scrub for each writeable device.
>
> This is normally fine, but some behavior is not ideal like the
> following:
> 		X	X+16K	X+32K
>   Mirror 1	|XXXXXXX|       |
>   Mirror 2	|       |XXXXXXX|
>
> When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
> will try to read from mirror 2 and repair using the correct data.
>
> This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
> to be read twice, which may or may not be a big deal.
>
> But the problem can easily go crazy for RAID56, as its repair requires
> the full stripe to be read out, so is its P/Q verification.
>
>
> There are also some other minor problems, like due to the difference in
> the disk read speed, we may be scrubbing different block groups on
> different devices.
> This can lead to reduced available space and higher chance of false
> -ENOSPC.
>
> [ENHANCEMENT]
> Instead of the existing per-device scrub, this patchset introduce a new
> flag, SCRUB_LOGICAL, to do logical address space based scrub.
>
> Unlike per-device scrub, this new flag would make scrub a per-fs
> operation.
>
> This allows us to scrub the different mirrors in one go, and avoid
> unnecessary read to repair the corruption.
>
> This also makes user space handling much simpler, just one ioctl to
> scrub the full fs, without the current multi-thread scrub code.
>
> [TODO]
> The long todo list is the main reason for RFC:
>
> - Missing RAID56 handling
>    Unlike pure mirror based profiles, RAID56 repair now needs to be
>    handled inside scrub (or some new raid interfaces to handle fully
>    cached stripes).
>
>    This can be some extra investment, and add an exception for the
>    elegant and simpler mirror based read-repair path.
>
> - Better progs integration
>    In theory we can silently try SCRUB_LOGICAL first, if the kernel
>    doesn't support it, then fallback to the old multi-device scrub.
>
>    But for current testing, a dedicated option is still assigned for
>    scrub subcommand.
>
>    And currently it only supports full report, no summary nor scrub file
>    support.
>
> - More testing
>    Currently only very basic tests done, no stress tests yet.

Forgot one more feature missing:

- IO speed limit through sysfs interface
   The old interface is per-device one, which can not be integrated
   easily into the per-fs scrub.

Thanks,
Qu

>
> Qu Wenruo (5):
>    btrfs: scrub: make scrub_ctx::stripes dynamically allocated
>    btrfs: scrub: introduce the skeleton for logical-scrub
>    btrfs: scrub: extract the common preparation before scrubbing a block
>      group
>    btrfs: scrub: implement the basic extent iteration code
>    btrfs: scrub: implement the repair part of scrub logical
>
>   fs/btrfs/disk-io.c         |   1 +
>   fs/btrfs/fs.h              |  12 +
>   fs/btrfs/ioctl.c           |   6 +-
>   fs/btrfs/scrub.c           | 757 ++++++++++++++++++++++++++++++-------
>   fs/btrfs/scrub.h           |   2 +
>   include/uapi/linux/btrfs.h |  11 +-
>   6 files changed, 647 insertions(+), 142 deletions(-)
>
