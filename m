Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CADD585B72
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jul 2022 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiG3Rna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jul 2022 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3Rna (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jul 2022 13:43:30 -0400
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076D13EAA
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 10:43:27 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-34.iol.local with ESMTPA
        id HqUkoby2yMK28HqUloffVx; Sat, 30 Jul 2022 19:43:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1659203003; bh=x2OX+HdN5ylvPnEmTzI8ptmULlKrBcxfaBbPPNrbuek=;
        h=From;
        b=cMywWC1BBhZM1Q2MJOHKzmw1wWEoj0bu3UxVqnQvcqS2oNMe9tK05sQFtiBu3X5bY
         FOeu3QnAz09UlysVcpmT1+bqerrnJWDgfK8l4YpO54MPCaZammAXP6j2RaD0XTkWlZ
         WJQlt0/vPHH7mpCRaIAgh8rg/dtFU/+kUYC98vkwJdhKcjS/dIMKZV5OCouyxW+cwj
         qg9h0PODjsuZWJwj2tlBK4FnhgcH59vKbKoTDJrGHxfbzT6lNrvaWA/io1KQ9VsVre
         YB111q7YamM9Y0eMfemegvZasNpng0HnsUtJWJl739e5MU5a4jpF7Avcdr1QYjv67m
         DwPASTX6GS9nQ==
X-CNFS-Analysis: v=2.4 cv=a6H1SWeF c=1 sm=1 tr=0 ts=62e56dbb cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=FSGYwWTJvfc8HAPRjscA:9 a=QEXdDO2ut3YA:10
Message-ID: <55ffd61a-772d-97d4-0e5d-01d8a43bacd3@inwind.it>
Date:   Sat, 30 Jul 2022 19:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: How to get the lsit of subvolumes with
 btrfs_util_create_subvolume_iterator
Content-Language: en-US
To:     Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org
References: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
 <c2e7bd2e-e317-4741-5522-d7a311f5ff70@libero.it>
 <5d9e7395-1d8d-e1b5-5c1e-e7fe4c9b390c@couderc.eu>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <5d9e7395-1d8d-e1b5-5c1e-e7fe4c9b390c@couderc.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDc6G0k3XFK1mXNyv8nHODx+fAMSgTaEaRlQdEP/MEDuVhjX4lyM6TtQq5vKqoEgPuzDSb8+ybPxxgHPpEZqGFYkG1dCSemAoL47uqbCzCMLE5/dnzxX
 VBvjf5iRIkhk29Tl5A+K+B7XNSn3FWasYSG8NPYxzBn0vYUKVQulxHLrnMSwB4dldWaWqa9WR3aHvXF5WN0/gTjQVKsQ7lcGIjvL1ldKxA79Kw4vz2uQ8g1J
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/07/2022 18.29, Pierre Couderc wrote:
> On 7/30/22 17:38, Goffredo Baroncelli wrote:
>> On 30/07/2022 17.01, Pierre Couderc wrote:
>>> btrfs_util_create_subvolume_iterator("/",0, 0, &iter);
>>
>>
>> From the btrfs header "./libbtrfsutil/btrfsutil.h"
> Thank you, I had seen other documentations, but not this particularly. The key is : "To list all subvolumes,
> 
>   * pass %BTRFS_FS_TREE_OBJECTID (i.e., 5)."...
> 
> I still do ont understand what is BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER but it does not seem to matter...
> 
It should mean first father then children instead of first children then father


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

