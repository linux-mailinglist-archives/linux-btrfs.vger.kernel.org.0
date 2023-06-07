Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79190726C3C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjFGUbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjFGUbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:31:44 -0400
Received: from syrinx.knorrie.org (syrinx.knorrie.org [IPv6:2001:888:2177::4d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F523137
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:31:43 -0700 (PDT)
Received: from [IPV6:4000:0:fb:a::15] (2a02-a213-2b81-f900-0000-0000-0000-0004.cable.dynamic.v6.ziggo.nl [IPv6:2a02:a213:2b81:f900::4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id DF9CB6151B82E;
        Wed,  7 Jun 2023 22:31:41 +0200 (CEST)
Message-ID: <bdd74f6a-2f0a-6107-dd76-9e8e1c9e64fe@knorrie.org>
Date:   Wed, 7 Jun 2023 22:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
 <20230606164139.GK105809@merlins.org> <20230606232558.00583826@nvm>
 <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
 <20230607191719.GA12693@merlins.org>
 <a2a492ee-baa5-6881-e9ec-85ca2e611879@knorrie.org>
 <20230607200200.GA43020@merlins.org>
From:   Hans van Kranenburg <hans@knorrie.org>
Subject: Re: How to find/reclaim missing space in volume
In-Reply-To: <20230607200200.GA43020@merlins.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/7/23 22:02, Marc MERLIN wrote:
> On Wed, Jun 07, 2023 at 09:32:13PM +0200, Hans van Kranenburg wrote:
>>> On the plus side, this seems to have fixed the issue:
>>
>> Just a random hint... One possible situation in which a deleted
>> subvolume can't be freed up for real yet, is when there is a process
>> that still has an open file in it.
> 
> this is a fair guess.
> Too late now, but is this something that would show up in 
> lsof -n | grep volume ?

Yes, it should.

I just quickly tested this, by doing something like...

btrfs sub create foo
cat >> foo/bar
.. and then while the file is still open ..
btrfs sub del foo/

-$ lsof -n |grep foo
cat 577355 knorrie 1w REG 0,0 32 257 /home/knorrie/p/foo/bar

So it doesn't show as DEL, but still as REG, even.

Hans
