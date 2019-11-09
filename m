Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B01F5DA1
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 07:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKIGAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 01:00:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbfKIGAW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 01:00:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B64CAFDF;
        Sat,  9 Nov 2019 06:00:21 +0000 (UTC)
Subject: Re: [next-20191108] Assertion failure in
 space-info.c:btrfs_update_space_info()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
 <3579f352-038a-08a7-30b8-f4935cf55f2c@gmx.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Message-ID: <4392ccbc-85a1-10fa-bc7c-db19a4e9f86a@suse.de>
Date:   Sat, 9 Nov 2019 07:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3579f352-038a-08a7-30b8-f4935cf55f2c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Wenruo,

Am 09.11.19 um 05:01 schrieb Qu Wenruo:
> On 2019/11/9 上午11:45, Andreas Färber wrote:
>> On arm64 I'm seeing a regression between next-20191031 and next-20191105
>> that breaks boot from my btrfs rootfs: next-20191105 and later oopses on
>> found->lock, or with CONFIG_BTRFS_ASSERT asserts on a NULL "found"
>> variable in btrfs_update_space_info().
>>
>> According to git-blame that code hasn't changed in months, and I didn't
>> spot an obvious cause among the fs/btrfs/ commis between those two tags.
> It looks like caused by "btrfs: block-group: Refactor
> btrfs_read_block_groups()".

Thanks for the quick pointer - I've reverted all fs/btrfs/ commits down
to that one and it was indeed the culprit.

> Due to another refactor, there are conflicts in that patch and is not
> resolved properly.
> 
> Please try David's latest misc-next branch, which includes the proper
> rebased refactor.

Unfortunately that won't work as I'm developing some 100+ patches for my
linux-realtek.git, so I'll have to carry the reverts until the fix makes
it into linux-next.git.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
