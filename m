Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FB557529
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiFWIOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiFWIOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 04:14:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C448308
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655972061;
        bh=LHLXxeb0oBAluxhj3jeV2AF4TWUq/5XnLd5Edt1E7yE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=knwiKJAcMmnss9RG0uCZPIah6wEFuKFXH0qIJ5Ti1wAT2kctCgG/v2cShuGqXxYLV
         Mwn6QEcjDaekh60RlJtlLuAyHsXFixOb3yNvMyA2Ws2OskiOlOTR73y3/ViGS7Etu/
         g5ULe3Rj3dh2JLzNAFQESQuRx2OPzKsS0a+iEol4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MirjS-1nPkYi0oaK-00etPn; Thu, 23
 Jun 2022 10:14:21 +0200
Message-ID: <52dbd483-4ebc-89b7-635a-7f9e76341ad3@gmx.com>
Date:   Thu, 23 Jun 2022 16:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fix read repair on compressed extents
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220623055338.3833616-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220623055338.3833616-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wsd+39unJD0JoYwNTsZ9XAHtIBvUskf4bb+P3aFKnJyLX/fDLVx
 67BiTbuekkj34owgoBjKBwsi2/X1KchUECsybYmVQ1v+iJuzzS2AwT50JmWqjg/QNH5GUVk
 H1H1AttJQDzgm/KY2OhibVxWV5GVJRK2A4RcEza7a+u/imJYovdwMD0TpcprX/d4D9EMFVn
 tBJSUYqoTsqlM64bjuqAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgpg6Hi8kKA=:IXk5Ue2cFySty+qCYle/Jl
 2CQIc4lpvinCRIbJq+AoYjXg1C1qUIyNcO9hSGFvU6c9UNExr7KVWexStX2FSA9o2npQtK3IN
 ehIl5b1GaR+L6TWI1UWtg7EFtu0U/beFTkEtR0Pk+fwA85qEJ3ijR7qp/Wa3WFdjjmVXEhpaL
 tI4scl6TLHHR+iaVBjHEWXgTO9llbOiacQ8PPdJUVBh5sylL0WBm6LNzZfsLfzl4f7isB6AuA
 3JEz3/M+SxLHrrFaXluG3Po/f/DO+Ul3uI0jsVX6sWIhWpoBE8cadq18Cv4WLYkhYzbP2Nxd/
 0svMLbKNotLGO29VO4oLcnNiI8GCnNMwmnoBS35y3ILZZDaXYXk/lc1w7KKHqkdYW+4EKZIfg
 kgjHEUTEGLQ9MBxcE4DalESfay6uyW5OlXgeGcuSPrzVS3RnhXZYFYWvCDfDGFNofoKKC/EyN
 cBlFl+uAPBVh5XWFVDpmAgarQ7BK2CsIlV8xI/l+EEmPTG78R3xgYAaA8SqFMlsvH+mKD+o3O
 i8PPbXiKJ93t+kSut396KJiCh3vCFaL+htN3PQ0ZrC8J5CIWLDVuwtnraoLJbQDPT1t8ZTorE
 vqspeWhw1apm/pFdR52VqY/64w9+EYz55UtLCfSmCfCXoE10rWhB3PJnDEqL/b3UTMQ5o7oy5
 Dod/ByKWcn5mfphSJFPfma1rJnSMa5JkLqBxmVoUmdgp7f4aOZnR1lvNEtqh5htlPo1qIVIcL
 Mr8r9v/tiQMefnmn5ML2Gfa2iFm2D7iS8DeOmHNAsQDKP5K4B78xb/tyejb00iDwD9Fnav1/q
 xiGNLuosHf6C92DZBjkO1Jb9wlDrpTmgwggwAzLeWg6inzmSNb8mMnOCq91W8TY4w+R4oTAtS
 sIYygDZOJif3ueGC6GQac690dy5Htf6O0syGyJ5Oq5yP4mFbBFmKPlUqQcNUnHKbHNvMTzUkn
 vhyMQ3vRPZFBf3cnGA7zi9sjex7lmCnC+sADGkrwmGYcGa6b2rr7wghxFhkSNTvKtTdz2FyTN
 jZDQAGWF2919h/pE4HpQwFVYI/TJEAQnqNTZsRWYaW/swIPy2AdwGVWawHnv1fYhN4E3ORA6i
 Qpo7lM9m8ce8DizLE+lXsuvybst0I0yuqcR/I2n288WFl0Z2Agt4EPD0g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 13:53, Christoph Hellwig wrote:
> Hi all,
>
> while looking into the repair code I found that read repair of compresse=
d
> extents is current fundamentally broken, in that repair tries to write
> the uncompressed data into a corrupted extent during a repair.  This is
> demonstrated by the "btrfs: test read repair on a corrupted compressed
> extent" test submitted to xfstests.
>
> This series fixes that, but is a bit invaside as it requires both
> refactoring of the compression code and changes to the repair code to
> not look up the logic address on every repair attempt.  On the plus
> side it removes a whole lot of code.

I thought we would fix that after getting the read repair thing figured
out and just use that new read repair facility to do that.

Especially considering the similarity between compressed read and dio
read path (all handling pages not from page cache, needs extra structure
member to grab logical address), it would be a perfect match for the new
read repair code.

Thanks,
Qu
>
> It is based on the for-next branch plus my "btrfs: repair all known bad
> mirrors" patch.
>
> Diffstat:
>   compression.c |  287 ++++++++++++++++---------------------------------=
---------
>   compression.h |   11 --
>   ctree.h       |    4
>   extent_io.c   |   93 +++++++-----------
>   extent_io.h   |    9 -
>   inode.c       |   34 +++---
>   6 files changed, 148 insertions(+), 290 deletions(-)
