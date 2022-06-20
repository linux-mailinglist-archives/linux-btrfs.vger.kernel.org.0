Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E775521B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbiFTP6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbiFTP6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 11:58:03 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 08:57:52 PDT
Received: from mail02.aqueos.net (mail02.aqueos.net [94.125.164.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9391271F
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 08:57:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail02.aqueos.net (Postfix) with ESMTP id 82FCD7DFC3F;
        Mon, 20 Jun 2022 17:52:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail02.aqueos.net
Received: from mail02.aqueos.net ([127.0.0.1])
        by localhost (mail02.aqueos.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pqmADZXcC21R; Mon, 20 Jun 2022 17:52:15 +0200 (CEST)
Received: from [10.10.10.12] (adsl2.aqueos.com [185.63.173.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail02.aqueos.net (Postfix) with ESMTPSA id 2FEED7DFC38;
        Mon, 20 Jun 2022 17:52:14 +0200 (CEST)
Message-ID: <8d54c3c5-a0b5-fdca-f31d-f9b5c3eea655@aqueos.com>
Date:   Mon, 20 Jun 2022 17:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Suggestions for building new 44TB Raid5 array
Content-Language: fr
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20220611045120.GN22722@merlins.org>
 <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
 <20220620150132.GM1664812@merlins.org>
From:   Ghislain Adnet <gadnet@aqueos.com>
Organization: AQUEOS
In-Reply-To: <20220620150132.GM1664812@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> It has a few of its own issues, but yes, if it were actually GPL
> compatible and in the linux kernel source tree, I'd consider it.
> 
> It's also owned by a company (Oracle) that has tried to sue others for
> billions of dollars over software patents, or even an algorithm, i.e.
> not a company I'm willing to trust by any means.
> 

well i completly understand i use btrfs for the same reason but it seems on your side that this use case is a little far from the features provided.
The more layer i use the more i fear a Pise tower syndrome :)

good luck for the setup !

-- 
cordialement,
Ghislain

