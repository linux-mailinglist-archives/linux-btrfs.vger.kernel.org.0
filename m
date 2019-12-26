Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7E12AC5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLZN1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 08:27:08 -0500
Received: from naboo.endor.pl ([91.194.229.149]:56286 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLZN1I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 08:27:08 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Dec 2019 08:27:07 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 48F401A0EFE;
        Thu, 26 Dec 2019 14:17:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GyAC5jCvepZ3; Thu, 26 Dec 2019 14:17:15 +0100 (CET)
Received: from [192.168.1.16] (aaee101.neoplus.adsl.tpnet.pl [83.4.108.101])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 15A2A1A094D;
        Thu, 26 Dec 2019 14:17:15 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     linux-btrfs@vger.kernel.org
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
Date:   Thu, 26 Dec 2019 14:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Are you using qgroups?
>
> You can verify it by "btrfs qgroup show -pcre <mount>" to verify.
> Qgroup can hugely impact performance for balance, if using kernel older
> than v5.2.
>
> You can either disable qgroup, losing the ability to trace how many
> bytes are exclusively used by each subvolume, or upgrade to v5.2 kernel
> to solve it.
>

Not using qgroups.

root@wawel:~# btrfs qgroup show -pcre /
ERROR: can't list qgroups: quotas not enabled


Current data transfer speed is 2Mb/sek.

