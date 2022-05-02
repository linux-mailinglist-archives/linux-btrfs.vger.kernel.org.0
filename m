Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53032516B2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiEBHYT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbiEBHYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 03:24:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61ABC22
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 00:20:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57686210ED;
        Mon,  2 May 2022 07:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651476048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=316vBczhGLy+xxL6RxTzNHGdKjpT66UxrwebpuXAV2A=;
        b=vE0DRdgO9QNdMtjLh8oz8cWD81imyoKiVxjDjGJwUVnW26PZy2ciyjUTRJ75WfTnbCiVVg
        98QBFQyDryFZlKQFesB8xR7Pi3+w4aPnSIoYoBE6VqVr7OAH3tguZfKusXpsLhH0jcBNng
        QBIayNLp5e+BiM+GU91GlT8NYS0Ba7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3145D13491;
        Mon,  2 May 2022 07:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ssooClCGb2I9cgAAMHmgww
        (envelope-from <gniebler@suse.com>); Mon, 02 May 2022 07:20:48 +0000
Message-ID: <8a28fb76-0d20-a1c1-7e2f-5cbb87313ed1@suse.com>
Date:   Mon, 2 May 2022 09:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs: Turn fs_info member buffer_radix into XArray
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220421154538.413-1-gniebler@suse.com>
 <8fa5a2af-7335-108b-9ce3-a45270331b4a@suse.com>
 <20220429183932.GF18596@twin.jikos.cz>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220429183932.GF18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 29.04.22 um 20:39 schrieb David Sterba:
> On Fri, Apr 29, 2022 at 05:14:15PM +0300, Nikolay Borisov wrote:
>>> -		cur = gang[ret - 1]->start + gang[ret - 1]->len;
>>>    	}
>>
>> nit: The body of the loop can be turned into:
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index da3d9dc186cd..7c1d5fec59dd 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -7318,16 +7318,13 @@ static struct extent_buffer *get_next_extent_buffer(
>>
>>           xa_for_each_start(&fs_info->extent_buffers, index, eb,
>>                             page_start >> fs_info->sectorsize_bits) {
>> -               if (eb->start >= page_start + PAGE_SIZE)
>> +               if (in_range(eb->start, page_start, PAGE_SIZE))
>> +                       return eb;
>> +               else if (eb->start >= page_start + PAGE_SIZE)
>>                           /* Already beyond page end */
>> -                       break;
>> -               if (eb->start >= bytenr) {
>> -                       /* Found one */
>> -                       found = eb;
>> -                       break;
>> -               }
>> +                       return NULL;
>>           }
>> -       return found;
>> +       return NULL;
>>    }
>>
>>
>> That is use the in_range macro to detect when we have an eb between
>> page_start and page_start + PAGE_SIZE in which case we can directly
>> return it, and the in_range is self-documenting. And directly return
>> NULL in case of eb->start going beyond the current page and in case we
>> didn't find anything.  David, what do you think?
> 
> I like it and folded to the patch, thanks. The variable 'found' becomes
> unused so removed as well.

Nice! I didn't know there was such a macro - learned something again.

Thank you both!
