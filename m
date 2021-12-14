Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0B474774
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 17:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhLNQS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 11:18:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNQS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 11:18:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 125FF1F383;
        Tue, 14 Dec 2021 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639498707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLE1KCNxTEzxJuRmbnAqV8zkZ2sTe+pOiBlQLiQhAvM=;
        b=s4vNCkLKEtHr6HzpKbweDhxN2jH9G3oU0ngW1tNPhts7cmAk/R5+/iLrKLVQjI7ksT/dRX
        2p1DaZe42Fbg49QzELLU47TkIJ07SvrTZCsptbPJO6SZjRP5S4VOtz45KCPdM6wtSs2VdM
        BZVnaihdLjuYB6L/+fCPAgpfbWniwvQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC5FE13CE9;
        Tue, 14 Dec 2021 16:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hlXILtLDuGHgfQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Dec 2021 16:18:26 +0000
Subject: Re: [PATCH] btrfs: Refactor unlock_up
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211214133939.751395-1-nborisov@suse.com>
 <YbiuGuFdSM/BWHzk@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0ecf0600-9768-d8d4-b79a-bc997a28f36f@suse.com>
Date:   Tue, 14 Dec 2021 18:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbiuGuFdSM/BWHzk@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.12.21 г. 16:45, Josef Bacik wrote:
> On Tue, Dec 14, 2021 at 03:39:39PM +0200, Nikolay Borisov wrote:
>> The purpose of this function is to unlock all nodes in a btrfs path
>> which are above 'lowest_unlock' and whose slot used is different than 0.
>> As such it used slightly awkward structure of 'if' as well as somewhat
>> cryptic "no_skip" control variable which denotes whether we should
>> check the current level of skipiability or no.
>>
>> This patch does the following (cosmetic) refactorings:
>>
>> * Renames 'no_skip' to 'check_skip' and makes it a boolean. This
>> variable controls whether we are below the lowest_unlock/skip_level
>> levels.
>>
>> * Consolidates the 2 conditions which warrant checking whether the
>> current level should be skipped under 1 common if (check_skip) branch,
>> this increase indentation level but is not critical.
>>
>> * Consolidates the 'skip_level < i && i >= lowest_unlock' and
>> 'i >= lowest_unlock && i > skip_level' condition into a common branch
>> since those are identical.
>>
>> * Eliminates the local extent_buffer variable as in this case it doesn't
>> bring anything to function readability.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> This was weirdly difficult to review in both diff and vimdiff, had to look at
> the resulting code to see how it worked out.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Yeah, sorry about that but the function has a bunch of IF's ... I could
have probably broken it into 3 patches but each separate refactoring is
really small.

> 
> Thanks,
> 
> Josef
> 
