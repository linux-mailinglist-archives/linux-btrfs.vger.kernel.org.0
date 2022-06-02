Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3A53B2C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 06:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiFBEkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFBEkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 00:40:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921E2ACB44
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654144809;
        bh=P2kXtr9xv5VAYfwZDT36cHvcC8UA3h176QbYgjga83M=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=iJ4sCEdn2UdL5qpygEZTXVdiYdQA5/XZvAeLLQlTkwmol6D/GReX3h3WwVENqF7q2
         LcWApqaKgpVf1vqblmZ9fSqAs4fKloCm96rBEI4MQ4C+7TX4JFHrbYVCVJo6vxr2rC
         XPR/6+FgSLnTRSSlnuuT2L4SKS7nZnaxBHhqMcCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1nHD8k0sJd-00gLFG; Thu, 02
 Jun 2022 06:40:09 +0200
Message-ID: <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com>
Date:   Thu, 2 Jun 2022 12:39:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Matthew Warren <matthewwarren101010@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Manual intervention options for csum errors
In-Reply-To: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gt73FoFnoSc97QtNxerCfaIHxqfijie+xiPpjbBpg2S+5QM/M7E
 wcybYHEPvBVAD5mVeciQ5oWh9Lh7OI8liUHJTjWifM3pi3kgh5dvuLf104uW2ozgVItNvya
 BIc/avxqB9X3b/VY5aCekItX5X67Ea1LA9K9aKih2N5hsgQLxXL5vz3CDNJZZmH0BzkvuS6
 2qIw7+7kkWTaMPvLYC9rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MN4z7vGu1gU=:V0hMSR48dw3ff0Jv/eOQi8
 ZeEpLZzCGfcVRUJdSCATwA856O6IQLnGfVxSUFtABUf1xzJypiV6txeuc2WBuq/ylfpl6gn0Q
 AXXeZu8NRnMOeLUMFDBtGslFnRE/6ajOt8RPiRB+uck5DDONx5hw3w4G8hMSpKOTqb3CkhPHd
 O23yIlSvSXyY/epagasJRgslZ+uEsRJ3w8PUQj9asYFyhWWu/eQljck5WHuRmSiqw29dcrnKF
 oT/JJSDKNkHco82BBtIDZ48w0LVSjH9bQq3XCd/Dj/JO3+3ZJ1qa9hSbCWAHIMn6uP3dYXAWJ
 ejoRfAdgn4nChE+fCp4Lvg8h56C0GhMGizDztMSMPZYVSvTtWLhJ/y2ssP0TuiTFHoYRxyZn3
 8K4LpTgd1+xmaB3GiLHW1ndLCGLTMQI5cviDBwza9CB23VGjPrENMzTFMxahdY2Ldbn+U2v3N
 C71iuH+rNqmliRZBKxQUu9auwOJuk869o/RDAT6DjrxeRyhKfHH0Wk1Mkxx9YTyIcavS7AbLK
 1og0iqdeOMIj49vWzhfRBa3NQD6cgE7NQUcC+O1+i9/fiCYkzd+aShEEJrXWdKNubAh+L0VlO
 /yS6gvGRw1Lw+diOiFHmWAiabcc2P7PBksjOo0O0z04RqsbEaXY1R0iAJzqSEx+Z3bpnnOWec
 qoU5e+ImO+7g9DJ2XhiaAiTbQVf5VlyFJsnNZOFUqYNMhU2B0425/9Xo/kLQKRGWFtPx8qYqK
 xzd3IrJDNWvPbZmLLWS4GGrZrCpptmNvOxYBWJOr+hhc3HGBOVPcoWCE9LYIqB66Xb2WgCwV2
 KP/km8geqX+KUi8TCkgRhsRqWcKHCL9HlISvyYI+00u8gLkB0XqYxB0zuLVlPrqugPtuMcWqK
 3jrq+AmZs+euNIp3mHPYvkGe5C4r1U728YBLGUJ0PyriWNbNyuZrICz/NfOkyjjaJ7+x2lBkY
 7kZxuH1Zc3eWiZ7ma6G0LSfeOj2NNe170bgu1oV0UR7+bGNQGOiFguqrCtA7Rujeb15FrsP64
 bZM2E3CdKg+eUNZ8fkN2ucH1CbEcgy97GmT8KT1/kXVi5YgsrXiEq/teyLO/heqmQNTqCXJTo
 d3YU/C33lvDAy1Gy9RwrvLUhz9AlDzTU5HJANn4ZEZj+gAohOiPwhAMdg==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/2 05:16, Matthew Warren wrote:
> I have FS which is currently not in any sort of raid configuration and
> occasionally a bit flip will occur somewhere on the disk.

This is not a good sign.

Such bitflip can only happen in memory, as if it's a bitflip from disk,
then it will cause the metadata csum mismatch.

So this means, your memory is unreliable, and a memtest is strongly
recommended before doing anything.

> It would be
> nice to be able to tell BTRFS to recalculate the checksum for that
> specific block and assume the data is correct. For instance, I just
> had this bit flip in the csum for a non-important file which I have an
> external backup of.
>
> Jun 01 15:58:04 planeptune kernel: BTRFS warning (device nvme0n1p2):
> csum failed root 258 ino 63674380 off 208896 csum 0xa40b3c39 expected
> csum 0xa40b2c39 mirror 1
>
> This is a very clear case of a csum bitflip and I'd like to have the
> ability to tell BTRFS that the data is correct.

We have the ability to ignore csum mismatch and force read, but it's
only for recovery purpose only.

You can use "mount -o ro,rescue=3Didatacsums", which will completely
ignore data csum and allow you read the data out.

Unfortunately since it's a recovery mount option, it has to be used with
read-only mount.
So you can only read out the data and save it somewhere else, then copy
it back.

Thanks,
Qu

>
> Matthew Warren
