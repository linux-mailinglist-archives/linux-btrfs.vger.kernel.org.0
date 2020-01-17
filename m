Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C970E140C64
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAQOYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:24:31 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:59686 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAQOYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:24:31 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 4931F9C3F4; Fri, 17 Jan 2020 14:24:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579271069;
        bh=Tzm/8wKfUSLd6PfrrjH+IyzsPpHU07dgfVVTCq2AqmQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=q6OOAC6dUIk+XWd9uo38pBtXS9jPsOYQojkakUYbcCguU0KnqCZfbIjWSB3Mp8ouB
         ryv0FteAI+/OOoqqYQfOHZ7rD/EGzRSTNolGquuG5dPuzYo4msFIbXJcgdZU3S0o6N
         7dQxJmUOauKGd0MrNL1ODSO1S7ZeSwR35B/Ixh/ANsJ8iFGPGo3vzcIR16/8TnteHp
         2m5SEbvk8FZ3o8OHlkBI3AzphcSuu3e9lbWQSxRFuFXkchooK1I1RpQ9xBSvLPSiTE
         ATPV7atOgIJ8ZliM8LiDgR1pTlcvm5BLFtueq+R8IZ+F79RwBLfQXFlaJ6oPWLlF7r
         KppQMtDTEGPgQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D69B69C358;
        Fri, 17 Jan 2020 14:24:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579271061;
        bh=Tzm/8wKfUSLd6PfrrjH+IyzsPpHU07dgfVVTCq2AqmQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=g+HhALjPX30wijyva/NQx/OVNK9bn3hO8Urjgt+olGEJtGCz7fOPMjtEyan+Lmk1i
         SddAAuD1Upt90OUt0qMqSEdwZP8WyrdnbYRoFuTWiZGl1Yocc2IJyHMbanty8CiP2e
         fJCRjpkWKyLUARkUD5k5oWgYEZA92quPgfnkDKsKh2jkdIB3HNSZvJ8v0bw0/7Dz4j
         +q5D1/rMNvzPCdRmIhuHJJULViSPAsHX3QnlxYJ7BW9Djh9yUmrYGCkqaVcPbAly1M
         vTjiMCm0SD0PgEXlp/+9TQgUsKSreRZItngvqN1CFcvHMWwu1lUn+/FT4EEUvX65e0
         NL6g0N/tKrFmA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 8DF52AD8F5;
        Fri, 17 Jan 2020 14:24:21 +0000 (GMT)
Subject: Re: [PATCH] Btrfs: always copy scrub arguments back to user space
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200116112920.30400-1-fdmanana@kernel.org>
 <20200116141233.GW3929@twin.jikos.cz>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <56eaf838-a439-30a1-e47a-f2e41c14d1fe@cobb.uk.net>
Date:   Fri, 17 Jan 2020 14:24:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116141233.GW3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/01/2020 14:12, David Sterba wrote:
> On Thu, Jan 16, 2020 at 11:29:20AM +0000, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> If scrub returns an error we are not copying back the scrub arguments
>> structure to user space. This prevents user space to know how much progress
>> scrub has done if an error happened - this includes -ECANCELED which is
>> returned when users ask for scrub to stop. A particular use case, which is
>> used in btrfs-progs, is to resume scrub after it is canceled, in that case
>> it relies on checking the progress from the scrub arguments structure and
>> then use that progress in a call to resume scrub.
>>
>> So fix this by always copying the scrub arguments structure to user space,
>> overwriting the value returned to user space with -EFAULT only if copying
>> the structure failed to let user space know that either that copying did
>> not happen, and therefore the structure is stale, or it happened partially
>> and the structure is probably not valid and corrupt due to the partial
>> copy.
>>
>> Reported-by: Graham Cobb <g.btrfs@cobb.uk.net>
>> Link: https://lore.kernel.org/linux-btrfs/d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net/
>> Fixes: 06fe39ab15a6a4 ("Btrfs: do not overwrite scrub error with fault error in scrub ioctl")
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Added to 5.5-rc queue, thanks.

Just to let you know... As promised I have built a Debian Testing kernel
(5.3) with this patch applied. My btrfs-scrub-slowly script has now run
successfully to completion with 32 cancel/resume cycles (runs for 30
mins then takes 10 min break).

If it is useful, feel free to add:

Tested-by: Graham Cobb <g.btrfs@cobb.uk.net>

Thanks Felipe!


