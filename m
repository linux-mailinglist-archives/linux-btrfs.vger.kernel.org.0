Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7688777E19A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 14:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjHPM17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbjHPM1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 08:27:49 -0400
Received: from azoto.esiliati.org (azoto.esiliati.org [193.168.141.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3ADB2705
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 05:27:22 -0700 (PDT)
Received: from kater.esiliati.org (unknown [172.20.1.120])
        by azoto.esiliati.org (Postfix) with ESMTPS id 3F129EC5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 14:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oziosi.org; s=mail;
        t=1692188821; bh=KVzkq7xbGZJWd9Lk21U1dF2qR1etFG4WSqSy8BzBf14=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=p53Dg3T6uBRO1q3ZBrsp0MRqjfSORmhgePFmnLtn2OVPHe5k90CMLCHceREIAujCn
         +Fw/nKt05URZKesP7FicpVv2JJNs5fnnS8Fg7LEJYfCwiYKOazC6JQo/+dWhmCAyri
         sNanc5RIVeKVA1W1x0QtCfbfMd49N0aTS1cOfAvk=
Received: from kater (localhost [127.0.0.1])
        by kater.esiliati.org (Postfix) with ESMTP id AC0C117C0C41
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 14:27:00 +0200 (CEST)
Received: from [10.140.84.144] ([172.20.0.2])
        by kater with ESMTPSA
        id Ab/yG5TA3GS69w8AhHHK/A
        (envelope-from <alo@oziosi.org>)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 14:27:00 +0200
Message-ID: <01af0bff-1458-d4a2-c319-a2a702cbd66b@oziosi.org>
Date:   Wed, 16 Aug 2023 14:26:59 +0200
MIME-Version: 1.0
Subject: Re: Several BTRFS warnings on shutdown
Content-Language: en-US
From:   Andrea <alo@oziosi.org>
To:     linux-btrfs@vger.kernel.org
References: <0f78c419-4878-8e0a-eace-ffce9d2dd631@oziosi.org>
In-Reply-To: <0f78c419-4878-8e0a-eace-ffce9d2dd631@oziosi.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm sorry, I paste here again the errors from my previous message 
because I noticed that it was badly formatted.


dracut Warning: Killing all remaining processes

BTRFS warning (device dm-1): qgroup 0/266 has unreleased space, type 0 
rsv 210718208

BTRFS warning (device dm-1): qgroup 0/265 has unreleased space, type 0 
rsv 131072

BTRFS warning (device dm-1): qgroup 0/262 has unreleased space, type 0 
rsv 324243456

BTRFS warning (device dm-1): qgroup 0/261 has unreleased space, type 0 
rsv 319488

BTRFS warning (device dm-1): qgroup 0/257 has unreleased space, type 0 
rsv 42987520

BTRFS error (device dm-1): qgroup reserved space leaked

dracut Warning: Unmounted /oldroot.


Thank you.

On 16/08/23 14:22, Andrea wrote:
> Hey there, my system works fine but everytime I shutdown I see the 
> following warnings for a moment, before it shuts down:
>
> |dracut Warning: Killing all remaining processes BTRFS warning (device 
> dm-1): qgroup 0/266 has unreleased space, type 0 rsv 210718208 BTRFS 
> warning (device dm-1): qgroup 0/265 has unreleased space, type 0 rsv 
> 131072 BTRFS warning (device dm-1): qgroup 0/262 has unreleased space, 
> type 0 rsv 324243456 BTRFS warning (device dm-1): qgroup 0/261 has 
> unreleased space, type 0 rsv 319488 BTRFS warning (device dm-1): 
> qgroup 0/257 has unreleased space, type 0 rsv 42987520 BTRFS error 
> (device dm-1): qgroup reserved space leaked dracut Warning: Unmounted 
> /oldroot. |
>
> I’m using LVM.
>
> Do you have any idea what I can do to to fix it?
>
> Additional informations (dmesg.log is attached):
>
> uname -a > Linux tumbleweed 6.4.9-1-default #1 SMP PREEMPT_DYNAMIC Wed 
> Aug  9 05:07:55 UTC 2023 (5b9ad20) x86_64 x86_64 x86_64
> GNU/Linux
>
> btrfs --version> btrfs-progs v6.3
>
> btrfs fi show > Label: none  uuid: 581bdf8f-279d-402d-818f-9dfc42547677
>                 Total devices 1 FS bytes used 202.41GiB
>                 devid    1 size 474.43GiB used 209.07GiB path 
> /dev/mapper/system-root
>
