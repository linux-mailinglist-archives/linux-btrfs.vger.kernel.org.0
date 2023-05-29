Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1032F714E50
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE2Qd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2Qd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 12:33:58 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26DA7AD
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685376061; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=LFzPhY2CbEjN8xJA3QevOFBu+yB8VB7aVcfr+FeAQ80=; b=BvHl1tKZHkNzD
        XyYAdQY/hRB5eSErcHb7mFuyLH171/g7EIIVQZG1GUeFz70ez71/yiM44lXrJqhiC/dXTSG/hWetZ
        A5ruoGS6OvN0ac26IGXKbyAy5zEWvEAHh/YKO8GMNPJDFzQVIulk9p4oPlNSTE1i1YUDWNPcDh8pC
        nvgANd2pBBWfTG+RchRcVS3dvYOryH9eabxs3J86TBTWtH9TxHz94mWS0dUB8PZ4iXiEigPfn9dsa
        TQn0SavrppNSsxPeclynLyyUe1uzQ0wp/NAJprnNKEDYxvvRG3aTB870DsTC6HB8QJjpPIoVc41u2
        FNxwgrLnJTqsfrQ+cKngQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685376063; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=LFzPhY2CbEjN8xJA3QevOFBu+yB8VB7aVcfr+FeAQ80=; b=ZEh3ge/moQHYG7buXrxVKiKfz2
        32pHaHei3+lAiGeeBV4si42KNUq0ipDVaXK9jNL/VM9rc4TUB8eJH2JufFo/Gs595jpBs8NctVQ7a
        NFl59sfp4Xcrr5WQRn+0OZ0kjXb0vnfEG1JF71M9J7k6e5LdE2z65y6lWff5TsRfUE6aTFgCM6Wk5
        PsH+irET7/OW3l8bPCI0/+wDtr+7InpPeOtl0436Te8rlpv8nUSItVKCW8PzKtTQOq3Ckxumos1Y6
        IkcHRCIBRMGsgJmMi8LS1fDLb8CAcGXhM7X4IqKKSgnMmPhWc/zOa49OW1Oaoun0USste783d7W1r
        uWHgjAaQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3fog-002she-1J;
        Mon, 29 May 2023 16:33:54 +0000
