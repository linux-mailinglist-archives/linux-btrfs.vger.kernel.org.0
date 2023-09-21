Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200987A9793
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjIURZr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIURZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FDC423A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKNfKAr0ozqZGJU0pTiqUwEte0aBUe4YFp+VlpUsJO0=;
        b=hoE+4S7cJwNqtRK/6mPjZEp8H2n2jzptgbK8Y0naKc/JwNIrJYB6mCSR1EtUX3i9sOiCso
        GDkcSVUJtOEkqvN1tXWh8t8l1jP6NMgOUfjZgdenIQta+O1/U6onfTtZqkaPaDxxPmSVS2
        VkFFMQ6vxcFKNH0qTRMqn7Yx2pMmw74=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ckR3MukdMzS4N-gwhKrBTg-1; Thu, 21 Sep 2023 13:09:43 -0400
X-MC-Unique: ckR3MukdMzS4N-gwhKrBTg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-577f80e2385so988028a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316183; x=1695920983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKNfKAr0ozqZGJU0pTiqUwEte0aBUe4YFp+VlpUsJO0=;
        b=N0ZWFUjBC7XaPD8dixEt4EruVYWfqeFUDVpJ6DtvgS+AfhgjMWVivdznEnV1yl4QbC
         rla8K4oTNKXuvGLexX8lj1+6u2XaSuXPNlWE0iuguTJO8T37huX9nA8n7EQysHKpGHPm
         ZASrxKk1NxhUuba2uIDsD2fhdCh0mwqD4KVzUE/5DPTg+hHGlpaiKDzd5eBXfLvZY7Ss
         TOTRQ1E2VBL0ZZk9sT49hSBHhWFTK/ML8Uv0xo89bGYASgvu7zZfY15pjc39riloRFND
         IYcXAx+RR6kEoxNbhksrGf99Th5URK+Pw5iS2u5+w5Rcr+Ls+p1y9XFxpXCuuxim26nU
         nxDA==
X-Gm-Message-State: AOJu0YzE3z7bNufLhpXQ0EHnxezIMkMKqRNSszarnB7CLyb5746PBROk
        zlsu7LUmw1J6hWpWKozWcDJ06ERXooSbxwLbmPhumIGpvb6n5btsa97e0xqQRh21Ne8Mq02zmLv
        QtNvaUxhsw3BhdFnxpnevsM0=
X-Received: by 2002:a05:6a20:7288:b0:135:7975:f55 with SMTP id o8-20020a056a20728800b0013579750f55mr6850187pzk.47.1695316182849;
        Thu, 21 Sep 2023 10:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXjXLWs9og+M2o/PuwMBg3kbrihV1cC6ZfxlgM5RSSjiSZfNB5O+lCT7qMFEg9lAwA29B+3A==
X-Received: by 2002:a05:6a20:7288:b0:135:7975:f55 with SMTP id o8-20020a056a20728800b0013579750f55mr6850165pzk.47.1695316182484;
        Thu, 21 Sep 2023 10:09:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mu4-20020a17090b388400b0025bfda134ccsm1686141pjb.16.2023.09.21.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 10:09:42 -0700 (PDT)
Date:   Fri, 22 Sep 2023 01:09:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs/076: support smaller extent size limit
Message-ID: <20230921170938.jerqehx5427tgj45@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1694762532.git.naohiro.aota@wdc.com>
 <f03093d83baa5bcd4229a0dc9a473add534ee016.1694762532.git.naohiro.aota@wdc.com>
 <CAL3q7H5m-kGMT7=wAmfDm-ZJ3bpdmN0=GhRkinMciRq8GfF-QQ@mail.gmail.com>
 <lrlnkxdh47dd55y3uwdimbczoystuoikolaymnapsuheylvbs3@vztqzs75tlfx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lrlnkxdh47dd55y3uwdimbczoystuoikolaymnapsuheylvbs3@vztqzs75tlfx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 07:41:19AM +0000, Naohiro Aota wrote:
> On Fri, Sep 15, 2023 at 10:16:32AM +0100, Filipe Manana wrote:
> > On Fri, Sep 15, 2023 at 8:28 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> > >
> > > Running btrfs/076 on a zoned null_blk device will fail with the following error.
> > >
> > >   - output mismatch (see /host/results/btrfs/076.out.bad)
> > >       --- tests/btrfs/076.out     2021-02-05 01:44:20.000000000 +0000
> > >       +++ /host/results/btrfs/076.out.bad 2023-09-15 01:49:36.000000000 +0000
> > >       @@ -1,3 +1,3 @@
> > >        QA output created by 076
> > >       -80
> > >       -80
> > >       +83
> > >       +83
> > >       ...
> > >
> > > This is because the default value of zone_append_max_bytes is 127.5 KB
> > > which is smaller than BTRFS_MAX_UNCOMPRESSED (128K). So, the extent size is
> > > limited to 126976 (= ROUND_DOWN(127.5K, 4096)), which makes the number of
> > > extents larger, and fails the test.
> > >
> > > Instead of hard-coding the number of extents, we can calculate it using the
> > > max extent size of an extent. It is limited by either
> > > BTRFS_MAX_UNCOMPRESSED or zone_append_max_bytes.
> > >
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > Looks good,
> > 
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > 
> > Just two minor comments below.
> > 
> > > ---
> > >  tests/btrfs/076     | 23 +++++++++++++++++++++--
> > >  tests/btrfs/076.out |  3 +--
> > >  2 files changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tests/btrfs/076 b/tests/btrfs/076
> > > index 89e9672d09e2..a5cc3eb96b2f 100755
> > > --- a/tests/btrfs/076
> > > +++ b/tests/btrfs/076
> > > @@ -28,13 +28,28 @@ _supported_fs btrfs
> > >  _require_test
> > >  _require_scratch
> > >
> > > +# An extent size can be up to BTRFS_MAX_UNCOMPRESSED
> > > +max_extent_size=$(( 128 << 10 ))
> > 
> > For consistency with every other test and common files, using 128 *
> > 1024 would be perhaps better. I certainly find it easier to read, but
> > that's a personal preference only.
> > 
> > > +if _scratch_btrfs_is_zoned; then
> > > +       zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> > > +       if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
> > > +               # Round down to PAGE_SIZE
> > > +               max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
> > > +       fi
> > > +fi
> > > +file_size=$(( 10 << 20 ))
> > 
> > And this one it's even less immediate to understand, having 1 * 1024 *
> > 1024 would make it much more easier to read.
> 
> Agreed. I'll use 1024 and repost. Thanks.

I've changed that part when I merged this patch (haven't pushed), so you
don't need to send this patch again, save that time :)

Thanks,
Zorro

