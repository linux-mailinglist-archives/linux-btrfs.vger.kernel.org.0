Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4F4F858D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiDGRJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiDGRJ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 13:09:28 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904831D0C9
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 10:07:27 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so2420748ilo.5
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Apr 2022 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWlsgrAo5FKc9SZXFFYFtnE4LqGiZYnZDr+jCNgwazQ=;
        b=fNzGphjnywLBxx/TwHyohHUNKsdLaGoNafTiOQwalkY2TbCThJz9XX/dEtpGQtoL3K
         LsP5ShQJjRWO1dp1VCBUsdq0kkWiESJ6dMJWDrutgcYX5ArfQ3fZDvCxDk8u/Jg4LIAg
         MB8LXQTZIlFPzt93akTxx6C+RJSI/l6k7NQKFq+HQ0Ozv/W+jQBVZJSFWVYrwsaRhYAF
         V09Tdag/SOWRBuY2rS/+aUFaJ9Lek1Zjt6EIkoERYXk3/wotn3JjUZHnHKTtMN8sngva
         zPFKb/RDKHmyelGrRbBnHrXWlB/sZdbQhE9iXT2THIls5Os8iLS7EgIW/LKorVLDWXsu
         fFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWlsgrAo5FKc9SZXFFYFtnE4LqGiZYnZDr+jCNgwazQ=;
        b=BX5t6clUR4cu+vwEb+0liqaJr4lzwBegBw1UmT2F75DuFTTyf5fD3gB7xGd0Q2K3lW
         FMQlklLZua87madUQBoCwKHzLUQm9P+a3a1n+CX9mdEyd00a6q87we7gKaOEAr8Ph/T9
         K9hFBYHTLAxZqvTmxL10YVWf+ZaMIBPT3jciGpJvAn8T00AiEUbvoMZw+acCaNx9t4je
         Ubl1EnqNbkCaebOwUBe0HQFLAU8lfy5ISQGTOv2NVNKixAxPWEKfdkT/yg6lH5PK4OQ9
         vXGtoZTg0mn83tBCoAPe8+2aO9NHqTua5la8TZFUA4MHF0e7RRqrvfnMfY2gNcqBAvua
         D7Bg==
X-Gm-Message-State: AOAM533m29qEfoTcg0eP2AfQsvByMHGJts7kz1iMDUsx4z4CltOvlQDX
        Y/uoLeEUHQ3dmeNVIBEnybx2RRrxFCXXoY1hIffK6QM3Leg=
X-Google-Smtp-Source: ABdhPJwwXDfssP0eYeAuaEqWyIYUlb72fgwbB/R+ycPLZ4effjEotGUNK3w/D2eWx5o+p9q+4HMLcfK81UJ3zOAlcW0=
X-Received: by 2002:a05:6e02:170a:b0:2c9:f038:7f2e with SMTP id
 u10-20020a056e02170a00b002c9f0387f2emr7003848ill.127.1649351246694; Thu, 07
 Apr 2022 10:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <11970220.O9o76ZdvQC@ananda> <20220407052022.GC25669@merlins.org> <20220407162951.GD25669@merlins.org>
In-Reply-To: <20220407162951.GD25669@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 7 Apr 2022 13:07:14 -0400
Message-ID: <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 7, 2022 at 12:29 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 07, 2022 at 09:30:41AM +0200, Martin Steigerwald wrote:
> > I did not keep statistics, but this might be one of the longest threads
> > on BTRFS mailing list.
> >
> > Good luck with restoring your filesystem or at least recovering all data
> > from it!
>
> Haha, thanks. All props go to Josef for not giving up :)
> Even if I don't get my data back without going to the backup, this will
> have been a useful exercise, however I managed to hose my FS, made for
> an interesting recovery case.
>
> On Wed, Apr 06, 2022 at 10:20:22PM -0700, Marc MERLIN wrote:
> > On Wed, Apr 06, 2022 at 09:37:17PM -0700, Marc MERLIN wrote:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outo
> >
> > there may have been something else that ate all my memory.
> > I killed shinobi and re-ran your code overnight while dumping
> > memory. I'll have a memory trace running this time while it re-runs
> > overnight.
>
> Ok, good news is that it was actually shinobi that somehow managed to
> take enough RAM to OOM hang the system, but in such a way that I had
> never seen before (sysrq not even able to work anymore, which is
> worrisome).
> btrfs-find-root just took another 8G which was enough to tip the glass
> over, but shinobi (and ultimately the kernel for being unable to kill
> userspace that takes too much RAM), was at fault.
>
> Overnight, it ran stable at 8GB:
>   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
> 31873 root      20   0 8024m 7.8g    0 R  99.9 25.2 667:57.24 btrfs-find-root
>
> But the bad news is that it didn't complete, and it's not looking like it's
> converging.
>

Ok let it keep going, I have an idea of how to make this less awful
but also not use all the memory.  I'm going to start writing this up
now, if I finish before your run finishes you can switch to the new
shit and see how that goes.  I've got meetings until 4pm my time (it's
1pm my time), so you're not going to hear from me for a while.
Thanks,

Josef
