Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7E6A7C33
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCBIEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 03:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBIEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 03:04:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0613D7E
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 00:04:39 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pXdvZ-0006YB-Bt; Thu, 02 Mar 2023 09:04:37 +0100
Message-ID: <fcba79c6-7d1b-0e17-7c75-42e25fedae69@leemhuis.info>
Date:   Thu, 2 Mar 2023 09:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US, de-DE
To:     Sergei Trofimovich <slyich@gmail.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y/+n1wS/4XAH7X1p@nz>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y/+n1wS/4XAH7X1p@nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677744279;658ff392;
X-HE-SMSGID: 1pXdvZ-0006YB-Bt
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 01.03.23 20:30, Sergei Trofimovich wrote:
> Hi btrfs maintainers!
> 
> Tl;DR:
> 
>   After 63a7cb13071842 "btrfs: auto enable discard=async when possible" I
>   see constant DISCARD storm towards my NVME device be it idle or not.
> 
>   No storm: v6.1 and older
>   Has storm: v6.2 and newer

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 63a7cb13071842
#regzbot title btrfs: DISCARD storm towards NVME device be it idle or not
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> More words:
> 
> After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
> started flashing incessantly regardless of present or absent workload.
> 
> I think I confirmed the storm with `perf`: led flashes align with output
> of:
> 
>     # perf ftrace -a -T 'nvme_setup*' | cat
> 
>     kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_queue_rq
>     kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-nvme_setup_cmd
>     kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_queue_rq
>     kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-nvme_setup_cmd
>     kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_queue_rq
>     kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-nvme_setup_cmd
>     kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_queue_rq
>     kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-nvme_setup_cmd
> 
> `iotop` shows no read/write IO at all (expected).
> 
> I was able to bisect it down to this commit:
> 
>   $ git bisect good
>   63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
>   commit 63a7cb13071842966c1ce931edacbc23573aada5
>   Author: David Sterba <dsterba@suse.com>
>   Date:   Tue Jul 26 20:54:10 2022 +0200
> 
>     btrfs: auto enable discard=async when possible
> 
>     There's a request to automatically enable async discard for capable
>     devices. We can do that, the async mode is designed to wait for larger
>     freed extents and is not intrusive, with limits to iops, kbps or latency.
> 
>     The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
> 
>     The automatic selection is done if there's at least one discard capable
>     device in the filesystem (not capable devices are skipped). Mounting
>     with any other discard option will honor that option, notably mounting
>     with nodiscard will keep it disabled.
> 
>     Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
>     Reviewed-by: Boris Burkov <boris@bur.io>
>     Signed-off-by: David Sterba <dsterba@suse.com>
> 
>    fs/btrfs/ctree.h   |  1 +
>    fs/btrfs/disk-io.c | 14 ++++++++++++++
>    fs/btrfs/super.c   |  2 ++
>    fs/btrfs/volumes.c |  3 +++
>    fs/btrfs/volumes.h |  2 ++
>    5 files changed, 22 insertions(+)
> 
> Is this storm a known issue? I did not dig too much into the patch. But
> glancing at it this bit looks slightly off:
> 
>     +       if (bdev_max_discard_sectors(bdev))
>     +               fs_devices->discardable = true;
> 
> Is it expected that there is no `= false` assignment?
> 
> This is the list of `btrfs` filesystems I have:
> 
>   $ cat /proc/mounts | fgrep btrfs
>   /dev/nvme0n1p3 / btrfs rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=848,subvol=/nixos 0 0
>   /dev/sda3 /mnt/archive btrfs rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/ 0 0
>   # skipped bind mounts
> 
> The device is:
> 
>   $ lspci | fgrep -i Solid
>   01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)
> 
> Can you help me debug the source of discards storm?
> 
> Is it an expected discard storm?
> 
> Is it problematic for SSD life span?
> 
> Thank you!
> 
