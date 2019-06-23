Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1284F4FD7A
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfFWSP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 14:15:58 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:55113 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbfFWSP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 14:15:58 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 14:15:57 EDT
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 5DF003C009D8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 21:09:14 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZwwvwaL41h-9EMum7a0;
        Sun, 23 Jun 2019 21:09:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561313354;
        bh=W4m97D3ps5zs4aY0OHBx6czCBsbESqvkLVGfVlqRx2c=;
        h=To:Subject:From:Date:Message-ID;
        b=aGvVWlSmTYsS7Lya88GvbjKfs/Pz/x35CPNGsaqys6HvmKrPMbAophnzwujHNN82U
         dL+runL03WBvlG2ia6MbWoODY1cnu/+V8zUWdv68tBXr5GRYFHKDLqoU9jYscIo8xa
         jLoupfFlmlqG3HmdUi7KvP3pOTHsLirJcXuzP7lg=
Authentication-Results: mxback3g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0oaZUajvkg-9DB4HoEc;
        Sun, 23 Jun 2019 21:09:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dark Penguin <darkpenguin@yandex.ru>
Subject: Per-entry or per-subvolume physical location settings
To:     linux-btrfs@vger.kernel.org
Message-ID: <6e6152cc-da47-33cb-eb18-93d62d34ad44@yandex.ru>
Date:   Sun, 23 Jun 2019 21:09:13 +0300
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
darkpenguin