Message-ID: <bf3dd19b-df1e-206e-b6bb-26a7b5980fab@bluematt.me>
Date:   Mon, 29 May 2023 09:33:54 -0700
MIME-Version: 1.0
Subject: Re: [6.1] Transaction Aborted cancelling a metadata balance
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <f1c28123-d1e2-4fa4-0695-82905f4879e8@gmx.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <f1c28123-d1e2-4fa4-0695-82905f4879e8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 2:10 AM, Qu Wenruo wrote:
> 
> 
> On 2023/5/29 11:17, Matt Corallo wrote:
>> On a subpage, ppc64el 6.1.20 spinning-rust filesystem (which was
>> (mostly) btrfs check'ed not too long ago and passed scrub):
>>
>>
>> ....
>> [1158664.424471] BTRFS info (device dm-2): relocating block group
>> 52117042626560 flags metadata|raid1c3
>> [1158744.142005] BTRFS info (device dm-2): found 7188 extents, stage:
>> move data extents
>> [1158769.675743] BTRFS info (device dm-2): relocating block group
>> 52115968884736 flags metadata|raid1c3
>> [1158770.648131] BTRFS info (device dm-2): balance: canceled
>> [1158770.648155] ------------[ cut here ]------------
>> [1158770.648157] BTRFS: Transaction aborted (error -22)
>> [1158770.648205] WARNING: CPU: 43 PID: 1159593 at
>> fs/btrfs/extent-tree.c:4122 find_free_extent+0x1d94/0x1e00 [btrfs]
> 
> Can you provide a full code context of it?
> (aka, the leading and tailing 10 lines around that extent-tree.c:4122 of
> your distro)

This is Debian 6.1.20 with your patch from "6.1 Replacement warnings and papercuts".

David's response source lines match up with what I see locally.

> My current guess is, it's from btrfs_alloc_chunk(), which looks very
> weird, as it can only return -EINVAL if we have mixed block groups.
> 
> But in your case, it's definitely not so.

We do because its a convert:

[1156697.072335] BTRFS info (device dm-2): balance: start -mconvert=raid1c4,soft -sconvert=raid1c4,soft
[1156697.293873] BTRFS info (device dm-2): relocating block group 60016594780160 flags metadata|raid1c3
[1156920.460378] BTRFS info (device dm-2): found 31511 extents, stage: move data extents
[1156929.894625] BTRFS info (device dm-2): relocating block group 52144993468416 flags metadata|raid1c3
[1157034.827965] BTRFS info (device dm-2): found 7675 extents, stage: move data extents
[1157056.979579] BTRFS info (device dm-2): relocating block group 52143919726592 flags metadata|raid1c3
[1157173.221239] BTRFS info (device dm-2): found 8077 extents, stage: move data extents
[1157208.230391] BTRFS info (device dm-2): relocating block group 52140698501120 flags metadata|raid1c3
[1157338.558662] BTRFS info (device dm-2): found 9117 extents, stage: move data extents
[1157368.718736] BTRFS info (device dm-2): relocating block group 52138551017472 flags metadata|raid1c3
[1157476.719487] BTRFS info (device dm-2): found 8683 extents, stage: move data extents
[1157495.244964] BTRFS info (device dm-2): relocating block group 52137477275648 flags metadata|raid1c3
[1157602.475782] BTRFS info (device dm-2): found 8365 extents, stage: move data extents
[1157622.391882] BTRFS info (device dm-2): relocating block group 52136403533824 flags metadata|raid1c3
[1157729.551508] BTRFS info (device dm-2): found 8864 extents, stage: move data extents
[1157747.297398] BTRFS info (device dm-2): relocating block group 52135329792000 flags metadata|raid1c3
[1157822.904374] BTRFS info (device dm-2): found 8846 extents, stage: move data extents
[1157841.823686] BTRFS info (device dm-2): relocating block group 52134256050176 flags metadata|raid1c3
[1157969.640420] BTRFS info (device dm-2): found 13309 extents, stage: move data extents
[1158004.653309] BTRFS info (device dm-2): relocating block group 52133182308352 flags metadata|raid1c3
[1158086.479791] BTRFS info (device dm-2): found 9200 extents, stage: move data extents
[1158111.903478] BTRFS info (device dm-2): relocating block group 52132108566528 flags metadata|raid1c3
[1158172.257727] BTRFS info (device dm-2): found 9016 extents, stage: move data extents
[1158190.537662] BTRFS info (device dm-2): relocating block group 52131034824704 flags metadata|raid1c3
[1158277.389247] BTRFS info (device dm-2): found 11447 extents, stage: move data extents
[1158302.356863] BTRFS info (device dm-2): relocating block group 52126739857408 flags metadata|raid1c3
[1158385.531824] BTRFS info (device dm-2): found 8667 extents, stage: move data extents
[1158412.539291] BTRFS info (device dm-2): relocating block group 52125666115584 flags metadata|raid1c3
[1158507.164138] BTRFS info (device dm-2): found 11169 extents, stage: move data extents
[1158545.608519] BTRFS info (device dm-2): relocating block group 52124592373760 flags metadata|raid1c3
[1158633.368470] BTRFS info (device dm-2): found 9762 extents, stage: move data extents
[1158664.424471] BTRFS info (device dm-2): relocating block group 52117042626560 flags metadata|raid1c3
[1158744.142005] BTRFS info (device dm-2): found 7188 extents, stage: move data extents
[1158769.675743] BTRFS info (device dm-2): relocating block group 52115968884736 flags metadata|raid1c3
[1158770.648131] BTRFS info (device dm-2): balance: canceled
[1158770.648155] ------------[ cut here ]------------

> 
> And any other btrfs related messages before this paper cut?

No, sadly not. Only the normal balance stuff above.

Waiting on `btrfs check --readonly --progress /dev/mapper/bigraid21_crypt` to finish, but its passed 
extents + free space tree and no issues so far.

Matt
