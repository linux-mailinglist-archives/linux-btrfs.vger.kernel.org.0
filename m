Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8D3FC68D
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhHaL2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:28:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241476AbhHaL2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:28:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BCAB20163;
        Tue, 31 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630409228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+/TE50rHS/eHJix9V/ai8hQ66CTbTJWeMAfo3Vg9Go=;
        b=cL/uGgzymjjuZjX1BoysDUttMUwfpdNbvTCN2vFwq/eiBykyxcvYChyZdqDxQW3bjk0k6r
        JaLg1mcatjWVCvMuxCj8H6qzJxGc74Vmtjve/cssxhUTW2oNBzoxQF5RE1tJUk7vxa4CH8
        Ty++zrUPH2F9LuxhpEMJfvE/CuDzlsU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DDDA913A8B;
        Tue, 31 Aug 2021 11:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ktULMwsSLmGcDAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 31 Aug 2021 11:27:07 +0000
Subject: Re: [PATCH 5/8] btrfs: inode: use btrfs_for_each_slot in
 btrfs_read_readdir
To:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-6-mpdesouza@suse.com>
 <f9647be1-25a9-e29b-4524-9b5ebf752567@suse.com>
 <20210831111051.GH3379@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b61685b1-db19-872f-8c9e-74dfe6c80ca7@suse.com>
Date:   Tue, 31 Aug 2021 14:27:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831111051.GH3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.08.21 г. 14:10, David Sterba wrote:
> On Mon, Aug 30, 2021 at 04:05:28PM +0300, Nikolay Borisov wrote:
>>> @@ -6137,35 +6136,19 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
>>>  	key.offset = ctx->pos;
>>>  	key.objectid = btrfs_ino(BTRFS_I(inode));
>>>  
>>> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>>> -	if (ret < 0)
>>> -		goto err;
>>> -
>>> -	while (1) {
>>> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
>>
>> I don't think it's necessary to use iter_ret, instead you can use ret
>> directly. Because if either btrfs_search_slot return an error or
>> btrfs_valid_slot then ret would be set to the respective return value
>> and the body of the loop won't be executed at all, no?
> 
> Yeah thre's no reason to add another variable in this case. As long as
> the loop body does not use ret internally, then reusing ret is fine.
> 
> The point of having an explicit return value for the iterator is to be
> able to read the reason of failure after the iterator scope ends, so it
> can't be defined inside. We'd need to be careful to make sure that the
> iterator 'ret' is never used inside the body so that could be also
> useful to put to the documentation. I think a coccinelle script can be
> also useful to catch such things.
> 

Actually even if 'ret' is used inside the loop body it's still fine.
That's because as soon as we call the btrfs_valid_item (aka iter) and it
returns an error we break from the loop.
