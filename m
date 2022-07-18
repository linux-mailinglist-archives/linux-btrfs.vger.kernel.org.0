Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8A578104
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiGRLjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiGRLjK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 07:39:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86E64C9
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 04:38:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DF0933AEF;
        Mon, 18 Jul 2022 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658144338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+bTfyWlGEXRkhqEj9AnyJL1qks0Mqno0dfRXkdHBlI=;
        b=u+CPCwYBqPt5KtQyYDOmlulL6yL8ne4Jj6elCPVB7Ac+NlCoKwg/dKucUkfDgvCwkqwcyK
        79z8zJAtAkdz0M+0PwcoQQYq9lnIlwWFa69iy1Mp5sy5Tlrw0xwyV8qE/dSuOBWUniNURQ
        ZMpCcuIymK2qgargvJ29MZYnorQO3jU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4017C13754;
        Mon, 18 Jul 2022 11:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9tQADVJG1WK5bgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Jul 2022 11:38:58 +0000
Message-ID: <525a7b92-018f-a820-c04e-4d5cb0226623@suse.com>
Date:   Mon, 18 Jul 2022 14:38:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: btrfs device stats in table?
Content-Language: en-US
To:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org
References: <d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.07.22 г. 12:52 ч., waxhead wrote:
> I am not skilled enough to supply the patch , but would it be possible 
> for someone to please consider adding a table view for "btrfs device 
> stats /mnt" as the current output is rather "messy". Something easier to 
> read would be much appreciated.
> 
> 
> for example borrowing the output from btrfs fi us -T /mnt
> ---snip---
>               Data     Metadata System
> Id Path      RAID1    RAID1C4  RAID1C4  Unallocated
> -- --------- -------- -------- -------- -----------
>   5 /dev/sdh1  1.81TiB  4.00GiB        -     4.62GiB
> 10 /dev/sdf1  1.80TiB  7.00GiB        -     9.00GiB
> 11 /dev/sdi1  1.81TiB        -        -     9.29GiB
> ---snap---
> 
> 
> and perhaps adding a -T view for device stats as well for consistency...
> for example : btrfs de st -T /mnt to output something like...
> 
> ---snip---
>               I/O Errors
> Id F Path      write    read     flush    corrupt  generation
> -- - --------- -------- -------- -------- -------- ----------
>   5 * /dev/sdh1 1234567  7654321   13579     97531      24816
> 10 - /dev/sdf1       0        0       0         0          0
> 11 * /dev/sdi1       5        4       3         2          1
> ---snap---
> 


Test the patches I just sent out to the mailing list.
