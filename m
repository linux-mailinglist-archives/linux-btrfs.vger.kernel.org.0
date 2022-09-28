Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D75ED452
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiI1Fr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiI1Fr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 01:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E08EEEB4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 22:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664344046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcB2qI4DuMPPORjctmP9Ux78GtR4/YOSaCOXY9+toX4=;
        b=B43Y8YfjSS1XdZnF73u2nitnZjhjyGDkdz+t0jqIz0OLqCPNa+4EmLx4ptLYeVvHsRs93P
        lUKnrOpHfy1z8rUPQr91SZDaLHcj9K1i3M/nPV3dETDOZBYWAA6PmGsUFo2ZCUuPc1mjij
        RKBecHWmw+9Eg2zUydZrYxCLJpc/zYE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-Ae8RchERN0CLX0kN7YLuwQ-1; Wed, 28 Sep 2022 01:47:21 -0400
X-MC-Unique: Ae8RchERN0CLX0kN7YLuwQ-1
Received: by mail-pg1-f198.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so6922813pge.13
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 22:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UcB2qI4DuMPPORjctmP9Ux78GtR4/YOSaCOXY9+toX4=;
        b=0xX/Q0LyoxB8FmqDQYddRj11LDPGLo4R1AqlzcmRP4a3VYwKyY1Qx9+U59iQPhJRSD
         XNdxC9QQP8E3yK6ui2midIRemcuOBpb/Q7WHWtF/s5TDgFIEE8mGHJV9kbJvnSfCKUWI
         1ySlQam/Qs3CrixVVBfOAJnkGN1QapQfnU1HqJId67Zm2IBAMDB0B5v4YbgNseslFCFP
         3Y60NcbEbEguiecgVxWh0zIY2AaOzKIL8Vyfg65CTt+t6MgIDWlXH2Ez5rYhEXzQCfXb
         ku0qImnvDdV86CyZPlqnxYKkcUMHEP/XuthavNc34anmeRjCyiAINkvVWYugPWQxr8Lf
         AZGw==
X-Gm-Message-State: ACrzQf1OdC168+DNkiCS1mFDk0hO7YC+GXe+eCiZI3WuAM7Ni+QOcYxg
        hzLAx8nyWzHbRmcjtGS4cJKMNcP43TTv1PCWRls/wpQCb2upjlY6D4bsG/9aBvEh4uZuxmTAVfa
        caryVuPzTZcRDG8HdhjDTREg=
X-Received: by 2002:a17:90b:3889:b0:200:8255:f0e5 with SMTP id mu9-20020a17090b388900b002008255f0e5mr8744431pjb.51.1664344040111;
        Tue, 27 Sep 2022 22:47:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Z3qZ4SqdS6G6THd0M37egNcEsx/EbTy2MlWbZFALHMCqylw9cj/wRIMVdY5U4D3hbRjSn4Q==
X-Received: by 2002:a17:90b:3889:b0:200:8255:f0e5 with SMTP id mu9-20020a17090b388900b002008255f0e5mr8744416pjb.51.1664344039801;
        Tue, 27 Sep 2022 22:47:19 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g20-20020aa796b4000000b0053e199aa99bsm2874819pfk.220.2022.09.27.22.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:47:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:47:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Message-ID: <20220928054715.ol6gammnf6jmrjab@zlang-mailbox>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
 <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
 <20220928035707.v7kv4ult46w3hjlj@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928035707.v7kv4ult46w3hjlj@naota-xeon>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 28, 2022 at 03:57:08AM +0000, Naohiro Aota wrote:
> On Fri, Sep 23, 2022 at 07:51:26PM +0800, Zorro Lang wrote:
> > On Fri, Sep 23, 2022 at 08:02:10AM +0000, Johannes Thumshirn wrote:
> > > On 22.09.22 17:42, Zorro Lang wrote:
> > > >> --- /dev/null
> > > >> +++ b/common/zbd
> > > > I don't like this abbreviation :-P If others don't open this file and read the
> > > > comment in it, they nearly no chance to guess what's this file for.
> > > > 
> > > 
> > > zbd is a well known abbreviation for zoned block devices. I think most
> > > people in storage and filesystems know it.
> > 
> > OK, but we haven't been that "a single character is worth a thousand
> > pieces of gold", so we can use a longer name, likes common/zone,
> > common/zoned, common/zoned_block, common/zoned_device or something likes
> > that. Anyway, that's just my personal opinion, if most of people prefer
> > using "common/zbd", I'm fine to have that :) 
> 
> Sure. I'll use "zoned" as it is more common in the kernel code.
> 
> > But I hope you can move all zoned block device related helpers to the new
> > common file if you'd like to bring in this file, likes what Darrick did in:
> > 
> > commit 67afd5c742464607994316acb2c6e8303b8af4c5
> > Author: Darrick J. Wong <djwong@kernel.org>
> > Date:   Tue Aug 9 14:00:46 2022 -0700
> > 
> >     common/rc: move ext4-specific helpers into a separate common/ext4 file
> 
> Yes, that will be better to have things in common/zoned. I considered
> moving zoned functions (_zone_type, _require_{,non_}zoned_device), but
> _require_loop() and _require_dm_target() use _require_non_zoned_device() in
> them. So, moving _require_non_zoned_device() will make a dependency from
> common/rc to common/zoned, which I considered not much clean. How do you
> think of it?

Oh, below commit [1] brought in the coupling of common/rc and zoned helpers.
Hmm... that cause all the 3 helpers (_zone_type, _require_{,non_}zoned_device)
have to be in common/rc or be imported in common/rc. Looks like we have to
keep them in common/rc, except we make a bigger refactor to common/rc, or you'd
like to make your 2 new helpers in common/rc too (likes these 3 old ones:)

BTW I doubt if we might need to use more zoned related helpers in common/rc, due
to we deal with test devices in common/rc mostly, likes dax. Someone might want
a seperated common/dax or common/pmem file one day. The common/rc imports
specific fs helpers according to $FSTYP (common/config: _source_specific_fs()).
If we need to deal with different kind of device types in common/rc one day, is
there a better idea to determine which one should be imported? Welcome any
suggestions if anyone has :)

[1]
commit 952310a57d9323ae0bb174b50be93107a8895e0c
Author: Naohiro Aota <naohiro.aota@wdc.com>
Date:   Mon Aug 16 20:35:08 2021 +0900

    common: add zoned block device checks

> 
> Moving _filter_blkzone_report() would be fine, though.

Yeah, moving this is fine.

Thanks,
Zorro

> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > 
> > 
> 

