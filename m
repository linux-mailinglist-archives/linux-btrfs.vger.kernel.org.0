Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97A53BE27
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiFBSnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbiFBSnQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 14:43:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6A5F8E0
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 11:43:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s23so5618926iog.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjcJDFjZVTv+InXhQNia/aSujXT/4pSXhXF+jZqgRyQ=;
        b=23k0Gll4cGoUObyoN/4qcwOtirBXroFhXJzmKR3f97xAflB9buTnOdpu5OtTw/FHfq
         eN+mchyT4JLMEu+16QWYrJr7OT+zVZzSA4YB/wWFBsyS3cxe/1OETwJZneCK2+JvJWez
         OYjYnHuOQjQFOBcFqK1Io215pCmJi54uBlx46bf/OS9YZQOaqlpXi7lSwsIpfxTm91z1
         zO0JtpUgxcCsJeE8VSt2j23Y60wUKL3OOaOHamBoL3Ul7TPc2W2PmUnJo17XXvjUkGoW
         sUS5kiWT00iHBnJ5mTvnwdI7bYSy10XotyaMcg5Z1bxe0PTvYuq0kPk8fMD6zrCrhg/k
         G/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjcJDFjZVTv+InXhQNia/aSujXT/4pSXhXF+jZqgRyQ=;
        b=teaM54HaJ4qW0VcfmiEP2NiqmWu+XumuUGbpdw4LFWYgzM30uQbO7a769X4lsK9NIj
         CXnL3EMZcQfWVX2n5meQ4zR/NxOnoOH0KLP0q5Up7KWfbUzjIoMvHbZwU0VkKVExgmv1
         xoHj9C83mn9osUK1YpoFB/LCPwGn9TCnpl3bWElWApTPUNY8pmHgz/4sK4b1ys/nKOAR
         JyRANWIXqrAUfIrVK1YiL1PO6joqRHCRm2k4vEqtCdsgSSRWNX83rkO+THfcxNZYjjd1
         j2Um6gNE0RvyO1wCXW/yAqyLxZ2KNooMywhXPjsLo4gq61C8SL4cr+d3x/oVWyC+yha9
         XFpg==
X-Gm-Message-State: AOAM530mLPJVf1hhNb7qcr3g69cXr6PFHx772Jjs8+In0E5sxAuF+LcL
        npyuBMCb+R72VdSkiIN1I0mkx23+yu6n7z9bmtc5XdJNp8w=
X-Google-Smtp-Source: ABdhPJwXS3566xF00CYAY9fvX/A4K62i+7JUv+M+QbYD6Q9iu5HsfGoBPA8jKACHCUiOT404xt4PB01K89SWr9YMy+Q=
X-Received: by 2002:a02:a609:0:b0:32e:7865:17f4 with SMTP id
 c9-20020a02a609000000b0032e786517f4mr3747730jam.313.1654195394398; Thu, 02
 Jun 2022 11:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220601231008.GK22722@merlins.org> <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org> <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org> <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org> <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org> <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org>
In-Reply-To: <20220602143606.GR22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 14:43:03 -0400
Message-ID: <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 10:36 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 10:27:59AM -0400, Josef Bacik wrote:
> >
> > Ooops, helps if I use the new flag I added.  Thanks,
>
> Good news?
>
> Inserting chunk 15486104371200
> Inserting chunk 15487178113024
> Inserting chunk 15488251854848
> Inserting chunk 15671861706752
> Inserting chunk 15672935448576
> Inserting chunk 15772793438208
> Inserting chunk 15773867180032
> Inserting chunk 15774940921856
> Inserting chunk 15776014663680
> Inserting chunk 15777088405504
> WARNING: reserved space leaked, transid=2582704 flag=0x2
> bytes_reserved=180224
> doing close???
> WARNING: reserved space leaked, flag=0x2 bytes_reserved=180224
> Recover chunks succeeded, you can run check now
> [Inferior 1 (process 21907) exited normally]
>
> What check do I run now?

Now we run

btrfs rescue tree-recover <device>

to restore the roots we lost.  After that we run

btrfs rescue init-extent-tree <device>

then

btrfs rescue init-csum-tree <device>

and then finally we run

btrfs check <device>

Now I have to write some code to fix up the device extents for the
chunks I just added back, but I need to make sure that's the only
thing check complains about.  Once we have that worked out I'll write
the code to add the device extents for the restored chunks and then
theoretically we'll be done.  Thanks,

Josef
