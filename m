Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B094B44F213
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhKMHwN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 02:52:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57000 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhKMHwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 02:52:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7078121988;
        Sat, 13 Nov 2021 07:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636789752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ov6UjYjwYXvDuXCzf0wIIbPppOEmRfHSkMezqP/bcWA=;
        b=uC6xXdJFPz7cxqcKvA2XCBTQMrNYxDyNBV6OPmjRj3rUI5aK7aMj6hb4ko1WvXoSWze5jQ
        xPQoiqiGEiaToF42ktMvbRUYomwSHwDcSLdAaI0ANULhAiHU6B6n0fztdOy08nkY5anXaX
        urlZ0g5dt/hlXXiesqL37w9D8hJj06E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A1EA13BAA;
        Sat, 13 Nov 2021 07:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZcYTC/htj2FYCwAAMHmgww
        (envelope-from <nborisov@suse.com>); Sat, 13 Nov 2021 07:49:12 +0000
Subject: Re: [PATCH] btrfs-progs: fix discard support check
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211113031408.17521-1-wangyugui@e16-tech.com>
 <19cde2a1-d17d-d8cf-2539-c1d79b32e376@gmx.com>
 <20211113150444.C372.409509F4@e16-tech.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4c355518-8f0b-63a1-1c97-dbb0d73d249e@suse.com>
Date:   Sat, 13 Nov 2021 09:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211113150444.C372.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.11.21 г. 9:04, Wang Yugui wrote:
> Hi,
> 
>> On 2021/11/13 11:14, Wang Yugui wrote:
>>> [BUG]
>>> mkfs.btrfs(v5.15) output a message even if the disk is a HDD without
>>> TRIM/DISCARD support.
>>>    Performing full device TRIM /dev/sdc2 (326.03GiB) ...
>>>
>>> [CAUSE]
>>> mkfs.btrfs check TRIM/DISCARD support through the content of
>>> queue/discard_granularity, but compare it against a wrong value.
>>>
>>> When hdd without TRIM/DISCARD support, the content of
>>> queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.
>>
>> Can we get rid of such bad comparison and just go strtoll() and compare
>> the value?
> 
> strtoll() or strcmp() is a good choice for refact.  but now just a
> direct fix.

NACK,

Use one of the conversion functions to convert the string to a number
and do a != 0 comparison. atoi() would be sufficient and deals with
whitespace/trailing \n character gracefully. I think it's high time we
ditch the "let's do a quick and dirty fix" mentality which leads to
unmaintainable gunk in the long-term as it tends to rarely get fixed
afterwards.

<snip>
