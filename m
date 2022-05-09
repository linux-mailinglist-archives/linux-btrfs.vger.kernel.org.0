Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F452022E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiEIQVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiEIQVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 12:21:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465B31534
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 09:17:42 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e194so15848462iof.11
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aY8RbYBMFQ5CWllug0kGcXAgvKzLgrf5g7CI1H9mwXQ=;
        b=nstqT1yOimqNmcS6dVdBI1IqBBCNNpxEuEiZCP9VNV55GIXwqrSDL/VwhGOkC+pFRc
         4k6yA9sRQPkX/gPJHyf01VBbTcLdNrLwHXWxKN8hF6gmcv+bwUsOpYenfMlqvtfns6u9
         bsv7lzcFZdVJh7DCmrFThKXvchsSH+DTiZ07SfjpkUNSbLo07oNlr6Gfhpgs17IjZ5+p
         K0BNgR6K1CxGZSzt6jFIrIKeN4Loe6htnRC//U03CUP+zwHzKiNtUQpQfpgeL79o3iZv
         Ve/i5ITzqYEIjpSBYSS9u/dEzt9GsEA1VkdXqgK34rJUI8w5vuyRI1IBNAv9t3C5ef6l
         JFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aY8RbYBMFQ5CWllug0kGcXAgvKzLgrf5g7CI1H9mwXQ=;
        b=TggO50jRBPhSsnPYypMAYBr8jetOr/SbE5EJ59sRGBvijnOxTYjKx8TFmNnx3ZM9xL
         ZTogoFx7bl2uXQva6bgQ2aLFvm9EImO+lzc04NNN43ADF8L3ksudPvs5fnoH9dUxvP0j
         RySPqY0hFGYCgvE9viDdhR7a1Sfe4J5E33LSP8dwtEKsJxNc6CFOrrh+ptbHtgWpfTc7
         ayFAM+yUBkHP5QYrM8/V/cT9yQUml4Yfy8CCQnbzgounVVKEAtLa8tsGHet5/cw/yVvz
         no1DdjuG/5m8jcsFYVjENnr+FUS7Nl3NM7pL74S3ShZZ5mYqBLSB6NmjWzw3Zw1ZtiO6
         Zc/A==
X-Gm-Message-State: AOAM531mzomJuFim8ahH4OamPlWCt3ygvdMCxEoR6D9LfkcxBmRmLDJM
        vfTna+Q+VP4f0WrAPAO5Doq2YlLw/xSEsBmeO71UC1LU1BY=
X-Google-Smtp-Source: ABdhPJzJeaTvbzsHF9mbIL4tGqS1oRX0UhP7s95vQaP93E3sqvpgQCf+ET3MA9f3X+TAuYtLJSIXf/d9rnNurIN+lfA=
X-Received: by 2002:a05:6638:2501:b0:32b:6083:ca39 with SMTP id
 v1-20020a056638250100b0032b6083ca39mr8238441jat.281.1652113061407; Mon, 09
 May 2022 09:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220507153921.GG1020265@merlins.org> <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org> <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org> <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org> <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org>
In-Reply-To: <20220509004635.GT12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 9 May 2022 12:17:30 -0400
Message-ID: <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
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

On Sun, May 8, 2022 at 8:46 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 08, 2022 at 08:22:19PM -0400, Josef Bacik wrote:
> > On Sun, May 8, 2022 at 6:14 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> > > > Yeah this is the divide by 0, the error you posted earlier is likely
> > > > because of the code refactor I did to make the delete thing work.
> > > > I've added some more debugging to see if we're not deleting this
> > > > problem bytenr during the search for bad extents.  Thanks,
> > >
> >
> > Ooooh right this is the other problem, overlapping extents.  This is
> > going to be trickier to work out, I'll start writing it up, but I want
> > to make it automatic as well, so probably won't have anything until
> > the morning.  Thanks,
>
> Thanks for the heads up
>

Ok I've pushed some code, but I'm sitting in a dealership so testing
was light.  I've added a 10 second pause before doing deletions from
the new code to give you time to spot check if the numbers look
insane.  It'll only do that 5 times, so if everything looks good it'll
just yolo delete stuff as it goes after 5 pauses.  Let me know if you
have trouble, thanks,

Josef
