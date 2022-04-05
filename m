Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962634F478F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiDEVN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457519AbiDEQDU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 12:03:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7C12606
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 08:58:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so27503023ejc.6
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cr/uUizgr/4LNpusvZFcNmm9oWq5EZAD+WYWV0PPzE=;
        b=b7tog62pv2fPQ1TZ9Jj5qy6e3KfwSPJR3+W/BOcdKx/d3vb140ht/lRhz4S8v2WkCy
         o2GYojOl9q6tty2rR1vAj4wJaMYkLbzu9C3jFOULVo3NXjsPKXS31hQ2unsjguxrupMt
         ps28ABr+7ajK98jOzYsA36byYngqlC4boPYFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cr/uUizgr/4LNpusvZFcNmm9oWq5EZAD+WYWV0PPzE=;
        b=W/qTDdtUP74E2SjRoYPGmMy6Kxzm2aMqzAt/mLEd5Mz3hLoNSVlglyyIRPn0R2V0mL
         N73OqovQnmJ/+JibhgTRZcdsn3rW/r99t60ZuRQaum/EgIFdVFXBFi8Z1miWCDH7sd2t
         0Gg56QAdevxw0ODVct4ogl3gyj/wyo5eWVxZhEX63SSX4LHsBtcbRsqpDDw6OVdSdkbL
         i8pL7hvV/EH6pz5tZXsEpu2xyQE19jDUYTDvSZtwCHo6YOQo41vLAVE2NTLRP9/Gv7Ts
         4X15/7S9j9H0Dx7CvDJ7O/uH1X5r2uqc4P4As/mjfD0xI39vTSW9su/WA39KLuipHRV4
         Jhbg==
X-Gm-Message-State: AOAM530BTSAKsLWiDfnu3yuLxKNetG8mNxQTbBvBZ70AQ3arT3PQh5gq
        EA8HjgeJtmHiIeJa7FhiChjNY3BOc3zhTaGsda0ftA==
X-Google-Smtp-Source: ABdhPJzilsgNVvKQDJzpKqS53Wp6YBs1ihzZ9U8NbTzdYYs6GM+QQv3uAUJcWClXu8eKUS9vMxO9yfcEcTtMuykHP5w=
X-Received: by 2002:a17:907:3e16:b0:6df:b4f0:5cc2 with SMTP id
 hp22-20020a1709073e1600b006dfb4f05cc2mr4278368ejc.285.1649174326720; Tue, 05
 Apr 2022 08:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649109877.git.dsterba@suse.com>
In-Reply-To: <cover.1649109877.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Apr 2022 08:58:35 -0700
Message-ID: <CAADWXX-XPrfiD0TLGwMuzmGfs9pZ+HiTo1v9cs-mxb6x0OXpZw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc2
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 6:28 AM David Sterba <dsterba@suse.com> wrote:
>
> please pull the following fixes for btrfs, thanks.

Hmm. I got two copies of this...

...and both were in my spam folder.

I don't see anything wrong with the message (spf and dkim both
fine).so I assume it's something about suse.sz or suse.de that gmail
doesn't like. Presumably some spammer sitting on a nearby network on
the same ISP.

Anyway, not much you can do about it except perhaps ask whatever MIS
people to see if they got put on some blacklist or whatever.

I've obviously noticed the pull request despite it being in my spam folder.

              Linus

>
> - prevent deleting subvolume with active swapfile
>
> - fix qgroup reserve limit calculation overflow
>
> - remove device count in superblock and its item in one transaction so
>   they cant't get out of sync
>
> - skip defragmenting an isolated sector, this could cause some extra IO
>
> - unify handling of mtime/permissions in hole punch with fallocate
>
> - zoned mode fixes:
>   - remove assert checking for only single mode, we have the DUP mode
>     implemented
>
>   - fix potential lockdep warning while traversing devices when checking
>     for zone activation
>
> ----------------------------------------------------------------
> The following changes since commit d3e29967079c522ce1c5cab0e9fab2c280b977eb:
>
>   btrfs: zoned: put block group after final usage (2022-03-14 13:13:54 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc1-tag
>
> for you to fetch changes up to 60021bd754c6ca0addc6817994f20290a321d8d6:
>
>   btrfs: prevent subvol with swapfile from being deleted (2022-03-24 17:50:57 +0100)
>
> ----------------------------------------------------------------
> Darrick J. Wong (1):
>       btrfs: fix fallocate to use file_modified to update permissions consistently
>
> Ethan Lien (1):
>       btrfs: fix qgroup reserve overflow the qgroup limit
>
> Johannes Thumshirn (2):
>       btrfs: zoned: traverse devices under chunk_mutex in btrfs_can_activate_zone
>       btrfs: zoned: remove left over ASSERT checking for single profile
>
> Josef Bacik (1):
>       btrfs: do not warn for free space inode in cow_file_range
>
> Kaiwen Hu (1):
>       btrfs: prevent subvol with swapfile from being deleted
>
> Qu Wenruo (2):
>       btrfs: remove device item and update super block in the same transaction
>       btrfs: avoid defragging extents whose next extents are not targets
>
>  fs/btrfs/extent_io.h |  2 +-
>  fs/btrfs/file.c      | 13 +++++++++--
>  fs/btrfs/inode.c     | 23 ++++++++++++++++++-
>  fs/btrfs/ioctl.c     | 20 +++++++++++-----
>  fs/btrfs/volumes.c   | 65 ++++++++++++++++++++++------------------------------
>  fs/btrfs/zoned.c     | 13 ++++-------
>  6 files changed, 81 insertions(+), 55 deletions(-)
