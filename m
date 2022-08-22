Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8E59CB4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiHVWDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHVWDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 18:03:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09151414
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661205779;
        bh=XOxBYe/TK7v2ojOYx/i/proW7E9+iYSrSYhTheLXz14=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=G4B0SBcw5LlskZuy1CTO/3mPMmexqpIiSTw1U5GM8Bo9y1ev/6L1h82ujIiHe146M
         gsbkIBdLi2g62RJrafQ4I4WVq2dHS3Biz6e/TLa9UtVZlF9d5UtktspWo6/TRF92jL
         iEt2wU8rDtg37yh82TvhehbDH/T7K4QxD6zWDQ1g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1oz2A732pt-00ZcTy; Tue, 23
 Aug 2022 00:02:59 +0200
Message-ID: <5efc6c8b-94d3-992f-aed2-8f0026790f54@gmx.com>
Date:   Tue, 23 Aug 2022 06:02:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/5] btrfs: qgroup: address the performance penalty for
 subvolume dropping
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1657260271.git.wqu@suse.com>
 <20220822174541.GB13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220822174541.GB13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lPVnwQOOGdlAVxtry/2LSxaxprR7u7YjVrMAax7GbxKdt0kseQp
 Vm3lSd5w+zlW/AO9sitsjaaUgiZPWmQvkbnnp71wuWYPMnQEn6R9dgoJAGggRTruUH6L+NN
 Iqj+eTqWBB9eqfh2eTF8fdJH989C2wNt7XRjJspAtfppumIPG8OPBme4JEPyE4WUzmydGNF
 wPzTDtpZCr2RNuI+4sdtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Jc0XAKb8Us=:qJ7xhouy8iPB/DEKvjOVhY
 FHJ8qTBOl8GnGQsK9I/tejY1yR7ZiuIoHTywL89pAmN15VaUVznvKIMmXv8hVmgnXz4/CvmLt
 ob3yRCphXG6xu++yHmr5AWL0H2X1Q+f38VfBQTWlwFOWnQsxbBBVSkE0WVD7pEpgBtwVqbytd
 CNsIrnIbbrMg1aD9icw94yhe6OxQcasXM5/qCyyRek8WxXeanTw/PPcAsleWR83xq10f8+MCX
 8AJw49XmzyN2JOuVQshN044CohgKpgMeevPdT2QqRHGrj9t50EmYMeeB4q+M1Byuf2VS2Yica
 BILYjjCZ861hlyLvaY6jRIawkBsChc/Ipk6iOUX965coco5wunNRaY5s84s4pRF3Bo0in1PhB
 PdWkuoI0ufPoeB5P2EesYbOb3vwF6RNeE8QUJbxmrrLksC5SatTXPqSWTA4AsIn3i4Rbz247Y
 rILp6Mbkssr/6IIfrFFlN2aRZ69R9am8QUKgrp4dfBDScG2MwwnU30cFxxS9ohWHGrJBew+Wi
 i/60Is3xC4/IianYIjhbq3WT+CVXYLhKpUPLt/LevYHrQ3NxFiw1pwipcZnLEJGNesidrrA4q
 qLDgocjwjJS6aPq39rVezKrvA9S5MHBy6hABrdZVUPrjJSqvozYagfza9Ohkof3e5ibA6ixHB
 bHYKiqmUMPoJw39KHH+UbzuvYLcY6hzJ7hFWBkrbezsDHgVyVAI+H0ragu86obfyA0YWIxgDU
 bMq8sp8NmSxKm6uHqWkQ0wmIzSCiWN8fTO1drs2vdmWUKskuZLo7cjKKlcDscj7rSdmO166dS
 v28ZRfHnL+LRqpt9i2sZmyei4WI6OI7FOYUSj13X8VO/mLgjZ51VNeYjkwQDbRmL+588zcAFb
 PPsoBR3dlbu2sqW6gIloy1IP9lfAB96EHUzIzUPdX3bVNwtYaATVenzpU36DyGnKbPJ7WyIkh
 TBy5S3e8ivRS8D+pdTdZv8vMgkSrzgv2xMvxzLDeqMo+4WxQC2IXs+QQQ4BpaZZ/7CUu1U+Tu
 lF6kTpREK6xyQT5Zs45mh1tbqZhL5W5crA0EGd7WU+AdqBOzv0TJoLLtO/MF2kOuBqXPDD0Tn
 KnfmiX078LLA3f67ZF5UtNFvLEJSm54hNRtupW3VZ8gBXqkj6X40oWnBw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/23 01:45, David Sterba wrote:
> On Fri, Jul 08, 2022 at 02:07:25PM +0800, Qu Wenruo wrote:
>> Changelog:
>> v2:
>> - Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
>>    entries
>>
>> - Update the cover letter to explain the drop_subtree_threshold better
>>
>> v3:
>> - Rebased to latest misc-next
>
> I'll add this to misc-next, but regarding the overall design how to
> set/unset the quota recalculation I'm not sure it's a clean solution.

Yep, that's always the main concern.

Alternatives includes new on-disk item for qgroup, something like
QGROUP_CONFIG items.

But that would need a new compat RO flags.

Personally speaking I'm fine either way, any suggestion on this?

Thanks,
Q
