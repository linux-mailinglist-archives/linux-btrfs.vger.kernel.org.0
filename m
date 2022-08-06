Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4FE58B3FC
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiHFGCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiHFGCD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 02:02:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49F13F34
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659765718;
        bh=T2zqnkv0HP+IIvHY96b/FMdodGI9jm9mfjSgvxPr8wo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I3eNAyWZT59PDwNRSVjdzdocYtzdoK5kaP9armoWfntZnhtWSeCsWDxQpzA3i4cu5
         KRf5yt/kFA7fztRW5s8tfjh3ux2qKsDLHB4VD3DL6HITb7PhjSOfKKnPYtbxgeOdGD
         xVEwZdP4yLCFNu7vTaSZ1BuBD7QwpTIsS3hy+C6Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1nuBYS1lmD-00QlkT; Sat, 06
 Aug 2022 08:01:58 +0200
Message-ID: <7dd7fd85-863a-3c16-16d6-0f4436091d33@gmx.com>
Date:   Sat, 6 Aug 2022 14:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] btrfs: scrub: try to fix super block errors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
 <20220803125513.GC13489@twin.jikos.cz>
 <52323456-6820-ce55-101a-8aecc3e73539@gmx.com>
 <20220804130621.GM13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220804130621.GM13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H9qoGQF12TA5hWwTs2xFesDUT1e1VC46fpxQtAJwNzo3rPs1GM/
 7bfUfVZyXbcY9RzpF3CGcxP3RwFueXqVbORYfgoAKyTIvEze88zZKjRdCRKnMPS0gz8vFKM
 x1rx160DhF//TvvwFHBIU+aHUos20EoZhzgXxJ/77cj6ywNxD9/AdAJKHQEssdhjIwTmKh/
 BVZ+6IS98pbU4RSeaFLWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8HkWoepoRQI=:4fVf2+15Gm4yYzRqcisIxk
 GdwOeQJsaidGu1Q6V7CsF9PoRch1Ru1O+9yRynZ9XNtXHJcgqpYN3iFDJmh0ASTcbjJKFjYOu
 FWcVywxgrW9LXJdh0V8JErU009khRYNX/9amN16zGZwX/ahwlt33gzJoJY4aSt+HJhdyNtq3o
 gZ6GtbeuBEhd2dlbHT2V1rPSJNj2l69795Sja027Ie+8jM1FaCU7EZa4Jzd6nnnkKE3XaNrJn
 MuQn56csk4x8k3axQrnvxCtemH5cHP4fq60LMiUMYHF26JkwUbE9ZjQoY3kGrGHO+IAow54qP
 J3hp33BzeeQZz3cx4g1Xw4UVTKCkZYlxY9RHG4P8/i58fdYbObK1fyLyVs5n2r9EW1clj+4aW
 jQQBh42CBM9rYxuv5X5kLpBqVQGkSWj2RJGHZGXBkQ+ndF/KAVnXHqkXwF4NA7DkTcEhSZTsL
 9Jn8Rc1fTET4VKpl73Dn52GDZLgMZfuh95Ar+wOsT9lg9w8mgMV12Lsj/vVbVKzZ2ovPOzTSt
 F7Fj3V/a2/WXeIJJ43ubfEvhqvFVbrYZnHsjPXhpiPSkLzTgNUXTKmNkQXGVDcjni0ijYrNt2
 +AuSCCOzMdtjDGghJqWwfIH9dxon4vqxobdY4uxiP98eUfnVlqddQAMkqWPxl6dupwrKA/XlW
 42cOKMSf97WP1hYrnsQgwNZHUt9NRaj3SBdnAavmEvLCFhyy3F42sWvz3yB6LReWkloy/BDK+
 eOuuKlfk0hlYW+ehVce7/iNFOezVpl6tUg2ZY003qi5IGG727QhYaks+kI1jJcG9E5/CoIkIN
 nKcdzswGsAjr5T2iz13wEURu0HSP/uSl53f2SMc5WbbLIFVx38exrVZbJl4GK4jY4iAKTNCUu
 6DW5NIxT0B14qjbLZL7MZUNWG2HXk9ffJ4KLIPegjFVgVZgXhZ3l4zs3p/66tQZYzsQjRW6qI
 vVUW5ZhsvEYqHgVA2Ajnj4YFQ8uLhndKhRp6F3vvl9AtwQT4Re+GRGeJWDW+L7opKrCS/E39q
 RzuObF9WU1F0jt63y+PhcvMxmrjPBxyKDAu3wMPqs6f6/gXfjW5KaZ6MEKyZXwcFD2hWS+4Qs
 ZePDJvvMDZASfrHak0wrOjAfDUi/4spS5ChKgqS5l502inQZrWqqM3j6A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/4 21:06, David Sterba wrote:
> On Thu, Aug 04, 2022 at 05:49:20AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/8/3 20:55, David Sterba wrote:
>>> On Tue, Aug 02, 2022 at 02:53:03PM +0800, Qu Wenruo wrote:
>>>> @@ -4231,6 +4248,26 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_i=
nfo, u64 devid, u64 start,
>>>>    	scrub_workers_put(fs_info);
>>>>    	scrub_put_ctx(sctx);
>>>>
>>>> +	/*
>>>> +	 * We found some super block errors before, now try to force a
>>>> +	 * transaction commit, as all scrub has finished, we're safe to
>>>> +	 * commit a transaction.
>>>> +	 */
>>>
>>> Scrub can be started in read-only mode, which is basicaly report-only
>>> mode, so forcing the transaction commit should be also skipped. It wou=
ld
>>> fail with -EROFS right at the beginning of transaction start.
>>
>> It's already checked in the code:
>>
>> +		if (sctx->stat.super_errors > old_super_errors && !sctx->readonly)
>> +			need_commit =3D true;
>
> Great, I overlooked it and searched only for BTRFS_SCRUB_READONLY.

My bad, I didn't test it with replace group, and it can cause hang in
btrfs/100.

The cause is, dev-replace will call btrfs_scrub_dev() with extra
dev-replace related locking.
However btrfs_commit_transaction() will also need to wait that lock,
thus we will dead lock there.

I'll fix the last patch, meanwhile please remove it from misc-next.

Thanks,
Qu
