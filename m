Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947E6BA2A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 23:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCNWmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCNWmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 18:42:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AB50F8E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 15:42:34 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1pgL160Rm3-004FJN; Tue, 14
 Mar 2023 23:42:31 +0100
Message-ID: <ace9e432-37fb-dea4-0de9-4cb32a594dbc@gmx.com>
Date:   Wed, 15 Mar 2023 06:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <20230314184812.GS10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
In-Reply-To: <20230314184812.GS10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k20jrpPBxL+8680VRyz0eMZgx/OKvDPxSZF4Bdkj1wcDaqqLWXh
 YWfOflDEmH9x4nlg+1tjUJIH1xw3yT6gZ4opxtyMbqut/gV0/Ebj3vHRJV9g3FKQZUSxKvS
 xGx5P/D796ScVyFNFKMYohhXuOYkOT/XyekNr9SdJD9xnvtUG8uoWAYrkxJyKCqGNYT2L2R
 hfuvrmOmmss062l9E5pEQ==
UI-OutboundReport: notjunk:1;M01:P0:G2NVzOJkQq4=;o6qvbSStkMTQ9MzuhD1NZCmnfE3
 mnmt2i6ymWgz8lrIC3AHdntsYB3FFtDYhr4PHGJY5YDeEPprg2ZE36q9WX22jMWuog+NAt9x2
 kCgyXo15xFhOiqI/81Y88umwj5aNPiKlHE+42ywyp46csbPdVNV7/Tea7DspVtifKrZehHiA4
 pwyhJH+Hx9a5/frWt8Hki8kepI+7NqPLPXir8ncTyaM990bq/lFZ44LDdCcwLJTPWYYvr4LkT
 ywvSKSOwb5JE8/Jl/6+HIfXhM9FdOyu+KYFjPz6dCCtsgaPSwAdkIwmOClUcSAucPAG3b0api
 zG+dvYCfp0aunP0PcAvYSKnSRf4SfCJMC43eJXHHASR+TsYQapgQ+fCQXv76JEMvVwn8mPIZo
 7aTc0LLQVylcoYSEJ5AL6Q6qS1Dbp83I+PzJDfA1LNGjOYy6Uq/hhwesMDm9GO6eZPW/bSeC3
 jPojH5G0OOd0xK3+6dQa/me/PMIEbVn1eyewToWpnS0SFimfR/p9gJA0MwT8nMyaj2XfKEea+
 e4yzJGjTw7P7FTsZkMB6Dxm5QqXsqCGCET9vrviWCGELAmg9ne+q1hEie9XLPdEQ5W1xoQxVM
 QLbhcUN3/uI5T2g7iXzotoqjht0oPROe80tB+7V1HbSIS3aknFH1sumdsUHh8eLasr/6zpwCb
 6szC96O0X07xmhNvuXDjWfSTHshGI0OVZmlyNCQIhLh8XbgFUo0GfcjIIGXi/4YvRN1josWAt
 1/V6gUIaP7tjRQ505ZNjKVJtWS+khdUSopAxMWO0lEsofRTmRIz8v3LMXwMJRmgO42gkVHFS7
 x9xMcb1jA4kUyQxGZ+BRaSrLi2xawLDb/FFHZCE9kp4bVzxEGPbnyj7N6F05kJCbXTAhq1lR8
 XIXxtvxgZy9cg5wE+cPQ4kDaziPRY/4K+VbKmSQna7/QUdrrD1KO72Jb5Dr2l5GP6MgZPsooP
 0fpryJBloocPUFAgCaWt+HwyPWQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 02:48, David Sterba wrote:
> On Tue, Mar 14, 2023 at 03:34:55PM +0800, Qu Wenruo wrote:
>> This series can be found in my github repo:
>>
>> https://github.com/adam900710/linux/tree/scrub_stripe
>>
>> It's recommended to fetch from the repo, as our misc-next seems to
>> change pretty rapidly.
> 
> There's a cleanup series that changed return value type of
> btrfs_bio_alloc which is used in 3 patches and it fails to compile. The
> bio pointer needs to be switched to btrfs_bio and touches the logic so
> it's not a trivial change I'd otherwise do.

I'm aware of that type safe patchset and that's expected, and I'm 
already ready to rebase.

The reason I sent the series as is, is to get some more feedback, 
especially considering how large the series is, and it's touching the 
core functionality of scrub.

> 
> There's also some trailing whitespace in some patches and 'git am'
> refuses to apply them. Pulling the series won't unfortunatelly help,
> please refresh the series.

That's a total surprise here.

Shouldn't the btrfs workflow catch such problems?
Or the hook is not triggered for rebase?

Anyway thanks for catching this new problem.

Thanks,
Qu

> 
> Regarding misc-next updates: it gets rebased each Monday after a -rc is
> released so the potentially duplicated patches merged in the last week
> disappear from misc-next. Otherwise I don't rebase it, only append
> patches and occasionally update tags or some trivial bits in the code.
> 
> If you work on a patchset for a long time it may become a chasing game
> for the stable base, in that case we need to coordinate and/or postpone
> some series.
