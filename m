Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1C252223
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHYUr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 16:47:57 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:56333 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 16:47:56 -0400
Date:   Tue, 25 Aug 2020 20:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598388473;
        bh=ASt66SyNUpZ8CiUTRmU8UKOFwWgRYyznqpZOeqMi3EM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=o8p45YTQePhbZ2eZtfvvu4ViknU0/SEWzL0v5urNOKANRMfCsncRVYkVM0urjCHFS
         r87NtgEZ6bp7G2LqfdDCi6GgEVZIq/PodKwZF3yNVOiiFNDW+XeJDEXTIQdbV4KkU/
         +7cwrx1VkMMN+jraJU6niIxS0AbXi5Vmw7e35ohg=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
In-Reply-To: <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
References: =?us-ascii?Q?<bdJVxLiFr=5FPyQSXRUbZJfFW=5FjAjsGgoMetqPHJMbg-hdy54Xt=5FZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=3D@protonmail.com>_<CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh=5FyAKtnX-Z1-nXSVjBW7w@mail.gmail.com>_<Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F=5FEa6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=3D@protonmail.com>_<CAJCQCtSqe=5FoqRZWYP7iLJcGQnzZkC4vmoYVTm=5F9RPb8eb0-E6Q@mail.gmail.com>_<BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk=5FEfbkl02s31niRqtCS67WJ9S7=5Fs4jiK9afeA=3D@protonmail.com>_<E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=3D@protonmail.com>_<lyGE8gPEf9cUEMJceWoJWD=5Fibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=3D@protonmail.com>_<CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=3DNnoGHmRKPnaQ+P7yyg@mail.gmail.com>_<8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1=5FNPonyU=3D?=
 =?us-ascii?Q?@protonmail.com>_<CAJCQCtQH3h=3DNNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>?=
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

> Yeah but is / the top-level?
>
> btrfs sub list -t /

ID=09gen=09top level=09path
--=09---=09---------=09----
258=0994017=095=09=09var/lib/portables
259=0994017=095=09=09var/lib/machines

> mount | grep btrfs

/dev/nvme0n1p2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=3D5,su=
bvol=3D/)
/dev/mapper/home-azymohliad on /home/azymohliad type btrfs (rw,nosuid,nodev=
,relatime,ssd,discard,noacl,space_cache,subvolid=3D5,subvol=3D/)



