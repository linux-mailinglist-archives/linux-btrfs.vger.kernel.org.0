Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A081253013
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgHZNkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 09:40:33 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:22203 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbgHZNkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 09:40:31 -0400
Date:   Wed, 26 Aug 2020 13:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598449228;
        bh=wq+PDZm0o6w9+pJZTKM/1FVmIh7Ku3xSz/IpyeQUwFk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pGcvpD2OfpUvNVp0ponHsoj7zEx1znNMhXH72dtSLum3jY1Cg9ZxhZXkLcQm7Tt7U
         oWWyjT/6eD8aRv3A5XmS4X+vG7lF2kn6SqeKnmAMloaaLvWLESfAUGVG838RyfjXrt
         CxE0jVIpOWasjljAP6k1Oknp7Iar8bBVn917OgdQ=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
In-Reply-To: <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
References: =?us-ascii?Q?<bdJVxLiFr=5FPyQSXRUbZJfFW=5FjAjsGgoMetqPHJMbg-hdy54Xt=5FZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=3D@protonmail.com>_<BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk=5FEfbkl02s31niRqtCS67WJ9S7=5Fs4jiK9afeA=3D@protonmail.com>_<E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=3D@protonmail.com>_<lyGE8gPEf9cUEMJceWoJWD=5Fibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=3D@protonmail.com>_<CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=3DNnoGHmRKPnaQ+P7yyg@mail.gmail.com>_<8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1=5FNPonyU=3D@protonmail.com>_<CAJCQCtQH3h=3DNNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>_<6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz=5FugNFmmRtzN33BlSa5pCvds0F8=3D@protonmail.com>_<CAJCQCtQDt=3Dx7WCX7KhWz=5FpPn4yB1YdZm9jN29jRuQDFy=3DZTO?=
 =?us-ascii?Q?jA@mail.gmail.com>_<emBWetDIaC=5FTYsBRNRlPcz-yLjIOxlhIBny=5FK9bTqHxLO=5FkdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ=5FCfZOrTH0=3D@protonmail.com>?=
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

Interestingly, I have much less shared extents now:

    # filefrag -v /home/azymohliad.home | grep shared | wc -l
    1679

It was over 18k the first time you asked me to check it (even before I enab=
led discard in homectl).
