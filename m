Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D64CA1DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiCBKLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 05:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiCBKLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 05:11:18 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A082C672
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 02:10:35 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id f38so2316184ybi.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HeCFIBR9p13ClAG+QCmfhx5nxqdk6y5ghRmB6XmX4yU=;
        b=N5Cp69hdhI0Pb5qy2FZgQT/tvgiKcHz2Tto/n6VZkYyRUDjAQYPkG4yLcgv5W5ezzm
         U1YOKR7eJ3esvxhxXXbSqUlzkLWVREC6VfDEoUM5Ij+kABIv8DPpyfio2LDS2c4cgGNu
         hw/Eva1gXlglNBcAKPPr1qLoLAP1IAnEnyyXjckErI3RNOUdHa2XullsxtCMiB8Xwgdx
         HCjn47XqlZ/CxBS0wFBu5Z3sjiDRnlUZfsB34lEy6dC64dOROnhAKDGlzhsul7u61V/6
         voESBXdBfdzwxs3luPVAjbDImrdkJ7b7Uz/R9Cra6CQtRDSV8DkE48mo6TNF/qQf8Hqo
         isZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HeCFIBR9p13ClAG+QCmfhx5nxqdk6y5ghRmB6XmX4yU=;
        b=RluVaTkEF6h/1VDe3DgHr+N2RpaKixSM/2QXwBt8pZgqwlqw+KNPeY9wVvHMilBZf7
         e4B+5jERrh2cGeBFVTd67PTRLcc8u+my7ASCejvTdaWFiFlDHLf6M0jz2qAq5Odb0Gwc
         Q1Ux2cjB+stc2Zw1iPkcIJshjxa8njTvnNHa1YjQ5eHLP24G1AZD9VFDF3zgNgKniIYP
         nZt3jCwYSPU78tWZbFSplqb/S4jycLWK877QNfCm75Pc2nEgeDh4wt23Jm7/ENTdrSXt
         dqlBAwSCtIokDVrxaX8X9nqGMiq6NnqnSJ4m7FG0CZs4Ypx6kTJaqO3MBvo9yIZdVBTu
         Kn2A==
X-Gm-Message-State: AOAM533jlN9SXrsWuZhocvgE8H0PDqGp0I1Prs2qqUc8pssC/X7ECEO2
        OPu13nWfUjUzt7c7/hyN+1U02fCJ1Oyo0jGh8ZQ=
X-Google-Smtp-Source: ABdhPJz/iusvMIUmNEm6HpE39W3FbEwFNE1t4qzrF5Bq45wEyZAnQ2sNS52g7Mkn+feHlKG0QM8O4tKgn0YfVC6YB9c=
X-Received: by 2002:a25:6642:0:b0:61a:8a17:f0a2 with SMTP id
 z2-20020a256642000000b0061a8a17f0a2mr27194320ybm.608.1646215834745; Wed, 02
 Mar 2022 02:10:34 -0800 (PST)
MIME-Version: 1.0
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com> <20220225114729.GE12643@twin.jikos.cz>
In-Reply-To: <20220225114729.GE12643@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 2 Mar 2022 05:09:58 -0500
Message-ID: <CAEg-Je_KvG_rhy3=i5car11ndOB9-cs1GFY1KqEt2Fq3TyGtbQ@mail.gmail.com>
Subject: Re: Seed device is broken, again.
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 25, 2022 at 9:44 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
> > Hi,
> >
> > The very basic seed device usage is broken again:
> >
> >       mkfs.btrfs -f $dev1 > /dev/null
> >       btrfstune -S 1 $dev1
> >       mount $dev1 $mnt
> >       btrfs dev add $dev2 $mnt
> >       umount $mnt
> >
> >
> > I'm not sure how many guys are really using seed device.
> >
> > But I see a lot of weird operations, like calling a definite write
> > operation (device add) on a RO mounted fs.
>
> That's how the seeding device works, in what way would you want to do
> the ro->rw change?
>
> > Can we make at least the seed sprouting part into btrfs-progs instead?
>
> How? What do you mean? This is an in kernel operation that is done on a
> mounted filesystem, progs can't do that.
>
> > And can seed device even support the upcoming extent-tree-v2?
>
> I should, it operates on the device level.
>
> > Personally speaking I prefer to mark seed device deprecated completely.
>
> If we did that with every feature some developer does not like we'd have
> nothing left you know. Seeding is a documented usecase, as long as it
> works it's fine to have it available.
>

For what it's worth, I've been interested in using seed-sprout for
live media for a while now. I just haven't had time to experiment with
it yet...

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
