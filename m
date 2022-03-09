Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B024D2D17
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiCIK1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 05:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiCIK1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 05:27:53 -0500
Received: from mail02.aqueos.net (mail02.aqueos.net [94.125.164.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD6156C72
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 02:26:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail02.aqueos.net (Postfix) with ESMTP id 0C40868C19F;
        Wed,  9 Mar 2022 11:26:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail02.aqueos.net
Received: from mail02.aqueos.net ([127.0.0.1])
        by localhost (mail02.aqueos.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gc02_QBHvlZl; Wed,  9 Mar 2022 11:26:51 +0100 (CET)
Received: from [10.10.10.10] (adsl1.aqueos.com [51.68.231.211])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail02.aqueos.net (Postfix) with ESMTPSA id 6BAF368C195;
        Wed,  9 Mar 2022 11:26:51 +0100 (CET)
Message-ID: <1ed9f2b7-5a64-cd29-0d90-223030488daf@aqueos.com>
Date:   Wed, 9 Mar 2022 11:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: how to not loose all production when one disk fail in a raid1
 btrfs pool
Content-Language: fr
To:     Forza <forza@tnonline.net>
References: <c58f6d6d-fb95-5a6b-7028-4640ab5d1fee@aqueos.com>
 <02cf4d4c-fcba-12dc-6636-da0d42bdb42d@tnonline.net>
 <58d38b6f-db67-e167-31c6-c74ea5f12e91@aqueos.com>
 <b20f6820-332f-1d2e-8589-9f67347dc67d@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
From:   Ghislain Adnet <gadnet@aqueos.com>
Organization: AQUEOS
In-Reply-To: <b20f6820-332f-1d2e-8589-9f67347dc67d@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> but it seems i got the order wrong , the disk failed near 23h and the server crashed later in the early morning. So the raid was working for a part of the night then.
>>
> 
> It is conceivable that the amount of errors over some time triggered some other bug that lead to a crash.

yes never had any on mdadm but so many variables here...could be btrfs could ba another part of the kernel.


> Yes, there are several articles and information "out there" that doesn't have all things correct. Best when in doubt is to ask on the mailing lists or check the #btrfs IRC channel[*] for help.
> 
> It is possible to run a Btrfs RAID1 with only one device in degraded mode while waiting for a replacement drive. It is, however, not recommended to do so for any extended periods because any errors on the remaining device could not be corrected.
thanks for your very valuable input on this !


cordialement,
Ghislain

