Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2AE7B02F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjI0LaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjI0LaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:30:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68705F3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:30:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlSkE-0003a8-UQ; Wed, 27 Sep 2023 13:30:18 +0200
Message-ID: <40003db4-6414-4446-aca1-a4808519aa45@leemhuis.info>
Date:   Wed, 27 Sep 2023 13:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Content-Language: en-US, de-DE
To:     Chris Mason <clm@meta.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
 <706df63f-ec5b-457a-b0ab-2d18816e3911@leemhuis.info>
 <20230912072057.C1F5.409509F4@e16-tech.com>
 <34cbea07-8049-4089-a0cc-79d6c423c4f5@leemhuis.info>
 <6ba3e137-ba01-4f29-b0f2-bfc9afcffce8@leemhuis.info>
 <9b98c3c1-2915-2a04-e27a-defb739832a0@meta.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <9b98c3c1-2915-2a04-e27a-defb739832a0@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695814222;f2b72d26;
X-HE-SMSGID: 1qlSkE-0003a8-UQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26.09.23 19:18, Chris Mason wrote:
> On 9/26/23 6:55 AM, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Christoph, I'm sorry to annoy you, but things look stalled here: it
>> seems the Btrfs developer don't care or simply have no idea what might
>> be causing this. So how do we get this running again? Or was some
>> progress made and I just missed it?
> 
> I've been trying to reproduce with the hardware I have on hand, but
> unfortunately it all loves the change.  I'll take another pass.

Many thx! Ciao, Thorsten
