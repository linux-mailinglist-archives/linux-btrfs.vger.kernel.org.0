Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE838D49E
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 May 2021 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEVIyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 May 2021 04:54:24 -0400
Received: from mail.dubielvitrum.pl ([91.194.229.150]:55445 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230043AbhEVIyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 May 2021 04:54:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id A49129D5F2A;
        Sat, 22 May 2021 10:52:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6-OnGXzU14iW; Sat, 22 May 2021 10:52:55 +0200 (CEST)
Received: from [192.168.55.108] (93.159.186.235.studiowik.net.pl [93.159.186.235])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id AE4479D5F29;
        Sat, 22 May 2021 10:52:55 +0200 (CEST)
Subject: Re: Btrfs not using all devices in raid1
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
 <20210522020858.GB11733@hungrycats.org>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <588d379d-6d27-b9e1-1a3b-b4c62a073856@dubiel.pl>
Date:   Sat, 22 May 2021 10:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522020858.GB11733@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>> ### btrfs fi df /
>>
>> Data, RAID1: total=4.49TiB, used=2.90TiB
> There are about 1.5TB of available space in existing block groups, so
> those will be filled in first.  Block group allocations will start on
> sdc2 after the existing block groups are filled.

Ok! This is what I didn't know.
Now it's clear why Btrfs is not using /dev/sdc2 currently.
New blocks would be put on /dev/sdc2, but only after
currently allocated blocks got filled.




> Unfortunately balance is the only way to redistribute the existing data
> onto new drives, so if you don't want to run balance, then you'll just
> have to wait until sdc2 fills in naturally.

Your answer above solved my problem.
Thank you.

