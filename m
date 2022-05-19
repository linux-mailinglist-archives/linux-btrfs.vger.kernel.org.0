Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117752D1B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiESLqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiESLqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:46:07 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 04:46:05 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFF1FCD2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:46:02 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 9A4269B806; Thu, 19 May 2022 12:46:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1652960761; bh=4tAxyVYi5CfeLsj509dwNFUJmDhl5kx2D/F44AWCboI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=aJzw9k+2i6RQ5YETDZ97li7Ovng64ToqGyo9Bu+RZYvRB39vSRFyvWEULu7h8VfmT
         STN/rw9btuHsZSu3SrcIr3w8ESXnBKNA2iSh0rLe0jEzrdfqdW/ktyV55IoMXkbYjR
         IcHi8dr/Rnxe3c1MVwbwkuZEHKGPCc24vbblqMifEuT2o7hR5TSbOy2i9XJUS/fhFW
         7au2bFKqs15KCXXnpoX3K32OpnWNqhptst3x8p59UWV6JGIoUBnRcCb1tmA/4e80HJ
         K0EhVrPKcmSYqt4Oxos6Ia91vgpWBM27BRlCfM5+HhEEO7++kDZri4Rp+OY7LOU1dj
         FH2w3mhE1NbyQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 6BA669B6AE;
        Thu, 19 May 2022 12:45:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1652960741; bh=4tAxyVYi5CfeLsj509dwNFUJmDhl5kx2D/F44AWCboI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=LEr7Do2+C0sw8ghBbG+R7bLNEmK7VoMzxIlylrhhAdjsEIHjU6WwZK2Gw7QSRa9b6
         WOSqdjN8PIbu1lZhDAMPBL1lJGUL74sxb8JRLzX6rf8o3ygAUOBo9loTVKKB8tXvpH
         FOix3/KJdKGW3Cg89wIqzYenypmLr3RZaL/9UasznVYQQxdNRTSLXY7vO3CUUoL9wT
         WtjbPm0NsnPPhkkqirye92v1SabpCh3MWJWuKlDywwXo3kAjQT+ql3tewyCP5KCMJX
         dSJFMA72wR7N+3rvCU6CHya7I2wwZwb43GNY29BptI49WPC8K2IZzxA4G4AaQnwXNS
         kvbEs0RmKTFAQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 296CE16FC6E;
        Thu, 19 May 2022 12:45:41 +0100 (BST)
Message-ID: <5071436f-8eb7-1c7d-9ac8-b86dc887754d@cobb.uk.net>
Date:   Thu, 19 May 2022 12:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Graham Cobb <g.btrfs@cobb.me.uk>
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     arnaud gaboury <arnaud.gaboury@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
 <CAK1hC9u_9w5K6Mz=k+AhzjNcZ4N_7fmaDtrLqVSpM3ttb46muQ@mail.gmail.com>
In-Reply-To: <CAK1hC9u_9w5K6Mz=k+AhzjNcZ4N_7fmaDtrLqVSpM3ttb46muQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 12:36, arnaud gaboury wrote:
> I take the opportunity of this thread to find a solution on my initial
> probel: how to use an external device to store the backup snapshots?
> 'btrfs subvolume snapshot' command will not allow me to store on
> another device. So my idea was to add the external device to my btrfs
> filesystem.

My recommendation would be to create the external disk as a separate
btrfs filesystem - you can then mount into something like /backup. That
way, if it is not present, or not working, your system can still boot.

Then use btrfs send/receive to copy any snapshots you want onto the
external disk. There are several tools which will automate this and
manage the backups (personally, I use btrbk).

