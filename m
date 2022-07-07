Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA0569A0C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiGGFsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiGGFsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:48:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E125C3
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657172894;
        bh=nvvcDVtx+2gOn/xjD/VQ9jj7ib8RTbsKxV578lFv6+I=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=hz0mjE/QWpK7stNfJHXXIUeLVy8szcyOwNN81ND2HJ0O1mVgEzq8fPovSdchtryHW
         cYw6i9+j+afDcTGFcPsKtnq8tqiazD42E1dV8AQnzCjxHFa3fvEapJsbzD2Ndcreji
         xvokJB5q2CemOLVWPXFm2k+WMJbKuuHfwNUiOg/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUqL-1oIvYX09XD-00Cvoz; Thu, 07
 Jul 2022 07:48:14 +0200
Message-ID: <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
Date:   Thu, 7 Jul 2022 13:48:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
In-Reply-To: <YsZw9O8fRMYbuLHq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dftzf2+aI8N3pocodQ6sHm47/4sXAKmHCJNrcfiVD5MUAhbmMn
 n2bGvp2PNHb6nwKIS/tsUNpTk8z4HZQ43wnvDzMWHWhljH+oyVlEpBmU4wvxQPxm/D04Y3M
 XbdU41EVCz9s43hGNxKnX45O2a/vXmUrirGqdz4iu/EqP6ILtxMltR55P70BHlgVJV4juvO
 Eihz50qORAfwdFw1MirLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wjFBTCIdh5o=:dFSYbLtRdNj9kzDulKCrQG
 tTxo3gsD3QM6+hodR6wJepgMYB1ee7sNgneQn5YDHt72uGm/b1qMzVqAh1mPxAQXyQiV5RWLc
 qj3NDH6mXEyZaByidH648Kicl11eLF40aorMdwT7dAO7vbyzD1OKSrBUYp6TaKjrIBGxAi3F6
 Xgfr1Z7ivMMa0dd52IwwBKwUX7nfjRysI118AAlHI5ftXkMhdM5/HSKolCFsuhjPVLuq39GYD
 WkAqGPDCGOF4qM+3vc6F7VCOr8O+EyXncev+VteVs1TPt5/9X4ktGXFV/h9PlwAYymD5mEkB8
 ZpTMWD6TcAIIjZYCoZrG9TesZTQvRif2uGrWRs7RJC6e6kJ4la1cN+FRYQu347+bGtL+aFLQs
 JC0993nUiCfT2dQW68ABBz1YzjfpbcsTFYRpW6m8lAEWjKmeBXxF8Kc01fDz3q6jy8xXMKhHg
 mEXEq1BRBxGpVsut5pDd/+VbnZZ+7n3qnFRJkCiNMiBVOxRdthxe2IEWb2mAB42NRMSdb+6C4
 zM+UEivA3NrpcmdlxJlTCGZdc1ZNjoDpmkOUvTNuP1XnAhTCgadtJmDPUBAjSoEFfYmjDPQfN
 TTMD+/R13aLURfxUrot24j/uzUbDvEYoiaU+3YJwzZasbTGh3ZfPFxN3Sa+7OOmINXHxIC7um
 nMBQmSjoLj4wA6un9ZT/TnhjA0WuiwRqIblKBqqBf60QVLKkmJ0oNT9LfjZ2vV2iNNikfxE9q
 v+h99yNige8eejqcL3AepglqyRMynkOdLzZH89R30YdeB5dbly4zyLDnkVZ7gosSV/ROpeR5R
 wlWRHUyBco4RfDjAtWY5WeyeeAwN1aLKMK0dnK9kHyHW0+A6IeGCZOwioe9CLalmtGBzqanh5
 96JvfIoTdbZ7Nsgvo4yGuDzFik67IL71SPW2z68vFeyaMFqiy7arVsHQfp+20OLKOlbIlegJV
 2W05aqLATIWeB4ySSE48C4+R/Z1eR80eAISqvdYNjJ6d2oboCPkyOVURH/1LMNAJeTZv6Iaqp
 R+wpNXj8UzbRXIW1WOw3mD9ZmNmyML7gD9Jrx0eugGxw6/5tnydHuIFztB9J+M9tvcGmGnfwU
 w0EPnbnVNbpMKhM+H13T6qbyPbLo7sRjn9RP+FMGTvUPqclOeIX/BbTZA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 13:36, Christoph Hellwig wrote:
> Just a high level comment from someone who has no direct stake in this:
>
> The pain point of classic parity RAID is the read-modify-write cycles,
> and this series is a bandaid to work around the write holes caused by
> them, but does not help with the performane problems associated with
> them.
>
> But btrfs is a file system fundamentally designed to write out of place
> and thus can get around these problems by writing data in a way that
> fundamentally never does a read-modify-write for a set of parity RAID
> stripes.
>
> Wouldn't it be a better idea to use the raid stripe tree that Johannes
> suggest and apply that to parity writes instead of beating the dead
> horse of classic RAID?

This has been discussed before, in short there are some unknown aspects
of RST tree from Johannes:

- It may not support RAID56 for metadata forever.
   This may not be a big deal though.

- Not yet determined how RST to handle non-COW RAID56 writes
   Just CoW the partial data write and its parity to other location?
   How to reclaim the unreferred part?

   Currently RST is still mainly to address RAID0/1 support for zoned
   device, RAID56 support is a good thing to come, but not yet focused on
   RAID56.

- ENOSPC
   If we go COW way, the ENOSPC situation will be more pressing.

   Now all partial writes must be COWed.
   This is going to need way more work, I'm not sure if the existing
   data space handling code is able to handle it at all.

In fact, I think the RAID56 in modern COW environment is worthy a full
talk in some conference.
If I had the chance, I really want to co-host a talk with Johannes on
this (but the stupid zero-covid policy is definitely not helping at all
here).

Thus I go the tried and true solution, write-intent bitmap and later
full journal. To provide a way to close the write-hole before we had a
better solution, instead of marking RAID56 unsafe and drive away new users=
.

Thanks,
Qu
