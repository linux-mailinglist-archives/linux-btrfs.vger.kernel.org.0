Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E05220DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbiEJQSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiEJQSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 12:18:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC586270CBD
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 09:14:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l15so11682905ilh.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKA/1yZ8g+zy9X4xsj9FmCafba5CtY9zp+PSDZbhIdg=;
        b=PFYdPMOjnfbHZ0T2F25Ke3810UzkzLUtEmOEyKQnfwJoZNTo3dJ5iny3+d0kO/LbKD
         Vem42hOYH1OJTGObwArI+Uzv7G85auE+raPmhvPy4wCTpZsLNRVjxwiBvI8tklot7O4f
         WbW9UHeYdcfUHb1pIAIzx7i5w64jrVtrXBzxVLVTnwo4dTHk/V7AcOtFtz+yOJzobMKO
         X/ALOKUGir01Cf7fcTmh95Qu0Gq6LvhkpPvFrXhtx110oq7VjTAFyjCbVWwVFVa4goV5
         EW4YB5JtmF7VcvB4Fn1/x8g7r/+kZutbuNydhuMcjcW8HVMX+t22wErC7gdRAzKI/q2a
         ucKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKA/1yZ8g+zy9X4xsj9FmCafba5CtY9zp+PSDZbhIdg=;
        b=zndZA5C1cxeef27GFntmq8TtmQBNDpc5yxQml3JZJpVABNo8tFVyQeTVwqDALauVQj
         u+Adq1WgUis7lvQYsmpDtkSwx3MnDQG1/ZsnAgOrcch449xPevpkY1K7itaFhYLBFEUY
         zOmKYnbPgiOG5o/cPom6E1ouShU3lFL6Nk21d6dp8uADlsKXbZSi9/WV/jkuFbirRP7a
         AF85vUnNMcXxUy/dVqroATOaZ4RX1SGyYT/jevRzcrnPAITNO3RPiL3aZ3fXljr5HbtQ
         A3HluaOV/hrX0cUjdUbKSNUrdPppb/RpcwfZ3KoPBFPHg9o0vg+m/Ce7CDmifhdwTSMl
         iq5g==
X-Gm-Message-State: AOAM533C7lZZ7nGciLpBzQgJsvi4CgB3DkP9GM5o0dh5L0xV3aa5B0HV
        fCI4x9kQ6KOe8ux5CMd6FEl9V5+ll6st0Ubu83qxpH8oaMs=
X-Google-Smtp-Source: ABdhPJzXDhD+E+iIjJVAVTaS9YDpwLt+f2aKCOCeKP0IYmCQClOzI5yGdZQs5mechW9rgjRo/v93qZDbGAn8Ji9+fSY=
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id
 j13-20020a92ca0d000000b002cf3bb8f1a5mr9951706ils.152.1652199288929; Tue, 10
 May 2022 09:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220509171929.GY12542@merlins.org> <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org> <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org> <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org> <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org> <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org>
In-Reply-To: <20220510160600.GG12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 10 May 2022 12:14:37 -0400
Message-ID: <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
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

On Tue, May 10, 2022 at 12:06 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 10, 2022 at 11:20:51AM -0400, Josef Bacik wrote:
> > > looking for this?
> > > processed 49152 of 0 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [4075, 108, 0]
> > > Couldn't find any paths for this inode
> > >
> >
> > Yup that was it, now it makes sense, I've fixed it hopefully.  Thanks,
>
> processed 75792384 of 75792384 possible bytes, 100%
> searching 164620 for bad extents
> processed 49479680 of 49479680 possible bytes, 100%
> searching 164624 for bad extents
> processed 102318080 of 109445120 possible bytes, 93%
> searching 164633 for bad extents
> processed 75792384 of 75792384 possible bytes, 100%
> searching 165098 for bad extents
> processed 108756992 of 108756992 possible bytes, 100%
> searching 165100 for bad extents
> processed 49479680 of 49479680 possible bytes, 100%
> searching 165198 for bad extents
> processed 108249088 of 108756992 possible bytes, 99%
> Found an overlapping extent orig [10467701948416 10467702210560] current [10467695652864 10467704328192]
> I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
> 2
> 3
> 4
> 5
> 6
> 7
> 8
> 9
> 10
> The original extent is older, deleting it
> Couldn't find any paths for this inode
> Deleting [4075, 108, 0] root 15645018177536 path top 15645018177536 top slot 3 leaf 6781245898752 slot 66
>
> searching 165198 for bad extents
> processed 108249088 of 108756992 possible bytes, 99%
> Found an overlapping extent orig [10467701948416 10467702210560] current [10467695652864 10467704328192]
> I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1

Ah duh, we delete it the first time, but then we find another
overlapping extent and we try to delete it again and it's not there.
I've fixed this up, try again please.  Thanks,

Josef
