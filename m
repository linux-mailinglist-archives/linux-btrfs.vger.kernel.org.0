Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF03AD10A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFRRT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 13:19:58 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:33495 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhFRRT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 13:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1624036667;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=SX/6MdsVpjObawWHKhuBF6lJ8Jl3MPyENYYEzv7xS1A=;
        b=qFTjnxEt+Gx1dS4lPAkRcAc3D9CQFHMSCjTlp6ABsDJ9ZCx1Y808bs7E4x/Rl9XN
        rwZly90XjlTJmw1KaznSL+kcZhFM/niIUq9Gj1vLE0048YnGHoHvTrmf4R6hVu3TPwK
        xpXl2skn15MihGB3ajh1izBagVAZsLCYu88eb5Zk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1624036667;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=SX/6MdsVpjObawWHKhuBF6lJ8Jl3MPyENYYEzv7xS1A=;
        b=bTVnE1QA1l7fxCRT8/MKac0+MsdLqaIjgBtH+6+AUBfqz3+kF0XtY5Sy0zkQ63a+
        V9mxkFklQ8EwLgZKMFKJ2EhwoF/kN7JadIuR+b3X1S+DbT2i9XbrILe0T8D3FlGYEKR
        k395Fp+5wJrvKTop+SuFA1dj2NfCZbTenghx649s=
Subject: Re: IO failure without other (device) error
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <20210618212836.579f905a@natsu>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017a2020ed98-9f5819aa-4324-4ca5-9bf7-949e49ead98e-000000@eu-west-1.amazonses.com>
Date:   Fri, 18 Jun 2021 17:17:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210618212836.579f905a@natsu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.18-54.240.4.2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.06.2021 18:28 Roman Mamedov wrote:
> On Fri, 18 Jun 2021 16:18:40 +0000
> Martin Raiber <martin@urbackup.org> wrote:
>
>> On 10.05.2021 00:14 Martin Raiber wrote:
>>> I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:
>>>
>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>
>>> This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).
>> Just got it again (5.10.43). So I guess the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each location?
> Is this the complete 'dmesg'? Usually it would print a backtrace that could be
> useful for figuring out the reason.

Yes, that's why I included the systemd stuff... This is the newest one:

[86764.516395] systemd-journald[892771]: Received client request to flush runtime journal.
[182813.980004] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2735: errno=-5 IO failure
[182813.980059] BTRFS info (device dm-0): forced readonly
[182814.174438] BTRFS warning (device dm-0): Skipping commit of aborted transaction.

