Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF721348E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgAHRNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 12:13:19 -0500
Received: from mail.mailmag.net ([5.135.159.181]:36564 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHRNT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 12:13:19 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 12:13:19 EST
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 5B72EEC02AF;
        Wed,  8 Jan 2020 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1578503276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GtZQoxZkox3X1DhbIYuFLvz2QhnAxSeufIwpyl9cVI=;
        b=AXvlOEnKysXwmT9DaYREsqtZRC23DWKxH8XZkt8FntvKaiuvX9Mz9NZz2MCQwZskUG/CMg
        7AIql+IRRhYqmS0hE+zHnEKip6ZqH8uxHu6sJqbLoFqYfOWR4Ej+/mLtC3UFjf3SA29Kxl
        ZeXm0ZhN/WFEQzBALxoTMnMTpMB34Z8=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0
Subject: Re: How long should a btrfs scrub with RAID5/6 take?
From:   Joshua <joshua@mailmag.net>
In-Reply-To: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
Date:   Wed, 8 Jan 2020 09:07:47 -0800
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F28464EB-75E4-4ECB-BEFB-078186706776@mailmag.net>
References: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
To:     Robert Krig <robert.krig@render-wahnsinn.de>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1578503276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GtZQoxZkox3X1DhbIYuFLvz2QhnAxSeufIwpyl9cVI=;
        b=pxaMPnafkAhqzeyz1UJtYUj9657SiC14dcwxee3usQPMZ/PhWyl8sJSoju57Kg7CGbNYpS
        nT5W35RwbclbZYDgF9lT6pxvtckuRp/aXeUcbD2Rx+/7hpV7rzXUREfRmU4d/nKGlw5cfk
        /h+QNttgswxR/zNGpMhF3Uui8ghSz1Y=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1578503276; a=rsa-sha256; cv=none;
        b=SZL0gbzWWCfykMwzGHRrITIhOtVSziK1ylmK68gT073Poa0amrczNqfhthzkpGZUgC9G41
        SPaOe1BzvXuIoyy1FsMU9PAr5wx7o08xzQLE/X/zRMzbc90tkMYeyo5eXaJV6DK6IiZQsi
        xNiyAkzkzHMy83A5cjicjm7IOR0z4r8=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I do not have a direct answer to your question, but I can chime in on your s=
crub times:

I have 4x8TB, 4x10TB, and 8x3TB drives, all in one huge BTRFS =E2=80=98RAID1=
=E2=80=99.

I can tell you that even in my setup, scrubs usually take less than a day.  S=
o unless it=E2=80=99s the raid5 making yours take so long, that does not sou=
nd typical.

> On Jan 8, 2020, at 2:13 AM, Robert Krig <robert.krig@render-wahnsinn.de> w=
rote:
>=20
> Hi, I've got a server where I have 4x8TB Disks in a BTRFS RAID5
> (metadata and systemdata as RAID1) configuration.
>=20
> It's just a backup server with data I can always recreate.=20
> This server is in the bedroom, so I send it to sleep/suspend when I go
> to bed and then wake it up in the morning.=20
>=20
> Since a scrub takes days on such a setup, I issue a btrfs scrub resume
> whenever the server wakes up again.
>=20
> btrfs scrub status shows me that the total data to scrub is 18.67TB,
> but it's already scrubbed 36.60TB. Is there any way I can calculate how
> much more data is going to be scrubbed? 4x8TB is 32TB, so we're passed
> that, but I'm guessing this also has to do with parity data as well.
>=20
