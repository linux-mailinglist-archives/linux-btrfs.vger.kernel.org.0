Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31B407CF8
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhILLD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 07:03:26 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:56371 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILLDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 07:03:25 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id B069B210237; Sun, 12 Sep 2021 12:46:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631443584;
        bh=vk6TK1EUGj10DCmJSYw2/5QWUhgrPRQxnvs9r/DwIFI=;
        h=To:Subject:Date:From:In-Reply-To:References:From;
        b=YUQoC81QfgMc4eDQvqW+pzm5yS8brNBC43RBP24nk96I8Ul0tCVe0FNz8AYXIdYJi
         YHvpC4h2g5ZM97yDj1oE/XEGTb+58iz6RElzmQn7UYWNM2Ed9K19qmrrBM6s584t+5
         UKLH4KDeiX0JFw7dVep10PI+4Rum51F3hcYKVB1o=
To:     linux-btrfs@vger.kernel.org
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 12 Sep 2021 06:46:24 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
In-Reply-To: <a38098d2c2cf96c367707635791b06f9@linuxsystems.it>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <a38098d2c2cf96c367707635791b06f9@linuxsystems.it>
Message-ID: <5b83677221e203dca518234bfd3c47ad@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-12 06:44 Niccolò Belli ha scritto:
> Il 2021-09-12 06:27 Niccolò Belli ha scritto:
>> I did manage to recover some data with btrfs restore (no idea how much 
>> of it):
>> 
>> $ sudo btrfs restore /dev/nvme0n1p6
>> /run/media/liveuser/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6_restore/
>> Skipping snapshot snapshot
>> [...lots of snapper snapshots]
>> Skipping snapshot root
> 
> I just noticed it completely skipped to restore my root subvolume.
> Maybe because it was originally restored from a snapshot (during a
> previous btrfs corruption issue) and so somehow it thinks it's still a
> snapshot?
> How can I restore it? I cannot afford to restore all the snapshots, I
> don't have enough free space to do so.

Even better would be to restore a snapper snapshot of my root subvolume 
(that way it would be less likely to be corrupted).
