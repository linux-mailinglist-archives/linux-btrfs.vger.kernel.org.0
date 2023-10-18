Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB57CE009
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbjJROfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjJROf2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 10:35:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7661BF0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ds6Q1tcYx1XaQOpl4qN33taCaA6/V4SHsQRZcc/9YLI=; b=JqpLXnyauDrrhiGUpmQshDa2KD
        bq/VnTLl/1zhgrVZc4ExXcB+ipFJlrGjAgyJo5xzhWm+hSiS1pEvO28vjujeQUE7evXD4oEKsqndj
        hRzvj/23JAsDlfSYud9ZGym7HjmsxJyz3uvJSDeBxrAc+FZhimPCKeu4cNcNgDhUBYL763QQJq8EE
        sHLL8DGty9DCVUTkxayU21A6Sjmaksfb3Jl7kRH5qGNDjjaFsz6UfrrIvcrvILYgdLQbqPiOXbUIc
        tdUXPGYo3JOjoxOcTAFkyUC08s72OzCD7v8m/N+Dmm6oVQjRZxV07Pkn0Rcd2B0kXnQ6Wrnm+Pf5L
        EfLgofPQ==;
Received: from 210.red-80-36-22.staticip.rima-tde.net ([80.36.22.210] helo=[10.0.20.175])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qt7KP-001pNq-Nt; Wed, 18 Oct 2023 16:15:17 +0200
Message-ID: <2a729b71-3f30-d99a-7129-4e13841d180d@igalia.com>
Date:   Wed, 18 Oct 2023 16:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
 <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
 <dfc68882-ac04-4b11-9ac6-505341e0517c@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <dfc68882-ac04-4b11-9ac6-505341e0517c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/10/2023 10:01, Anand Jain wrote:
> [...]

Hi Anand, thanks for your response and apologies for my delay.


>> Also, we can mount multiple
>> partitions holding the same filesystem at the same time, given the
>> nature of the patch (that generates the random fsid based on devt as per
>> my superficial understanding) - right?
> 
> Indeed, devt remains unique to the partition we've utilized for a
> similar purpose prior to this patch. Are there any devices lacking
> a distinct devt value?
> 

Not that I'm aware of, it was more of a curiosity.


>> i.e., we kinda "lose" the original fsid?
> 
> How? Have you tested to confirm?

Oh no, not literally I meant. When we go with the temp-fsid approach as
you implemented, the kernel doesn't inform the real fsid. But that's not
an issue at all, more of a curiosity...

I just tested misc-next and your approach seems to be working fine!


> 
>> If that approaches is considered better than mine and works fine for the
>> Steam Deck use case, 
>> I'm glad in having that! 
> 
> As you have a use case to verify, can you indeed confirm whether
> it works?

It does work! I'll test more in the Steam Deck, but so far seems to be
addressing fine the use case we have...


> [...] 
>> But I would like at least
>> to understand why it was preferred over the temp-fsid one, and what are
>> the differences we can expect (need a flag to mkfs or can use btrfstune
>> for that, for example).
> 
> The in-memory disk-super hack in the original patch is essentially a
> workaround. This led to the necessity of restricting devices using
> metadata_uuid from being used as temp-fsid device. A more appropriate
> approach is to enhance device_list_add() to intelligently manage
> duplicate disk-super entries by checking devt and permitting them
> to mount if unique. This solution deviates from the original patch
> and simultaneously addresses the subvol-mount corruption issue
> observed in the original implementation.
> 

OK, makes sense Anand.
Thanks,


Guilherme
