Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF569C36B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 00:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBSXj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Feb 2023 18:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBSXjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Feb 2023 18:39:55 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F0C65F
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 15:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qUQMt0iuB/lhOCgbNSUvMOPZuH6RB5LJarig5FbDToo=; b=jaUnD97yBep5R0ZCZM3uLnVAcS
        STCyc2ow7+fWPO1qjIgzViRxzczgiyNUqgg61I9vLVYpTJP5rHb2L9RSKtHmqW+LY7DNBPq3sB14d
        QeuVXj9uEcaOs3P5eDq5iLIArjVNpPs81Rcczlp2OMLXcQTiZdBJdg7ruEjvAbBg24V+gRk/1Jl7j
        1ltqw9hN6TLCJYtYn1pbtRY5B8hVnu4KwSLcPK3gSc2krvng9uEjv14sWc0Gd2n4XkaqABEahyLKM
        89PotTEfa2wqoKO9SNeRfJduTULP9SuKL6eYkm4GXjIrpDZhTefeUk8uJCoIcMrZwBtlmCXrUS8Na
        doj56wbA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:19311 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1pTtHb-00DlwE-1K
        for linux-btrfs@vger.kernel.org;
        Mon, 20 Feb 2023 00:39:51 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
To:     linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
 <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de>
 <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
 <87k00dmq83.fsf@physik.rwth-aachen.de>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
Date:   Mon, 20 Feb 2023 00:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.15
MIME-Version: 1.0
In-Reply-To: <87k00dmq83.fsf@physik.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Hallöchen!
> 
> Goffredo Baroncelli writes:
> 
>> [...]
>>
>> Just for curiosity, I know that the BTRFS RAID1 is not the fastest
>> implementation, but how slower is in your "I/O-intensive
>> operation".
> 
> What exactly do you want to compare?  Be that as it may, I have no
> benchmarks.  Originally, I was just wondering why RAID1 --> single
> may take hours, given that all data is on both disks anyway.
> 
> Regards,
> Torsten.
> 
So what I think you would like to have answered is : Since RAID1 has two 
duplicate chunks (A1 and A2) why could not BTRFS simply change the chunk 
type of A1 to single and discard chunk A2.

Personally I don't have the slightest idea why , but I imagine that this 
perhaps might be possible with the extent tree V2 changes sometime in 
the future. Meanwhile perhaps someone else would like to explain why...
