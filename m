Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C8C1569BF
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 10:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgBIJAh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 04:00:37 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:55923 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbgBIJAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 04:00:37 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id F3E10AF9AC;
        Sun,  9 Feb 2020 10:00:34 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times, watchdog evasion on 5.4.11
Date:   Sun, 09 Feb 2020 10:00:34 +0100
Message-ID: <2202848.tjv8jjdcNr@merkaba>
In-Reply-To: <20200209004307.GG13306@hungrycats.org>
References: <20200209004307.GG13306@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell - 09.02.20, 01:43:07 CET:
> Up to that point, a few processes have been blocked for up to 5 hours,
> but this is not unusual on a big filesystem given #1.  Usually
> processes that read the filesystem (e.g. calling lstat) are not
> blocked, unless they try to access a directory being modified by a
> process that is blocked. lstat() being blocked is unusual.

This is really funny, cause what you consider not being unusual, I'd 
consider a bug or at least a huge limitation.

But in a sense I never really got that processed can be stuck in 
uninterruptible sleep on Linux or Unix *at all*. Such a situation 
without giving a user at least the ability to end it by saying "I don't 
care about the data that process is to write, let me remove it already" 
for me is a major limitation to what appears to be kind of specific to 
the UNIX architecture or at least the way the Linux virtual memory 
manager is working.

That written I may be completely ignorant of something very important 
here and some may tell me it can't be any other way for this and that 
reason. Currently I still think it can.

And even if uninterruptible sleep can still happen cause it is really 
necessary, five hours is at least about five hours minus probably a minute 
or so too long.

Ciao,
-- 
Martin


