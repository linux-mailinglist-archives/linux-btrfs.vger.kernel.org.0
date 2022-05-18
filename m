Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C552C247
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiERS0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiERS0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 14:26:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9941A0769
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 11:26:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e3so3231737ios.6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOL/VR7c7PTjZq8Z3C+CxZ3xj9Sqs1fPI/7x+W+pszM=;
        b=a0ou32nZPaBkGpib8wzIs1uKvfD/vRZ/GuB77eKj7nUe3Ju9FgNe6ZbdYN4t0oWXnU
         daVbUoJGh0kvcUD9v32jUJGkKumPbco7rz5oWY6N/jzI5iqI9XCmGDq9CnTCucYavRdg
         UzfGv/03heP89MLoFjX+28x4zUOHsTAwaQAOJG7z+/84JMfJEDTSguG4ALMOaDzw3CEB
         FhCBDlI+FpztovZimEIkKeDxF4fc33tI9A6szaPpuC5HYUuGaAscPQ4w9ILmvuWFRXaT
         26zx1z6JolETHso4imlaw1lsZ4DVB63vpTAZnj0S+bZwsI3nV70OcpjVPgTLQm3YnPJC
         mvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOL/VR7c7PTjZq8Z3C+CxZ3xj9Sqs1fPI/7x+W+pszM=;
        b=F1foVRJ82Z2q8jVnOtZGx6eLMF2W+qfT2itRv1vXZaYkNN9BsdIAFY9xwGr/F5vRQS
         d/5blaA9jEphY7aBESZ4XBwhb6DzSl2TfTfxFoELjtxeoJWB2hIFllL0FHHvmktoyqzL
         KJhrbekcYCKald5z9PouPFVa060Q3/KY6xVLZLYrIH0i7MXNkeaGDM/e6ETKDstm7jLW
         QosjFJ0wFS8nXS0cQPnOx1T+hQVtyO4g3qs4eZD98V+v4W86XIdN5HEsdUPiwMkouoFT
         xwUIPFi1sPnqx6uNIdegLyLYTtKK2jt0RXNaUIMftLMzyVBcJsA/QP7uCha3/hahLaUC
         IyPw==
X-Gm-Message-State: AOAM533dVpi2Gqd3qSUUbT9tCkFukY4mHksk8T+zN7WThitqiDlTnICA
        AQt4Uqqbly5R7cPCJ5nX/EtRXuv6K6TkZQUa6TSxItHeEig=
X-Google-Smtp-Source: ABdhPJzTRQSR7Ar+WFP96/oC3KKwhb5uXTbjeazURCXFLSetEGuNmBCVD4Nsz7z4bhvL6Hu+0g3Yr/z3xRDa2pKKxeM=
X-Received: by 2002:a05:6638:2501:b0:32b:6083:ca39 with SMTP id
 v1-20020a056638250100b0032b6083ca39mr481130jat.281.1652898407899; Wed, 18 May
 2022 11:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org> <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org> <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org> <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org> <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org>
