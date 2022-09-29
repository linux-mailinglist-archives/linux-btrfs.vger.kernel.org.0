Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240275EF72A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiI2OGT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiI2OGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 10:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB915EF91
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Sep 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664460371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3xUfxrUlnPa302WMqJuwHhl7GKgLDJ9rA/szu7Wwvvg=;
        b=OkHSV+zSqiKo8stU5oeb2kJB9sJH+4vTXVBPieRYuRpJm69PR+yAd/fPVgB+gDYA4FojZd
        fdWStt5U/DlvtqsxmuqN1akgITbtkc2sTpWCNYj6+EqGmkPdzKEHuQpZKNN74Ym/gXlbky
        hDqCtBI67JhpDrc0lgvMd6MABN/L9Lc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-dEJd1DocP-CTxdXsizNwVw-1; Thu, 29 Sep 2022 10:06:10 -0400
X-MC-Unique: dEJd1DocP-CTxdXsizNwVw-1
Received: by mail-pl1-f198.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so1098492plx.5
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Sep 2022 07:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3xUfxrUlnPa302WMqJuwHhl7GKgLDJ9rA/szu7Wwvvg=;
        b=kJjLuotGhOB8ubW1LF/39Mqsg68PJJprrd98HK1WTJMtbo2SuuTuS76cG++P3wPqCy
         l9P2+FFBQNeh0TmVMU1hmQrWrprKXk/yQOu+z2PCuScbU+cdxGyKxJb6UbcBn5pWtOD/
         aY6bcgU+GzENaCBLGS3/MHYMiopNpV1TmHRGOWalpzBXDR+hGGxBzM8UftMY0qYRa10P
         DmYePFP6VUGZlD3Z7pxwKISFTQ5cDvaWefCD5ae0qYRVJZvhsBaBAQsd3JkhRZxNgDSF
         ghh9B/bEHR8XOJllY9eUpkYeIqeXu5aOdEENFYXbpdCFSVxCSmQn3zXKQuWQjg+6rSAp
         bKjg==
X-Gm-Message-State: ACrzQf1Tv9OCVwY2731aEU+ErJTlxY6Yw8OpAPcjeGlhr/XZZCEjsdWC
        2x/xHp4DyrhntFr+zxZw8QZBS5BJTTWd2a145hn7tQOHHjJDtpRm9jS4EKvfN3t9B/S0UMA0VKm
        aUiUpJlBNctbrLf3bp8sctcI=
X-Received: by 2002:a63:2cce:0:b0:434:e004:a218 with SMTP id s197-20020a632cce000000b00434e004a218mr3045894pgs.241.1664460369322;
        Thu, 29 Sep 2022 07:06:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zSCuJVZsNsx9fUONef8AaexSagg4Xuh2iJ0C5ZSMOP0DRFDr8bs2WL2xDubQFnxrHnBrwKw==
X-Received: by 2002:a63:2cce:0:b0:434:e004:a218 with SMTP id s197-20020a632cce000000b00434e004a218mr3045873pgs.241.1664460368932;
        Thu, 29 Sep 2022 07:06:08 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b00170d34cf7f3sm5020738plg.257.2022.09.29.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 07:06:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:06:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Message-ID: <20220929140604.phlru3cjcqfsbsr2@zlang-mailbox>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
 <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
 <20220929120400.GG13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120400.GG13389@twin.jikos.cz>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 02:04:00PM +0200, David Sterba wrote:
> On Thu, Sep 29, 2022 at 02:01:06PM +0800, Zorro Lang wrote:
> > On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
> > > A ZNS device limits the number of active zones, which is the number of
> > > zones can be written at the same time. To deal with the limit, btrfs's
> > > zoned mode tracks which zone (corresponds to a block group on the SINGLE
> > > profile) is active, and finish a zone if necessary.
> > > 
> > > This test checks if the active zone tracking and the finishing of zones
> > > works properly. First, it fills <number of max active zones> zones
> > > mostly. And, run some data/metadata stress workload to force btrfs to use a
> > > new zone.
> > > 
> > > This test fails on an older kernel (e.g, 5.18.2) like below.
> > > 
> > > btrfs/292
> > > [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
> > >     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
> > >     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
> > >     @@ -1,2 +1,5 @@
> > >      QA output created by 292
> > >     -Silence is golden
> > >     +stress_data_bgs failed
> > >     +stress_data_bgs_2 failed
> > >     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
> > >     +(see /host/btrfs/292.full for details)
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)
> > > 
> > > The failure is fixed with a series "btrfs: zoned: fix active zone tracking
> > > issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
> > > helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> > > allocation didn't progress")).
> > 
> > If this's a regression test case for known fix, we'd better to use:
> > _fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (patchset)
> 
> This is very misleading as the commit only adds a helper that's used in
> later commits. If anything, the last commit in the series should be
> mentioned.

Sure, I just gave an example, you learned about that patchset more than me, so
feel free to pick up a proper commit and description :)

> 

