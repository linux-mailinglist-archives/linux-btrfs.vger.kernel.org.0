Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBD578754
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiGRQ0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbiGRQZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:25:52 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C02AC79
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:25:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C15FF803C6;
        Mon, 18 Jul 2022 12:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658161550; bh=oJqSkCSvdk7Um9FDrD/vY05JARX3gieXdGtrCQk5tdI=;
        h=Date:From:To:Cc:Subject:From;
        b=Izf6Hh9KEl+1ZPj6KEbPpIJl8/hgQNpibw6HyEgPdLOglIwaE5Gld8nlhdv+9PV2x
         5DUhLZ3R3FJm+yHjbwCZ4Nm359l+XShv0rW4OgrglL3yAXuG9nZLd1qv0/p1MIhYaQ
         ny7gu6DPLvhXhwXzjEP6lvnvx18z4gskCP6j1QDkHwrXicbk580X23fRnJR9Iwr4wP
         q8R+PdfzVujVNPKuPt8CBr6NekdIFRaj1reITAqYBNRMt1/bw9MAGWJFYWWL0TleJY
         w49QVLrx/KuWL/BBDCdjWd4UXaffRqaVCUR0PG2hosz/4CIQgAwXx+OJyNP4lcoQ10
         BTuQsbNr4j6vg==
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 12:25:50 -0400
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs-progs: corrupt generic item data with
 btrfs-corrupt-block
Message-ID: <8c4bef8cb04e5a617119b8f8e302bf05@dorminy.me>
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


> -	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the
> passed key triplet (must also specify the field to corrupt and root
> for the item)\n");
> +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the
> passed key triplet (must also specify the field, or bytes, offset, and
> value to corrupt and root for the item)\n");

I'd find it a little more understandable, even though I know it's not 
intended to be read often, as:
+	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed 
key triplet (must also specify the field, or (bytes, offset, value) 
tuple, to corrupt, and root for the item)\n");



> +	data = btrfs_item_ptr(leaf, slot, void);
> +	// TODO: check offset/size legitimacy

Is it worth fixing this todo?

I'd prefer if there was a check that the existing data at the offset 
isn't the same as the new value, so as to ensure we notice if we're 
failing to corrupt.

> +			case 'v':
> +				bogus_value = arg_strtou64(optarg);
> +				break;

You're parsing, and storing here, a u64; meanwhile 
corrupt_btrfs_item_data() takes a char bogus_value. I think it probably 
makes sense to only parse and store a char, but

> +		else if (bogus_offset != (u64)-1 &&
> +			 bytes != (u64)-1 &&
> +			 bogus_value != (u64)-1)
Might be worth calling out (u64)-1 as #define UNSET_VALUE for easier 
readability?

> +			ret = corrupt_btrfs_item_data(target_root, &key,
> +						      bogus_offset, bytes,
> +						      bogus_value);
> +		else
> +			print_usage(1);
Maybe add an extra message here to say that either field or all of 
offset, bytes, and value have to be set?

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
