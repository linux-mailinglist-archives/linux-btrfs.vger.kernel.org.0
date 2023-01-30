Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7068168F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjA3QjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjA3QjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 11:39:19 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322A6196
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 08:39:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt14so33519122ejc.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qo+Zxyqb6eJ1K/aWBxJ3U93RXqgA9WzKnHWq+FuZYo=;
        b=qi73YP3AIMIiZ8SZpu2+dpaZQt9bo3MkaCsn387FpOzmfuoeXztDTsQvufVV/npnIM
         C29YMUkJR2YvZfaki3PzIIjiGLJFjQE8T1wMCE06CdDkr2AHzgsF4xdRPqHKCHhEQkKs
         bwwNDdL6M+zofoX0oKOpQTeM25x3U0ssw8X8WLWSI7OTpmOv+ZuTpPro0TPNooHUAnIo
         MHBnvpA/jGQVYQJia7RPBNxgP+QUrOjRYVEbpJroaSjLmPIGfId4MGiBtiyCbWZVLK5t
         pWgvSvzbXXnoIMO8elnYhW2JRwKep9sSFqJ3W0jvPofHFryx5YrRElQqYHoh3B6mhr9M
         XKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qo+Zxyqb6eJ1K/aWBxJ3U93RXqgA9WzKnHWq+FuZYo=;
        b=2NHv+6gzvf9dd3vdF7225RaOc/QzRHe0NO9N3+AxPz4D/R5PMlRNBH2Rzoy8LViRUp
         tkB3myJ0QPfYAUHG08G1U5BeMZJJxVGBWUBbYSEkxFoqTY6BQhVdeSKem+2nGJBUegpy
         x8fAGMrI3ttBTk2gxTemercCfeIujkeoL05i5Tmc/MMeUE6bo5DbwTRUV2idblhjwjIs
         jyAYAu/vt0JRPIS00a7TI/gXZRYF5zhvJt0Itli4QjSnwgtGGHSoTVeoKwymqyGPcFC2
         Cky8E4F/Ht7Ad5cNmveev6XDlfyolI2u5tOmR/SLICm6XPjW9U5wRsUyGf5P+qnUz2Bx
         jhPQ==
X-Gm-Message-State: AO0yUKVnTzDbsMAVmwkICqQ80hGCFcZ0pBrwdSQ+hLBxTxuCO3xkFQzA
        8WhZ0gF6KBbGgamdRFXWW+X5DVLTYn7AfrRNDsEnqZ8PdUA=
X-Google-Smtp-Source: AK7set+KXC/fvAq2iSSU+tyRs0GvF1ZSxm9x833aW/rtf77HMUpBqUd0/rQGCUBEkv3leg68zdLe5mvMliOM2qNze/8=
X-Received: by 2002:a17:906:26c9:b0:87b:d26f:eb49 with SMTP id
 u9-20020a17090626c900b0087bd26feb49mr3322421ejc.176.1675096756536; Mon, 30
 Jan 2023 08:39:16 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
 <c08cea1d-1ae3-c0d1-c164-6453ad73f0c0@libero.it> <Y83S6QRxiM/L/2qD@hungrycats.org>
In-Reply-To: <Y83S6QRxiM/L/2qD@hungrycats.org>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 30 Jan 2023 17:39:05 +0100
Message-ID: <CAA7pwKPeVjqkytpvU1X2txatQzuOULTTBXHBAm46YKQmcMn0Ug@mail.gmail.com>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 23 Jan 2023 at 01:36, Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Sun, Jan 22, 2023 at 09:27:33PM +0100, Goffredo Baroncelli wrote:
> > On 22/01/2023 12.41, Cerem Cem ASLAN wrote:
> > > Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> > >
> > > The problem with the "chattr +C ..., move back and forth" approach is
> > > that the VM folder is about 300GB and I have ~100GB of free space,
> > > plus,
> >
> > This can be solvable: it should be possible to make a tool that for
> > each unit of copy (eg each 1 GB) does:
> > - copy the data from the COW file to the NOCOW file
> > - remove the data copied from the NOCOW file (using fallocate+FALLOC_FL_PUNCH_HOLE)
> >
> > So you can avoid to have two FULL copy of the same file (in pseudo code:
> >
> > block_size = 1024*1024*1024;
> > while (pos < file_len) {
> >       l = min(block_size, file_len - pos);
> >       len_copied = copy(srcfd, dstfd, pos, l);
> >       fallocate(srcfd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, pos, l);
> >
> >       pos += l;
> > }
> >
> >
> > end pseudo code)
> >
> > I don't know if there is an algorithm that prevent the data loss in case of
> > an interruption of the copy. May be that it exists... We need a file where
> > we could log the status.
>
> Start at the end of the file and work backwards, making the source
> file shorter with truncate.  The size of the original file provides a
> built-in checkpoint that you can resume from, at worst, copying the last
> 1GB of the file again after resuming.  There's no danger of accidentally
> copying a bunch of zeros that would be left behind by PUNCH_HOLE.
>
> Don't forget to open the dst file without O_TRUNC, and call fsync()
> (or ideally sync() to force a full commit and avoid possible log tree
> replay issues) between writing the copy and truncating the original.

I threw together https://github.com/pLuster/btrfs-uncow and even tried
interrupting and continuing a half finished copy once, which worked
fine. A huge drawback is that files with holes will grow.

It's not well tested and I don't know if it's very useful. Copying
zeros should be smarter. Open for suggestions.
