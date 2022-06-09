Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC75455E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiFIUqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiFIUqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 16:46:42 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1D36B50
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 13:46:40 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u2so18670406iln.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jun 2022 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh5Tw1A1aYvc+pUEMGtrhziyYOY1xbFfjSx2AUlXFBQ=;
        b=6UGV+L7TzJZmT3WLrd2wa0KbBUEuJJjcEzANN3cH4YU0H1P5yoEDRSw1iFQbqIrRG9
         IiMWimrAB6/oNViK5adZ4qDKw1npZCSu2qoOzWRLczk2UNoqu8h7xErVLzfb11MTeMY8
         2tGpDRj1Cv0EvUKLz0HPJxgS9PuLTcch5COcsqH1tP2n/69RVYGtz35yN9ioBB6GKN2/
         L6Hk9f490KYT1HQP59hJ82Zk9DagLHOFxWPpjP75z5mKo7IhKsyGBGKtBvvzU0EEVKEj
         p9hc9nVcTT9/vSHtWxPFye0UlXQJLkkwbEX/pvuMigFs8ifF/8jQRwPmtfZQU+zlOXSn
         KnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh5Tw1A1aYvc+pUEMGtrhziyYOY1xbFfjSx2AUlXFBQ=;
        b=G0umtJ7gG2dEbTk1UnJxbUNy5aNcW8Q+uMa8MoVcjbG+77axlBBwvMYHGPt950mnZ0
         xIVGOy0tdGa/zyvtvnA75cYriqNXrp0eqv2VYZgn6HsJGIECXSsXBaWDkx7s5ekUsowu
         UBX8YUwLvisfunLEMwLdWSqGiRiBN75NqlEEbBwPpVnKj4qD2zU6BnPeblWbu4d2P5bP
         w7+n2DJK4XM3r4c3GntTtRzT8kMPbpRu3WnAnVeiU6F9Xy7+OpnJdfHhv3mgquDLq7iq
         59ThEjlpfFL30HqhGikYE8LuznDkul++A9GqIG7VC7+lfAYQnTuUDdo75D6kbB6IYWoi
         8vhw==
X-Gm-Message-State: AOAM5308zQRe904i59A8rOXocb2SmfW1zzAwB5IdPaH9TaszwWkRDYzE
        uysB9fFt0/O2/jsGRrc8cXTQUrBkBO6SWBTbhBTxsGaxnXU=
X-Google-Smtp-Source: ABdhPJwCj5ZWIRGD4J0EsJqVIjfT2x4c3z8E/qZl8AkuEHpvSwNxEQmlkqo2mIj1S0KlB/MnGST3RHarUgXZxt6up1s=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr23886769ilg.152.1654807599641; Thu, 09
 Jun 2022 13:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220608000700.GB22722@merlins.org> <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org> <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org> <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
In-Reply-To: <20220609030128.GJ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 9 Jun 2022 16:46:28 -0400
Message-ID: <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 11:01 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 08, 2022 at 06:46:53PM -0400, Josef Bacik wrote:
> > Ok I've added some stuff to fix the device extents.  Go ahead and run
> > with --repair and lets see how that goes.  After that finishes run
> > again without --repair so we can see what's still broken, I imagine
> > I'll have to clean some other stuff up.  Thanks,
>
> Can't determine the filetype for inode 69105, assume it is a normal file
> Can't get file type for inode 69105, using FILE as fallback
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 69105
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 69135
> reset isize for dir 69136 root 164823
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 69136
> Trying to rebuild inode:69252
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 69252
> Trying to rebuild inode:74108
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 74108
> Trying to rebuild inode:74132
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 74132
> Trying to rebuild inode:74193
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 74193
> Trying to rebuild inode:74838
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 74838
> Trying to rebuild inode:76221
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 76221
> Trying to rebuild inode:76328
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 76328
> Trying to rebuild inode:76329
> Moving file f to 'lost+found' dir since it has no valid backref
> Fixed the nlink of inode 76329
> found 43825717248 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 10846208
> total fs tree bytes: 6848512
> total extent tree bytes: 1146880
> btree space waste bytes: 3705949
> file data blocks allocated: 67228672000
>  referenced 67225485312
> gargamel:/var/local/src/btrfs-progs-josefbacik# mount -o ro,recovery /dev/mapper/dshelf1 /mnt/mnt
> mount: /mnt/mnt: wrong fs type, bad option, bad superblock on /dev/mapper/dshelf1, missing codepage or helper program, or other error.
> gargamel:/var/local/src/btrfs-progs-josefbacik# dmtail
> [3890613.672704] BTRFS info (device dm-1): flagging fs with big metadata feature
> [3890613.694891] BTRFS warning (device dm-1): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
> [3890613.759915] BTRFS info (device dm-1): trying to use backup root at mount time
> [3890613.782884] BTRFS info (device dm-1): disk space caching is enabled
> [3890613.802960] BTRFS info (device dm-1): has skinny extents
> [3890613.826455] BTRFS error (device dm-1): super_num_devices 1 mismatch with num_devices 0 found here
> [3890613.855092] BTRFS error (device dm-1): failed to read chunk tree: -22
> [3890613.876716] BTRFS error (device dm-1): open_ctree failed

Sorry this took me longer than normal to work out what happened and
how to fix it properly.

You can pull and re-run btrfs check --repair <device> and it should
fix the device thing that's missing.  We can tackle the other fs
errors next, but I want to see if we can at least get you mounting the
fs.  Thanks,

Josef
