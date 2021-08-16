Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16EC3ED3F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhHPMbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 08:31:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhHPMbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 08:31:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F84F21E54;
        Mon, 16 Aug 2021 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629117034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh3gSRR/DXx/xhS4r72+EQO+AHg+1QWMpoK2wPsiWus=;
        b=pLlPR6DgYI3bE+dbUJLgHqaWHK02G8QLMrcANqMCiy9baoHeEOEX+XAP1sFmdLZUavQPZs
        cjBW8r+1hKFvD38JTvNtabnZKCcbS9LjiFEhK8A4iXfnO8yd80AsIzcaVNBYbSo9Pz9Zrx
        LUnMkg0FXUzoma5w7NlQJ0qjiZVUfhE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CF39E136A6;
        Mon, 16 Aug 2021 12:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qJBuL2laGmF5KQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 16 Aug 2021 12:30:33 +0000
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs_for_each_slot
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20210802125738.22588-1-mpdesouza@suse.com>
 <9107ecb2f56198dc7329820d3a25173d4924682d.camel@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <42dfeb76-e6b7-55da-04be-d7868fd3d397@suse.com>
Date:   Mon, 16 Aug 2021 15:30:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9107ecb2f56198dc7329820d3a25173d4924682d.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.21 г. 15:21, Marcos Paulo de Souza wrote:
> On Mon, 2021-08-02 at 09:57 -0300, Marcos Paulo de Souza wrote:
>> There is a common pattern when search for a key in btrfs:
>>
>>  * Call btrfs_search_slot
>>  * Endless loop
>> 	 * If the found slot is bigger than the current items in the
>> leaf, check the
>> 	   next one
>> 	 * If still not found in the next leaf, return 1
>> 	 * Do something with the code
>> 	 * Increment current slot, and continue
>>
>> This pattern can be improved by creating an iterator macro, similar
>> to
>> those for_each_X already existing in the linux kernel. using this
>> approach means to reduce significantly boilerplate code, along making
>> it
>> easier to newcomers to understand how to code works.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>
>>  I've being testing this approach in the last few weeks, and using
>> this macro
>>  all over the btrfs codebase, and not issues found yet. This is just
>> a RFC
>>  showing how the xattr code would benefit using the macro.
>>
>>  The only part that I didn't like was using the ret variable as a
>> macro
>>  argument, but I couldn't find a better way to do it...
>>
>>  That's why this is an RFC, so please comment :)
> 
> Gentle ping :)
> 


I didn't give a RB because the patch is too small in the sense that it
shows just a single caller. In order to be able to better ascertain how
useful is I was expecting you'd submit a larger series containing all
the necessary changes. Additionally, does this patch relate to the
changes in 'btrfs: Use btrfs_find_item whenever possible' or are those 2
independent?