In-Reply-To: <20220517212223.GL8056@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 18 May 2022 14:26:36 -0400
Message-ID: <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 5:22 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 17, 2022 at 04:39:18PM -0400, Josef Bacik wrote:
> > What I *think* happened is you essentially lost random blocks from 1
> > transaction.  This isn't particularly harmful, except you had a chunk
> > allocation that happened, so you lost some of the chunk root.  I
> > didn't realize this is what was happening until now.  If I had I
> > probably could have pieced together these dev extents into chunks, and
> > then all those blocks that we had that didn't map to a chunk probably
> > would have been fine, because they were in the range that we lost.
> >
> > It's not that you lost a lot of blocks, you just lost a few really,
> > really important blocks, and then I failed to recognize what happened
> > so I threw out more than I should have, plus all the other little
> > wonkiness from experimental recovery tools.  Thanks,
>
> Right, which is totally understandable. I'm still glad I have backups
> (waiting to restore), but I very much appreciate your work right now as
> it's fixing the bigger problem of recovering an unmountable filesystem.
>
> Ultimately I don't care as much about how much data is lost, but I very
> much care about btrfs check repair getting the filesystem back to a
> mountable state, so I've been more than happy helping you get to that
> state and I'm very thankful for all the time you spent on this so far.
> Hopefully we're almost there :)
>
> For extra points, files that have corrupted checksums, I'd love for them
> to be renamed to file.corrupted, so that someone who cares about partial
> data, can get some data back, and that you can recover much faster with
> rsync if it only has to look for missing files, as opposed to running a
> checksum on all the data on both sides, which would take ages.
> I know in this case, I may end up with some amount of files silently
> corrupted since we rebuilt the checksum table, not sure if there is a
> way to do this like I described or some similar way, in the future.
>
> I see you pushed another change, trying it now.
>
> I have the full output saved if need be.
>
> Device extent[1, 14812306210816, 1073741824] didn't find the relative chunk.
> Device extent[1, 9544528822272, 1073741824] didn't find the relative chunk.
> Device extent[1, 11231377227776, 1073741824] didn't find the relative chunk.
> Device extent[1, 11406397145088, 1073741824] didn't find the relative chunk.
> Device extent[1, 11416060821504, 1073741824] didn't find the relative chunk.
> Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
> Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
> incorrect local backref count on 2952871936 parent 13576823652352 owner 0 offset 0 found 0 wanted 1 back 0x55db601ea230
> backref disk bytenr does not match extent record, bytenr=2952871936, ref bytenr=0
> data backref 2952871936 root 11223 owner 258 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 2952871936 root 11223 owner 258 offset 0 found 1 wanted 0 back 0x55db80f5c6a0
> backpointer mismatch on [2952871936 262144]
> repair deleting extent record: key [2952871936,168,262144]
> adding new data backref on 2952871936 root 1 owner 258 offset 0 found 1
> adding new data backref on 2952871936 root 11223 owner 258 offset 0 found 1
> Repaired extent references for 2952871936
> incorrect local backref count on 4156227584 parent 13576823652352 owner 0 offset 0 found 0 wanted 1 back 0x55db607ad1f0
> backref disk bytenr does not match extent record, bytenr=4156227584, ref bytenr=0
> data backref 4156227584 root 11223 owner 259 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 4156227584 root 11223 owner 259 offset 0 found 1 wanted 0 back 0x55db80f5c570
> backpointer mismatch on [4156227584 262144]
> repair deleting extent record: key [4156227584,168,262144]
> adding new data backref on 4156227584 root 1 owner 259 offset 0 found 1
> adding new data backref on 4156227584 root 11223 owner 259 offset 0 found 1
> Repaired extent references for 4156227584
> (...)
> adding new data backref on 10449820549120 root 1 owner 256 offset 0 found 1
> adding new data backref on 10449820549120 root 11223 owner 256 offset 0 found 1
> Repaired extent references for 10449820549120
> super bytes used 14180042240000 mismatches actual used 14180042256384
> Invalid key type(ROOT_ITEM) found in root(11223)
> ignoring invalid key
> Invalid key type(ROOT_ITEM) found in root(11223)
> ignoring invalid key
> Invalid key type(ROOT_ITEM) found in root(11223)
> ignoring invalid key
> Invalid key type(ROOT_ITEM) found in root(11223)
> ignoring invalid key
> Invalid key type(ROOT_ITEM) found in root(11223)
> ignoring invalid key
> Block group[4523166793728, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[4524240535552, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[4525314277376, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[4526388019200, 1073741824] (flags = 1) didn't find the relative chunk.
> Block group[4527461761024, 1073741824] (flags = 1) didn't find the relative chunk.

Hrm crud, I've fixed this, but you may have to re-run the init's.  Start with

btrfs check --repair <device>

and then see if it works.  If not do

btrfs rescue init-extent-tree <device>
btrfs rescue init-csum-tree <device>
btrfs check <device>

and then you should be good to go.  Thanks,

Josef
