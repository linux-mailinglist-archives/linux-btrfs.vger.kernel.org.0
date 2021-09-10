Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4954068F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhIJJUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 05:20:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhIJJUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 05:20:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54F7222425;
        Fri, 10 Sep 2021 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631265532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jI6a5o5DwXXW/j4/OfRx92ZYN5SJRPWKgarju8PVH60=;
        b=kxj/Oe4tiVmEwzzBybODWlASZ9nPiwrOwuM6Ohe1MwEokeFFF4uOHtFzi0LJDfLc4AXeeS
        /mLGje82hhTZ3mp9yE37lqYUzD4qnl5xAj2AuSARQTs/ru2UJe4Piic+8Z1roi+GVYt3ev
        bx5T0L80e5LDURSkYFZwM5okSxv6GoU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E58013D26;
        Fri, 10 Sep 2021 09:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TmfWCPwiO2F1bgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 09:18:52 +0000
Subject: Re: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210910083344.1876661-1-nborisov@suse.com>
 <PH0PR04MB7416EA5BCA3624D86F2701A29BD69@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b983789e-3671-a5f3-1803-37b8992261b4@suse.com>
Date:   Fri, 10 Sep 2021 12:18:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416EA5BCA3624D86F2701A29BD69@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.21 г. 12:15, Johannes Thumshirn wrote:
> 2021 10:33, Nikolay Borisov wrote:
>> Currently when a device is missing for a mounted filesystem the output
>> that is produced is unhelpful:
>>
>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>> 	Total devices 2 FS bytes used 128.00KiB
>> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>> 	*** Some devices missing
>>
>> While the context which prints this is perfectly capable of showing
>> which device exactly is missing, like so:
>>
>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>> 	Total devices 2 FS bytes used 128.00KiB
>> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>> 	devid    2 size 0 used 0 path /dev/loop1 MISSING
>>
>> This is a lot more usable output as it presents the user with the id
>> of the missing device and its path.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> but I think this also needs a patch for xfstests adjusting the filters.
> 

It does, I had sent one, but I need to send v2 to adjust for the removed
***, ah this bike shedding ...
