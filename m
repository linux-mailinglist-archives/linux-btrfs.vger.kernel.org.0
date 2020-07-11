Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917C21C651
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGKVIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 17:08:44 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:53629
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgGKVIo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 17:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:to:from:date:from;
        bh=P3m/SemiAXwRcRbRE/9Z3vhwjRfUFbr+U1J6kiJ/dcI=;
        b=THnt9nuVBfeG4F+WurF6kr2NIy8erveoCmFgp9vQsXLMZ8K3VufqG8tZrBtKLglAunmUems3pPmWt
         l0IT7C6uyjlpeZaOdhn3rXB95qdAljncUd/TWMtkke+W4kBFYvlnpfwEy6NW/MyD4A4Z+U3wRrG/02
         x3aC5hEAAi7YR8RLowJ/c5Y514tquvbGWzYNdA4JLT9Ta8/d6IXQpvayzPKJ10GmyStG8n2BSxXrPu
         WnUxzRCbaFJoR0lLzWMCQiOF8kCugbgsD+zE7Gk8zX6N5xwIPW1GOR/mu2nX14I3IC9z1TodBTQ9CA
         D2KuPxBSfdVnNe9c+iTX0xNvvUSaPQg==
X-HalOne-Cookie: e738cb5a21bf2eb2ea1c6043b708f60d10f3556d
X-HalOne-ID: b23f1fca-c3ba-11ea-8888-d0431ea8a290
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b23f1fca-c3ba-11ea-8888-d0431ea8a290;
        Sat, 11 Jul 2020 21:08:41 +0000 (UTC)
Date:   Sat, 11 Jul 2020 23:08:39 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Peter Foley <pefoley2@pefoley.com>, linux-btrfs@vger.kernel.org
Message-ID: <798d01f.397441d9.1733fb56693@lechevalier.se>
In-Reply-To: <5bc91ff8-1764-203d-53e1-a691b1b5abf9@pefoley.com>
References: <5bc91ff8-1764-203d-53e1-a691b1b5abf9@pefoley.com>
Subject: Re: balance failing with ENOENT
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Peter Foley <pefoley2@pefoley.com> -- Sent: 2020-07-11 - 21:39 -=
---

> Hi,
> I've got a btrfs filesystem that started out using the single profile.
> I'm trying to convert it to raid1, but got a strange error when doing so.
> Note that this only started happening after the initial balance got cance=
led part-way through.
>=20
> btrfs balance start -dconvert=3Draid1,profiles=3Dsingle /
> ERROR: error during balancing '/': No such file or directory
> There may be more info in syslog - try dmesg | tail
>=20

You can try "btrfs balance start -dconvert=3Draid1,soft /"=20

'soft' avoids balancing chunks that are already in the target profile. *

* https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-balance#FILTERS=20



