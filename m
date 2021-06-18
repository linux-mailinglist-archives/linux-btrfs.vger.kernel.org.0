Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C073AD062
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhFRQau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 12:30:50 -0400
Received: from rin.romanrm.net ([51.158.148.128]:45902 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhFRQau (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 12:30:50 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id CCAC56A0;
        Fri, 18 Jun 2021 16:28:36 +0000 (UTC)
Date:   Fri, 18 Jun 2021 21:28:36 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: IO failure without other (device) error
Message-ID: <20210618212836.579f905a@natsu>
In-Reply-To: <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
        <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 18 Jun 2021 16:18:40 +0000
Martin Raiber <martin@urbackup.org> wrote:

> On 10.05.2021 00:14 Martin Raiber wrote:
> > I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:
> >
> > [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
> > [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
> > [2260628.156980] BTRFS info (device dm-0): forced readonly
> >
> > This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).
> 
> Just got it again (5.10.43). So I guess the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each location?

Is this the complete 'dmesg'? Usually it would print a backtrace that could be
useful for figuring out the reason.

-- 
With respect,
Roman
