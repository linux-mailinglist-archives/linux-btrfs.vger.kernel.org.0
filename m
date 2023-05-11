Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991EA6FED0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjEKHlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjEKHlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 03:41:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABBE6D
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683790865; i=quwenruo.btrfs@gmx.com;
        bh=wOOKwcrygTyta/EzYPF6FDF1fqcK/0r3EDBR/WFbKI4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cTAu+V/M6MVdkEP+bMJpyLcKAlvkPNY4KIGi/WGED2ENYpEpuTC9tOctc8VTFC+Z2
         zZIgxh/94DLvF/Xd3ivG319REFpQBJ76BqnKdZwRfydRv1bUmU60a6iPH+F2199OM/
         215CsFJAyPqBXKxmTMQNERNRYNpV1X6qGBJ3K63b8D+4Z0f0AyIOvJf9lcoLTHMWWk
         lIYv5qfIlUn7niGlBh7kLZE4ea1d9Bug8wSLWri/CUXelkSM1IZSYi/wwvWxU7yHKn
         PMvP+0OkI77QNX7Blj4CwSPKzyyrXrxhiz1TkcpWqJeQ5oL2pPiJomTSmubV5I6B+c
         7+MB9UFRNQ8aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1qNNXk3xjc-00zquZ; Thu, 11
 May 2023 09:41:05 +0200
Message-ID: <2bd96f37-0a4b-75a9-72ff-3e6b7411ab7a@gmx.com>
Date:   Thu, 11 May 2023 15:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [bug report] btrfs: output affected files when relocation fails
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>, wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <18dc983b-cd00-4846-b820-d71d5bf6b8a2@kili.mountain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <18dc983b-cd00-4846-b820-d71d5bf6b8a2@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2dqOHpVw+071Z614qdskh6M3NY4rA2M+fpNeelMyhxMWzQ3Wp/9
 2wnY+NNizoDMv3Yp+0X5EXf+iLSwvnMwmxc7vMdUBuTIezpou0Fw9Hhs7U7uNvbyUR9tVQJ
 uFwiI/aTBImJXE6y3MYgXjRaFEfculE+YlI99AwNpFOsujVmnSdkYtIPPU3b/wm2X5mmBDx
 CdWZ3bfWm9cHZUa2ga4rA==
UI-OutboundReport: notjunk:1;M01:P0:PTnz4natIzY=;+Tb0xFI0nBUfIiXybojbjg04fCb
 orRjwqV9xZ2XT8XIrBp223jxs5ydzphYFr1PrdGAmEmb3CFFuvK03jBuj79OQreCwgxQMeTqr
 4aBECkSaP5P0RYOlUjEw+Hf3I/J1fNm//GT1dx7O78QzZOk7xaIS/XqAaS+5uq7arepDikL2P
 xE2dLbCAfE9CFDD3m5m415Sl3THuWT63toqo5rcuQqkpcylgSzwDPGEFeJhstmRVWgSbQV9iu
 5Don3JkNMbNOTKsJ77jdm62K5STJNS6KYyis0JcKsntLpqABTDMMXTefW0NLZiKL1yjbgpKSY
 j/t74i+rnhiJ5JSuZUMvwthe8cO+US8PsSqOUk0JzshwqovwjGJ2vgdgo1m4ldLFBCrxJAZag
 F1we8WvPT/Cb+jAChoSFkFw+pJVSr1YtJbdNRdJAvudFEX48u7qUTq5rTKPis9rcb1mVlLErr
 zG/kdIojmCaQfBHGjt34XcsFuWlZ+djxBHygakkO4FDGt24g7L5OwObqSpiTtuP6Lid0lwxD7
 ldrjgYO8bUV/6blueB9XJ0jHMgUghPctKYfkEhf2/t/6OeD1TM6KFb/RCX+tUvPpKdE64JzyX
 odrp+4XRCEPtIIo8RSyv2FwC/Y6Mc9DN9sqFPPnMBNm7fxVkkTzcnfquDmyR6SoDW6Io9X8mL
 DyuC0/EFvoh5aM6/OadehX7E9yWprjwHNvu3RkSGf8TU1GGsCJgFgQC4n1dR31CjHTO1X5AAy
 znSMWQH8+aaBgQBk4DVIEYTwRU6Ij9wi82hOmDJr3+It2h4/wZHY/Ij8fJSxb7DBB2VeRG8nN
 FnB6ouZM3MMfwLScG0Pjyp7v9IDtFQVcOFPpJzjv3B7zdg7+o++oruzYDFka5GL7cEc0Na3eu
 PqkWpAlXrNQPJFsobnNSXr/9UhyxChcCK4dmqijA+9eSIzSc20uJPD1Zmi9kZ+jVlicCNalA9
 i22GaTQ5YuPImzQJh7NPFuj4BpU=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/11 15:09, Dan Carpenter wrote:
> Hello Qu Wenruo,
>
> The patch 3093caaa4d16: "btrfs: output affected files when relocation
> fails" from May 3, 2023, leads to the following Smatch static checker
> warning:
>
> 	fs/btrfs/inode.c:283 print_data_reloc_error()
> 	error: uninitialized symbol 'ref_level'.
>
> fs/btrfs/inode.c
>      274         if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
>      275                 unsigned long ptr =3D 0;
>      276                 u64 ref_root;
>      277                 u8 ref_level;
>      278
>      279                 do {
>      280                         ret =3D tree_backref_for_extent(&ptr, e=
b, &found_key, ei,
>      281                                                       item_size=
, &ref_root,
>      282                                                       &ref_leve=
l);
>
> It's weird that we don't check "ret" before printing an error.

That part of the code is from scrub_print_common_warning(), which also
has the same the problem.

And thanks for the report, I'll craft a fix to convert those codes to
modern standards.

Thanks,
Qu
>
> Also ref_level is not initialized on the first return (error path) or
> the second return 1 path.
>
> --> 283                         btrfs_warn_rl(fs_info,
>      284 "csum error at logical %llu mirror %u: metadata %s (level %d) i=
n tree %llu",
>      285                                 logical, mirror_num,
>      286                                 (ref_level ? "node" : "leaf"),
>                                           ^^^^^^^^^
>
>
>      287                                 (ret < 0 ? -1 : ref_level),
>      288                                 (ret < 0 ? -1 : ref_root));
>      289                 } while (ret !=3D 1);
>      290                 btrfs_release_path(&path);
>      291         } else {
>      292                 struct btrfs_backref_walk_ctx ctx =3D { 0 };
>      293                 struct data_reloc_warn reloc_warn =3D { 0 };
>      294
>
> regards,
> dan carpenter
