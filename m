Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3359A89B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbiHSWbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHSWbV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 18:31:21 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F32104441
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1kzYE/OrrXdKDlum+AlvyAL6EciqffRf5OO6Rs9U7uo=; b=E/BQ4ebmrIc126pMu9MMBNMVST
        QEh/d4LNKRZfNm1BSgvvVkdGCi1/JpuJU4pv+fSWYTaMAAGC2aN5qAH8D7aHX07fkXtsAR8NIvV8A
        wOY8fzrsEZWlbZ+gtOYDmACCBUrky4surHAYKzZr8JgWeDofFPmVvrL0eQ407UV4w5Ecvhs1swiYT
        lgXYozXIS7wHk9MkiYN8MvrOScPLyO7vLiqiKx0YW7sGvRVQAnOQM007hwZkbjVac3DOPYkXeJhcP
        YRgCoeseusyVNib/x0/sD616Teo1CLvzQrLQSOXgEx2ig6R3jh7Obxsra1CWPpEs008KjCycP/3B0
        lXYNuxgg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:15065 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1oPAWK-00032F-RO; Sat, 20 Aug 2022 00:31:17 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: What exactly is BTRFS Raid 10?
To:     George Shammas <btrfs@shamm.as>, Phillip Susi <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <87v8qokryt.fsf@vps.thesusis.net>
 <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <6f014dda-94d1-63cb-9ffb-583c34431a3d@dirtcellar.net>
Date:   Sat, 20 Aug 2022 00:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.13
MIME-Version: 1.0
In-Reply-To: <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
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



George Shammas wrote:
> On Fri, Aug 19, 2022, at 2:10 PM, Phillip Susi wrote:
>>> The Raid 1 example there also likely needs a bit of explanation or
>>> validation, as all the blocks are written to one device. In that raid
>>> one example three devices could be lost as long as it is not one of
>>> them is the first device. It also cannot be accurate once the amount
>>> stored is above 1 full drive.
>>
>> It is meant to show a *possible* layout, not every potential layout.
>> The data may be stored like than and then yes, you could lose multiple
>> drives and still recover as long as the lost drives were 2, 3, and 4.
> 
> I wouldn't expect all potential layouts, but maybe the _worst_ possible layout and an text. IE. If the layout blocks is random and only guarantees that each block will be on two disks. That would mean raid1 setup of 4 disks is pretty much guaranteed to have data loss if _any_ two disks fail.  This is important and should be made clear somewhere.
>
I am just a regular user , but yes, BTRFS "RAID" is (IMHO) a stupid name 
and confuses people easily. RAID1 means two instances of the data. That 
is why RAID1c3 and RAID1c4 exists which gives you a bit more redundancy 
(3 instances and 4 instances in case it was not obvious).

RAID10 is also just 2 instances of the data spread over as many disks a 
possible. E.g. any two disk lost means you might be in trouble.

Another interesting fact (last time I checked) is that BTRFS allows for 
interesting configurations like data in RAID6 mode and metadata in 
RAID10. This is a problem since small files can be stored directly in 
metadata and since RAID10 can have dataloss with two disks lost and 
RAID6 should not, you have to pick your configuration with care.

Now this sounds awfully critical, but BTRFS is a fantastic filesystem 
and have saved me from silent corruption more than once.

There is also a fantastic little tool on the web (that should have a 
ncurses version to be honest) here : https://carfax.org.uk/btrfs-usage/

That gives you a pretty good idea about what is happening if you play 
around with the values a bit. Good luck :)


