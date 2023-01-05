Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3165E50A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 06:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjAEFYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 00:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAEFYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 00:24:24 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E751309
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 21:24:22 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-482363a1232so350114827b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jan 2023 21:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lm3vJ8qP713etqlDj8BmGuEkNhedm22jncXyb+zTxtI=;
        b=vWIi+g3ydqD+AC8LXgtKoH1dxTsZg1jsZxBne1TUoyvUr9K5mM5FmrABH5HGe/HvsH
         2HzdmI38d/Z8ajJbGRWLlwyAPyEykRouXh7aE9zMFLF6cJSLpUa4d2R7CVlpQhkLWeAM
         2RKRkSy2uHlXukfohhhlKoRu+/P/pe4x9AsJ9UQ3wI1oDmXF5/ezh9NQlTj2ynFd2Vnn
         QeagpcnfY/Fg9bz73BOnOUQsJ3FlK7Hxq75lOGpPXhWk22rV1zsJFImqiygR4UM9W+Jq
         sYPko5oo2sCOQsYSxc26kMipBJXGNrV6r0/b0xFoa3/0flJa7NvKceITOiggDh9E+w3k
         qF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm3vJ8qP713etqlDj8BmGuEkNhedm22jncXyb+zTxtI=;
        b=V7Bxx2TkwmGc+c8E5JK4tBZxHZNXCalpadmCx0Md2ng6k+sU/uTw4f5vbgIVGojOkg
         Mrbzf62f966OkGXHaX5NVWc+TVVG4uP/OeV0BBcuqPm0tr4QJ83Xac1qnaSr4Fmc+ADc
         kvjZVTmDK/PhNkf8G8OAkLoXr897mpr2WQr1noUrKYOmlsPSXNQMbGqXit3ohVXZ30vo
         +OtM5+D6ITslEXrD7YcfcLiEJe+YLryK/2Sjn09j+xCN0uiBYD3YPb6/OUoDc+8pTNf1
         ZOIphdvFkNCteCfVhQgwxdUIRh0Q4Fu59rlen1GCJkMXu9ul8UPK4jjfjoMNptifxTAx
         rgPA==
X-Gm-Message-State: AFqh2kr+YFJIi5UgmtODOR/YOlnKlHQzoyI7GjGTUBmGBpxCY0hrYCGW
        Fjn5KvMzctyxzGA0A52m7xosA8PfLiDjQLfKQARzLHKIJc9r7f+XMiWS/A==
X-Google-Smtp-Source: AMrXdXunAXK1ZwHTf/8hiFXoKeyw5Cb7wXUsqHQTKjY5TEVDjKuh3EvUUkqiI/j1ykK14q45O5uaBgRv3PguUPdz+WQ=
X-Received: by 2002:a81:610a:0:b0:47b:bada:70a0 with SMTP id
 v10-20020a81610a000000b0047bbada70a0mr4789320ywb.504.1672896260667; Wed, 04
 Jan 2023 21:24:20 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
