Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2358C30E354
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBCTeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 3 Feb 2021 14:34:12 -0500
Received: from mail.eclipso.de ([217.69.254.104]:58718 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhBCTeB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 14:34:01 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 36FD3665
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Feb 2021 20:33:18 +0100 (CET)
Date:   Wed, 03 Feb 2021 20:33:18 +0100
MIME-Version: 1.0
Message-ID: <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs does,
                what's that called?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <Cedric.dewijs@eclipso.eu>
Cc:     <linux-btrfs@vger.kernel.org>
In-Reply-To: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
References: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--- Ursprüngliche Nachricht ---
Von: " " <Cedric.dewijs@eclipso.eu>
Datum: 03.02.2021 20:04:32
An: ", linux-btrfs" <linux-btrfs@vger.kernel.org>
Betreff: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs does,         what's that called?

­Hi All,

I am looking for a way to make a raid 1 of two SSD's, and to be able to detect
corrupted blocks, much like btrfs does that. I recall being told about a
month ago to use a specific piece of software for that, but i forgot to make
a note of it, and I can't find it anymore.

What's that called?

Cheers,
Cedric


Hi All,

it's called "dm-integrity", as mentioned in this e-mail:
https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg93037.html

Apologies for the noise,

Cheers,
Cedric



---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


