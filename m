Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAD50D657
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 02:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiDYAj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 20:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiDYAj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 20:39:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB9387
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 17:36:54 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e194so14242950iof.11
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuUWEngUUAUmD8omHh8Ypmwid+x9cuhRcIA46S1ipKs=;
        b=eVwluDCAwFe8HsLPMAFkSVz4FMBHz91ZCTBytymlALB652sOKPxOzgu/W2AVPbwllE
         sk/Q5YH1jWxkAvQtvE4E+Z13KPXeCV7eNZHVPRAN1bs9kYykNlNSgXSpacUWpXAIOAv3
         MGH61XT2CidJYgN0lTExPgVRufID5tQdpIVw7K5pfbi59Q4eFTZQmRxUwBIOkX4O4j9d
         6f/WmzkmR0k7q5UEPOEK7eBsoJ6HLqwCeKTTK55r3QpBsimMgR256n9/T+3TUcj/Vhn+
         xH1W+BYMwknjUCPYTOORKLr49htHcCE4xhZ0lnG5UJCfnNQ87xrWJQL+XOzKsCOTsUZ5
         fLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuUWEngUUAUmD8omHh8Ypmwid+x9cuhRcIA46S1ipKs=;
        b=GCIXOHlehYefFvDQQOiPICReJINO/CtpAS0ryJeXPSehprJ0n3TBegJXOxakwzR24i
         1HgnXxi0iHCItSfGC0+n0OC4h4TvdXsJcUZV57NN0ilszD3ExPQKmeQIH3bhFIgbrZ/W
         2vtOB2Vggf2YSF9xpV8s2YaElhwvRYcFnEMTWTfK9bzzM4387fgGVQri1YJhXXe43Aay
         0RXCBU8aYqJs9EGLhpnz47bQx3Xbj2rja52r+X2s/mNq60W/QA8bVjfLa2b79MFf6Dds
         D9M/QmAjBlXGy+FGEz3Elhea9eK/W01vKC2Oftpxm5nERs+R4dDkCCrzdScry/p/Pk34
         FStQ==
X-Gm-Message-State: AOAM533qP6R7bs5LsXuc+hWbnWsqb7ipY6zENWM2hyIkPnBeNI4ptDhV
        yP77YKatkYsFaukpiesTeFEJAi30J2M/uApnBF9B7RlUxfw=
X-Google-Smtp-Source: ABdhPJwyrc/elVlFwDEmKlKWLHXL/AGWPp/3a0LSWMU7bKc0qKM6TMrcHvV96ZAvOjrqKhjtXCmk8FcFUmM5r0xL3RI=
X-Received: by 2002:a05:6602:14ce:b0:657:2bbc:ade8 with SMTP id
 b14-20020a05660214ce00b006572bbcade8mr6172140iow.83.1650847013048; Sun, 24
 Apr 2022 17:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220424205454.GB29107@merlins.org> <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org> <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org> <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org> <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org> <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org>
In-Reply-To: <20220425002415.GG29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 20:36:42 -0400
Message-ID: <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
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

On Sun, Apr 24, 2022 at 8:24 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 07:27:02PM -0400, Josef Bacik wrote:
> > On Sun, Apr 24, 2022 at 7:14 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Apr 24, 2022 at 06:56:01PM -0400, Josef Bacik wrote:
> > > > I feel like this thing is purposefully changing itself between each
> > > > run so I can't get a grasp on wtf is going on.  I pushed some stuff,
> > > > lets see how that goes.  Thanks,
> > >
> > > After all the tests we did, is it possible that some damaged the FS
> > > further?
> > >
> >
> > That's the thing, we're literally deleting the entire tree and
> > starting over, it should do the same thing every time.  I pushed
> > another fix, I think I've been messing up the buffers and that's why
> > we're getting random values. Lets try this again,
>
> Gotcha.
>
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x55555564cbc0
> JOSEF: root 9
> checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
> Couldn't find the last root for 8
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> (...)
> checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
> FS_INFO AFTER IS 0x55555564cbc0
> Walking all our trees and pinning down the currently accessible blocks
> Clearing the extent root and re-init'ing the block groups
> inserting block group 12582912
> inserting block group 20971520
> inserting block group 29360128
> inserting block group 1103101952
> (...)
> inserting block group 345237356544
> inserting block group 346311098368
> inserting block group 347384840192
> inserting block group 348458582016
> inserting block group 349532323840
> inserting block group 350606065664
> inserting block group 351679807488
> inserting block group 352753549312
> inserting block group 353827291136
> Ignoring transid failure
> Ignoring transid failure
> ERROR: Error adding block group -17
> ERROR: commit_root already set when starting transaction
> WARNING: reserved space leaked, flag=0x4 bytes_reserved=81920
> extent buffer leak: start 67469312 len 16384
> extent buffer leak: start 29540352 len 16384
> WARNING: dirty eb leak (aborted trans): start 29540352 len 16384
> extent buffer leak: start 29589504 len 16384
> WARNING: dirty eb leak (aborted trans): start 29589504 len 16384
> extent buffer leak: start 29655040 len 16384
> WARNING: dirty eb leak (aborted trans): start 29655040 len 16384
> Init extent tree failed
> [Inferior 1 (process 6259) exited with code 0357]
> (gdb)
>
>
> I ran it a second time and got the same output

Well thats something at least, I've rigged it up to dump the leaf so I
can see wtf is going on here.  Thanks,

Josef
