Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AD444FD4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKDHxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 03:53:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDHxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 03:53:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E2BA212C7;
        Thu,  4 Nov 2021 07:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636012234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKxRx4qH7tYjftosA4myk/yzUogd/mwwEi0sAETzHUM=;
        b=EtdL24J6ZzTs2wUvpZZCa68GIVEtoNHTXTNV1wd+HTD7jUL/kp+/LlaDmRwu7Lm+QzgeF2
        7CrvSNEkhr3MhxLAVXqmjbqhngC6aBjf3BRd+9uoQMZ2BrjjyxR2VN+TVutra+LQx5JPJs
        b/PSPJuoD1VCXiwbLFJdckbHcP36uvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5E4C13A98;
        Thu,  4 Nov 2021 07:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bIHdMMmQg2EdEQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 07:50:33 +0000
Subject: Re: [PATCH] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211103151554.46991-1-realwakka@gmail.com>
 <665f8532-e176-3dc6-ccf0-395672cb3383@suse.com>
 <20211103235259.GA47276@realwakka>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <dd777050-db1e-d6f0-d41b-2b1f7226cb20@suse.com>
Date:   Thu, 4 Nov 2021 09:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103235259.GA47276@realwakka>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.11.21 г. 1:52, Sidong Yang wrote:
> On Wed, Nov 03, 2021 at 05:25:38PM +0200, Nikolay Borisov wrote:
>>
>>
>> On 3.11.21 г. 17:15, Sidong Yang wrote:
>>> This patch fixes potential bugs in fixup_extent_refs(). If
>>> btrfs_start_transaction() fails in some way and returns error ptr, It
>>> goes to out logic. But old code checkes whether it is null and it calls
>>> commit. This patch solves the problem with change the condition to
>>> checks if it is error by IS_ERR().
>>>
>>> Issue: #409
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>>  check/main.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/check/main.c b/check/main.c
>>> index 235a9bab..ca858e07 100644
>>> --- a/check/main.c
>>> +++ b/check/main.c
>>> @@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
>>>  			goto out;
>>>  	}
>>>  out:
>>> -	if (trans) {
>>> +	if (!IS_ERR(trans)) {
>>
>> Actually I think we want to commit the transaction only if ret is not
>> error, otherwise we run the risk of committing partial changes to the fs.
> 
> I agree. If ret is error, committing should not be happen. But I 
> think it needs to check trans. 
> 
> I wonder that if ret is error but trans is okay, trans needs to be
> aborted by calling btrfs_abort_transaction()?

This is the general way errors are handled in kernel. Currently abort
trans in progs simply sets transaction_aborted = error and
commit_transaction checks if this is set and returns an EROFS. Every
failure site in this function should ideally have a
btrfs_abort_transaction, because in the future we probably want to add
code which would yield the exact call site where a transaction abort
occurred.



>>
>>>  		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
>>>  
>>>  		if (!ret)
>>>
> 
