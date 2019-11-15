Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DCFD21A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKOAvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 19:51:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:39904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfKOAvY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 19:51:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 662EDAC5B;
        Fri, 15 Nov 2019 00:51:23 +0000 (UTC)
Subject: Re: [next-20191108] Assertion failure in
 space-info.c:btrfs_update_space_info()
To:     dsterba@suse.cz
References: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
 <3579f352-038a-08a7-30b8-f4935cf55f2c@gmx.com>
 <4392ccbc-85a1-10fa-bc7c-db19a4e9f86a@suse.de>
 <20191111182146.GS3001@twin.jikos.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <cf6d57b0-c64c-7039-ecdd-f45d0ae98a96@suse.de>
Date:   Fri, 15 Nov 2019 01:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111182146.GS3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 11.11.19 um 19:21 schrieb David Sterba:
> On Sat, Nov 09, 2019 at 07:00:20AM +0100, Andreas Färber wrote:
>> Am 09.11.19 um 05:01 schrieb Qu Wenruo:
>>> On 2019/11/9 上午11:45, Andreas Färber wrote:
>>>> On arm64 I'm seeing a regression between next-20191031 and next-20191105
>>>> that breaks boot from my btrfs rootfs: next-20191105 and later oopses on
>>>> found->lock, or with CONFIG_BTRFS_ASSERT asserts on a NULL "found"
>>>> variable in btrfs_update_space_info().
>>> It looks like caused by "btrfs: block-group: Refactor
>>> btrfs_read_block_groups()".
> Fixed branch for linux-next will be pushed today, sorry for the
> inconvenience.

Confirming that next-20191113 worked again, allowing me to drop reverts.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
