Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0765C4F0CDB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 01:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiDCXI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiDCXI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 19:08:57 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD835DF7;
        Sun,  3 Apr 2022 16:07:02 -0700 (PDT)
Received: from [192.168.148.80] (unknown [182.2.36.220])
        by gnuweeb.org (Postfix) with ESMTPSA id EF8A17E2F8;
        Sun,  3 Apr 2022 23:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649027222;
        bh=AgxCk/JVw9/hkc4+DKBbYPNAgm4m8EN1bmKcRraOkOI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sdw+Y33/dXPrCEFe/gQkpoD3FRialbIxVxV7IFGzGWV7U40WVX/fl4p99DxkWoKzF
         tftnE5xtKvgsygWN0XWNTLcdbT5jOF1pVwzRJCw9SuOfL1lEPvcKjYZQb5ns3xmyI6
         +3WKDEohjga9SBJCamSfht4pEc0LIcSY6kK1mWKWj8bl8dZZLhWw8AG8Yb2Mw79896
         wWCwH31H4Tt3hbaO0j77pEFIyDp7JW9in4qDUo7obMyZlFyTnAoRHTGe5Bvrf3t1El
         m73gEDGzgL7dRkJDNKfP0SlA7e9KfswKSCWqE6DXV0I78mYZyqse8p8J+mCIxiXQT0
         GiTcfuYcR7RgA==
Message-ID: <29e7cfd7-47fb-a435-1862-1ff96dfd35df@gnuweeb.org>
Date:   Mon, 4 Apr 2022 06:06:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>
References: <322c0884-38fe-a295-0aff-caee1308833d@gnuweeb.org>
 <PH0PR04MB7416A2426687A7A4803628729B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <PH0PR04MB7416A2426687A7A4803628729B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/28/22 3:10 PM, Johannes Thumshirn wrote:
> On 27/03/2022 03:31, Ammar Faizi wrote:
>>
>> Hello btrfs maintainers,
>>
>> I got the following bug in Linux 5.17.0 stable. I don't have the
>> reproducer for this. I will send any update if I find something
>> relevant. If anyone has any suggestion on how to debug this further,
>> or wants me to test a patch after it gets a reliable reproducer,
>> or something, please let me know. I will try it on my machine.
>>
>> If you need me to send something to investigate this, please let
>> me know.
>>
> 
> This can be solved by increasing CONFIG_LOCKDEP_CHAINS_BITS.

TIL, got it, thanks.

-- 
Ammar Faizi
