Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CC25130C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgHYHWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 03:22:12 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:21129 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbgHYHWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 03:22:10 -0400
X-Greylist: delayed 90607 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 03:22:09 EDT
Date:   Tue, 25 Aug 2020 07:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598340127;
        bh=Ry0/F9XzTVOXkghEYpiUW2Q+X5IckgjPzonjL/Lu2JU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DHrqb3UOkdxtHtN6t8QHUIi3+NZtIeV3H6ooJL+7Tw3QNlACJsFSlLKPMurYCgHFW
         2lpatF4kNx1Ouj23UKh/fZvR0dg1v1Q/gbg0JeHE7gzHqTkBPwPH7jkG07I7CP49ob
         SLAZfOEE+qIAon95iGqMy0c3V4fiLD7epGEZpd6o=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
In-Reply-To: <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com> <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com> <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com> <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com> <E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=@protonmail.com> <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com> <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Seems like bool should take either yes, true, on, or 1. But I'm an odd
> duck. Anyway! Glad it works.

Ah, sorry, I didn't notice I changed true to on. It doesn't matter. The thi=
ng is, it should be "homectl update", and not during activation/authorizati=
on itself.

> Next question is to find out why you have shared extents.

    # filefrag -v /home/azymohliad.home | grep -m 10 shared

    55082: 52756487..52756516:  291198215.. 291198244:     30:  291722503: =
shared
    55083: 52756518..52756522:  291198246.. 291198250:      5:             =
shared
    55084: 52756524..52756528:  291198252.. 291198256:      5:             =
shared
    55085: 52756530..52756530:  291198258.. 291198258:      1:             =
shared
    55086: 52756532..52756534:  291198260.. 291198262:      3:             =
shared
    55087: 52756536..52756546:  291198264.. 291198274:     11:             =
shared
    55088: 52756548..52756553:  291198276.. 291198281:      6:             =
shared
    55089: 52756555..52756557:  291198283.. 291198285:      3:             =
shared
    55090: 52756559..52756578:  291198287.. 291198306:     20:             =
shared
    55091: 52756582..52756595:  291198310.. 291198323:     14:             =
shared

And for all of these extents the output of "btrfs inspect-internal" is:

    //home/azymohliad.home

I call it on root / filesystem, e.g.:

    # btrfs inspect-internal logical-resolve $[291198246 * 4096] /


