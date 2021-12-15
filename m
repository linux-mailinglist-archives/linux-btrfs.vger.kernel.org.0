Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391F47556B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 10:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhLOJse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 04:48:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42060 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhLOJse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 04:48:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EC09212C5;
        Wed, 15 Dec 2021 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639561713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cSSQJ1rNr7DgN9C3m0/iSj/YZiaWILzdfiVp2t1hSQ=;
        b=mtMFvfxpp0ktYtn/nXThPl9oQoqsmlk4XlXzQfLP6ifrMS3fjPiYyRFgBgXdrhks2cpruM
        T6HlYkl3qTi2USZS3vuKm/k9oOs5Md0DdHzJyGKhUqySDqlBCAG1iWU/wQ2oqAwumEpHjY
        CJjkoA03iTnniJN4Iadol7RjwGPrx08=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0501813B09;
        Wed, 15 Dec 2021 09:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mf0TOvC5uWGYXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Dec 2021 09:48:32 +0000
Subject: Re: Btrfs lockups on ubuntu with bees
To:     =?UTF-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
 <20211209044438.GO17148@hungrycats.org>
 <6b1f34700075ef5256800edfe2c486fee36902d6.camel@bcom.cz>
 <YbfOXO3ZPEXLB397@hungrycats.org>
 <340ab9b906fd1b1e4fe2f0329c6be85a9958e661.camel@bcom.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f6b25f1a-f90c-98c4-6d07-bd76b38572c6@suse.com>
Date:   Wed, 15 Dec 2021 11:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <340ab9b906fd1b1e4fe2f0329c6be85a9958e661.camel@bcom.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 11:42, Libor Klepáč wrote:
> 
> On Po, 2021-12-13 at 17:51 -0500, Zygo Blaxell wrote:
>> On Thu, Dec 09, 2021 at 09:23:53AM +0000, Libor Klepáč wrote:
>>> Hi,
>>> thanks for looking into it.
>>> More bellow
>>>  ......
>>> Lockup happened also at second customer, where we tried to use this
>>> solution.
>>> Good news is, that when we stop bees, it does not happen again and
>>> btrfs scrub says, that all data are ok.
>>> Bad news is, we will run out of disk space soon ;)
>>
>> Downgrading to 5.10.82 seems to work around the issue (probably also
>> .83 and .84 too, but we have more testing hours on .82).
>>
> Ok, thanks for info. I will try, if we can run this machine with debian
> kernel from stable - 5.10.x
> 
>>> Are you interested in trace from kernel? I saved it, but i don't
>>> know,
>>> if it's the same as before.
>>
>> Sure.
> 
> Here it is 
> https://download.bcom.cz/btrfs/trace5.txt

That's the same issue that Zygo has reported, care to also perform the
steps I outlined in the following email:

https://lore.kernel.org/linux-btrfs/c6125582-a1dc-1114-8211-48437dbf4976@suse.com/T/#m79e9da87b8ec15c40999999d3ffc348f271fbf33

> 
>>
>>> Thanks,
>>> Libor
>>>
>>>
>>>>>
