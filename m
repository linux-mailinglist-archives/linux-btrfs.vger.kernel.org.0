Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4516C2692
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCUAyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCUAyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:54:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9734F58
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:54:29 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1qU45M3Fi1-00uXp7; Tue, 21
 Mar 2023 01:54:26 +0100
Message-ID: <900424d7-0659-aabd-4456-277b60e808e8@gmx.com>
Date:   Tue, 21 Mar 2023 08:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 03/12] btrfs: introduce a new helper to submit write
 bio for scrub
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <c9482839875af328d7fe5ff6a9bebdc84c33c5ab.1679278088.git.wqu@suse.com>
 <20230321001445.GJ10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230321001445.GJ10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K7+hcZNYaShIJY5oat47DRN4E9owvOrnVF+yssAIZKF/4MgzLW4
 JtfJ7/E1c3kg45Quks0qRB5zzrNHfvu/9XdRSt083TB/nbjSFYionHnvVEMStmTqO0k9nST
 bsTObLOb5MP0sFMFaTjgLF78xstKLG9dCYK/bFJypCyureDci7u4zZwiNBLJ6YspQvC0NmE
 nnAWf6ZuyAeIc2270a7NQ==
UI-OutboundReport: notjunk:1;M01:P0:riqVoCZycCE=;0jzHwfo8GFsj/Dai2QIkPq3ChUK
 v/GZV8agUgFzV8oG/2u8GUxe5f/MD7jinJQnV1+K5pLx1refXyY3W67Dqehl3rlt1VCB2ucGx
 N8aREhl/hCImTJof4P4kMH9SOSaNVXZz4O+JaDo4dGiOjpUqoXuT/a8XolWjj9W9Q1uSDwXhA
 i2V00JNUHSL/rd4fJK3AYAykTQ2Q9lQ47HPY10WwnJO3InS6U5YNDPJDuBoYPfeNRAYepKGUE
 g2RWw6CrXtPez+FSuiBNJpDXGBjC+nikUrtEeiIK01tqwgQgNO0yDaEz/NqsrIP/PYYg4jSTo
 AYLPTQAdg109ojIBXBjw+pWzOgwQkjKqrF/Oj9moYbumxLCk5R5CZxhyG2Z4F6CdiYPcGMI8b
 sVuyj2KihBAdeHPl64xyDOGQpbvj9uv/L9fDtlrRx7k9yWyGZOuR6uBAI6gZpGBVrn71SdToy
 BJR4M1p7O4H2EiB8VzT8uoxsoVoFRoMdqxnLX9npgJSNO0X+083M7dqOsXJgSMFYxZUedEbbv
 u/pNnBKSJiUaijFRv4zAonBKFN8XaS+XqusyZ/ZIpZ9fvfpmcUu6nXE7EWxhkLaByQRqOm4xr
 +CXkIfuu05aul0CENFeUeWS16SSWgdpvs9p5CYKY0JP2dX5sQTotpXxad4V10OZTUWgIpEqSb
 allNflhYCU9+8vZVgWyeao7XnAr2MFIXO5+Wfr1EtHQnmAPD/rshCoA1noCO+IjCEJd3Qn7J8
 WbhLRuThfaYmLhtpxgj18f1VBlrrIaPrJauVzBuz5inN7MVp3pRZD9UEH6RqQvnsUuPiP2pmK
 2QRUrrNm0ffMyHoSuH1sTHjXK4cTgUGw55k3cfEYV0Jphl5qD+za/wjjaHv5jshRBD4ey7s8T
 jFNlNE3KNo98IMTekyfzXqGXuji76hCbyEFee+t0TddFXMUsdI+D9V0IGmDPA/h1bV+hlUd/F
 hZ9V/tR+p7AJuM8c2fyg8EyptHk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 08:14, David Sterba wrote:
> On Mon, Mar 20, 2023 at 10:12:49AM +0800, Qu Wenruo wrote:
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index b96f40160b08..633447b6ba44 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> +	/* Map the RAID56 multi-stripe writes to a single one. */
>> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>> +		int data_stripes = bioc->map_type & BTRFS_BLOCK_GROUP_RAID5 ?
>> +				   bioc->num_stripes - 1 : bioc->num_stripes - 2;
> 
> When ternary operator is used in expression, please put ( ) around it so
> it's clear where it starts.
> 
>> +		int i;
>> +
>> +		/* This special write only works for data stripes. */
>> +		ASSERT(mirror_num == 1);
>> +		for (i = 0; i < data_stripes; i++) {
> 
> 		for (int i = 0; ...)
> 
> We can now use the iterator value defined inside for (), it's relatively
> new due to bumped minimum compiler version so I'd like to see it used
> where possible.

Just one question.

There are quite some for loops in the last few patches.

In that case, should we still go the "for (int i = 0;...)" way?
Or it's better to declare "i" as the old way?

Thanks,
Qu

> 
>> +			u64 stripe_start = bioc->full_stripe_logical +
>> +					   (i << BTRFS_STRIPE_LEN_SHIFT);
>> +
>> +			if (logical >= stripe_start &&
>> +			    logical < stripe_start + BTRFS_STRIPE_LEN)
>> +				break;
>> +		}
>> +		ASSERT(i < data_stripes);
>> +		smap.dev = bioc->stripes[i].dev;
>> +		smap.physical = bioc->stripes[i].physical +
>> +				((logical - bioc->full_stripe_logical) &
>> +				 BTRFS_STRIPE_LEN_MASK);
>> +		goto submit;
>> +	}
>> +	ASSERT(mirror_num <= bioc->num_stripes);
>> +	smap.dev = bioc->stripes[mirror_num - 1].dev;
>> +	smap.physical = bioc->stripes[mirror_num - 1].physical;
>> +submit:
>> +	ASSERT(smap.dev);
>> +	btrfs_put_bioc(bioc);
>> +	bioc = NULL;
>> +	if (dev_replace) {
>> +		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
>> +		smap.dev = fs_info->dev_replace.tgtdev;
>> +	}
>> +	__btrfs_submit_bio(&bbio->bio, bioc, &smap, mirror_num);
>> +	return;
>> +
>> +fail:
>> +	btrfs_bio_counter_dec(fs_info);
>> +	btrfs_bio_end_io(orig_bbio, ret);
>> +}
