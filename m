Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218F52343E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgGaKG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:06:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38298 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbgGaKG3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:06:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C1E4A1F5AE;
        Fri, 31 Jul 2020 10:06:28 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:06:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Alberto Bursi <bobafetthotmail@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid1 with several old drives and a big new one
Message-ID: <20200731100628.GA18568@dcvr>
References: <20200731001652.GA28434@dcvr>
 <6d29319f-301e-c1d2-9674-b39619356ae7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d29319f-301e-c1d2-9674-b39619356ae7@gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Alberto Bursi <bobafetthotmail@gmail.com> wrote:
> On 31/07/20 02:16, Eric Wong wrote:
> > Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> > a way I can ensure one raid1 copy of the data stays on the new
> > 6TB HDD?
> > 
> > I expect the 2TB HDDs to fail sooner than the 6TB HDD given
> > their age (>5 years).
> > 
> 
> I'm not sure what is the problem, ok maybe the drives are old and are more
> likely to fail, but why would more than one drive fail at once?

Why wouldn't they?  Otherwise there'd be no reason for RAID6 to
exist over RAID5.  Recovery puts more stress on the remaining
drives and increases the likelyhood of another drive in a pool
failing.  I've seen HW RAID5 arrays lost like like this in a
previous life (I didn't manage to convince the other sysadmins
to use RAID6 :<).
