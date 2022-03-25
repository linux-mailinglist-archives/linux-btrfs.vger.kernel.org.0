Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629E4E71AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiCYKzU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCYKzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 06:55:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E333884
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648205615;
        bh=b2p0fjLt7Ij+Xi4Dg1O/+oqTOqC+AwwJLlXVVegSuQg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F/hxWdEDXxfosBYCHg7JPzKEApipA4gBIv9VAQ3AaBMORnQiFjDwa+MBm5Yw+rWAw
         TtMHzZRJImLSoSruvlanGFxZtVfJGsCy931UHTDeJNpvx/BThvY1NCmd/eDuK4MvfC
         Gl2CmyHw4FbYgu+H1AFOt6mXEkKMn8uZ4qy32JeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1oMlmu2OQk-00tngU; Fri, 25
 Mar 2022 11:53:35 +0100
Message-ID: <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
Date:   Fri, 25 Mar 2022 18:53:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yj2ZALUKtblRSaxP@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S/OuLTtfVQQzoTfq1ATDY2eJpeCBVpbIAmpYXW0DW/Fue0vpIg+
 +R03hBTRQbAPPSCCQK+r5PP2LaHMJpDFEV/bOj6YL6Wo2DsJaKVRwwIu1QZr+aBs+uHPiEq
 zrjpR3TITPFMiPka3KD5WlEACncLD2ruzsq+lXGrt63i05pHj/Fz1TBe9zuvhFrQiZp3AQY
 2icKgchdhQVzngaIEUEMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gyxwiDNb93k=:ELVXoIsrtTzfWsus4P4vSd
 O+a7e5MEiq76bO9tR7XqSy/hTkTxM7VQYOiGPe12suWKxj66BrnHgQYA5gL0wXf9ddVR2J67m
 upNmHAQopa+HVYCfcOP2sbig0OkAUrP9EKBTpG3b1x6p55WvOgIZEb97sB9UJBCl81sr6TnGp
 DpfsW7IAdD1300jRED/7X94FIukVVJjxw201OhKeJI37gmZ3IxjwL5wKDjl4KGRjWwMw6wSMT
 lSybvQsfWBvz+8UEkUdi2pNQ5Mfmh15+fUC2YurjYG6vfgGFcT0S/DpAiHu00gefP7eMqE4jT
 gkWi1ENBbHyRpuj/BNDWA5xOKIAJOkj5vHMPsdVGWuN0TI1yosT3sJlMxq9q0HqEgOzHuJhZI
 XWAjHo3dj1zjt5StyAuTBS4X0MYspmb/Xtwermfcvoq0SPkQbbHRxYfKdnlSMWaEQFNMnFROp
 UIGvY0IyP5k3EgjJU8C39TF3V0gvHxrFsFww9OEkyoKBdD4ORUJ0yyVwA/jwz8ufisngdOe8l
 lfZuzXAjSJ2sbHlZWom5SKCTLw7cw4YoXYkgAnJKoBfNjqCgLXM6e0iWy3Rk7qHtkM2Ojdd7S
 btIabucXVCbln8Kj5jp4UrRNJ7biyjDvXOzMxlMm1vjh4lId/OAjBowbZwU2YdC9ZnFbZGMRL
 8xu/FHiSGGEmcrpM7ZLRKApnE0/kYBR7m5MMLIZYaEFFGS3KvCEj9L9/fsRF4o9FPmXtNIU3c
 4BeNhCpGmNLJAMazQ5cEsLcpGSsSUqJHh03LWFj1gWDNavblAEzJnxrdv/UuyOuO52f9gcank
 FsXm78G03RHJeQ/voJmTAqksF9vdfn2PxkPCztgozTnsN3F29PJIwCWAwi4Unm9IMe5P2/HMk
 KInxMfy8dExjRHnTizk3pIuyJoON71jja/KW/pdzsuzjs7qfkG+cCCYhhGkVsZiUYBJnTwdIq
 tGpU9CeW1rGOgv+Lo5ss37tX6tS1C09147rdhqyEvz+d1jcCTBKPwWhf2jz6nwpx92rxcw9bO
 vsoeJXbm+4G4eJqM+4AN22XKZSSBcKStCO4DUcBQKTj8ALjG8V9s9FuxINMVSB3n3fSps/1Yt
 hK4ILd/R6CuJDY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/25 18:27, Christoph Hellwig wrote:
> I'd suggest to at least submit all I/O in parallel.  Just put
> a structure with an atomic_t and completion on the stack.  Start with
> a recount of one, inc for each submit, and then dec after all
> submissions and for each completion and only wake on the final dec.
> That will make sure there is only one wait instead of one per copy.
>
> Extra benefits for also doing this for all sectors, but that might be
> a little more work.

Exactly the same plan B in my head.

A small problem is related to how to record all these corrupted sectors.

Using a on-stack bitmap would be the best, and it's feasible for x86_64
at least.
(256 bvecs =3D 256x4K pages =3D 256 sectors =3D 256bits).

But not that sure for larger page size.
As the same 256 bvecs can go 256x64K pages =3D 256 * 16 sectors, way too
large for on-stack bitmap.


If we go list, we need extra memory allocation, which can be feasible
but less simple.

Let's see how the simplest way go, if not that good, we still have a plan =
B.

Thanks,
Qu
