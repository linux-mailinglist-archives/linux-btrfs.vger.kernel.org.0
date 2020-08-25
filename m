Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135F3251F7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYTFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYTFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 15:05:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F26C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 12:05:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so13992837wrw.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9XrsqpgLl8oJaUnaIM5MG8ZuDgqqK8DNwj9gqvZusk=;
        b=tI1tfKvgaFHF0PLwH8HlixR489d/bhP0vFDBMKK+jnIpaJppwDJbfAyGYN5RDXgjno
         Zves3KiVH8SpJjku5BNwHqXTn+I+Y7U3hHrtXrxVsRi4lLEZccCUMqBvsEd/Sx98OVBH
         kHZFC2GSwSviPbW1k8kjfxWKd/V1kH+r+2hRUgLhnWYywG7boPKbb+bIQm0GXhdV+D+b
         eWwkVO9I/zc7DdCbiXj224s57hCwfzkHSCn+AU1rW2uZkUDWpSugHV/hueVmc3DvWzqk
         KJZK52jv5LgoiPX2+ec6/ewoJiqru5yG8p1Ubo6/qPOoHmEi95Nto/isCEFavQ+zlCOA
         HV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9XrsqpgLl8oJaUnaIM5MG8ZuDgqqK8DNwj9gqvZusk=;
        b=sxJ8xiMBhnfJT3VXKg8YzMlume3BFWBEjVyom4bhX9EcASgIBTWw9GOC3XbyHi3MOe
         FNRI/A7PPnoKVCKOGIENxsBBj5Mf8Wk9YWtaUSdcCPrzmtNitQOj6PwRAhTbcuHKI9OQ
         Zo96Bhn8QOg3bz2tPxiN78RE8gPsFnXoI25PbAp8gLY++pb/tlcXSzIZOec11qRjlXTp
         hEd4Lj/cE5Js4hyZxyG4lhABWBCEykuEyBsMvL7CfES39YTmhAjP+ot9E0I7iipnQNJr
         IgklExMkM/K8citMdGz1nNLUnTdeGBNsPsfYZhDlv0ZCTYCJAvSG9nJ5+hBl8cRLTHeT
         CRLg==
X-Gm-Message-State: AOAM532DhODMvHJxDuJXmID+PbU78jSR2qm2+MDSoAICS0kGlQNC2BZz
        d+Sjb1VWv5alic0IIXJlW7u9Ur0AfjSMR0qpO7w2Rw==
X-Google-Smtp-Source: ABdhPJwWQF+09U44Ufi/KK+EEkSTdayr1q1x5EshGka/prgVRRSDsa1rpvHpfaM9A7iFHIzx+S5vta3B1fjOlzVMVPI=
X-Received: by 2002:adf:aace:: with SMTP id i14mr11677841wrc.236.1598382349200;
 Tue, 25 Aug 2020 12:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
 <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
 <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
 <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com>
 <E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=@protonmail.com>
 <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com>
 <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com> <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
In-Reply-To: <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 25 Aug 2020 13:05:06 -0600
Message-ID: <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 1:22 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> > Seems like bool should take either yes, true, on, or 1. But I'm an odd
> > duck. Anyway! Glad it works.
>
> Ah, sorry, I didn't notice I changed true to on. It doesn't matter. The thing is, it should be "homectl update", and not during activation/authorization itself.
>
> > Next question is to find out why you have shared extents.
>
>     # filefrag -v /home/azymohliad.home | grep -m 10 shared
>
>     55082: 52756487..52756516:  291198215.. 291198244:     30:  291722503: shared
>     55083: 52756518..52756522:  291198246.. 291198250:      5:             shared
>     55084: 52756524..52756528:  291198252.. 291198256:      5:             shared
>     55085: 52756530..52756530:  291198258.. 291198258:      1:             shared
>     55086: 52756532..52756534:  291198260.. 291198262:      3:             shared
>     55087: 52756536..52756546:  291198264.. 291198274:     11:             shared
>     55088: 52756548..52756553:  291198276.. 291198281:      6:             shared
>     55089: 52756555..52756557:  291198283.. 291198285:      3:             shared
>     55090: 52756559..52756578:  291198287.. 291198306:     20:             shared
>     55091: 52756582..52756595:  291198310.. 291198323:     14:             shared
>
> And for all of these extents the output of "btrfs inspect-internal" is:
>
>     //home/azymohliad.home
>
> I call it on root / filesystem, e.g.:
>
>     # btrfs inspect-internal logical-resolve $[291198246 * 4096] /

Yeah but is / the top-level?

btrfs sub list -t /
mount | grep btrfs



-- 
Chris Murphy
