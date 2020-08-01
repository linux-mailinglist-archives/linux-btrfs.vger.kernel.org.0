Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0E235157
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHAJFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 05:05:54 -0400
Received: from rin.romanrm.net ([51.158.148.128]:55214 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgHAJFy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 05:05:54 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 57FBD40F;
        Sat,  1 Aug 2020 09:05:52 +0000 (UTC)
Date:   Sat, 1 Aug 2020 14:05:51 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Eric Wong <e@80x24.org>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: raid1 with several old drives and a big new one
Message-ID: <20200801140551.76348735@natsu>
In-Reply-To: <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
References: <20200731001652.GA28434@dcvr>
        <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 30 Jul 2020 20:57:38 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> On Thu, Jul 30, 2020 at 6:16 PM Eric Wong <e@80x24.org> wrote:
> >
> > Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> > a way I can ensure one raid1 copy of the data stays on the new
> > 6TB HDD?
> 
> Yes. Use mdadm --level=linear --raid-devices=2 to concatenate the two
> 2TB drives.

Or go with a RAID0 for this, to get a nice performance benefit as well. It is
a bad idea in any case to hope for any data recoverability from a half-failed
linear "array".

-- 
With respect,
Roman
