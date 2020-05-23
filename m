Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE61DF848
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 May 2020 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgEWQm1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 May 2020 12:42:27 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:35899
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgEWQm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 May 2020 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:to:from:date:from;
        bh=5GdLK1zsFPU64p2k72Fg045K1miZ0ab+a2TfT/7AO3k=;
        b=BJKX5aRBC4gaLzJCjUNUVIm6fZGaL1tnBsQpm4B78X80P7Doxh3se2WXg1NC/kKSp121wLLYFxRol
         nDzZoRrlCLcKwtygp/zAePjgq4BWoGUPj3F47yK6TbvCLx4Sd24s1qJLzG4V1IoA2F1wKji9LoQfk2
         jBXZLjjN/lNXQtGI9XJ0V4stfSEBIaV5agDY2Ei5BXNdfIrbiDdgK4gqs3lqpm+wQscRW62Nlq30xk
         FY9u5E7d0Uj84aXwkfTNeKg0Gd3YUfPZa75FoRtUfVTu1yqd+FQTPFaoXWLpqACWJrFU224rmaZi1x
         3HVvcydtuoI2lLXb3OHtJzhKFbY2psQ==
X-HalOne-Cookie: 7503e6c6f2607ee34a3939924d9e79eb3e802ab8
X-HalOne-ID: 6154d6e9-9d14-11ea-8054-d0431ea8bb03
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 6154d6e9-9d14-11ea-8054-d0431ea8bb03;
        Sat, 23 May 2020 16:42:24 +0000 (UTC)
Date:   Sat, 23 May 2020 18:42:27 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <62395bb.90271dad.172426a118f@lechevalier.se>
In-Reply-To: <CAHzMYBRMqYK4tX5eqoO95=OwZb=uqzWrUE8ngvA1rO2_gqf+Dg@mail.gmail.com>
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com> <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com> <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com> <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com> <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com> <CAJCQCtT=rStKTwUc86FyAp8C0D8eoRvgKHWYC3+e=fLJxJNUZA@mail.gmail.com> <CAJCQCtT6zXdNOeTh1YTrWwji_QtK00hhiAP96ysrHdeg-DU3bw@mail.gmail.com> <CAHzMYBRMqYK4tX5eqoO95=OwZb=uqzWrUE8ngvA1rO2_gqf+Dg@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Jorge Bastos <jorge.mrbastos@gmail.com> -- Sent: 2020-05-23 - 18=
:11 ----

> Hi there,
>=20
> I'm also having much lower than normal send/receive performance since
> upgrading to kernel 5.6 (currently kernel 5.6.13 - btrfs-progs 5.6),
> there's also a very high CPU utilization during it, anything that can
> be done for now?
>=20
> Regards,
> Jorge Bastos


One possibility is to add "mbuffer" in the pipeline. It is async compared t=
o "pv". This helps quite a bit on spinning HDD's.=20

# btrfs send /some/subvol | mbuffer | btrfs receive /other/destination

PS. There was a possibility of a bug in <=3Dmbuffer-20150412 so don't use t=
hese old versions.=20

