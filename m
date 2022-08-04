Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70D7589AFE
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiHDLXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiHDLXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 07:23:35 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EE2B182;
        Thu,  4 Aug 2022 04:23:34 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 274BNE8H015743;
        Thu, 4 Aug 2022 20:23:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Thu, 04 Aug 2022 20:23:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 274BNE6x015740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Aug 2022 20:23:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d3fa0cc8-472d-d3c9-aeb9-81f50d04f774@I-love.SAKURA.ne.jp>
Date:   Thu, 4 Aug 2022 20:23:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, dvyukov@google.com
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsMNF_SKns-av1kAWtR5Yd7u6sjwsFT9er8tSebfuLG8VQ@mail.gmail.com>
 <1d1afda7-2b4b-4984-adbe-51339ebbdd18@www.fastmail.com>
 <CABXGCsO5+L2fX-wT=-UYFgzO9JuB7RNKDzv-wg5XrCt=yCuK1w@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CABXGCsO5+L2fX-wT=-UYFgzO9JuB7RNKDzv-wg5XrCt=yCuK1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022/08/04 16:35, Mikhail Gavrilov wrote:
> On Thu, Aug 4, 2022 at 1:01 AM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> This will be making it into Fedora debug kernels, which have lockdep enabled on them, starting with 5.20 series, which are now building in koji.
>> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
> 
> I saw this change, but it would be good if users of all other
> distributions will be happy too.
> 

I'm not a lockdep maintainer.

Please submit a patch to lockdep maintainers and persuade lockdep maintainers
to change the default value. ;-)

