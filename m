Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49804CEA9E
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 11:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiCFKzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiCFKzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 05:55:42 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0A5131D
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mMVZ0RvxSVEMEg+J1Ih/FPqEvtzRV1OWjuP8NMIAyTk=; b=TLGP+YwrEwunprcrwqBHWsiUYb
        EAwTMGtcLTnbrFGsHV3RI/OK6yrkmszCWT/UGXRa4ymT8WydPHdSR5ut1VxE4ytVDt50hAl5c51ov
        R1Iec7KWNknOu94v8gqJpCeM9Fiza4SEW3UK3+o1fGRKHAvNSzWVhEn4a/VLAzNwsw1LR/q6PAdu2
        8mKWhYPiO5Tq0AM2yTiVFr4dWzDbNYaeOVBr2qUI5iDiTdsm2iWURT+48e6xNu4/0cXy4v+pDG3Lu
        iYoecNfATUufNDkW6ryPXFqe9io5OhUMTQJQGXeFcr71zkI783sHZl51XKD4fkY3VaR6xLKvq6mtF
        LlFeB18A==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:11623 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1nQoXI-0001hE-2w; Sun, 06 Mar 2022 11:54:48 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: status page status - dedupe
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <b6f4a074-cc6a-8261-59fb-07a80ecc9f0e@dirtcellar.net>
Date:   Sun, 6 Mar 2022 11:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.11
MIME-Version: 1.0
In-Reply-To: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Christoph Anton Mitterer wrote:
> Hey.
> 
> I just wondered about the status of the wiki status page?! ;-)
> 
> E.g. it says seeding would be stable, while right now there's an
> ongoing thread on this list about it being broken again.
> 
> 
As just a regular user I got a couple of thoughts here.

I think that the status page should primarily reflect the status of the 
LTS kernels. Perhaps the last three or four LTS kernels. If a bug is 
fixed or introduced it should be pointed out at what specific version.
Perhaps this would be easier to maintain and easier to direct users to 
as well.

Another interesting thing about the status page : zoned mode is marked 
as "mostly ok" since 5.16 , but in the description it stays "there are 
known bugs, use only for testing". In my point of view this is UNSTABLE 
so I hope someone updates either the status or the description to 
whatever fits best.

And one more  thing - would it perhaps be a good idea to put the status 
page somewhere in the documentation pages?!
