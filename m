Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A21F2EAA3C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbhAELyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 06:54:14 -0500
Received: from rin.romanrm.net ([51.158.148.128]:60024 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhAELyN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 06:54:13 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 9B2D37A9;
        Tue,  5 Jan 2021 11:53:31 +0000 (UTC)
Date:   Tue, 5 Jan 2021 16:53:31 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Forza <forza@tnonline.net>, Cedric.dewijs@eclipso.eu,
        linux-btrfs@vger.kernel.org
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
Message-ID: <20210105165331.31aa8aee@natsu>
In-Reply-To: <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
        <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
        <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 5 Jan 2021 11:24:24 +0000
Graham Cobb <g.btrfs@cobb.uk.net> wrote:

> used that approach as the (old) NAS I was using had a very old linux
> version and didn't even run btrfs.

One anecdote --

I do use an old D-Link DNS-323 NAS with old kernel and distro (older Debian),
and only ~60 MB of RAM to serve a 8 TB disk or two. How does that even work?

Simple: it exports the disk(s) over the network as block devices via NBD, and
they are mounted remotely on a much more modern and powerful host.

A bit of a secret sauce surprisingly turned out to be the QEMU's NBD server
(qemu-nbd), it allows to set disk access modes inherited from QEMU itself, and
there with "--cache=none" the little thing doesn't choke (anymore) RAM-wise,
even with full jumbo-frames enabled on the network side.

(Other NBD servers were much less performant and/or reliable on the hardware).

Transfer speeds are around 17 MBytes/sec. That's on a Gbit LAN, and admittedly
running blockdevice-level access over a network does prefer to have a low ping
for good performance.

-- 
With respect,
Roman
