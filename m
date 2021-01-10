Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE02F073A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 13:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAJMjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 10 Jan 2021 07:39:08 -0500
Received: from mail.eclipso.de ([217.69.254.104]:59052 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJMjH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 07:39:07 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 4C74405D
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 13:38:26 +0100 (CET)
Date:   Sun, 10 Jan 2021 13:38:26 +0100
MIME-Version: 1.0
Message-ID: <f1151bac14674472000b788fdcfe0d53@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: btrfs send / receive via netcat, fails halfway?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     "Roman Mamedov" <rm@romanrm.net>
Cc:     <linux-btrfs@vger.kernel.org>
In-Reply-To: <20210110163705.1852c4a7@natsu>
References: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
        <20210110163705.1852c4a7@natsu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



It is a common annoyance that NC doesn't exit in such scenario and needs
to be
Ctrl-C'ed after verifying that the transfer is over.

Instead, at host2 try:

  ssh host1 "btrfs send ..." | btrfs receive ...

Also much more secure.

-- 
With respect,
Roman

I was practicing on a test system, the real transfer was supposed to be between two systems on a LAN. I didn't want encryption, as my system then only is capable of sending 30MB/sec, instead of the 110MB/sec over the 1GB network.


---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


