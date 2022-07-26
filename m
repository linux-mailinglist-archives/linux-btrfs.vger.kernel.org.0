Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975A581BC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiGZVrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGZVre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:47:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76E32D9A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658872049;
        bh=m6GEf1NF+wvR1bG3MTdPbDEm7dfb1Vsy3aQTIu2rGrM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=kY/0U6WCHrodYFStiLbjEnR620b5GV6aaCKHj2g8MJ4/mD+7hrD2XM9AYIX7kbluj
         AXjzgnujnabvAEogF3HFugVL44jWhg1HUpxDSZCsUgGJQNkwxMksBM72VxPWAT08yA
         tusvGG+6cMozLMinkREotraYI9SKjyGbN47PhAEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1nWd6f0iTZ-00xrGB; Tue, 26
 Jul 2022 23:47:28 +0200
Message-ID: <56492a5b-8d98-38af-50f2-57a75a3417fc@gmx.com>
Date:   Wed, 27 Jul 2022 05:47:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658293417.git.wqu@suse.com>
 <20220726175922.GH13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220726175922.GH13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CScpKtwGGy8q5nROgpEZKPEZIw5kSQRI7JKbVx7LTnjRc+0MRFM
 YbnuJSpH2h+flD1LVFd4iDXLzgVh9F4QShvsg4dtKH7AuHVmcwILYoAVJde0j05AJVgaflX
 xjmNIs8wPJXstFwyfNSUrjtg98Kn/3jfc5kPhL8Pk8dCOiooNlMSCaU/N/ahg0XoIkNcBpx
 8ndneWSqSFHDhZbfky/xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHNq2HeF67U=:zmGwbneLETjjn2H9uQn5Tl
 1aD2R/44A/aWbOChvd0/lK+ipHn5cKukVqfdfCna/tIHWopB0u8oBSJBs7WmcCmZ/em0m1hq4
 kpFkZcieHbv8z0bC/ODHd6A8WCiavMso+CbGtdcs1X5NDRwPwKBHI5K6Cq8AYBV+xbOhn/+Zp
 34bC54uwCRdTr1/ClwcK2Sm+EpuXyp5IERCQv9VdZvy0FmsqQJUIo/C9oXD788zIV8UHkl2jt
 ppIJht7K0tzdUbsbc+17/1PkIaRILjm0FarGjGLXtVgkI3v//SPXcWkKM1FVMVRjsYXqjmoUl
 sZcxQhu9MSF1u4Jz12FcwVPlrqPj1cC0VU2ULqdtcTEjvGUwTdV1QdfREn1rY/cyl4nAnRxXi
 6/OsM3T13ihdef9pqluz3xPq9ftuCpEFcTmS9hPgn8e3NuOkjpsCQk65sJZNmeyh8IWMg4rh4
 /TK4TFucS8X4DkC9PAgOvw0NR9ns8/73D9XU/CXjR7KP0befDUk88tAyT2EhXPhIkDC47bm+k
 PQTu8FJaPVqFUA545t1eOsOGHdw07ZQN15SqQFC/m2kBbHeK13L5ariOc7/pp5wlpTtufm1Gq
 C7e6CJjd/Cgl2CZ+IYyIOczSoDpKqo1IC1pXGES2tcrKOxi5L9YR8iiaQkq4BwSQlAqWT2O1t
 GDz27PcdV5yaCcTVwJxyHNdyPqQpTvejYS9w9srBASxLXqhxDnaLn4pqvbr8rRwKntVVbLB0u
 9kUF1bVFso3qWbHOnxOntJxSohTzcxFh9zpZsGu9zUARczZw4+YuOG2lPpNdWy2StfbLIypy8
 RFNkSPTa1/XXh/pDzE11UlBSCf+4SDmCw9fiM57Wieggg9zn+L+MKehMrTAj+vDRaJT75xzeM
 9roofHsj+76dx/MhUtXi3WelpKpbR9vs6WOTfZNhbLmS3XuAl6bDlLD0457ah7du/7vQHPshk
 s7YNdRvoGeNxJ+kcVJlrkXlz3sc543vPp8a+/T64vRLG5S8t9MiWrxcbkz8Kg4GxvUSMid81A
 nTN6b8dq3jCfu0pwX+cOASUN/be2d2WYihJoPjeGdEZKbXBYCh+ITD8Gzvkm/oHn3TcUq6jjQ
 RID7Ph2liI4SkrfXm6ketG9qnGkyhIBxj2ZoDqVkx5cOdyhn0tvx9Dwog==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 01:59, David Sterba wrote:
> On Wed, Jul 20, 2022 at 01:06:58PM +0800, Qu Wenruo wrote:
>> Qu Wenruo (3):
>>    btrfs: enhance unsupported compat RO flags handling
>>    btrfs: don't save block group root into super block
>>    btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2
>
> It's short series and I don't see any new code to use the separate tree
> for bg items, so it's on top of the extent tree v2, right?

Yes, it's based on extent tree v2 prepare code that is already in the
mainline code.

>
>  From the last time we were experimenting with the block group tree, I
> was trying to avoid a new tree but there were problems. So, I think we
> can go with the separate tree that you suggest. We have reports about
> slow mount and people use large filesystems, so this is justified.
>
> Will it be possible to convert existing filesystem to use the bg tree?

Yes, that's completely planned as the old bg tree code, btrfs-progs
convert tool will be provided (mostly in btrfstune).

Thanks,
Qu

> I'm not sure about a remount, that would need a new option and for
> single use. We could possibly use the sysfs interface to trigger it, or
> leave it to offline change by btrfstune.
