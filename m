Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB20A4F6745
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiDFRXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbiDFRWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 13:22:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A37CF49E
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 08:20:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z6so3387280iot.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF1ihA9uxjNdeOeesjX/SkPGe/7BnCjuPcrS2A1ifgs=;
        b=uHOi3HoQPfPlVONvcnrOtlQaKTBb/RHk91WWAjW1xSOrbNl7tgMmHNon3MCeEuLuS2
         sH2yxLCJ5pvE4yTbFeL7s4D5iCbXm5IJ5qdq8NMvJkgLdVGyZddTzUiAadm4bL6JIpkx
         KaCoBJItUF+/Z39YkMqZqw/V5guXUx5fRAyA4Et9bPn5fjCTQBcoqZuYot0a5PtB70mu
         jZ/V189GzEGGHsO/+sAkECDjW3HoKoCZsNUicz7vsLazZRdLlMB7qf5FE69WDRw7i+kV
         uvjwvmc/yZDY47R4tBVcZjRGYG6QXHOhQGT/kVllrRWNS3uNd64DQ/CdYwTsldQVgBSQ
         +O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF1ihA9uxjNdeOeesjX/SkPGe/7BnCjuPcrS2A1ifgs=;
        b=aCM24gBfhw7YTzgJyAoKrCD2SfgbvRUCEW3Z1xYuF/GZa+RJqLXt9LA1KYbtO4kZr7
         AAsXMenJ2QY/4jUh1hULEWpTu1jqsWEuEr8QsZyBw/hTW6YCvTUlNiFqrMI9hiyqKJ3W
         XpaHScpVgmJqgM3tcFMBJEhQOXj4WMkTK/5QqgvOaUdLQIHq63q6zcirbkZYno2TRLTm
         I3yie44OyU/09HXgvSgQzJWLqoE3YhZnUH+trpjy0rgAd/qkEsRFnDFv5SU+dQx81vuu
         lLciA85VB4/Q3v6oJ43jCjoTUrdNDTFkBv1UfJoFbjwRkkW6erU+nO2lGxwX/eAHARo7
         NKzg==
X-Gm-Message-State: AOAM533sP7m9XyvrZyVYBnGyHUgxwNUORyTNZTnHJft3bUW341sPsS/B
        r7+41TlWj/2KE7RhUFrxDOFtl39Kf6gXs521uZviXo5OuG8=
X-Google-Smtp-Source: ABdhPJz6UArCE1VaWF/JZEzijdRk8PToD82W5t0fCpmmObscASk1v3GAHNP5k0IlW29uzffc395S2xQ8XiuAu35+7Qg=
X-Received: by 2002:a6b:ea07:0:b0:649:f07e:9c73 with SMTP id
 m7-20020a6bea07000000b00649f07e9c73mr4429294ioc.10.1649258424324; Wed, 06 Apr
 2022 08:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220405212655.GH28707@merlins.org> <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org> <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org> <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org> <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org> <20220406033404.GQ28707@merlins.org>
In-Reply-To: <20220406033404.GQ28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 11:20:13 -0400
Message-ID: <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 11:34 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 08:12:55PM -0700, Marc MERLIN wrote:
> > On Tue, Apr 05, 2022 at 09:08:32PM -0400, Josef Bacik wrote:
> > > Also keep in mind this isn't the final fix, this is the pre-repair so
> > > hopefully fsck can put the rest of it back together.  Thanks,
> >
> > Done, so now I can run
> > btrfs check --repair /dev/mapper/dshelf1a ?
>
> Here is regular check:
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1a

Woo ok we're almost there, that's great.  Can you re-run the
btrfs-find-root and see what it spits out this time?  It should run
faster now that it fixed everything, I'm wondering what it wasn't able
to fix and if I should run the same check on all the roots.  Thanks,

Josef
