Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2B40906B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbhIMNxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:53:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57008 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbhIMNvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:51:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 331041FD81;
        Mon, 13 Sep 2021 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631540983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g8T9uNCrZMw4SD+r1f2m3stotAsVUONMuaiPUsHCVaM=;
        b=MwOHmMHtncFBmMik8Qwfj+B7ww2x4upyWlmNnUei/NwKKm+SpPi/XrJXT8LpTj2OKqYSDc
        7f/llvTOSJmfsLGYDslpYSOMOJx0JMbMzzTzEcG4Vxi0U5/adxPa6BW4xSF/nefgAQPv5t
        XOOuihTn310oStD3L08qIuCnSTuOgDw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 048C713AB5;
        Mon, 13 Sep 2021 13:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8o9IOvZWP2HETgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:49:42 +0000
Subject: Re: [PATCH] btrfs: Make 233 be part of subvol group
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210913133226.39007-1-nborisov@suse.com>
 <CAL3q7H6rkvgboQKvcGiZgG-qzejg+vBiTK+xBejXkuQojpRVQw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6a0f544b-c82f-f446-a9e6-9c54b4c722a9@suse.com>
Date:   Mon, 13 Sep 2021 16:49:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6rkvgboQKvcGiZgG-qzejg+vBiTK+xBejXkuQojpRVQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.09.21 г. 16:40, Filipe Manana wrote:
> On Mon, Sep 13, 2021 at 2:35 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> All but this test use 'subvol' to designate they relate to btrfs
>> subvolume functionality. For the sake of consistency make btrfs/233
>> also be part of 'subvol' rather than 'subvolume'. This brings no
>> functional changes.
> 
> There's already a pending patch for this, which also fixes the same
> inconsistency for btrfs/245:
> 
> https://patchwork.kernel.org/project/fstests/patch/163062676513.1579659.12516104685003091290.stgit@magnolia/

Thanks, I have missed it. Since Darick's patch is fuller hopefully it
will be merged. So this one can be ignored.

> 
> Thanks.
> 
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  tests/btrfs/233 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/233 b/tests/btrfs/233
>> index f3e3762c6951..6a4144433073 100755
>> --- a/tests/btrfs/233
>> +++ b/tests/btrfs/233
>> @@ -9,7 +9,7 @@
>>  # performed.
>>  #
>>  . ./common/preamble
>> -_begin_fstest auto quick subvolume
>> +_begin_fstest auto quick subvol
>>
>>  # Override the default cleanup function.
>>  _cleanup()
>> --
>> 2.17.1
>>
> 
> 
