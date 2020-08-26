Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D552537D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHZTHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZTHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 15:07:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82914C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 12:07:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so2939429wro.3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSFi06gUWtXD5qBJuvwr//h8l99fbmilz0UjnHoArsw=;
        b=jVjTAbE4wwPPWiesbYD5dThpXAc+0BgFwe/tODAQ2oKKSbCwuDb+iE0jAleUb1couZ
         9+EUWOiyvFFXm4sy0OHHxRkBxfclzQClZ8TW3Y3D39gQJYF69mecgYLIO+HZiqcjahkT
         xZfLYx30/EZThQJj+lY5V/hm7my1vcgpO4E5G22WbscjUG0PR81R+TjWcsvyyOSPHWdN
         VkiT+ieqEsIibldaVhamdTtC+hkAaF4UpZLsehVRu4exJgWMCRTCZ0KF5/jA3Ey+4Pdj
         vSE2Uhk3+hWVH2EvheU49hsXRm/awW1Vlgc0dg1x1DYYG/PynzorsIF1gmh0ZbA2ST5T
         RLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSFi06gUWtXD5qBJuvwr//h8l99fbmilz0UjnHoArsw=;
        b=hq6mY0TD+oCztLF+Jip1K1tuVe5l0K9yjYw/qx0wpE8VncCCFHCv2+z/hANAUrwXol
         sJGb97Eb7PrxvCQKZ4VqhKzyTm9MyJiJmCmI8iGyZZl7QZBzzrQw7dUy85g619bwCZni
         emQhYCtKluyV22M+RVz/DmP5cKMf+G5MifTYmkWblmGSzY42YPlKo/AZhLiCuIaTgsyx
         JXytXfZuFWNz7AJZDthOvNp6QKP5ytY/Eiw5GHCzN7GwPjXEj1KFNK2pr2n8t1JM9vqN
         6XEBTyP1/WZSPwVVDP01mgOyZNTerKAKcns94UzjL9QUMLn/Nuoo6Zhyn4JmOgBJJ4TY
         89UQ==
X-Gm-Message-State: AOAM533S0R9tOrAxFqR7u+fkviPmef7KdALSNEhdFAG3t/vc6Hp0rWZN
        c/kz8487Ew1ZwK8BhmYk3vhcbUqT19kBT2sT//u64w==
X-Google-Smtp-Source: ABdhPJw8LZrnVSxp6426qCIlPhkbLEgDYqMFGr47M+Ci18HlyMPw4CohNHcqJFkZU3XobkOuB2/0ywzrTn2Fp75vqpM=
X-Received: by 2002:adf:8401:: with SMTP id 1mr16567035wrf.274.1598468830262;
 Wed, 26 Aug 2020 12:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com>
 <E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=@protonmail.com>
 <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com>
 <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
 <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
 <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
 <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
 <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
In-Reply-To: <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 13:06:25 -0600
Message-ID: <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 7:40 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> Interestingly, I have much less shared extents now:
>
>     # filefrag -v /home/azymohliad.home | grep shared | wc -l
>     1679
>
> It was over 18k the first time you asked me to check it (even before I enabled discard in homectl).

OK so Josef found a bug. Filefrag is showing shared extents in certain
cases when there are none. So you can stop worrying there's some copy
of the file somewhere. And stop looking for it.
https://github.com/btrfs/btrfs-todo/issues/6

The fallocate problem is still real, and that might take some time for
Andrei or someone else to figure out why.


-- 
Chris Murphy
