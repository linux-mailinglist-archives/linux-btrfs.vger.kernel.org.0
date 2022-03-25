Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214E64E7588
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 15:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiCYO76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiCYO75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 10:59:57 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834299026F
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 07:58:21 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 7111A805DD;
        Fri, 25 Mar 2022 10:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648220300; bh=0M7KIoBcG4u5ikJR00fJqvuYG11vz3xhLoIhfcefZ7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FNVBvJfgS+e4bdKWVTBPO0gnrXBckaCLhlxEE1hPwdbj1hvJ3J2B6Y+i+5ROaNCoR
         0LgfnX9DNirwOSYPWEUNma1DoW+o+HIbc6Pdw+NrtLvfRmxnRhFqS+6xhSPdbvhw9E
         dbd13ow98uju4tuTRIkuahq3RBQe7QYSU6tc2QqkijiyxIbxABk+SkEjIYxyPfnBIf
         Xe2A4f1BfJJXg8i3RF6r8Bg4pWJgR8yrD9Psn6RrUh0oGz1R0ejNB7kBbGtjDQ7Rtn
         wWLUVvcbpQ4vbg8W+vSoRh40hncLB3ah7T3ujO+yIpnrAPWjxcvQc4UA4cEW6apl5W
         Ygxf3ToXu+iBQ==
Message-ID: <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
Date:   Fri, 25 Mar 2022 10:58:19 -0400
MIME-Version: 1.0
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/25/22 06:53, Qu Wenruo wrote:
> 
> 
> On 2022/3/25 18:27, Christoph Hellwig wrote:
>> I'd suggest to at least submit all I/O in parallel.  Just put
>> a structure with an atomic_t and completion on the stack.  Start with
>> a recount of one, inc for each submit, and then dec after all
>> submissions and for each completion and only wake on the final dec.
>> That will make sure there is only one wait instead of one per copy.
>>
>> Extra benefits for also doing this for all sectors, but that might be
>> a little more work.
> 
> Exactly the same plan B in my head.
> 
> A small problem is related to how to record all these corrupted sectors.
> 
> Using a on-stack bitmap would be the best, and it's feasible for x86_64
> at least.
> (256 bvecs = 256x4K pages = 256 sectors = 256bits).
> 
> But not that sure for larger page size.
> As the same 256 bvecs can go 256x64K pages = 256 * 16 sectors, way too
> large for on-stack bitmap.
I'm not understanding the reason why each bvec can only have one page... 
as far as I know, a bvec could have any number of contiguous pages, 
making it infeasible for x86_64 too, but maybe I'm missing some 
constraint in their construction to make it one-to-one.
> 
> 
> If we go list, we need extra memory allocation, which can be feasible
> but less simple.
> 
> Let's see how the simplest way go, if not that good, we still have a 
> plan B.
> 
> Thanks,
> Qu
