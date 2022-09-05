Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8E5ACE88
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiIEJI0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiIEJIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 05:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A8751A38
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEFeJD2ndTirB+xQ56lkbiYe6LofADrROqtJbJfuWSE=;
        b=bQW6Wp+yfXJgHXNm0nUH/FKFqUygcfCT9LlS7bHRly1z2sV+qw/NNlcxYyrWFf3QgVZlWk
        IweGRR82uJa7WHs5x0iZafxGCBDl0L15fp+xmlcP4HANv9IPT2Nq2T1mnB3fAANCpcOuVz
        4Xz1wUjd7AcDFeBYbJEDSMaI1odH7r0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-9F9my0MJOT678iyYjzd86Q-1; Mon, 05 Sep 2022 05:08:16 -0400
X-MC-Unique: 9F9my0MJOT678iyYjzd86Q-1
Received: by mail-qk1-f199.google.com with SMTP id u15-20020a05620a0c4f00b006b8b3f41303so6478524qki.8
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Sep 2022 02:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AEFeJD2ndTirB+xQ56lkbiYe6LofADrROqtJbJfuWSE=;
        b=Xj6cAx9lh2ZicMf5fXbJ6yQ/bpIMqK1FHMgV3TThP6RS4ptYa7M94++nmHmDJq7MPT
         TKBa0v8LNQRnqqQhb6Qjrf/CCwAyexS0ejNQEu0fQQuJnlPSaZJJ2lVk3UNvXX7SG8F4
         9TGRkZGF1HFXczv473oN6hCn1TAdzPDTXO9SA7oSYm0gubgl+206v/cqRQ+EaWJ9+1ZG
         Bklneg+NGIES++m3Na0p8pxcpOW5vgmu3trMVq92t0mmZ4UYMnhDNq+VTgqJqxFOVCW4
         RpNjnZFSnPvNnUiHa9G78bQQHTJJc3ATBc2MTmC24aQvYWjv+WUZFJnXbRa0B05kEW0z
         M5eQ==
X-Gm-Message-State: ACgBeo2OyFTcngcx1d5OHfb+o5qznja3q0iWho2maMib33gmsbxtChkv
        7ZgcRx5Yg0bDL/a0UO2iWQ7fYteBYtYaWfOmjOjF0HY2vrOrqVT9OWsjilgGHYnNj0gCEq48V5a
        cw0vP5P6jpNuZDVcNl0hNaKI=
X-Received: by 2002:a05:620a:1709:b0:6bb:85a4:4e8f with SMTP id az9-20020a05620a170900b006bb85a44e8fmr31584553qkb.184.1662368895594;
        Mon, 05 Sep 2022 02:08:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4BZmjGbZguy1/0bwv5WY/fF6Qt+5SK7h57MJV7j26pRtqH2lgCxTk5U3u/1T/maorwuF7Ifw==
X-Received: by 2002:a05:620a:1709:b0:6bb:85a4:4e8f with SMTP id az9-20020a05620a170900b006bb85a44e8fmr31584536qkb.184.1662368895337;
        Mon, 05 Sep 2022 02:08:15 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b006b9815a05easm8178907qkb.26.2022.09.05.02.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:08:14 -0700 (PDT)
Date:   Mon, 5 Sep 2022 17:08:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220905090809.54feouoalvrzmaao@zlang-mailbox>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
 <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
 <20220902094424.GQ13489@twin.jikos.cz>
 <20220905063539.GA2092@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905063539.GA2092@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:39AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 02, 2022 at 11:44:24AM +0200, David Sterba wrote:
> > >   commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
> > >   Author: Christoph Hellwig <hch@lst.de>
> > >   Date:   Mon Feb 18 10:05:03 2019 +0100
> > > 
> > >       fstests: add a seek group
> > > 
> > > So I'd like to let Christoph help to double check it.
> > 
> > It's quite obvious from the test itself that it tests only send/receive,
> > which is mentioned in the changelog. The commit adding the seek group
> > does not provide any rationale so it's hard to argue but as it stands
> > now the 'seek' group should not be there.
> 
> Probably.  Unless it somehow exercised seeks through the userspace
> seek code I can't see any good rationale for this addition, and the
> patch was far too long ago for me to remember.

Hi,

I just tried to learn about the history of this *problem*:

At first, Jan Schmidt added src/fssum.c into fstests by df0fd18101b6 ("xfstests:
add fssum tool"). In this original version, fssum does SEEK_DATA in both
sum_file_data_permissive() and sum_file_data_strict(), that means it always
does SEEK_DATA. So all cases run fssum, need SEEK_DATA/HOLE support.

Then 5 years later, Filipe removed SEEK_DATA operations from the 
sum_file_data_permissive(), by 1deed13f69b2 ("fstests: fix fssum to actually
ignore file holes when supposed to"). And fssum run sum_file_data_permissive()
by default. So that cause fssum don't need SEEK_DATA support by default (except
you use "-s" option).

Then 1 year later, Christoph added btrfs/007 into seek group, I think that might
because btrfs/007 still keeps the *_require_seek_data_hole*, which runs the
src/seek_sanity_test.

So, now, if we all agree that btrfs/007 isn't a seek related test, we can remove
the seek group and the *_require_seek_data_hole*.

Thanks,
Zorro

> 

