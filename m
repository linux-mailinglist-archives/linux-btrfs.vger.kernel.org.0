Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEA5AC1A8
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 01:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiICW6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICW6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 18:58:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7284E841
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662245883;
        bh=fuLVsPOpH6nIg9WN1bItqI1bFUZJawHI5JbbHDFZcaA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LQHCcPC7ejge35PidbeKm5hFMxGB4cIMw/89gitwd/k8wo0zC+oaMndviJUUNR5qF
         QkD5yn6yce/Rh8pb8PFXpIqjUcEWq4JZlwWpwvugCX9fcL0QJOkOUbAqPKdlLQMS2m
         Yiy27x4OAhEn8hmQ3oG7yu0KxHI1ouz6olym9OX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GMk-1pPcTb01C4-014AjF; Sun, 04
 Sep 2022 00:58:03 +0200
Message-ID: <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
Date:   Sun, 4 Sep 2022 06:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
 <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMk56c0eflvIe5PEy7qdFn5Jh9fQnu7M+A27vjfZV7V/VZtOL3O
 OlDhdM6HtfQ3hlIIcMscOhVLUaRbQSDMd/wVxzL7j/+c3Ngb4JZmsWpenwdfT5rhl1cTkXr
 Lxd7wXqXf4eErrABObM7TSxJcoXx+SHXvqtRUmzGkdFJy16Vm2fBqFFdnQxbO+hbR3uCPF+
 e/Ob6AD3yaFa2/wXpba6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z/IHXQXM3Zs=:Of857A906AsW0IVtxZ/Qqi
 EuNqjWHpVfFitTiJRdM1JYv1mpEScHfFXfBGWilzqxtLMzQuoY197TB//1HWvLOoG06Yeocok
 eSTTL0WbTKMyCkYxkcNya21ddvo+pDfItIA5IxV7A6ZIeoxbiSUUZmQ5FCJ6BOAvMMXvdgStG
 HaQdw3IFIdxFnt6uWWJEyQ4BywtGcF4JZbP6f0fmT4nW51KXwZJoMrnKEcpIhjTrDTYLtOPLE
 EHjfb9076X4PIHtwk788LG+mklHQ3+Qes3WVeYQDgqh6+yZcM4QiDKBUlr0vp0d4z06iPbwLX
 tSDP/mnZ3WsaFHmgT+vbxMf/Nx26ekMtFteoHKKJjCvAEZkp3mvGYZdXNZhELw+DKfc/VVo+T
 Rq/SOxYQoaXNDC+ovrADAdoePBkxwp917PZ5BFJ4tX2zEDO46VsZr6VAp5Al9wvqtTIpPmtYH
 EMKK4pOVSXecbgZQABbsJ/xl76PRJW64BVFDXgmntBuR7VoTrk7wZuYQyGY4AdV294GtPOCaJ
 4kNdRQ362GV/zD4gmw4L7vI4BQ2J7r6OfZFd2xwGRdhMUKgx9zjR201gWqERu8P5qcohI0pSL
 lIfbYNCfi42uW8caZt2C9pTcCr9u15awYPF/SHU2b9cFEOhVMz/ldWB1sxQw8Wg2sQgoFB0WR
 bWWJaRGECr7FC9vnCVVq4Jbe0LE6FeZo8UGYVd9Q12IjVOJFuP85y4ijVn0L8ZWbf6hQUzGlo
 Sfu0E4xyrJYEP+W0kclqDFc6NK9hngcQRIc74bO0fa49W44O32LBcPhMVWzH7XrWhlXHh3vEb
 xzEuB/ZESRJJQUoH8jICX9nkWlQ99LsLMQ/XzoYe4VvllDZpWVsG65gg++o7f43yW1ueOz/Mz
 x2vcV2Z8qRm58QQKblQeeR24n8DJ+w/R/pYVJDE7RsMtwLU/PZyAFkknqj6EyPcBPsqZlAt9s
 s0QMfsGj2kh4LbJ77+1w7RhZ8DEtnwaGFCu/t7VLzlI7ExduvCTA/6vFzcjU1thcYEtoei73b
 uzTxFDMdlaZ/TEPwuDUjcGSrWTUurLBn+pUEtwro5WgnPhtk89GcPTx/45sA1QZZKlrfSvGx1
 eY1eQHGZ8GlhdOeiEGMnKgC92lwnC+RwiKJz1x1N87wEgemsdoRxzLMIl10T8e6ZQHc4Yk79l
 hlqwHTIBFDXXx+D5AldZ+wU6JN
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/4 06:11, Christoph Anton Mitterer wrote:
> btw: This is on Linux 5.19.6, i.e. supposedly with the free-space-cache
> v2 corruption fix.
>
>
> But a freshly created fs with:
> mkfs.btrfs -R ^free-space-tree
>
> does *not* show the:
> extent buffer leak: start 30687232 len 16384
>
>
> Kinda loosing my trust in v2 space cache ;-)

Already known and fixed:
https://patchwork.kernel.org/project/linux-btrfs/patch/043f1db2c7548723eaf=
f302ebba4183afb910830.1661835430.git.wqu@suse.com/

Thanks,
Qu

>
>
> Cheers,
> Chris.
