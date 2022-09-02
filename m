Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AD5AA70E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 06:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiIBEiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 00:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIBEiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 00:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0B3ECC5
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662093494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSKxsbWcbjemUY+RQV9MT0hnj8un8lsAL7pYZO+AaoQ=;
        b=glPInDTINrwprW1GJoH0gpwOMSXAVKE7cL+8aNFXz2UKB4/fKg/1WCUgtdSRqdqqovVHF3
        34m/0MDzcqRjdPsehf47isnjhiwdgTnkX1QSItE9NAi4KhfmexWzvsXWk9xi7f2a3+mBLY
        d5DUl5Ag5LvwtagFWyq4jrXeXO0LQlQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-cKSVDWfVPIuJmrj6QABkdQ-1; Fri, 02 Sep 2022 00:38:13 -0400
X-MC-Unique: cKSVDWfVPIuJmrj6QABkdQ-1
Received: by mail-qv1-f70.google.com with SMTP id dn8-20020a056214094800b00498f685a1b3so572359qvb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 21:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KSKxsbWcbjemUY+RQV9MT0hnj8un8lsAL7pYZO+AaoQ=;
        b=67uxdgI7khnzZZUD6BWPfGfl+0DYlCpVBnX7Me03uWcqPVx7fSHUC+VZ2YsoHZ/r1x
         DjyqRXnbram09RqjXqGlniMVIBkZ6zjPmYcxjSJiNZNEjFoYZpRxHkiiOr3PDwfQC088
         aLmnheaBPkC06zZSIuZXec1RmurlBtLMYR9hQmEodPkkmmpqKydUjWDU1Aba963n3O/j
         7wLGb/XgLIpmE/40WrIbuS7dEDBAGGe4RiA4OljS3AEqzgAtvAs5IqEeEj1i85h/GZq2
         yOBAK9CiyX1UwA4b716TgZVK1OaDwEAVC3GV4dNghVhNCOxWl1j1yesvT1UgXzP9MXE7
         G9ZQ==
X-Gm-Message-State: ACgBeo3rC1M08rYwUcqhmxTNbE5cTu9bl+QMcbLvhvxbyCvXmtQRWhyQ
        KkI1VWtFv+oFZGZtlqHymyKspkq9Wfld+ojtAWQjN02bYfSGy/YCoivgx1Ut4BJeiGMlpTJWlyd
        AgAbr4gKvDF9r0j4rE5Y3w5U=
X-Received: by 2002:a37:65c6:0:b0:6bb:ed38:3145 with SMTP id z189-20020a3765c6000000b006bbed383145mr21854361qkb.262.1662093492844;
        Thu, 01 Sep 2022 21:38:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR74uXYv6AOD4YNCxdNuw365+wkHRZgQMFRoNK2cWmCoW1wKu/pWmC2sk82gR3mjFnEHRgQZqQ==
X-Received: by 2002:a37:65c6:0:b0:6bb:ed38:3145 with SMTP id z189-20020a3765c6000000b006bbed383145mr21854349qkb.262.1662093492449;
        Thu, 01 Sep 2022 21:38:12 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a29-20020ac8611d000000b0033b30e8e7a5sm441370qtm.58.2022.09.01.21.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 21:38:12 -0700 (PDT)
Date:   Fri, 2 Sep 2022 12:38:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix btrfs/271 failure due to missing source of
 fail_make_request
Message-ID: <20220902043805.7isxdhmvzmopl4zj@zlang-mailbox>
References: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
 <20220902022751.4q7uvzzljzstakg3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902022751.4q7uvzzljzstakg3@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 10:27:51AM +0800, Zorro Lang wrote:
> On Thu, Sep 01, 2022 at 09:17:02PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > The recent commit 49272aacac850c ("common: refactor fail_make_request
> > boilerplate") moved _require_fail_make_request() from common/rc into
> > common/fail_make_request, but it forgot to make btrfs/271 source this
> > new file, so now the test always fails:
> > 
> >   $ ./check btrfs/271
> >   FSTYP         -- btrfs
> >   PLATFORM      -- Linux/x86_64 debian9 6.0.0-rc2-btrfs-next-122 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 09:45:59 WEST 2022
> >   MKFS_OPTIONS  -- /dev/sdb
> >   MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> > 
> >   btrfs/271 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad)
> >       --- tests/btrfs/271.out	2022-08-08 10:36:20.404812893 +0100
> >       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad	2022-09-01 21:12:29.689481068 +0100
> >       @@ -1,4 +1,5 @@
> >        QA output created by 271
> >       +/home/fdmanana/git/hub/xfstests/tests/btrfs/271: line 17: _require_fail_make_request: command not found
> >        Step 1: writing with one failing mirror:
> >        wrote 8192/8192 bytes at offset 0
> >        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >       ...
> >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/271.out /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad'  to see the entire diff)
> >   Ran: btrfs/271
> >   Failures: btrfs/271
> >   Failed 1 of 1 tests
> > 
> > Fix that by sourcing common/fail_make_request at btrfs/271.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> 
> Thanks for fixing it! Looks like we missed the btrfs/271 ...
> 
>   $ grep -rsn _require_fail_make_request tests/
>   tests/btrfs/271:16:_require_fail_make_request
>   tests/btrfs/088:26:_require_fail_make_request
>   tests/btrfs/150:25:_require_fail_make_request
>   tests/generic/019:21:_require_fail_make_request
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>


Oh, Christoph has sent a patch to fix this issue:
https://lore.kernel.org/fstests/20220823193230.505544-1-hch@lst.de/

It's been reviewed but hasn't been merged (will be in this week).

Thanks,
Zorro

> 
> >  tests/btrfs/271 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/btrfs/271 b/tests/btrfs/271
> > index c21858d1..681fa965 100755
> > --- a/tests/btrfs/271
> > +++ b/tests/btrfs/271
> > @@ -10,6 +10,7 @@
> >  _begin_fstest auto quick raid
> >  
> >  . ./common/filter
> > +. ./common/fail_make_request
> >  
> >  _supported_fs btrfs
> >  _require_scratch
> > -- 
> > 2.35.1
> > 

