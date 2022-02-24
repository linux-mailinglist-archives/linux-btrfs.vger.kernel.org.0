Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7384C3690
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 21:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiBXUJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 15:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiBXUJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 15:09:41 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5925A33C;
        Thu, 24 Feb 2022 12:09:10 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 41C6680054;
        Thu, 24 Feb 2022 15:09:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1645733349; bh=5IgLcIBl4ewGZXN7xM8bD2gcQkHoEkdSW6EarFjjkAo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kZIXYAzMGFUiWndbXVy703UHFFLKdgKxNyj+qKi5tt8fvye4qLJbZDZjVPqh0xxVY
         MStcQK7LPPaxjpDaufHqu1hJaTENREUNwtYL5FyPeY9LjT7iBQX8zu8J5++nhWzorV
         El4EP34llbag3tqUAktdhy2J9vo67jIbx58pcUPx9ldNdIrfIlJa6pudFvrbwfSPKK
         SXA1Niv3bd6bDQrh7pMxCYGShppxKHJtL3JjkV60FDvRjT6uGc4yp2IhPjkQlRNPpS
         N8VOKGP5lnszRg7TRqWOrI0yNgjiPqDF83Ju+zClCyzv3R65Ro0r+t79r9luAlcBZh
         qPKHLyBsKf31Q==
Message-ID: <20f14d85-6a07-e66d-4711-c16c6930c2a3@dorminy.me>
Date:   Thu, 24 Feb 2022 15:09:08 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v4] btrfs: add fs state details to error messages.
Content-Language: en-US
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
 <20220224132210.GS12643@twin.jikos.cz>
 <284ccc08-8de7-9188-19d8-20f4eda56cb4@dorminy.me>
 <20220224184231.GZ12643@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220224184231.GZ12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> All the other interactions with info->fs_state are test/set/clear_bit,
>> which treat the argument as volatile and are therefore safe to do from
>> multiple threads. Without the READ_ONCE (reading it as a volatile),
>> the compiler or cpu could turn the reads of info->fs_state in
>> for_each_set_bit() into writes of random stuff into info->fs_state,
>> potentially clearing the state bits or filling them with garbage.
> I'm not sure I'm missing something, but I find the above hard to
> believe. Concurrent access to a variable from multiple threads may not
> produce consistent results, but random writes should not happen when
> we're just reading.

Maybe I've been reading too many articles about the things compilers are 
technically allowed to do. But as per the following link, the C standard 
does permit compilers inventing writes except to atomics and volatiles: 
https://lwn.net/Articles/793253/#Invented%20Stores

>
>> Even if this is right, it'd be rare, but it would be exceeding weird
>> for a message to be logged listing an error and then future messages
>> be logged without any such state, or with a random collection of
>> garbage states.
> How would that happen? The volatile keyword is only a compiler hint not
> to do optimizations on the variable, what actually happens on the CPU
> level depends if the instruction is locked or not, so different threads
> may read different bits.
> You seem to imply that once a variable is not used with volatile
> semantics, even just for read, the result could lead to random writes
> because it's otherwise undefined.

Pretty much; once a variable is read without READ_ONCE, it's unsafe to 
write a new value on another thread that depends on the old value. 
Imagine a compiler which invents stores; then if you are both reading 
and setting a variable 'a' on different threads, the following could happen:

thread 1 (reads)       thread 2 (modifies)

reads a into tmp

stores junk into a

                                 reads junk from a

stores tmp into a

                                 writes junk | 2 to a


Now a contains junk indefinitely.


But if it's too theoretical, I'm happy to drop it and amend my paranoia 
level.


(Thanks for fixing the !CONFIG_PRINTK warning that btrfs_state_to_string 
was unused; sorry I missed it.)


Sweet Tea

