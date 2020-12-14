Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2392D9CF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 17:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439351AbgLNQvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgLNQvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 11:51:42 -0500
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3841C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 08:51:02 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b07ef82.dip0.t-ipconnect.de [91.7.239.130])
        by mail.itouring.de (Postfix) with ESMTPSA id BD0D61259CA;
        Mon, 14 Dec 2020 17:50:14 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 7846E77D48E;
        Mon, 14 Dec 2020 17:50:14 +0100 (CET)
Subject: Re: Odd filesystem issue, reading beyond device
To:     Ian Kumlien <ian.kumlien@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
Date:   Mon, 14 Dec 2020 17:50:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-12-14 17:28, Ian Kumlien wrote:
> Hi,
> 
> Upgraded from 5.9.6 to 5.10 and now I get this:
> [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3e33
> devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> [  589.602444] BTRFS info (device dm-0): use lzo compression, level 0
> [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> [  589.602465] BTRFS info (device dm-0): using free space tree
> [  589.602470] BTRFS info (device dm-0): has skinny extents
> [  589.603082] attempt to access beyond end of device
>                 dm-0: rw=4096, want=36461289632, limit=10971543296
> [  589.603108] attempt to access beyond end of device
>                 dm-0: rw=4096, want=36461355168, limit=10971543296
> [  589.603125] BTRFS error (device dm-0): failed to read chunk root
> [  589.603412] BTRFS error (device dm-0): open_ctree failed
> [  834.619193] BTRFS info (device dm-0): use lzo compression, level 0
> [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> [  834.619214] BTRFS info (device dm-0): using free space tree
> [  834.619219] BTRFS info (device dm-0): has skinny extents
> [  834.619825] attempt to access beyond end of device
>                 dm-0: rw=4096, want=36461289632, limit=10971543296
> [  834.619844] attempt to access beyond end of device
>                 dm-0: rw=4096, want=36461355168, limit=10971543296
> [  834.619858] BTRFS error (device dm-0): failed to read chunk root
> [  834.620205] BTRFS error (device dm-0): open_ctree failed
> 
> Any ideas?
> 

See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.org.uk/
+ followups. Nothing to do with btrfs.

-h
