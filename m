Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963DA4292D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJKPLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:11:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59688 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhJKPLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:11:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40835220D0;
        Mon, 11 Oct 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633964962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iri9vStT0/9xWwHBgFho4CeekFs6FnrqJexXkzD7F+8=;
        b=vBrxrJQ+bPUuq92igoA6GnnL8Te+VAVOODc6svRrCZSZ/ELlCrFXrdICiw0Rl6woPGnT0w
        FiCQTQV66U1Z7IWu+mP84L1oLq7yNMZb9etAZnPBde3H2wfuL3iS/922oA6O0pnyLU+GQU
        gz3j9rsDMc+5aikfuwAR5Vp+/HK8huA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A23213C72;
        Mon, 11 Oct 2021 15:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XJ9+A6JTZGF4SAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 15:09:22 +0000
Subject: Re: [PATCH 5/5] btrfs: make real_root optional
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20211011101019.1409855-1-nborisov@suse.com>
 <20211011101019.1409855-6-nborisov@suse.com>
 <20211011150552.GQ9286@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <98b77681-d165-25d6-1bd5-91b79466a89a@suse.com>
Date:   Mon, 11 Oct 2021 18:09:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011150552.GQ9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.10.21 г. 18:05, David Sterba wrote:
> On Mon, Oct 11, 2021 at 01:10:19PM +0300, Nikolay Borisov wrote:
>> @@ -273,9 +266,10 @@ static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
>>  static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
>>  				int level, u64 root, u64 mod_root, bool skip_qgroup)
>>  {
>> +#ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>  	/* If @real_root not set, use @root as fallback */
>> -	if (!generic_ref->real_root)
>> -		generic_ref->real_root = root;
>> +	generic_ref->real_root = mod_root ? mod_root : root;
> 
> 	generic_ref->real_root = mod_root ?: root;
> 
> Ie. the short form where the true branch only repeats the condition.

Ah, this is a GNU extension which I had to go an read up on explicitly,
but will keep it in mind :)

> 
