Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A056D605AEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJTJQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJTJQo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 05:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7B1BE1E9
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 02:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE90C61A6A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F05C43470
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666257400;
        bh=pyVMTMn6Bbqpum2NvBvSf/CLLVsHx60OCzeRiLPPMjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jzSmU6/d/FrFoLixTLldinEmohHtK0GEoTy2iIw7VlQA6aYZGo43KV1SggXZ8rCLJ
         v0oB+y6VwIt33NCTVkMyqqIk3gVnbNwabHTtDQ75aPnGMGKWJ4k/PkNjO5QqrldSJT
         bRFsoHEycN+DzWT+4xRY7WiT5zuKwllhauAi1WdILvIydo6/QKGd9GlloiuCr07nN6
         Db1exiVLbZY6KFtYgJyW6gFHuZfYMDcZ1JNVaFxB7ZX6jFLdXiOYQ1HstLdRWsTi5t
         uNc1lP3f7+FU2fkBKrI/g4AI9XSkD3ij/1HTzksJYDNb+Ga1qIzSbO3Dy3VLwyEwnG
         VNNiASM7fDdaA==
Received: by mail-ot1-f45.google.com with SMTP id a16-20020a056830101000b006619dba7fd4so11029446otp.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 02:16:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf3iHWWEY7KH/WiPEPUA8jIUihGIYSNJAot5HhMtjCTJsFGDSWIE
        o4Ei2JQO9GyEguqZUY1qZTVF+hYm5a1YOhaHVEY=
X-Google-Smtp-Source: AMsMyM6xaSD4E0d6s1OPtuKD364ITxib+Z+L+feJopH7epRQ9f+H0DBy4A3bhsQlPFW2vOPXL3qxmabGk6FWIRLQG6g=
X-Received: by 2002:a9d:635a:0:b0:661:c48b:12cc with SMTP id
 y26-20020a9d635a000000b00661c48b12ccmr6878101otk.363.1666257399210; Thu, 20
 Oct 2022 02:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <1666204197@msgid.manchmal.in-ulm.de>
In-Reply-To: <1666204197@msgid.manchmal.in-ulm.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Oct 2022 10:16:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H55=yCEc9ROmS+AObK+p_XzEvYv5QPwDUQNULh_PfnADQ@mail.gmail.com>
Message-ID: <CAL3q7H55=yCEc9ROmS+AObK+p_XzEvYv5QPwDUQNULh_PfnADQ@mail.gmail.com>
Subject: Re: Endless "reclaiming chunk"/"relocating block group"
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 8:12 PM Christoph Biedl
<linux-kernel.bfrz@manchmal.in-ulm.de> wrote:
>
> Hello,
>
> On some systems I observe a strange behaviour: After remounting a BTRFS
> readwrite, a background process starts doing things on the disk,
> messages look like
>
> | BTRFS info (device nvme0n1p1): reclaiming chunk 21486669660160 with 100% used 0% unusable
> | BTRFS info (device nvme0n1p1): relocating block group 21486669660160 flags data
> | BTRFS info (device nvme0n1p1): found 4317 extents, stage: move data extents
> | BTRFS info (device nvme0n1p1): found 4317 extents, stage: update data pointers

So that means you have automic block reclaim enabled (in this case a
non-zero value in the sysfs
file /sys/fs/btrfs/<uuid>/allocation/data/bg_reclaim_threshold).

This sounds like it can be fixed by a very recent patch which is not
yet in any released kernel:

https://lore.kernel.org/linux-btrfs/5f8c37f6ebc9024ef4351ae895f3e5fdb9c67baf.1665701210.git.boris@bur.io/

>
> and (with differing numbers) this goes on for hours and days, at a
> read/write rate of about 165/244 kbyte/sec. The filesystem, some 2.5
> Gbyte total size, is filled to about 55%, so even if that process
> touches each and every block, it should already have handled everything,
> several times.
>
> Now, I have no clue what is happening here, what triggers it, if it will
> ever finish. Point is, this takes a measuarable amount of I/O and CPU,
> and it delays other processes.
>
>
> Some details, and things I've tested:
>
> This behaviour is reproducible 100%, even with a btrfs created mere
> moments ago.
>
> The filesystem was created using the 5.10 and 6.0 version of the
> btrfs-progs (both as provided by Debian stable and unstable resp.).
>
> Using the grml rescue system (stable and daily, the latter kernel 5.19),
> the system does not show this behaviour.
>
> The group block number is constantly increasing (14 digits after two
> days), in other words, I have not observed a wrap-around.
>
> It was suggested in IRC to format using the --mixed parameter, no avail.
>
> It was also suggested to set the various bg_reclaim_threshold to zero to
> stop this process, no avail.
>
> This is amd64 hardware without any unusual elements. I could easily
> reproduce this on a fairly different platforms to make sure it's not
> hardware specific.
>
> Scrubbing did not show any errors, and the problem remained.
>
>
> The host runs a hand-crafted kernel, currently 5.19, and I reckon this
> is the source of the problem. Of course I've compared all the BTRFS
> kernel options, they are identical. In the block device layer
> configuration I couldn't see any difference that I can think would
> relate to this issue. Likewise I compared all kernel configuration
> options mentioned in src/fs/btrfs/, still nothing noteworthy.
>
>
> So I'm a bit out of ideas. Unless there's something obvious from the
> description above, perhaps you could give a hint to the following: The
> process that emits the messages above, is there a way to stop it, or to
> report completion percentage? Looking intobtrfs_reclaim_bgs_work
> (block-group.c), it doesn't look like it. Are block group numbers really
> *that* big, magnitudes over the size of the entire filesystem?
>
> Regards,
>
>     Christoph
>
