Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AE5B78E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiIMR4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIMRzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 13:55:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D728A98C6
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 09:55:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3452214cec6so148150887b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EQ2OI2Bi+tMc97FxfccwICpjDxSSAOHUBhviJjqYpjo=;
        b=jaMMBZ4KYozKTMX7Heqs2FOW35Y8BFF7SqTqYdFtVMaagbupvo5aRy5/0DjJmW4uN2
         xrzwuOumhhbLKAhv8m9XDcQvVw5quAgEwIn64AQpc0I0uMGd37I4EhRZfGKwUwS1fSBK
         quUjU+YdYCZ35zD8LvIgyLPZJWNGiB+M6ak48pVbQehsmTrpDbkJZOxBWxQOa6Irg6nm
         /6PjmGm+eL2YATppqc5dFiPgHbAvbjsxkAE/viqSdjBPH4wKP/qhQw7LQsv4Frma0O0f
         zKTAdLpIVunpB1TcDY6aK03LiM5Cbtpg0xcj0MZqhy9VvH/7A3sQslsfviMduFN7CZ1P
         3vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EQ2OI2Bi+tMc97FxfccwICpjDxSSAOHUBhviJjqYpjo=;
        b=XHk6XTEqm/Hj3rTrKKmubSRw7FwElZYkLixzjf7jjqLex8g083yzp20TLMMKEetL7U
         ffVZZ3/KAZklrkTUB8Lxs8LtTPJRFgfatERa7CUxzS2pYYr4NpEP/ZZc8xFFpJGXfeSL
         dYfM7MKrLV5pAA4In9LHE3kBn+oEZ5K+5pMAf/tEE+Juaa278lLhqV+QN22yftYWCJGb
         4+Zo/9JOerIeeHjEYdaCVpYoCtBmwKpDNmPydm/cmBPf2DrbkUoNL8fVGHqu9qL30GC7
         SzmseXfx2H9SM/IxOaq1MlYqxxfXujZz2ppCIQg876X3jj3uPXBcPZ0tbWyAFhSfGEoj
         FmPg==
X-Gm-Message-State: ACgBeo3oy24SxavtBSXHG6sb9WZxoaEf9QpK6LGkM0FgbN0oOASutbes
        FwaJ8BdJrrhCI+t0QwRHbTxpeDlyFHcg5x+esPSwb4+33YG6ddraNmY=
X-Google-Smtp-Source: AA6agR5KCvGWEQN3LJYhqIQU6V3Ye61Cb2H0y6ayGAuf4yycKLJmGiy51NO5lex2RW/CgmaxtcfaGtct1qeVpW/C5vo=
X-Received: by 2002:a0d:f847:0:b0:341:3399:fd55 with SMTP id
 i68-20020a0df847000000b003413399fd55mr27401834ywf.55.1663088150434; Tue, 13
 Sep 2022 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <2a76b8005eb7208eda97e62a944ae456cbe8386f.1662705863.git.wqu@suse.com>
 <20220913123828.GK32411@twin.jikos.cz>
In-Reply-To: <20220913123828.GK32411@twin.jikos.cz>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Tue, 13 Sep 2022 18:55:34 +0200
Message-ID: <CAK-xaQYFKh88OsA9noaZbz4k5pYZwYSwtY7ZLqb_XOzZkc-KKA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: don't update the block group item if used bytes
 are the same
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just for the record, I cherry-picked this patch for my storage
(>120TB) and no problem at all since it was released.

Thanks a lot Qu!

Ciao,
Gelma

Il giorno mar 13 set 2022 alle ore 17:44 David Sterba
<dsterba@suse.cz> ha scritto:
>
> On Fri, Sep 09, 2022 at 02:45:22PM +0800, Qu Wenruo wrote:
> > [BACKGROUND]
> >
> > When committing a transaction, we will update block group items for all
> > dirty block groups.
> >
> > But in fact, dirty block groups don't always need to update their block
> > group items.
> > It's pretty common to have a metadata block group which experienced
> > several CoW operations, but still have the same amount of used bytes.
> >
> > In that case, we may unnecessarily CoW a tree block doing nothing.
> >
> > [ENHANCEMENT]
> >
> > This patch will introduce btrfs_block_group::commit_used member to
> > remember the last used bytes, and use that new member to skip
> > unnecessary block group item update.
> >
> > This would be more common for large fs, which metadata block group can
> > be as large as 1GiB, containing at most 64K metadata items.
> >
> > In that case, if CoW added and the deleted one metadata item near the end
> > of the block group, then it's completely possible we don't need to touch
> > the block group item at all.
> >
> > [BENCHMARK]
> >
> > The patchset itself can have quite a high chance (20~80%) to skip block
> > group item updates in a lot of workload.
> >
> > As a result, it would result shorter time spent on
> > btrfs_write_dirty_block_groups(), and overall reduce the execution time
> > of the critical section of btrfs_commit_transaction().
> >
> > Here comes a fio command, which will do random writes in 4K block size,
> > causing a very heavy metadata updates.
> >
> > fio --filename=$mnt/file --size=512M --rw=randwrite --direct=1 --bs=4k \
> >     --ioengine=libaio --iodepth=64 --runtime=300 --numjobs=4 \
> >     --name=random_write --fallocate=none --time_based --fsync_on_close=1
> >
> > The file size (512M) and number of threads (4) means 2GiB file size in
> > total, but during the full 300s run time, my dedicated SATA SSD is able
> > to write around 20~25GiB, which is over 10 times the file size.
> >
> > Thus after we fill the initial 2G, we should not cause much block group items
> > updates.
> >
> > Please note, the fio numbers by itself doesn't have much change, but if
> > we look deeper, there is some reduced execution time, especially
> > for the critical section of btrfs_commit_transaction().
> >
> > I added extra trace_printk() to measure the following per-transaction
> > execution time
> >
> > - Critical section of btrfs_commit_transaction()
> >   By re-using the existing update_commit_stats() function, which
> >   has already calculated the interval correctly.
> >
> > - The while() loop for btrfs_write_dirty_block_groups()
> >   Although this includes the execution time of btrfs_run_delayed_refs(),
> >   it should still be representative overall.
> >
> > Both result involves transid 7~30, the same amount of transaction
> > committed.
> >
> > The result looks like this:
> >
> >                       |      Before       |     After      |  Diff
> > ----------------------+-------------------+----------------+--------
> > Transaction interval  | 229247198.5       | 215016933.6    | -6.2%
> > Block group interval  | 23133.33333       | 18970.83333    | -18.0%
> >
> > The change in block group item updates is more obvious, as skipped bg
> > item updates also means less delayed refs, thus the change is more
> > obvious.
> >
> > And the overall execution time for that bg update loop is pretty small,
> > thus we can assume the extent tree is already mostly cached.
> > If we can skip a uncached tree block, it would cause more obvious
> > change.
> >
> > Unfortunately the overall reduce in commit transaction critical section
> > is much smaller, as the block group item updates loop is not really the
> > major part, at least for the above fio script.
> >
> > But still we have a observable reduction in the critical section.
> >
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > [Josef pinned down the race and provided a fix]
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks for the numbers, it seems worth and now that we have the fixed
> version I'll add it to 6.1 queue as we have the other perf improvements
> there.
