Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE844FA2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhKNTiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 14:38:06 -0500
Received: from mail.mailmag.net ([5.135.159.181]:37830 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhKNTiC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 14:38:02 -0500
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 93493EC5AC2;
        Sun, 14 Nov 2021 10:35:02 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1636918503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hgs+AWiGP3k2fZfv4JHL5tOzj2rlkNmk4HUsgvuVIUA=;
        b=SNB+1aqkT0voL2k4rOfaVgH4yo5X2h8hcXNAWAeYbBV61LZ9Ozo+w+AINbnEcOmuUYT9VM
        NfX2mj/4ubTb6qGCG9LvEgtLKtbHVNo/8YwSYcjjpdbs7Nr2fk6jD1b8NuVPy9y+eIxR9F
        /A0D+HAspS8yuU3wkVcpozUI3HwyJ0k=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joshua Villwock <joshua@mailmag.net>
Mime-Version: 1.0
Subject: Re: Large BTRFS array suddenly says 53TiB Free, usage inconsistent
Date:   Sun, 14 Nov 2021 11:34:58 -0800
Message-Id: <17249A9D-D368-4978-BB66-930EC8FE30AC@mailmag.net>
References: <77924dab-1bc9-ce56-056f-da795998365c@applied-asynchrony.com>
Cc:     =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <77924dab-1bc9-ce56-056f-da795998365c@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1636918503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hgs+AWiGP3k2fZfv4JHL5tOzj2rlkNmk4HUsgvuVIUA=;
        b=sfcPT7LYqVvreVcDAOuBQA5+gp6tFCffkRic1WmY/AuJrWYLmlhQCVk4QkgI9Y1w6zlm8s
        QTuspUlQTonWWPecJnnAdBZU/MoUwm9KN6jnYg32JasfIvNmtFhZ8VobsAZigmkJ+cNuQ2
        qg4iZKIJYaGwDmzlh3nnx0LIKxDOM3E=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1636918503; a=rsa-sha256; cv=none;
        b=uF+Nx9VMy6F2XWn6TAvyv2qB6pMV7DoF4OYk3zKFKHq92Bm8P9wETB7Eip5JFjl2hLlzLh
        L3l12NOM+76E6l1ZEDFGwOe6rr2Gzefo8Fk5BSk+sEaVr9EnTSFDmZw+F25VRmS3/+gjJo
        QdAxvOy6Tyej7N2JNb+Osw16/HJ4+eM=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> On Nov 14, 2021, at 11:16 AM, Holger Hoffst=C3=A4tte <holger@applied-async=
hrony.com> wrote:
>=20
> =EF=BB=BFOn 2021-11-14 19:45, Max Splieth=C3=B6ver wrote:
>> Hello everyone. I observed the exact same behavior on my 2x4TB RAID1.
>> After an update of my server that runs a btrfs RAID1 as data storage
>> (root fs runs on different, non-btrfs disks) and running `sudo btrfs
>> filesystem usage /tank`, I realized that the "Data ratio" and
>> "Metadata ratio" had dropped from 2.00 (before upgrade) to 1.00 and
>> that the Unallocated space on both drives jumped from ~550GB to
>> 2.10TB. I sporadically checked the files and everything seems to be
>> still there.
>> I would appreciate any help with explaining what happened and how to
>> possibly fix this issue. Below I provided some information. If
>> further outputs are required, please let me know.
>> ```
>> $ btrfs --version
>> btrfs-progs v5.15
>  ---------------^^
>=20
> https://github.com/kdave/btrfs-progs/issues/422
>=20
> Try to revert progs to 5.14.x.
>=20
> cheers
> Holger

I can also report that I am on btrfs-progs v5.15 as well.

I can also confirm that btrfs-progs was updated precisely when the issue beg=
an happening.

Thanks, I will test reverting later, and maybe provide more details on the g=
ithub issue if that makes sense.

=E2=80=94Joshua Villwock=