In-Reply-To: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Wed, 4 Jan 2023 22:24:09 -0700
Message-ID: <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
Subject: Re: File system can't mount
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 4, 2023 at 10:11 PM Robert LeBlanc <robert@leblancnet.us> wrote:
>
> I may have run into a new bug (I can't find anything in my Google
> search other than a patch that exposes the issue). I had to recreate
> my BTRFS file system about a year ago when I hit a bug in an earlier
> kernel. I was able to pull a good snapshot from my backups (and mount
> the old filesystem in read-only to get my media subvolume) and it had
> been running great for at least a year. My file system went offline
> today and just would not mount. I downloaded the latest btrfs-progs
> from git to see if it could handle it better, but no luck. This is a
> RAID-1 with 4 drives and the metadata is also RAID-1, but it looks
> like both copies of the metadata are corrupted the same way which is
> really odd and the drives show no errors. I tried taking the first
> drive that it complained about offline and tried to mount with `-o
> degraded` but it couldn't bring up the filesystem. It would be nice to
> try and recover this as I have a subvolume with my media server that
> isn't backed up because of the size, but the critical stuff is backed
> up.
>
> Here is the `btrfs check` output:
> ```
> #:~/code/btrfs-progs$ sudo ./btrfs check /dev/mapper/1EV13X7B
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/1EV13X7B
> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
> [1/7] checking root items
> [2/7] checking extents
> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
> aligned, may cause problem for 64K page system
> ERROR: add_tree_backref failed (extent items tree block): File exists
> ERROR: add_tree_backref failed (non-leaf block): File exists
> tree backref 12462950957056 root 7 not found in extent tree
> incorrect global backref count on 12462950957056 found 1 wanted 0
> backpointer mismatch on [12462950957056 1]
> extent item 12462950961152 has multiple extent items
> ref mismatch on [12462950961152 16384] extent item 1, found 2
> backref 12462950961152 root 7 not referenced back 0x56292931ae60
> incorrect global backref count on 12462950961152 found 1 wanted 2
> backpointer mismatch on [12462950961152 16384]
> owner ref check failed [12462950961152 16384]
> bad metadata [12462950961152, 12462950977536) crossing stripe boundary
> data backref 12493662797824 root 13278 owner 193642 offset 0 num_refs
> 0 not found in extent tree
> incorrect local backref count on 12493662797824 root 13278 owner
> 193642 offset 0 found 1 wanted 0 back 0x562920287070
> incorrect local backref count on 12493662797824 root 17592186057694
> owner 193642 offset 0 found 0 wanted 1 back 0x562929472ba0
> backref disk bytenr does not match extent record,
> bytenr=12493662797824, ref bytenr=0
> backpointer mismatch on [12493662797824 24576]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> there is no free space entry for 12462950957056-12462950961152
> cache appears valid but isn't 12461878018048
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 13920420491265 bytes used, error(s) found
> total csum bytes: 13555483180
> total tree bytes: 17152835584
> total fs tree bytes: 1858191360
> total extent tree bytes: 563019776
> btree space waste bytes: 1424108973
> file data blocks allocated: 28183758581760
> referenced 19476700778496
>
> #:~/code/btrfs-progs$ git rev-parse HEAD
> 1169f4ee63d900b25d9828a539cee4f59f8e9ad7
> ```
>
> dmesg output:
> ```
> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): using crc32c
> (crc32c-intel) checksum algorithm
> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): allowing degraded mounts
> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): disk space
> caching is enabled
> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
> /dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
> /dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
> /dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
> /dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
> previous extent [12462950961152 169 0] overlaps current extent
> [12462950973440 169 0]
> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
> block corruption detected on logical 45382409060352 mirror 2
> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
> previous extent [12462950961152 169 0] overlaps current extent
> [12462950973440 169 0]
> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
> block corruption detected on logical 45382409060352 mirror 1
> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): failed to read
> block groups: -5
> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): open_ctree failed
> ```
>
> Linux leblanc 6.0.0-6-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.0.12-1
> (2022-12-09) x86_64 GNU/Linux
>
> #~/code/btrfs-progs$ sudo ./btrfs filesystem show /dev/mapper/1EV13X7B
> Label: 'storage2'  uuid: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>        Total devices 4 FS bytes used 12.66TiB
>        devid    3 size 10.91TiB used 9.10TiB path /dev/mapper/8HJK8KGH
>        devid    4 size 10.91TiB used 9.10TiB path /dev/mapper/8HHW90DY
>        devid    5 size 5.46TiB used 3.65TiB path /dev/mapper/1EV13X7B
>        devid    6 size 5.46TiB used 3.65TiB path /dev/mapper/K1KLMBZN
>
> Let me know what would be useful, I've been using BTRFS since the
> early days and want to help it get better.

As a test I booted back into the previous kernel and was able to mount
the file system "just fine". My guess is that the patch I found
uncovered a ticking time bomb. Is there a way to fix it?

Linux leblanc 5.18.0-4-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1
(2022-08-10) x86_64 GNU/Linux

[Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): flagging fs with
big metadata feature
[Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): disk space
caching is enabled
[Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): has skinny extents
[Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
/dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
[Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
/dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
[Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
/dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
[Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
/dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
[Wed Jan  4 22:19:35 2023] BTRFS info (device dm-4: state M): disk
space caching is enabled

# btrfs filesystem show /mnt/storage
Label: 'storage2'  uuid: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
       Total devices 4 FS bytes used 12.66TiB
       devid    3 size 10.91TiB used 9.10TiB path /dev/mapper/8HJK8KGH
       devid    4 size 10.91TiB used 9.10TiB path /dev/mapper/8HHW90DY
       devid    5 size 5.46TiB used 3.65TiB path /dev/mapper/1EV13X7B
       devid    6 size 5.46TiB used 3.65TiB path /dev/mapper/K1KLMBZN

I'm going to kick off a scrub as I never got notification from my cron
job that runs on the first that it completed.

Thank you,
Robert LeBlanc
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
