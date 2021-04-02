Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0123524F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 03:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhDBBKr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 1 Apr 2021 21:10:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32792 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBBKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 21:10:46 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C7D039F8B59; Thu,  1 Apr 2021 21:10:45 -0400 (EDT)
Date:   Thu, 1 Apr 2021 21:10:45 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Markus Schaaf <markuschaaf@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Any ideas what this warnings are about?
Message-ID: <20210402011045.GX32440@hungrycats.org>
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
 <20210331015827.GV32440@hungrycats.org>
 <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
 <CAJCQCtSKjcDuVprCq_kjaMrwgJ1QXq=8YaU9b8hok+sqYhvqxA@mail.gmail.com>
 <ccb7cae7-08d1-4499-a1c5-9c7ccd1722da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ccb7cae7-08d1-4499-a1c5-9c7ccd1722da@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 12:20:51PM +0200, Markus Schaaf wrote:
> Am 31.03.21 um 22:20 schrieb Chris Murphy:
> 
> > Flushoncommit is safe but noisy in dmesg, and can make things slow it
> > just depends on the workload. And discard=async is also considered
> > safe, though relatively new. The only way to know for sure is disable
> > it, and only it, run for some time period to establish "normative"
> > behavior, and then enable only this option and see if behavior changes
> > from the baseline
> > [...]
> 
> Thank you for your detailed explanation. I was trying flushoncommit for
> better crash consistency. But this was based on theory, not experience.

flushoncommit does give better crash consistency--I've been using it
for years for that reason.  I have to patch the kernel to silence the
warning though.

> BR
