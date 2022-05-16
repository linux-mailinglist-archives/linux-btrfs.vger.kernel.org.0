Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417A52878E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiEPOu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiEPOuz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:50:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074E2B1B4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:50:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s6so5830716ilp.9
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoayhWjvcGmseROSrOrTSjhXD+oO53bjZThoI11mYCE=;
        b=o1DQXXl1KYV1xaRyBt71MTMVEW88cIQPMK7+poEgsqSg+s8iwbSaBULz9mnN7zGpM6
         FE2WF5M1WjqpmgBi4BtyQhaFzANZU77uBPtZmxXbQjXSD+ZvaS5mWQcFH1IrM91XcUTm
         oXoVhW8ORuh8i/fHkiKfPNkv5IXkAVUNf4JOGK7dlzEVO7keMmYTbrIAnYtMBQZFy5W3
         rZkhMmFgGxeDBHqE/EteYNtjjjkSJ3shHgeKXmAltHU0kfvctDPVSWHp+BW4+yyX4+hY
         HlCs6706hu1b+WbvoytJQLrI/3Z4vZmc/iWFbNSWxEy9Pw0YsD83gV0g8qV6cya3PBtI
         AsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoayhWjvcGmseROSrOrTSjhXD+oO53bjZThoI11mYCE=;
        b=EbAOdmQHLZMHeotwc1/aiomSUX01xWBwxwhzKkc510O+SLwG33t6J2sLT7nLEbwFx8
         nf6Ohfi2IwkRd6pUoMAPC+zo8UYNF5FczqGzSeRQY7/2TiHACbCFRHd+6o3xF/z6AA4q
         2bC1ZE64k3Z90TiPTlWWK65qk+OPqODgxnipgJRar/4MpjkNEFq//kcbBTO6gelIwrUd
         f8XPpsNXOVLLxqyk4gRIakj96WgJ7KOTaasf06eiRdgJIplwbmfibF4YMd1b+hnFl7A5
         VYpcJ9nu7GW38SgFSEA4BXYXLdPqdJACfW07qF3JiLVlOBxqQV0o/T+wmfdBUDg2+x98
         unow==
X-Gm-Message-State: AOAM533TMS3GIEgTlhcWNqh93ugUOZ+IRevjJ/LnYgujCTTufhB3+1j6
        EUaTcr9ymaKPvOQ0eHlUnyeV+uOL+alVExr6EFfplDCMy3U=
X-Google-Smtp-Source: ABdhPJxWgrMqXY+X+bOftup1x0c7MZdtXL6CYKKY0V/1iQlyhnpGH2Xk0An/dBMe0MwnBGdav5o4UQTePSy8yk59DQI=
X-Received: by 2002:a05:6e02:d06:b0:2d1:2be8:df10 with SMTP id
 g6-20020a056e020d0600b002d12be8df10mr1189843ilj.127.1652712653890; Mon, 16
 May 2022 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org> <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org> <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org> <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org> <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com> <20220516005759.GE13006@merlins.org>
In-Reply-To: <20220516005759.GE13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 16 May 2022 10:50:42 -0400
Message-ID: <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
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

On Sun, May 15, 2022 at 8:58 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 15, 2022 at 08:01:02PM -0400, Josef Bacik wrote:
> > Huh, did this pop during the btrfs check?  We can just delete that guy
>
> Yes, just at the end, when it looked finished
>
> > btrfs-corrupt-block -d "1,204,941709328384" -r 3 <device>
> >
> > and then you should be good, unless there are other dangling dev
> > extents that need to be removed.  Thanks,
>
> Is that bad?

Yeah, means I don't understand my own filesystem, use -r 4 instead
please.  Thanks,

Josef
