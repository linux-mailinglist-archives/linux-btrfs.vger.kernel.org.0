Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB74F2039
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbiDDX0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbiDDX0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 19:26:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6717068
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 16:24:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y16so8027738ilc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fUV9dMv+AOwJW8XQK0YASakA6KfwQ9ggwu4Sr9DE48=;
        b=C0ZEkVuDm0H1+L4t0NnfntG94J73yUyCDMRtIzAqwa0V5EsieA+CdXXxvkQcTxtP3k
         GDa3hWxIe9dRrLW55qKgcZme0hkHxKD6UaaJLH0x8+i4bajxaQ0Oehi4RRtgUSHtEJ7F
         F1YiQS2eWiEDqlU4VnuNokxvlvjE8lqiA66vmBKTmX104+JSqqItVxbk/Sam87TwIUO3
         55oS4IvNHGZrxIyFeMCtdOsE9vmN3H9vE128bytzSCPRzMZ9C45C7qycSSvdWdptIN/5
         fjRqhUMPI5PbLKZqgh7Wyq9le/Dmxip7zOoqZ3zDWUf+GPmo4nnvKNBEgmSm8guemn6A
         3aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fUV9dMv+AOwJW8XQK0YASakA6KfwQ9ggwu4Sr9DE48=;
        b=bStarztlvZLJjOU5EhShPBhm4NtjXgpERp4CVLTvmXqAF1nh5Twmty424sptRMopGc
         Y3cti/+wjr+pCwUgcALRqxnryjtLb3dsnvN4TOiMXrT/aiMCdafCKCOmHMoCqGw4+Igp
         UbqBGr0oCzjWcuPWo/rP+92xZDJnVPb4rUwSZjM5SBkO9IkkYIVoIGJw6RjWHflvJC34
         sz36E/qetmJB+FOocl/6GENNmnUPunkkpn2GegrwUUIKh7Fayf0cTkO0BjtmCTnzfP2b
         G351isJm7ZEQ+B3/KMKqwCWydyGbr1khQHwKD8jucQri3CawGC9NUb69BgbCzF5AI0cE
         gSaw==
X-Gm-Message-State: AOAM531oWOVHnCStWhtdX4X178R+mt1+9ccbfgWTo7UMdeU7DWCv5Wcu
        zGb4E3mATzDtu5W9NGuR37F4kcordQgIZ9izQpA3SMO6Dxs=
X-Google-Smtp-Source: ABdhPJwN/diLbc60KS97q2Hi1p6zjt4ikwA1PIaVelvnfU6PqdY4QKQozn3LEOXSvbMXYQm5wdeqnKhoK1Mr9OjV/7k=
X-Received: by 2002:a92:c56c:0:b0:2c9:db11:98d2 with SMTP id
 b12-20020a92c56c000000b002c9db1198d2mr360713ilj.152.1649114661516; Mon, 04
 Apr 2022 16:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220404190403.GY1314726@merlins.org> <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org> <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org> <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org> <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
 <20220404224503.GA11442@merlins.org> <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org>
In-Reply-To: <20220404231838.GA1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 19:24:10 -0400
Message-ID: <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 7:18 PM Marc MERLIN <marc@merlins.org> wrote:
>
> [removed Cc to others]
>
> On Mon, Apr 04, 2022 at 06:52:58PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 6:45 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 06:34:39PM -0400, Josef Bacik wrote:
> > > > Alright, lets see how fucked this thing is
> > > >
> > > > ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal
> > > dump-tree -t ROOT /dev/mapper/dshelf1a
> > > btrfs-progs v5.16.2
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > Couldn't read chunk tree
> > > ERROR: unable to open /dev/mapper/dshelf1a
> >
> > idk what I expected there, you can pull my tree again, rebuild,
> > re-run, it should work this time.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> btrfs-progs v5.16.2
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> Couldn't find the last root for 4
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/dshelf1a
>

Re-pull and try again please.  Thanks,

Josef
