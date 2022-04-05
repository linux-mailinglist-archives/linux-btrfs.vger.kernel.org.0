Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24D4F21CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiDECwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiDECv4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:51:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3983145032D
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 19:25:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b16so13627556ioz.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 19:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kblWu+1ASXv98eTNg+b/MmeImkaCnmvXELePffMwswo=;
        b=a9f5jFHsAGI6l1wqMM/QrXouor8f0tRUy1basDS6nYtLaBGyenm/WUZBrKQ/e8uXy5
         sGWpnTeNy4gUlruPlL6HpTn79YqjQxqv/jr4hfW6E+msuDFHYlvKTy2ubG81RiQEC8e9
         l/+w9nh6pkhtpW7oMgGXECP2zlISI539i8VKLC2lsk6t+zjD6Mss7N2iiL4HnpkEkgHS
         d3UVcxStryuSeZqbJr3s6CBLS73QfDmGfBnAqf2+BVxhrtvCJfsKKiWekZ55qzYPPW2w
         eXzHs7Nweb2bGXIH26rJOr9M45stsgFVKQ4+gTIRCS30PHWcpSKwGQdMKC6qBssfkfrS
         S2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kblWu+1ASXv98eTNg+b/MmeImkaCnmvXELePffMwswo=;
        b=Y8/42LNibgHVvxS4/pdHTsIzB4ltIDLo0mHTshQYMBFGYm42DSghjpDissBLKO9A6r
         bEYCHJVuCP6j1i4olv8i6Te02Xvs0JD3Y/fIpvM2W9rruygVS6sap7eTqvDh5OG6iuYZ
         Xc3Wl1gGindnc/JYG2HQSFuSYZy6NXXJTA6HJuJv18E3RYC8wxy8G07+v5UodymJTQCi
         5LNFhD39+LBtml6qnKV5JhGPvcVhHpRlkUEXWh53hpXt3+y+9u2BOckS1TqGWu029aNC
         gKKDFv6akN8TXjJKA11QDm0fLfBJSFeY/H469GnoBkJJhn64j0moM+C3i7vHkLT9YR9X
         RB8g==
X-Gm-Message-State: AOAM533I4wa0oDHHWrwjLDxglQJGH7wSjWco/WPfM+SxkwdxXFOghzV9
        3I1ijZEPGrdTBPCujXRHYeaSSVTa4ntle6NQeSoU3fsqbn4=
X-Google-Smtp-Source: ABdhPJzIaXuqj1z7R2RItoOX/EvTDC2TnaOkI3NW5y2yaO1stfEIEgX9G8mmNtvwPCok8jAk8bFHYO5KotlJzXmSxz0=
X-Received: by 2002:a05:6602:2bc4:b0:645:eb96:6495 with SMTP id
 s4-20020a0566022bc400b00645eb966495mr436179iov.166.1649117344544; Mon, 04 Apr
 2022 17:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220404203333.GZ1314726@merlins.org> <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org> <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org> <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
 <20220404224503.GA11442@merlins.org> <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org> <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org>
In-Reply-To: <20220404234213.GA5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 20:08:53 -0400
Message-ID: <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 7:42 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 07:24:10PM -0400, Josef Bacik wrote:
> > Re-pull and try again please.  Thanks,
>
> Looks the same?
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> btrfs-progs v5.16.2
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> Couldn't find the last root for 4
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/dshelf1a
>

Fuck it, I'll just comment it out.  Try it again please.  Thanks,

Josef
