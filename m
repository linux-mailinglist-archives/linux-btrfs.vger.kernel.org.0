Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA24C577FDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiGRKj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRKj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 06:39:26 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D06308;
        Mon, 18 Jul 2022 03:39:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10cf9f5b500so21415014fac.2;
        Mon, 18 Jul 2022 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vz8thXfyqmr8/ZGBgzP+4ncQZsqZIti3MIOVrQPZcf4=;
        b=UYrX4jNghz7l+TMu1SjHr0EY0oK4QtNJwXWXzW1OWV9IGqHjzN4L4uScGFTH3lh6+n
         FWjA33OtTjRxqNoUy2tUFKejBrjafdEVCPzpfaU+vB/W0oGN6axOFfZ5cRkmzwJyyReh
         CHOwmzAOrqtapvbnFwKc+UyoGb71wjnZvEkV5NafYWR/KAdHBnuZBTqRnfTe3uClrecb
         eI6UZLY4AEJkRkXay+9qF63zCyEIa4H9zcfwh6SaxYDgMq2zfApdDMxbnwQAFGoB2YT7
         3BvVn4M/CG+xRFJsWZl4sswbIBFawxZiM8J1BnAl5BADwKSTErJG0SZvSCIStZ6Fm+7r
         tDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vz8thXfyqmr8/ZGBgzP+4ncQZsqZIti3MIOVrQPZcf4=;
        b=ZSSl3P1dO97GlXmxotZA7O2dacBX8lK2WmdSN2lKMFYU30NYeLSsUeTbdHJidmrwe6
         HGZc5y0J+f28yrLMUr3HvAuA7eYVPIVuZ80SWbNtmo8S8pkLg2Moq0L3W3H8c0l41YFM
         axIMApWcr5cdee5bnycZVNXSrBlfi1FZgn5HNSIh73KIpIP+62g7iyeV1EBzvwFaRRvt
         KgCnb9vJeUrBGTi1vHCezXbP10psFBvGxVNNR5A6pFrjyy5BwJFa0ztYD9ChE4DjB1jo
         CMjFw5fxU55B38lEtpWD8p8LjBUi1Hm53h+RrO90Ns9A9CyNhX5+F1aJjH/rif+4I7kV
         7Lhw==
X-Gm-Message-State: AJIora90I1/D6JPr9h6iYb2UHbGoqyqiaUdRsZaalludwNR/nPx4OOng
        dfOyRatpuxtbx9zxLXrd1tGpUAS76BppR5YhqGk=
X-Google-Smtp-Source: AGRyM1uQOqVeM+UIDqTpNmTACLVwDpYhkfFVH7exxRRhDtnftOV9C6MxkZWzz27cPD3MJSJooxjEFQklnfn5c+TLsBA=
X-Received: by 2002:a05:6870:c889:b0:10c:7f1:c6b8 with SMTP id
 er9-20020a056870c88900b0010c07f1c6b8mr13629698oab.280.1658140764394; Mon, 18
 Jul 2022 03:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220712013632.7042-1-bingjingc@synology.com> <20220712145201.GA1074561@falcondesktop>
In-Reply-To: <20220712145201.GA1074561@falcondesktop>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Mon, 18 Jul 2022 18:39:12 +0800
Message-ID: <CAMmgxWGu9AJELK3hM10CoS8q38JfVB0yvbFr6=LpFqApXFqXVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] btrfs: send: fix sending link commands for
 existing file paths
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     bingjingc <bingjingc@synology.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robbie Ko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana <fdmanana@kernel.org>=E6=96=BC 2022=E5=B9=B47=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=8C=EF=BC=8C=E4=B8=8B=E5=8D=8810:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, Jul 12, 2022 at 09:36:30AM +0800, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > There is a bug sending link commands for existing file paths. When we'r=
e
> > processing an inode, we go over all references. All the new file paths =
are
> > added to the "new_refs" list. And all the deleted file paths are added =
to
> > the "deleted_refs" list. In the end, when we finish processing the inod=
e,
> > we iterate over all the items in the "new_refs" list and send link comm=
ands
> > for those file paths. After that, we go over all the items in the
> > "deleted_refs" list and send unlink commands for them. If there are
> > duplicated file paths in both lists, we will try to create them before =
we
> > remove them. Then the receiver gets an -EEXIST error when trying the li=
nk
> > operations.
> >
> > BingJing Chang (2):
> >   btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
> >   btrfs: send: fix sending link commands for existing file paths
> >
> >  fs/btrfs/send.c | 195 ++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 181 insertions(+), 14 deletions(-)
>
> Looks good now, thanks.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Also, are you planning on submitting a test case for fstests too?

Sorry for my late reply. I will try to add a test case to fstests,
thanks for reminding me.

>
> >
> > --
> > 2.37.0
> >
