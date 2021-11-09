Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AC44A6E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 07:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbhKIGit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 01:38:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57742 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKIGis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 01:38:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6098221B06;
        Tue,  9 Nov 2021 06:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636439762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEs6VGj0xdradDro0f+36+g/vV0PWXt8m7Px5gncWNM=;
        b=b846Uyb2J2zZICBDuxHRACzLW8BiPfk9CnWtywUrbRMw7LlkaVHRT6spLGSlxHbEjmRfcM
        nkNhiItDkQLuAHSD1ZE539mB3v6Jw8p0g9FNKno0k6b9IhtgIm4cX/oZlIwMivcYhbUgiy
        635Rx7aeva/oqJTTJjtXjR5PIxmIbQc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A5B13AB5;
        Tue,  9 Nov 2021 06:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHFYCdIWimFDBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 09 Nov 2021 06:36:02 +0000
Subject: Re: [PATCH v4 2/4] btrfs: expose chunk size in sysfs.
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-3-shr@fb.com>
 <1b9cde85-a7ee-42f9-f7ed-49169757e86a@suse.com>
 <aabdab98-f712-8345-decc-c83e84f009c2@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <39cfdac6-d02a-88b1-6ed6-0c02b3dbc208@suse.com>
Date:   Tue, 9 Nov 2021 08:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <aabdab98-f712-8345-decc-c83e84f009c2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 3:57, Stefan Roesch wrote:
> 
> 

<snip>

>> I wonder if we need to enforce some sort of alignment i.e 128/256m
>> otherwise we give the user to give all kinds of funky byte sizes?
>>
>> <snip>
>>
> 
> That makes sense. As the default size is 256M. I propose the following:
> - Sizes smaller than 256M are not allowed.
> - Sizes are aligned on 256M boundary otherwise.

Sounds good.



