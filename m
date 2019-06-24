Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991B051F1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfFXX3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 19:29:36 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:36852 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFXX3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 19:29:36 -0400
Received: from tux.wizards.de (pD9EBFA35.dip0.t-ipconnect.de [217.235.250.53])
        by mail02.iobjects.de (Postfix) with ESMTPSA id EB1784164D31;
        Tue, 25 Jun 2019 01:29:34 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 8B5FDEEB522;
        Tue, 25 Jun 2019 01:29:34 +0200 (CEST)
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't
 allow"
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <CAJCQCtR3azJyM40P0AyHSAp=uWxchN+R=LR5BxCuzdxQ5_JcbA@mail.gmail.com>
 <CAJCQCtSN5EO5K3T3K0hkzGPX0sXVL_HiL7V-W_aW5kE_1jjfEw@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <4d34f586-6045-0fea-e1a0-0b0c4253fb3f@applied-asynchrony.com>
Date:   Tue, 25 Jun 2019 01:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSN5EO5K3T3K0hkzGPX0sXVL_HiL7V-W_aW5kE_1jjfEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/25/19 12:46 AM, Chris Murphy wrote:
> Same call trace on ro mount and ro scrub with 5.2.0-rc2+, but also an
> additional call trace related to zstd. As this is a zstd compressed
> file system, it might be related.
> 
> [  366.319583] ================================
> [  366.325036] WARNING: inconsistent lock state
> [  366.330615] 5.2.0-0.rc2.git1.2.fc31.x86_64 #1 Tainted: G        W
> [  366.336202] --------------------------------
> [  366.341788] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  366.347423] swapper/4/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [  366.353042] 000000006070e818 (&(&wsm.lock)->rlock){+.?.}, at:
> zstd_reclaim_timer_fn+0x26/0x170 [btrfs]

Seeing that this is apparently *rc2* (which is insane to ship) the explanation
for the above is that 5.2-rc2 was tagged on 2019-05-26, but the patch for the
above problem [1] was committed *after* that, on 2019-05-28.

That may or may not explain the reason for the original error and its
corruption, but whatever you're doing, stop running that kernel..

-h

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fee13fe96529523a709d1fff487f14a5e0d56d34
