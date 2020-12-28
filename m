Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B072E69D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Dec 2020 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgL1RoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 12:44:03 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:40962 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728622AbgL1RoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 12:44:02 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 8587C199;
        Mon, 28 Dec 2020 18:43:20 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609177400;
        bh=soPBeGkz/Ys7pwhBPapR00aNY8QbliaV+OrSyWIXqWA=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=t8Q9ACLhVzn3C5qWtZsmvDaLCvXXZiEX8D/ZFMvHyEI08iWZd2mY9LW2W1Nynb03S
         D2U7SGIIuMEWKs1xSzOzWdcW/AWs04/1GI3AW4H1g+a9Z6wtIyATkMxm1kvbUZnIPb
         fSkal6rXWifG7cvsZKfX1VcGZWF0ZmuLJzmIXy6I=
MIME-Version: 1.0
Date:   Mon, 28 Dec 2020 17:43:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
Subject: Re: 5.6-5.10 balance regression?
To:     "Qu Wenruo" <wqu@suse.com>, "David Arendt" <admin@prnet.org>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
References: <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> unfortunately the problem is no longer reproducible, probably due to=
=0A>> writes happening in meantime. If you still want a btrfs-image, I ca=
n=0A>> create one (unfortunately only without data as there is confidenti=
al=0A>> data in it), but as the problem is currently no longer reproducib=
le, I=0A>> think it probably won't help.=0A> =0A> That's fine, at least y=
ou get your fs back to normal.=0A> =0A> I tried several small balance loc=
ally, not reproduced, thus I guess it=0A> may be related to certain tree =
layout.=0A> =0A> Anyway, I'll wait for another small enough and reproduci=
ble report.=0A=0AThis is still reproducible on my FS, and I have the btrf=
s-image.=0AI can easily upload it somewhere, but of course I understand d=
ownloading=0Aan image of 51G can be impractical.=0A=0AAn other way might =
be: as I know which block group is causing the problem,=0Aas per the dmes=
g, maybe I can dump only the part of the metadata relevant=0Ato this bloc=
k group?=0A=0AIn any case I can run commands on this system, compile a cu=
stom btrfs-progs=0Aor a custom kernel with whatever you want me to try, a=
nd reboot as many times=0Aas necessary (this is not a production server).=
=0A=0AI know it fails in relocate_block_group(), which returns -2, I'm cu=
rrently=0Aadding a couple printk's here and there to try to pinpoint that=
 better.=0A=0ARegards,=0A=0ASt=C3=A9phane.
