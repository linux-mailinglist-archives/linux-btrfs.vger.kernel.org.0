Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCCD24EF53
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgHWSt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 14:49:57 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:13564 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWSt4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 14:49:56 -0400
Date:   Sun, 23 Aug 2020 18:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598208594;
        bh=g9S8koKAZ9E9mmOfOSezoiT8yNytBSX1DCedq83epzE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=N4maPwg9b7HVJsu4YbqoO/lK/BRtK9p54rz87M9nRjUaonLWmxIGiniPWXYwawMS4
         Ep9t45LyyvswK4W9C1/fwp5a6rGtUreq0jjRTI5p0Y1VJedxRPvUy5JmHa/TcVZFlm
         4/azJwwUO82WwCchU7NWnwIq9kYtvKFLEyE+Xkao=
To:     Andrei Borzenkov <arvidjaar@gmail.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <3xjSaoCYmgmmVfKzqhR5ooUYdWPlI4R8fjh_4E0UuVCYRP9lPzoPszrseqXvxd6pAZY4xdmIBRuX_KLcn5U19G3VwVlK59FydVvDGulRvKY=@protonmail.com>
In-Reply-To: <db0c267c-5b8f-067b-673c-8f59002ee48e@gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <20200823153746.GB1093@savella.carfax.org.uk> <251eb1e3-0fcd-eb22-72b9-8ab2f2a5e962@gmail.com> <uE-fvxC5rW1snQPXRetWASSP8a8cJVSTiDa1WNLmtVANT-M_cd6NUZxUlUtLBID2-EBEEJjP0yK7-Knt9-vjWob1dU6H9FE2Dhg0Y1XFOx4=@protonmail.com> <db0c267c-5b8f-067b-673c-8f59002ee48e@gmail.com>
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

> Output of "btrfs fi us /" before and after fallocate would probably give
> more information. Also "btrfs sub li /" and "btrfs qgroup show -re /"
> would be interesting. And "btrfs fi du /home/azymohliad.home".

Collected the outputs of all those commands here (in order of execution): h=
ttps://gitlab.com/-/snippets/2007189

