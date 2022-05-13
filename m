Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09FF52604A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358237AbiEMKxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiEMKxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 06:53:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079B2181CD
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652439198;
        bh=CmddFT0owhPZm1GcWDQpXBxXBBZeBUoFlbR5pbMV5/g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Sb5rL7NnxsmHeyFScPoapHCkRdpRP9AYwoXctPWCE2XpEifvmLwCzMzANyxcJpaQY
         2HoD79CAJN3+UVYDti4Qa2wKltRWadVlDYPGt/CpAjGzZpsR2evXFRS+LaICEFXTzB
         z8Zrm+0S+WhDVVHEnugyZfyiJTfrWq01F6WfshaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1o8nF10siw-00pKY4; Fri, 13
 May 2022 12:53:18 +0200
Message-ID: <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
Date:   Fri, 13 May 2022 18:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
 <20220512171629.GT18596@twin.jikos.cz> <Yn40Fkhz0jyef1ow@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yn40Fkhz0jyef1ow@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NucAfGb923TxdpCKHaFh0MSlsffbtHmhfhprp6dRYNEtsxb/Tdg
 1a87CqqsUzO4IttbBvQTudmkjmnoOPbvtMsyiRdyOzaiYMLnQhRQHxzBLr2/ZDtavjmc2+I
 izIBwc3k3uRH3OH8y6jMzzn9mOYL3zTIK4fXtdhI3Fye9FJoC02PUGeUi3oHRzWSZ52mbAt
 NAA1ODQXtL4l0NFHYvtxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9fthHLKemBc=:G8V0nhlbpMOMXSj+KfiJmu
 WJG79hHtUKqepz5zpi7z404vm0Aj690lwu+bH0EbbFJdD30zolPGgS4zEOgXwK361G5QFI6/Q
 pembi25Ax3/ErcG2p1akmBoTn/Ca5AyL5iQug6s37vZIXP4/nQq9PitV9f/kCO783g8Ymw1nB
 qnloEGM9xG5BdCZsukf5+WX5npqym3FqyeHsDK5RsEo8EMAR1uey6jg4ruXDky0mgVHlhXBLa
 yV0NXqzewGum+zHBJwPxaks6jDvXo1WsLOpF0PJYosA2tizsSOcv5bR5EiMZLg2xc+ESZNYDh
 x27nDCpSoHAgNvSos7lxMxne2Kj5xWHFz8L0g4cQIMm+Cxo+4WU9fRIw+H6dAu5UQh9PNHreU
 abyHxFL1YYeSc/7U++C3BoPjjVPMswd15R+ZKtpN5q8zewL0lthGI0CeAr4oIVAqkO6kFhN87
 JZMUHs/xUrafmvTE0GbsJmY0GYYMB7RtpmNSxY3l4EUV6aCJ6JO0Qcc/cIg0zk8mTvWSk+AJM
 Ux562xMIG+JxC1unhyaAe8Dv1JX/x5sP5SrWvGZ1QgzE7lfSPsBCFQwA0smJ0wYlwKGiDheAg
 5A+AMdXKKMcvYJkbx8YXcDyX3AHZEgk/baUVUn56UzktMd74QFkQTEQ5vFjveUvWLSO132aVe
 FNJUE+ox5sT8KuwrkkMAm8nHh/QqvJH8wvvwb1CkkP7J40f5kFN8wj74fsVREMQOPXHkh1WfP
 0iTg9GoyM0nqR55xVWq6zoLL85i9/KUt9twtNZ01Ukl7W6/B0pdWBSVP5iwOoDElOGY/jfZEr
 4yHISvd5oq/LwbrOoZizcp9kvTpBreGhwdOml6e/bimkDM7DGP69AycWk31Q6XKZXXzDvt/Gc
 PRrDoA2O35z/mab+MZHu+PafhUgXRl5MUfqeJBwJoBTAOoUIP02u3UgCrRqpoF2VNBv+RvSyi
 p1QW6wXCqA0FT9X0C1y9AuygAqpmR9/Ftd61HmWtg7yNCbZT8S2hdDs+Aljl5QcFvjE3fMbLz
 2Qdh8zFiNeAhQ95tI2Gg4dRlLSqS+grX+lZdZgPgfJmoxWNOIXh6w/okVsQAMeP5UGxVGbsIn
 YMReQpHLNBiuxSYiYReGikvLFF1VskcFScjI4VQhmFq7KlxgAzT3lSrow==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 18:33, Christoph Hellwig wrote:
> FYI, I have a new different approach for the repair code that doesn't
> need any bitmap at all.  Should be ready to post in the next days.

Mind to share the overall idea?

AFAIK current code we don't need to allocate bitmap either, but it uses
io_failure_tree and re-entry the endio function with different mirror
number.

I hope to get rid of both io_failure_tree the re-entry of endio.

Thanks,
Qu
