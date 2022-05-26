Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A853516C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbiEZPa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347907AbiEZPaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 11:30:23 -0400
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4589C0394
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 08:30:20 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.14.90])
        by smtp-33.iol.local with ESMTPA
        id uFRInyG44VQ1EuFRInHdeU; Thu, 26 May 2022 17:30:17 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1653579017; bh=tMN4gj8PJn1sTD8GJUtdDLMPC4WqNzrkOgJdpMgcBjs=;
        h=From;
        b=hGzxWejSE+gbLQcE3pA3p9wxrdwcMKIOW+wbfVp6KVwbsvmGPmDZ8G2dUMNZYAnT6
         3EQowy9Ly19V0cfUg6iGrwaZSuKDyZ8U5PH6BtOP9RI8GuxVtwuscBJycG/BDnoRpe
         JLgkf1Lde6c67EONutEHOiNiWKLad81nibSghX+o3ARFGBDfm6VaJlKsqhn8DRy5Pv
         G3sOafhDdaNaPFtl/mJlMYjDJ7KLmXan/4t8WuOZybDkUq5VANHcViRSCAe7q1o1JF
         WwpC9CfLT9c1KxuMrB00lEjYrWiQwKHuKKXu2zoNNtQWcm+aaca/L+Lreo7cI8Jgfs
         PK75e4Tx0H9Kw==
X-CNFS-Analysis: v=2.4 cv=RM52o6u+ c=1 sm=1 tr=0 ts=628f9d09 cx=a_exe
 a=tzWkov1jpxwUGlXVT4HyzQ==:117 a=tzWkov1jpxwUGlXVT4HyzQ==:17
 a=IkcTkHD0fZMA:10 a=oRc3nhalbNAmCApWfcMA:9 a=QEXdDO2ut3YA:10
Message-ID: <4fde1fb7-b6ea-c6e5-7c04-f6c19e031354@libero.it>
Date:   Thu, 26 May 2022 17:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, waxhead@dirtcellar.net,
        Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz> <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
 <Yo32VXWO81PlccWH@infradead.org>
 <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
 <9d1e2fc6-9ee6-68f8-bda8-8dd7e59e74e5@dirtcellar.net>
 <50cb070b-2e2e-1987-3726-1e67eaf060cf@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <50cb070b-2e2e-1987-3726-1e67eaf060cf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLN34leJOA6aXVijturGVVKk9Ekvj/+uQ0QHTbKQNjZe9DI1g/24sgZF+7HJIr2+gaNQw0ta0GE7N+S87ltKTJNDaPxf88yB3Cw3BxLo/T7kOeQBtGIE
 NROUvLRAdf/vzqvr4w9TNwDGhesr7FDU/7hVf9kc0ZPXWcgg+ArWc2JorRIG7qW6WZ159NS/aRkSPrFShNmsXJ6957Eh307v1YnaMhiV9GnmtfJMBgsCRB/Q
 FFT/LkpQ/TNbP6dW1PdjFP/bF9gxFtBr7dCfTeZ2C0UhFcl9oceFrV+DB395umfMVFb6ZLx/0cyuWTgaEnm/O0AHV6Ujl9sczkfOQ2DDV6M=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2022 11.26, Qu Wenruo wrote:
[...]
> 
> Deprecation needs time, and RAID56J is not a drop-in replacement
> unfortunately, it needs on-disk format change, and is new RAID profiles.
> 
IIRC, the original idea was to dedicate a separate disk to the journal.
Instead of a dedicated disk, we could create a new chunk type to store the journal.
The main advantage is that the data/metadata are still stored in the "old"
raid5/6 chunk type. And only the journal is stored in the new chunk type.

This would simplify the forward compatibility (you can leave the already existing raid5/6 chunk, and enabling the journal mode only if the journal chunk exists)

And even the backward compatibility is simple: you need only to delete the journal chunk (via an external tool ?)

However I understand that at this phase of developing nobody want to introduce a so big change.

> If the code is finished and properly tested (through several kernel
> released), we may switch all raid56 to raid56J in mkfs.btrfs and balance
> (aka, balance profile raid56j becomes the default one for raid56).

If a balance is enough, I think that this can be considered a "drop-in" replacement.

> 
> For RST, it's harder to say with confidence now, a lot of things are not
> yet determined...
> 
> Thanks,
> Qu
> 
>>
>> This way the raid56 code would seem to be fixed albeit getting slower
>> (as I understand it), but the number of configurations available is not
>> overwhelming for us regular people.
>>
>> PS! I understand that I sound like I am not to keen on the new raid56j
>> mode which is sort of true, but that does not mean that I am ungrateful
>> for it :)


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
