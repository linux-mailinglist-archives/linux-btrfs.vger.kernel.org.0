Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79AD245C9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHQGkr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 17 Aug 2020 02:40:47 -0400
Received: from rin.romanrm.net ([51.158.148.128]:48592 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgHQGkr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 02:40:47 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 04C50256;
        Mon, 17 Aug 2020 06:40:38 +0000 (UTC)
Date:   Mon, 17 Aug 2020 11:40:38 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, benjamin.haendel@gmx.net,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Tree-checker Issue / Corrupt FS after upgrade ?
Message-ID: <20200817114038.11b37d2f@natsu>
In-Reply-To: <CAJCQCtQo4yj=DSbH4JQZ0EiN5huXQwf1b7g0Bo826r53gSrWEg@mail.gmail.com>
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
        <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
        <000801d670fd$bb2f62d0$318e2870$@gmx.net>
        <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
        <000301d671b4$fc4a0650$f4de12f0$@gmx.net>
        <0839617b-8d4b-c252-1c74-4a3ff941ba6f@gmx.com>
        <003301d6726d$de5cbe30$9b163a90$@gmx.net>
        <13619e31-627f-92a7-6d11-1f8bbd6d7d6a@gmx.com>
        <CAJCQCtQo4yj=DSbH4JQZ0EiN5huXQwf1b7g0Bo826r53gSrWEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 16 Aug 2020 20:25:20 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> On Fri, Aug 14, 2020 at 5:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> > On 2020/8/15 上午3:05, benjamin.haendel@gmx.net wrote:
> 
> > > 1. I am missing some folders and files
> > > 2. Some folders are there but no files in them
> > > 3. i can only access the drive via the samba share - not on the server directly
> > > 4. In Windows it shows "28TB of usage" but when i mark all data and hit alt+enter it counts to 21.1 TB only
> >
> > Windows? Why it's related to Windows then?
> > We're talking about btrfs, right?
> >
> 
> Suggests the file system is being used with WinBtrfs.
> 
> https://github.com/maharmstone/btrfs

Or just accessed via network from a Windows client, as hinted in point #3
about a Samba share.

But as for why behavior described in point #3 would be the case, no idea, that
sounds like something that's not really possible.

One possibility though is that a file manager that the user runs on the server
itself bails on showing a directory listing entirely, if it has some incorrect
entries in it (those that show up as ???????????? in 'ls'), but the Windows
one doesn't, or Samba doesn't export those in the first place. I'd suggest
examining the drive content from console with "ls" and not via any graphical
or even text-based file manager.

-- 
With respect,
Roman
