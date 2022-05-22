Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1A53031E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 14:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiEVMjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiEVMjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 08:39:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2B2ED42
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653223135;
        bh=WWwi5gxcv2NjetkjmPczcUyZPkrZGFHV828y5Enzye4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W5sGy14JvEiIItwqgDJQBsVHp7SRzAe1caHZvca3TS1iaXCZw9gZOLdOQ8DhMu/2N
         nNN4bgMMG+AGudLdBbL+e+Fi5pJqFn/zsbTgbw1Q3n4mduKNiltn1Zjb41jf99qOqc
         CH90e172NArZ+bs+xEJv/QxH7nHM8+/bf4HfwZ/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1nRceJ2YkH-00lpYv; Sun, 22
 May 2022 14:38:55 +0200
Message-ID: <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
Date:   Sun, 22 May 2022 20:38:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
 <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220522123108.GA23355@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DqnoyyKdsptVJ86dJzHhS0hRt7PgzvZKEGygby5R+cdxGpYebkr
 Wab+c34Pq9wweNEqR7OMwOmTzxO/McHPej7yESQ9rc6clcLZRMQ9FcLXulMoAtDrnHMGDjp
 7ocyWwruwzEaI+xhJrZnT9qzpcYX3PTIqV69OAbdu9Tu4TEL38IV0NKXZy2Mcg4+g5Gjj9f
 KhsZhceI/fbp6arJa0sfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tl/1vNb5WZk=:DGx1FfBKZjj39irn6+g4i/
 RZi0qJDNuDBJXI7jxFOPOiaHbH0vVSXP2LOc8v3U8rS1eQsb+5Blj5tLl7bbm/7p4egbwaD9W
 XbvN+7Wy/bnXB7G73sXs+LERm+aKCRQHHdzi001j1W9fcqejQHUronbC9eTzKUZmr4Xplc/Dz
 VFSuIsKbGknsgRfAW5ZrlEou5kep/Bjc25CpkmDb4JPX8hZLzBZJh1GXQ4tJJknmwoOXuMXxK
 Wb+b+d1bRS+dIh9U4LN30rqGsUos+utpZB1gYNv/U6csIsINnAH9A0Qk0n5TbAk3aMM9H/Dbl
 L3m9dS4u6RTR1sD1VaILqbpNj0gEpe1RbJRqmnvNb+D2lNLWW5z6L6jEpvdxIqGn2V4TmldRr
 rZGK5kvQ5Rg7fYqZ89bmXJ+5kubiTnIC4UvW5/nXqlEyIzmODw+gVIt14oAUrWvGC9CMASQNs
 vfen+Y6JJmDS+85BhOFuJ1ExAcqhrFw8U9U/Y62yvzwNoAjrhZgG1KJBt3MYiNtCZsKkEwGtn
 cI5kbJ/nz9cFtkDqkzHq9+WM+9omSuSlK0SFyG2wlvQReiphJoprdocV+JWfpLKUQMoL+i7Dn
 qy/d3XLMAunnojqXoKJjfC8iVdaTja88iRnl55O7NRxl8kh9wenMKzEzPvQ25HB+gZPXWo7CX
 smLBEANOvQILZjkkcOVaD1eDv1Zz59GrjdABtRXRpW10K6G/N7AAuKCN0b5n73x5ph9DWyzHd
 5LlFfKUFc+ewKFaz78Vzzb+88H+csvzvlxcSBDJJ8PjNhFySgxCV65p/eXbtm0RFcoYW9upKH
 5/mAF37+LpxbtGAXr3mjtYi2O+aH6zXMlqQLTrS3XtzyyPOtqUUF3OqubHEWIoPlOa6Uohm6b
 K8eHQ20v0NYBXeCGs9PRArX6xj5mCXbGYnyw/IAjCMNswxj6qww9+7wQNvDugtD9uDQlCiki3
 cKzKG9dI/c9Y3gHMdSF8Vux8SJrIGH9s5j9s8qUfo2iV9otTQ054dY1h15IFMEXAxONZNKccN
 WCFvD1PGTsRlIUaH9xXnogo8NhXl76K4LNDkMpT08abXL4/X38w6vGcEhatPDDPYJi+ktZbwy
 JmNiBXC5BRFZHiT+ajMLLUMoBWqK+T/n0CxQCVXfY6RMp8xndQbwIvm5Q==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/22 20:31, Christoph Hellwig wrote:
> On Sun, May 22, 2022 at 08:21:47PM +0800, Qu Wenruo wrote:
>> In fact, in my version I also want to convert the buffered read endio t=
o
>> use the helper, and get rid of the error bitmap thing.
>
> Yes, the buffered end I/O path could use some more love.  I also wonder
> if splitting the data vs metadata case might be good idea as well.  But
> maybe we can finish the read repair series first and do that next?

OK, that makes sense.

> 'cause now a lot of the bio works will depend on the read repair, and
> I don't want to block it on yet another series..

Although I believe we will have to take more time on the read repair
code/functionality.

Especially all our submitted version have their own problems.

 From the basic handling of checker pattern corruption, to the trade-off
between memory allocation and performance for read on corrupted data.

Thanks,
Qu
