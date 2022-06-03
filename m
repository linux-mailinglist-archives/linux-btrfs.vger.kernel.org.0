Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859D253CD09
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbiFCQR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbiFCQR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 12:17:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADBABCA4
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 09:17:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b17so3044037ilh.6
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CeMXhBId5vN4aQDQipj6E0R9RXBv5UzB90gsExquZY=;
        b=G4vqnEhUKIOA5ZWPqUm19qFMqlwvcy5foo7ZnOwoOvGWD86NO1/2qO96JLCyvHiT5a
         EQ9H3533XjzVlqnOUEMdxxITUx77+2wI3ST5TPLCL7RYz/wbWgR1r310wvi6pk0ImvPf
         nFqmpUHsyVw95qVi+PZGkfRaKmCZPVS3xgt5pW1r4G+S2svrX5njwMXtsl19WLWtI3oI
         Kl3qYfOND5Ho81wHttUDttZeiVOFeYc9rBTHWLCw4wWnykPpAk45Q/Rhdd9rAckRe3DH
         2Rx8upbFUFxfL2DFNBXzrv4RWnWMuxt/OmDODXYATYuYYygI4bxZJ7G9T+C9+n0ZEbju
         Ifrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CeMXhBId5vN4aQDQipj6E0R9RXBv5UzB90gsExquZY=;
        b=4yQEp6r9dUeBAYQBGOO+LEljqlfZKE37GTmiSnMZg+AMFUGxtJJfpl25K0IH5qbYHr
         J+7glWGHI9evOmxE5TbAjyWqL3KFq+exxNKLIqXMxwh37ZNZvvxztttu205aJHjCDOeb
         YVwzeJMjaObOP12J7WLfOGPPOD+E1G2kuucZ0DVJe729lxS/mfTMVopAJREnDNWZoyp/
         q8LjxVcw0ZaFf403RiXoud3iQR0Zoo5NKbfiMRqI4r1ryP4DjY0hWre0UoQpaRXZh1cj
         9hm1EvrPi/D4rgdJ1SnrjU9r8IkoPAU+KSbXtP+t7wASNuFcOzaHDFqaej72Z9VtZqIZ
         rGiA==
X-Gm-Message-State: AOAM530IPuWICKU3rHq/dOcot+wX5/wdTrlQI5I8hsuedqO1kOFqTpD3
        8to8IuiYtbHbwFJsVeZ4C+KJp7boRRj32VuQiqRk+wUKLsM=
X-Google-Smtp-Source: ABdhPJxme3uW3orwWNIYqyN0gji/T/1ee+uuGgkUvUvYzpsx+OxQNk9jV8nSgSUn1GHg3tWXEXETmROGfJ7qm1yMOfU=
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id
 k14-20020a056e02156e00b002d1c265964fmr6602628ilu.153.1654273045930; Fri, 03
 Jun 2022 09:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220602143606.GR22722@merlins.org> <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org> <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org> <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org> <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org> <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
In-Reply-To: <20220603144732.GG1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 3 Jun 2022 12:17:15 -0400
Message-ID: <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 10:47 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 10:20:13PM -0400, Josef Bacik wrote:
> > Sorry daughters graduation thing took forever, I've updated the code,
> > it should work now.  Thanks,
>
> Not sorry, congrats ;)
>
> It works better but seems to be looping on the same thing now (it has
> all night):

Ok I think I know what it is, try again please.  Thanks,

Josef
