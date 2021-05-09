Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4E3778F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEIWPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 May 2021 18:15:21 -0400
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:57357
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhEIWPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 May 2021 18:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1620598456;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=MVYa2GdNJnrxIeD2ohLibsdzrBneSyPcQsle31uoWgQ=;
        b=XscQBNbJjRzXxMNV+dB4n35rJgvfa963pGa9tmlgHUMCjyFTMEupQD2uFD1WZv4L
        6YHMHMTJsptiOXLbRUl3NE4HzLXvN4dDGtMteXrwFHh440YEPcyeCc9DWBJcsufvX5j
        IAqQDA//9XAE09yWQrp0OkjqbBo3gslDMMVS8bqQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1620598456;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=MVYa2GdNJnrxIeD2ohLibsdzrBneSyPcQsle31uoWgQ=;
        b=Ow6u5UxXdtzG2qcVEZ8g0LNXcCccF79qN+aNuy0JYgp1EEB8YEAq6sCdwe8qy1TL
        3uvS24XHkhMgJxjxoz3E/w6Syr+3ODBJoyrI/zMNMtwt+Nbu83gdExd7yqAMxefV1/j
        pWNsgPKT/E2nfgbAQTxxvR4GAq+OSVjXOzcoHSmo=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Subject: IO failure without other (device) error
Message-ID: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
Date:   Sun, 9 May 2021 22:14:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.05.09-54.240.4.15
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:

[1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
[2260628.156980] BTRFS info (device dm-0): forced readonly

This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).

Regards,
Martin Raiber

