Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08B2002FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgFSHvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 03:51:31 -0400
Received: from len.romanrm.net ([91.121.86.59]:34768 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbgFSHvb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 03:51:31 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 03:51:30 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 0FE9B4009F;
        Fri, 19 Jun 2020 07:45:04 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:45:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Behavior after encountering bad block
Message-ID: <20200619124505.586f2b63@natsu>
In-Reply-To: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 19 Jun 2020 09:24:26 +0200
Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:

> I was testing btrfs to see data checksumming behavior when
> encountering a rotten area, so I set up a loop device backed by a 1GB
> file. I filled it with a compressed file and made it rot with, e.g.,
> 
> dd if=/dev/zero of=loopie bs=1k seek=800000 count=1
> 
> That is, the equivalent of having data on a single block on an actual
> hard drive go bad.

Not really, because when real on-disk sectors go bad, the (properly behaving)
drive will return I/O errors, not blocks of zeroes instead.

For a closer emulation of hardware bad sectors, check out dm-dust:
https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/dm-dust.html

Roman
