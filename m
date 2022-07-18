Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB1578B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiGRUS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGRUS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 16:18:26 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A29DF3B
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 13:18:22 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E5F0080681;
        Mon, 18 Jul 2022 16:18:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658175501; bh=H91cTXPwtbo7Q0Eai1/38JQoW5zi2IAcnYjXqwocCB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v2gMEONMboY15UTJAhnxzXJJGQA5/Ug7UEdCrHEE8PQPferegHd5DSpLRYhaMTqlc
         yzBKAXH3qjpnzuKRPcUJ4+Z0bpewk5qYk85xLdv0Pow6BZm/JmtLSovvXVFdEMFCoJ
         vjUkM6IkFFjhpn6Ab7SvfPNzrhJUfArNjp1UPiGlAbusId9Ubgjj5VsZe7/z3MqYOU
         XBNS4nZJUfOWOluh4Pxmx+ZYFfF4rdULSbZKS8ylXhOF/YbNKAYQv7UMtC4KVdBg1o
         KTcH4eTEOC2sNkyKGiwSSVuKJl6HpMNAcKgrwe6H4NmZQJLgN4edClKRZJ9H+hGXeI
         1wliIpyx+BOkQ==
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 16:18:21 -0400
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs-progs: corrupt generic item data with
 btrfs-corrupt-block
In-Reply-To: <4c0d4b0003c31f1c1ee1d7a475f70f25663b98f6.1657919808.git.boris@bur.io>
References: <cover.1657919808.git.boris@bur.io>
 <4c0d4b0003c31f1c1ee1d7a475f70f25663b98f6.1657919808.git.boris@bur.io>
Message-ID: <b216ff59120ab14f76a8b04fe9eb88ce@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I thought I replied with this, but I can't find any evidence that the 
message actually sent, so: apologies if this is a duplication of a 
previous message...


>> -	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the
>> passed key triplet (must also specify the field to corrupt and root
>> for the item)\n");
>> +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the
>> passed key triplet (must also specify the field, or bytes, offset, and
>> value to corrupt and root for the item)\n");
> 
> I'd find it a little more understandable, even though I know it's not
> intended to be read often, as:
> +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the
> passed key triplet (must also specify the field, or (bytes, offset,
> value) tuple, to corrupt, and root for the item)\n");
> 
> 
> 
>> +	data = btrfs_item_ptr(leaf, slot, void);
>> +	// TODO: check offset/size legitimacy
> 
> Is it worth fixing this todo?
> 
> I'd prefer if there was a check that the existing data at the offset
> isn't the same as the new value, so as to ensure we notice if we're
> failing to corrupt.
> 
>> +			case 'v':
>> +				bogus_value = arg_strtou64(optarg);
>> +				break;
> 
> You're parsing, and storing here, a u64; meanwhile
> corrupt_btrfs_item_data() takes a char bogus_value. I think it
> probably makes sense to only parse and store a char, but
> 
>> +		else if (bogus_offset != (u64)-1 &&
>> +			 bytes != (u64)-1 &&
>> +			 bogus_value != (u64)-1)
> Might be worth calling out (u64)-1 as #define UNSET_VALUE for easier
> readability?
> 
>> +			ret = corrupt_btrfs_item_data(target_root, &key,
>> +						      bogus_offset, bytes,
>> +						      bogus_value);
>> +		else
>> +			print_usage(1);
> Maybe add an extra message here to say that either field or all of
> offset, bytes, and value have to be set?
> 
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
