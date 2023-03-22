Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868E6C4056
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 03:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCVC0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCVC0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 22:26:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510345A1B2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 19:26:07 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1q1XSA3QTX-00WmlU; Wed, 22
 Mar 2023 03:25:30 +0100
Message-ID: <c50dba5e-54a4-e546-5fbd-a1a074080b61@gmx.com>
Date:   Wed, 22 Mar 2023 10:25:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 0/1] Enforce 4k sectorize by default for mkfs
Content-Language: en-US
To:     Neal Gompa <neal@gompa.dev>,
        Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20230321180610.2620012-1-neal@gompa.dev>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230321180610.2620012-1-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:z3WQPfoV3/b+iGog5LttiHJHTddX5aJPyflYpXYBGFWhM2zShlJ
 Te4JM13/vtIHsJ4k2ySRo0zGZw5tx2ao8kQmkrkpSZn8+XyE1KZbUquqHtZo/SXRkZxsFGI
 ZDSGAEjKRfCPV0/6M99TRZK8u1YhP1KJZGpnp24PWwHcL9B2XpwBsL9x/GlGYhJ+0p537Wv
 HUnBwyhBUCYioBhjJxmUw==
UI-OutboundReport: notjunk:1;M01:P0:qwd7tg9ehyo=;rW4uZfQIQqSka3oYoZZT40/cg0j
 HAoJY8BMtdmwyK1B2MR3u6OrVD2VfWB3UNI0cvbyz2xL95fZJdy+b/XO4cEkuEL7PDPYrlj3F
 bzgdakS54RyxYeTtFjUH8ATwPtXP8qGqDO6HxKapy6aLGCE2bDdVVYpNqW+W39m/hEeB9EGAL
 1PpptBfMADuVPg9oV7u0UEZnaMmy/095m2MPcC+p2QWN9tKSptjJqJA/F8ZMJiKGKh6PfMAzH
 KHYFtN/s4MetyWxS2fEJD2zEjWUywL0ajjY2YAaepHqOg0LrLDaQ3iT2qilIR7HCQ//b+9+OI
 tJRN0UR7c6snOWE3lDJ39Mv1amWtGjVsrXQAbR3cYkQZUvJeMPpmKXCa/eJ6/1aazki1mRxbn
 cpoNVrI066tlXxykp5xEQ8PdNPF3q/vVVpcBGvqCjNeLA2vvYarUtrAfJ/38J8MZ6RddDc+JX
 LY5JqQTLUJK66OulKMZPJaquFNhCAyd6Uc3A9Jv5Gq4/WiiNASaO931IPlJR4KuJP90AuANhf
 PiFvOlFD6eOznUSbMEMZ4GcxV0tPlkQUWBww8HHljJRxDC/XQu7/h4bljmHtYljld4i8lG+jP
 Dtk/o37KC3lM3s2tRHLlq6MDSc6CMSqyegQ+iHU7zouafx5YJDAAbgh5NqEYdzXDkSE7ijXOL
 4ozfV+lfe1ySGNfhtNuWfFLjvYyxEUDQLdLLdSZb2r5PThtlhmKmrQMjRQm5AbKw3wbWI+UOG
 6EhkjvL6cNLHAsKleZlEuJ/o3mnnuZxS5O6/WEQuuoeyRBvDG9gA+6l8eRCOSqW7nN6vqfY7/
 xfuBmsAgcdSKa63to+L5VPbXhzMpswV1Y4txwChC/l4oLLGJHKtwNMDlzzJVEDcSP2Lqwn/H9
 JDspFQsrKKNj4mt7PCBw39P0iNiWD5pUmLPScfC2r8D5YhTjLONuMv1r8mphIR3ZUdN+j0lFK
 SaEdNMggWZMXj27NYGDOVKuJl5Y=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/22 02:06, Neal Gompa wrote:
> The Fedora Asahi SIG[0] is working on bringing up support for
> Apple Silicon Macintosh computers through the Asahi Fedora Remix[1].
> 
> Apple Silicon Macs are unusual in that they currently require 16k
> page sizes, which means that the current default for mkfs.btrfs(8)
> makes a filesystem that is unreadable on x86 PCs and most other ARM
> PCs.
> 
> Soon, this will be even more of a problem within Apple Silicon Macs
> as Asahi Lina is working on 4k support to enable x86 emulation[2]
> and since Linux does not support dynamically switching page sizes at
> runtime, users will likely regularly switch back and forth depending
> on their needs.
> 
> Thus, I'd like to see us finally make the switchover to 4k sectorsize
> for new filesystems by default, regardless of page size.
> 
> The initial test run by Hector Martin[3] at request of Qu Wenruo
> looks promising[4], and I hope we can get this to land upstream soon.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And I'm already pulling my aarch64 VM to run subpage tests again, and 
this time with 16K page size, just like the one utilized by Asahi Linux 
project.

The failures reported by Hector is being investigated, and such switch 
in mkfs would bring more feedback from other distros too.
Hopefully we can also remove the experimental warning from kernel soon.

Thanks,
Qu

> 
> This is an update on the initial RFC patch[5], which addresses the
> documentation feedback from Anand Jain.
> 
> [0]: https://fedoraproject.org/wiki/SIGs/Asahi
> [1]: https://asahi-fedora-remix.org/
> [2]: https://vt.social/@lina/110060963422545117
> [3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
> [4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
> [5]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#t
> 
> Neal Gompa (1):
>    btrfs-progs: mkfs: Enforce 4k sectorsize by default
> 
>   Documentation/Subpage.rst    | 15 ++++++++-------
>   Documentation/mkfs.btrfs.rst | 13 +++++++++----
>   mkfs/main.c                  |  2 +-
>   3 files changed, 18 insertions(+), 12 deletions(-)
> 
