Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAA4FD77
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfFWSJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 14:09:25 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:43524 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbfFWSJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 14:09:25 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 14:09:24 EDT
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id D73A867402B7
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 21:01:58 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jg9sccBA9F-1wdWruDJ;
        Sun, 23 Jun 2019 21:01:58 +0300
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id E0fIGDuZLe-1wxmCu21;
        Sun, 23 Jun 2019 21:01:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
To:     linux-btrfs@vger.kernel.org
From:   Valery Plotnikov <admin@tradelink.ru>
Subject: Per-entry or per-subvolume physical location settings
Message-ID: <2d428160-7e54-09ef-5ba6-9107732df54f@tradelink.ru>
Date:   Sun, 23 Jun 2019 21:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings!

When using btrfs with multiple devices in a "single" mode, is it
possible to force some files and directories onto one drive and some to
the other? Or at least specify "single" mode on a specific device for
some directories and "DUP" for some others.

The following scenario, if it is possible, would make btrfs even cooler
than bcachefs:

- Single mode, multiple devices - a HDD and a SSD
- Force system folders to be located on the SSD, or both - those have
little writes and need speed
- And still manage snapshots easily on one place, instead of two
top-level directories and a lot of symlinks!

Maybe it is at least possible to do it on a per-subvolume basis? This
would still be better than mounting subvolumes from different devices.


I remember reading somewhere in the early days of btrfs that the main
advantage on btrfs over LVM is that btrfs knows about your files, which
makes those things possible - even on a file structure level. However, I
could not find anything about it, while LVM allows per-volume physical
location settings, if I remember correctly.


-- 
Valery Plotnikov
