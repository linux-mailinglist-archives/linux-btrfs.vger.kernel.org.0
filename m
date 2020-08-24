Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2924F313
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXHZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 03:25:23 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:38966 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHXHZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 03:25:22 -0400
Date:   Mon, 24 Aug 2020 07:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598253920;
        bh=eXl5ZxL66ONoo+ZU99ERqQRzOPI4OPayNzBZY9cNzUM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IvLk1TKbW6+rJ6zeA5z/ZUXwmDEr9MTlGZCjXaDxrEKX//sMAyVmneokK7tBnWaKi
         tethGUFob3tp5bAyONO8bnE3ohS+gh7M/LaKwRlmepLwM9q6RABNZqXqRgD4Nl6qV9
         jGYrae4o+F5HEwUVligdrNdktysPkQqPnljH54g8=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com>
In-Reply-To: <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com> <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com> <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
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

> Are you using snapper or timeshift?

No


> Have you used 'cp' to duplicate the home backing file?

The /home/azymohliad.home file itself - no


> What do you get for
>
> lsattr /home/azymohliad.home

    ---------------C---- /home/azymohliad.home


> I think we've got a pretty good idea what's going on. The current work
> around in your case will be to use the --luks-discard=3Dtrue option when
> activating.

Thanks! I'm gonna finish reading this http://asalor.blogspot.com/2011/08/tr=
im-dm-crypt-problems.html
to have a better idea what discard implies, and then will try it out.

