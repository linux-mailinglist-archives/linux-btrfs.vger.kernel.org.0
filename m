Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970675F8B87
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJINMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 09:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJINMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 09:12:19 -0400
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4A18E3A
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 06:12:17 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr3.vodafonemail.de (Postfix) with ESMTPS id 4MljBS2LWqz204F;
        Sun,  9 Oct 2022 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1665321136;
        bh=irunEegAqsE3RWmfo/Hh2p/YcrQyfgHPnvD2W0Wv6cM=;
        h=Message-ID:Date:User-Agent:Subject:Content-Language:To:References:
         From:In-Reply-To:Content-Type:From;
        b=RpngPaqHOFXkg/wGvyBa+rr58x2dM5VFOS6wNdd7v2xidKiLbBwM+ZaPUyvJOUR9Q
         2adVFyo0k3PG6sf2alV960VPQKrZIhIZLdgtqqFKl+pel3j5Jx4O9ncjl2IS3k6yHq
         e82VkZ+Si8sbToCLlI1+2y30m/onFLWDz/SQMfG4=
Received: from [10.0.2.6] (p54afaf98.dip0.t-ipconnect.de [84.175.175.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4MljBN1Gd9zMmvG;
        Sun,  9 Oct 2022 13:12:08 +0000 (UTC)
Message-ID: <204ae7d0-9163-9ead-bbce-850006a3b3f8@arcor.de>
Date:   Sun, 9 Oct 2022 15:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RAID5 on SSDs - looking for advice
Content-Language: en-US
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
 <20221009164206.39de4305@nvm>
From:   Ochi <ochi@arcor.de>
In-Reply-To: <20221009164206.39de4305@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1750
X-purgate-ID: 155817::1665321135-FD7F94B9-7B901D12/0/0
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.10.22 13:42, Roman Mamedov wrote:
> On Sun, 9 Oct 2022 12:34:57 +0200
> Ochi <ochi@arcor.de> wrote:
> 
>> 3. Are there any other known issues that come to mind regarding this
>> particular setup, or do you have any other advice?
> 
> Keep in mind that Btrfs RAID5/6 are not currently recommended for use:
> https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#raid56-status-and-recommended-practices
> 
> If the NAS is backed up anyway, I suggest going with directory-level merge of
> filesystems, such as MergerFS. If one SSD fails, you will need to restore only
> the files which happened to be on that one, not redo the entire thing, as
> would be the case with RAID0, Btrfs single profile, or LVM-based large block
> device across all three.

Something like this might actually be a viable option for my use-case. A 
significant part of the data is pretty static in nature anyway, so 
having it sit on single drives together with the backup that I have 
anyway might actually be an option. I already thought about just using 
RAID0, but didn't like the idea that a single drive failure is pretty 
catastrophic (maybe RAID0 for data and RAID1 for metadata would be a 
possibility to at least have the filesystem structure survive a single 
drive failure, but I imagine restoring from that scenario to be pretty 
ugly).

I'll have a look at your suggestion and consider it as an alternative to 
my initial plan. Thank you :)

> Another alternative is mdadm RAID5 with Btrfs on top. But it feels like that
> also has its own corner cases when it comes to sudden power losses, which may
> result in the "parent transid failed" condition from Btrfs-side (not sure if
> the recent PPL in mdadm fixes that).
> 
