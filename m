Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57F521806
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiEJNcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiEJNa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 09:30:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684D2C8195
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 06:21:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f4so18464958iov.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0dCHthICA6BWKnXSDiz3AQ/Qc+xvFFTxd528VwSbqk=;
        b=VgJW4HmsZmZOHTJVP8GYh/PcptztPoQbb2MhA43ESFzVXPrVXI0GEdtNhb4Pl5Wwt+
         48kuFuetBACiqHNFjVBLAI0JEp+5QLeY/nIDAAwoDrs+dzppn+Ets3+nf3N1WD06xqgO
         XbBZtGskdSqWYI02ToAJOZs6jbGeC3fcQMcUHGMx4sicEhWh/dYtyrldVjNZz0hx6HtJ
         UXvvxh2DQSQTmkv2J7szBMiQnsoi3jAZFd6m6NrKBAkWjQZpbcSuxnt10/WgmjPInFTR
         aB7gxsBcX8S5B74Jw3wvz51jiwAKqFQ+i7e0fk69z1Ea03LbdCC/B53MkQaezjMhfVCW
         WuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0dCHthICA6BWKnXSDiz3AQ/Qc+xvFFTxd528VwSbqk=;
        b=s4ipLV4CMlO6izLOvqkV2oboTH/RxueNr4CfuPQUKja1Q92EOUxTAsvJ/pnHO1WdkP
         3EfGQBPlxBeKGleIPDPZwBiEpmX74XcEfMDSBwkYKfWIlZ1SwwVyv2Hq7uvcsk8or1FQ
         K00Y+aiK1M/RgLTxK6W1ZcxuxipC4TABp6xWgY2q7JBXAs8nJQNTFmZAhuZXY/GSFUIg
         u5ksvhhxdWyBwZisAeyzCKwxB6y8FXuYyvrx/LwoZER8y+fCKUk3ncO5mZaRr0rZNeYW
         Z5bDeWa+qGMoqZa0/qaHSol/vJMkZploPNy/1O6D0OemoHKbM0Qk20BURtHzBmPPVR/P
         +1HQ==
X-Gm-Message-State: AOAM531LZLFCFa2tcoKKF4sl+yqbIn+nQ+MKEQPiAAK5O2HSe6uloF/D
        0Wx8tjx3SwllTX7SY0b7EAcCBiJA7p0j0VGqklTddVnpPX0=
X-Google-Smtp-Source: ABdhPJyFeB5VfdXBdxnxvbHt3/Mobv0Hu6z+ODctK0bKtdu4DrrpOHnf+82jwBF3/KwS33yAKdeZh+mAAWJb3P+LdQQ=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr9210362ioq.160.1652188904884; Tue, 10
 May 2022 06:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220509004635.GT12542@merlins.org> <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org> <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org> <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org> <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org> <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org>
In-Reply-To: <20220510021916.GB12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 10 May 2022 09:21:33 -0400
Message-ID: <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
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

On Mon, May 9, 2022 at 10:19 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 09, 2022 at 10:03:27PM -0400, Josef Bacik wrote:
> > On Mon, May 9, 2022 at 9:32 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, May 09, 2022 at 09:18:32PM -0400, Josef Bacik wrote:
> > > > On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > > > > > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > > >
> > > > > > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > > > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > > > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > > > > > >
> > > > > >
> > > > > > Sorry my laptop battery died while I was at the dealership, and of
> > > > > > course that took allllll day.  Anyway pushed some debugging, am
> > > > > > confused, hopefully won't be confused long.  Thanks,
> > > > >
> > > > > Sorry :-/
> > > > > Yeah, I bring my power supply in such cases :)
> > > > >
> > > > > Did you upload?
> > > > > sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> > > > > Already up to date.
> > > >
> > > > Sorry, long day, try it again.  Thanks,
> > >
> > > processed 49152 of 75792384 possible bytes, 0%
> > > Recording extents for root 165098
> > > processed 1015808 of 108756992 possible bytes, 0%
> > > Recording extents for root 165100
> > > processed 16384 of 49479680 possible bytes, 0%
> > > Recording extents for root 165198
> > > processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> > > misc/add0/new/file
> > > Failed to find [10467695652864, 168, 8675328]
> >
> > Ugh such a pain, lets try this again,
>
>
> Looks the same?
>

There's no other debug printing before this?  Can I get the full
output from the run?  If there isn't something really wonky is going
on and I'm confused.  Thanks,

Josef
