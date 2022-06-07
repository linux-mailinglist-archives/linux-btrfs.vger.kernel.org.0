Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDB542233
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348600AbiFHA22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444001AbiFGXBf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:01:35 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C24D25BFA0
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 13:10:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r3so15074681ilt.8
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgpXW//wo+/yEOENT9fSzS9LnIdqI+tPP5JnZRfZSIc=;
        b=S3DvG0xAy1O1YmvGBcqLMrW6ht2o7Hxn6SU1O87q1+XR9QsGOOTvLVXTxaIbj9KCue
         OTDaZsmQDxXkhC+oqKISsK/hEG5XodRDVGbB2KUlxo4Fcsy9V/g5r+jpwFTCf40PQD7c
         v2w3Ba109ICfsurKAy2xqnXbI2RinTnFpmD8Gw6JB2iaWEOeCc4v8d8LeFMSK2y9WwUN
         t/8a/kVgr9LM6B2vOxHn3fpTR/0Ptcepf4HtY6zUGwtwqnKUiM/spkjErdR29XmslGE9
         iI1cehnL4lAzF4/B0zh3Ifp+yjWx0U883fss/L8OErf0ZvY9AYjMK8NPdFaKGP63ms7I
         tsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgpXW//wo+/yEOENT9fSzS9LnIdqI+tPP5JnZRfZSIc=;
        b=MhvWyAuKFRiz0rPZHlPEMP1p5C8Wd/rnNd1ycAy/dmfqqbC24CKV+RGpP7wBfuTUgE
         uMtRs4NjE65/GF6iXMGVsmR2u+/8hWizvueMSmhv/DVwf9B33QBoP2IJ1H3/g/Fv+Cw9
         1UukTUi9DvC0E9DhLpoQhvBVccYXJ5MXI64rzzdv/tS/gbM1wemorvjQfQFDUtXmrclS
         CVBe0nPCKi9RtT6XkmW0HmX+u4ROwTVD8R/n2Sga+FKJYRibzU6iM8rZ2GmT2lD52TZP
         oboa0ceI/lPcJRn7vZaSlkcE0vYPmdNlOZbpSsEBUSt1RvLD1WBsHsQoJ0bomDLTiAOO
         GAFQ==
X-Gm-Message-State: AOAM532mvPXI5lgiTwN2FqN8Bhj2XvkVdlOJWM+c1+HFM85qTwNvNOFq
        KduBBknd6BB2piFmeRtjloFNnM4v8E9Ofn0ljQ1cxehbUgc=
X-Google-Smtp-Source: ABdhPJwVTQwY0ezUjVoGBoCeszN/IbrkV5TmgpM7cuXaG4uKQjVS8qlvTEJFZ3r7mdvJ9EVXEzkcxmlKGvmTN0P3UYk=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr18220566ilv.6.1654632613213; Tue, 07
 Jun 2022 13:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org> <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org> <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org> <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org>
In-Reply-To: <20220607195744.GV22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 16:10:02 -0400
Message-ID: <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 3:57 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 03:46:12PM -0400, Josef Bacik wrote:
> >
> > Perfect, this isn't in our list, so we definitely don't have it.  I've
> > added some debugging to recover-chunks, can you run btrfs rescue
> > recover-chunks and capture it's output?  We may not find this chunk
> > and in that case it needs to just delete stuff, but I'd like to try a
> > little harder before we give up.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> FS_INFO IS 0x560392adcbc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x560392adcbc0
> Walking all our trees and pinning down the currently accessible blocks
> No missing chunks, we're all done
> doing close???
> Recover chunks succeeded, you can run check now

Alright it looks like we've gotten everything we're going to get, go
ahead and let init-extent-tree do its thing.  Thanks,

Josef
