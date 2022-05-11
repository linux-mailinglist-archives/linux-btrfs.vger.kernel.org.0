Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB3522876
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 02:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiEKA2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 20:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiEKA2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 20:28:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB414262651
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 17:28:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z26so515849iot.8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIoFPAERfm/R6eFKO+jk37f2Sq+UmFCTO33qPYdI7zk=;
        b=Uc3/Y4mvlvBXaKjeIm8HjWL6tgKQZ3d5jGbvzpcLAHir1P5Lqz3r0NgFlaDfVT/N6b
         822y7VKl85fNMWxqoZig21PBBlmtlcCVCIo13lbQMI3PIRp2YikUHfXFHG4ZR9idyxvU
         Sre0s/CGUeI2J8/M0SAmW28qRKgiuaLWkaIbbhvevdRPLOeDILNiSNrPif+HvaS1vwMp
         8CWTX50RtIQur49OFprRg1afDiaFHaVzqgH0S+gbp2lxowj1+U3l2VmR5hS+HFrRS5ah
         0ctCFEEfhta1fU9P6DBC15e8KjEUeYj+FKwLKyh8tlUqW9k5pVhemlb19jC1KZlhS/LX
         aLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIoFPAERfm/R6eFKO+jk37f2Sq+UmFCTO33qPYdI7zk=;
        b=V61oRTFLJvupxL77g5efq7R0VKcIj3b4fnPkpKULKwXWhMLiFlT1H2AvXlYQlLGxu/
         glyyiK1I+vse8CJaZFPh6XG222zPTcBHI2mDgZdkZ3X0GWhDMzTzhui5J9Bftowm+wdQ
         NghL9+ePeGXprQArJdCgMtu3HeN1n1SyxBJcrjcuSjBcddwhS9BMDGWj/nieZ/7QSRgM
         YLXeBcSzNYdpH0/Fr2qfEy6NbbQo7zxtV1vsYz1CJjuCukFqRlMyrze/IWHEXs8nqLvT
         VdSfP/VJvpZ7kmyf+nNa1awFZbNBheUFnmxbe0DS2aA5JyQ83i7K+htaRHk1NTWhnk1M
         B/hw==
X-Gm-Message-State: AOAM533nI1QXaJsssTO3BFHA97KO5VU8gXC0s34gnxzso0C/p7+ZhL36
        ezhXo0/YKQTeWZAxBR6ipHKDvcczU9XK5nPaoibL/mxWzmw=
X-Google-Smtp-Source: ABdhPJzebCqFNXSNDDgZMyIFeP/TAbxHhj1M3mx0NqB0m2gU5igtiOKeYvuI5V0QD5Qmtk2fV5PsxxHGvKd+SNl6C5s=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr10657507jap.218.1652228900804; Tue, 10
 May 2022 17:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org> <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org> <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org> <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com> <20220511000815.GK12542@merlins.org>
In-Reply-To: <20220511000815.GK12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 10 May 2022 20:28:09 -0400
Message-ID: <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
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

On Tue, May 10, 2022 at 8:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 10, 2022 at 07:38:37PM -0400, Josef Bacik wrote:
> > On Tue, May 10, 2022 at 5:15 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > I have
> > > ./btrfs check --repair /dev/mapper/dshelf1
> > > on hold (^Z), waiting for your ok to proceed.
> > >
> > > All good to continue?
> >
> > Hold on I'm looking at the code, I'm very confused, we shouldn't be
> > finding any extent tree errors at this point.  Let me work out what's
> > going on.  Thanks,
>
> Ok.
>
> I ran check without repair, at least it completed. 2.5 million lines of output
> but I think they mostly look like this
>

Ok the csum errors I expect.  I've made some changes and pushed them,
re-run the rescue init-extent-tree again.  Run check without --repair.
If it complains about extent backrefs then I fucked up, I just need
like 20ish lines of that output to see what I'm messing up.  If it
only complains about csums then we won, we can run btrfs check
--init-csum-tree, and then --repair.  Thanks,

Josef
