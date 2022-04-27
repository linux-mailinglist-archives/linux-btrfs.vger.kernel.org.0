Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65AD512486
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiD0VbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiD0VbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 17:31:10 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1D2DD7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:27:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 125so4614736iov.10
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0r3tijmwTTUOyrHg6oK5a+4JqZXbfBsjrXX/WZhnp0=;
        b=1OQX5lOz54yZ6B/ta5dZKTnDUofwQLtzufesEtZ7Jetfwe2IysqXHfSoEQT2nlWJc4
         H1JP+sNMbq/rWUZdyigHoOkRIzOzPzea4PcvMyxB31waLrtmYOCEiFTMgYT81Bi/C53z
         SiqLdlX7nwuFzRSZowCIqn+VYwANuNLO/8otndmWvyfrRajwF4edF7U5lBfqyTheTqwW
         Fem8T5bnxS5IXnTkjNZ1y2VleRhVKB/TGzX6OY8ihS96Al5JXVagdY7P20tbjw9IO4E4
         V+60OrefUjKStEofKBLVbmuHHNkxACIER+GOQgw1dK1RQn1cV3g7zzam70UTmRSEPuia
         pU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0r3tijmwTTUOyrHg6oK5a+4JqZXbfBsjrXX/WZhnp0=;
        b=TM/rAGMFYcNjPWdBrM0vXh6vL9sMdVOH/AkNR/kwzNDwyHfUwUuuvxhKcmH+AyRYxV
         xscPKW5CvaQC2KR9XD8rBr5FftiRCHQ35d9s5xbcctHaZ30gi2lY3Qwo0en2/lMEAYs9
         I3j2YoGnBziF6xo1lYhgq1YxZA/ewfYq5/jIIaNKb3EAZ1nqMq4qFv9IGT9W6y7k9qWD
         hKxCOSATYypxHx5UetIYovvuq0/poEPoAm2U9bmTYIZYaHDo9YWdlMpjRprcV4uPcep8
         QiByw9nAdx4yTfHT9UY753K28TWnUWEqMm+nYDEvZ8+wmGTktbAk4wkclu6NgNGQK0fl
         QZqA==
X-Gm-Message-State: AOAM532kKr/eypAaLVxGY+mpLFU7n2Mw/0x55NEJsSoNZY9JIZ8gWtsP
        W1x+hvNmX/2LYNuiKMw/D9LuCR9vGc9hbN2N2JJ1ROpka0Q=
X-Google-Smtp-Source: ABdhPJwQeEpfuJ9UuH2Y0QWBey8eMlvxZnVTZd2k1fF2az8jp6+CI25qlDBZAwsUduRqz0xCiwCDJINOo++e1a+hLLI=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr6239172jap.218.1651094875152; Wed, 27
 Apr 2022 14:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org> <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org> <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org> <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org>
In-Reply-To: <20220427212023.GW12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 17:27:44 -0400
Message-ID: <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 5:20 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 05:11:30PM -0400, Josef Bacik wrote:
> > > inserting block group 15838291689472
> > > inserting block group 15839365431296
> > > inserting block group 15840439173120
> > > inserting block group 15842586656768
> > > processed 1556480 of 0 possible bytes
> > > processed 1130496 of 0 possible bytesadding a bytenr that overlaps our thing, dumping paths for [5064, 108, 0]
> > > doing an insert that overlaps our bytenr 7750833627136 262144
> > > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> > > Failed to find [7750833868800, 168, 262144]
> > >
> >
> > Of course it doesn't work for you, I pushed some debug stuff.  Thanks,
>
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x55555564cbc0
> JOSEF: root 9
> Couldn't find the last root for 8
> checksum verify failed on 58720256 wanted 0x0d38525a found 0xb3a707fa
> FS_INFO AFTER IS 0x55555564cbc0
> Walking all our trees and pinning down the currently accessible blocks
> (...)
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1130496 of 0 possible bytesadding a bytenr that overlaps our thing, dumping paths for [5064, 108, 0]
> elem_cnt 0 elem_missed 0 ret -2
> doing an insert that overlaps our bytenr 7750833627136 262144
> processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> elem_cnt 0 elem_missed 0 ret -2
> Failed to find [7750833868800, 168, 262144]

Sigh, added another print_leaf.  Thanks,

Josef
