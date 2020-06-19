Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8E20052E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgFSJcj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 19 Jun 2020 05:32:39 -0400
Received: from len.romanrm.net ([91.121.86.59]:38498 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731949AbgFSJbu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 05:31:50 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 601744009F;
        Fri, 19 Jun 2020 09:31:48 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:31:48 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Behavior after encountering bad block
Message-ID: <20200619143148.1ec669e9@natsu>
In-Reply-To: <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
        <20200619124505.586f2b63@natsu>
        <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 19 Jun 2020 10:08:43 +0200
Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:

> Well, that's why I wrote having the *data* go bad, not the drive

But data going bad wouldn't pass unnoticed like that (with reads resulting in
bad data), since drives have end-to-end CRC checking, including on-disk and
through the SATA interface. If data on-disk is somehow corrupted, that will be
a CRC failure on read, and still an I/O error for the host.

I only heard of some bad SSDs (SiliconMotion-based) returning corrupted data
as if nothing happened, and only when their flash lifespan is close to
depletion.

> even though either scenario should still effectively end up yielding the
> same behavior from btrfs

I believe that's also an assumption you'd want to test, if you want to be
through in verifying its behavior on failures or corruptions. And anyways it's
better to set up a scenario which is as close as possible to ones you'd get in
real-life.

> But check out my retraction reply from earlier — it was just me being stupid
> and forgetting to use conv=notrunc on my dd command used to damage the
> loopback file :)

Sure, I only commented on the part where it still made sense. :)

-- 
With respect,
Roman
