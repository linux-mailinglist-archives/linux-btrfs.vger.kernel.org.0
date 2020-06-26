Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DED20BAC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZU4k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 16:56:40 -0400
Received: from rin.romanrm.net ([51.158.148.128]:54864 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZU4j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 16:56:39 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 16:56:39 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 913583F8;
        Fri, 26 Jun 2020 20:49:12 +0000 (UTC)
Date:   Sat, 27 Jun 2020 01:49:12 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Message-ID: <20200627014912.262647f2@natsu>
In-Reply-To: <5bf091c5-b769-b865-c1ab-4437565961d3@georgianit.com>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
        <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
        <20200621235202.GA16871@tik.uni-stuttgart.de>
        <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
        <20200622000611.GB16871@tik.uni-stuttgart.de>
        <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
        <20200622140234.GA4512@tik.uni-stuttgart.de>
        <20200622142319.GG27795@twin.jikos.cz>
        <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
        <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
        <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
        <5bf091c5-b769-b865-c1ab-4437565961d3@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 26 Jun 2020 16:18:03 -0400
Remi Gauvin <remi@georgianit.com> wrote:

> I'm probably just confusing the terminology... But could this be related
> to the queued trim problems with Samsung for which they should be
> blakclisted?
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/libata-core.c?id=9a9324d3969678d44b330e1230ad2c8ae67acf81

A Samsung 860 SSD that I have is the worst (compared to a dozen non-Samsung
ones) when it comes to TRIM, NCQ, combination thereof, and compatibility with
various SATA controllers.

However it should be noted that while the commit referenced is not in the
mainline kernel anymore, a narrower blacklist applying to 840 and 850 models
currently is [1]. And as the report is about the 850 Pro, queued TRIM should
not have been the cause, as is already blacklisted in kernel for all "Samsung
SSD 850". Can check in 'dmesg' for a note about it shortly after the SSD
detection to confirm.

[1]
https://github.com/torvalds/linux/blob/master/drivers/ata/libata-core.c#L3952

-- 
With respect,
Roman
