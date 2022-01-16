Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60748FC2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiAPKa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 05:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAPKa0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 05:30:26 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45607C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 02:30:26 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 77A9D9B89E; Sun, 16 Jan 2022 10:30:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1642329022;
        bh=NJpPhc9i4qY2uEf7UhIyCYAcylDeamFYAR3pPOvl8oY=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=I3JS1bi3F6a5od6UlB3ccYjleCq2N7z2Vzry3PA5H6Z139hj0vioMEi/vOy2xOvap
         gxSyZcDwN5UnwOBfAEA5W3/Fs54ENafN/GyUDJDMTuMzDxgFl9HXwIdBl/EtgWpjwX
         VDknQQjsKSIFH3T08S4YvQE9osravTQpXQztzVLyIckiMgJtjzrFCqGe6dwEOpixZ7
         6PtFS7DePfujDYFPlOLtSuDDRJWFpddZcWvCkaObbZtsvcWiZF/dKfbvCQXJGm27wM
         ua4dGg/s38qQhsyvsMxxI+6AESVkh/w/MHX7CzdK9bLLmkC7xtIIptKWoT4iulwz9t
         GIMPBjejB1VAA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 1C5B09B89E;
        Sun, 16 Jan 2022 10:25:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1642328721;
        bh=NJpPhc9i4qY2uEf7UhIyCYAcylDeamFYAR3pPOvl8oY=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=BAsONSFaIRDNtbU45epmlapvR42naIWpk3YMX3FFItxvRo+zrDugLGKYt2qn6dELm
         yO8SoyXYltmApE/LN/OJJi4bqzmX7CLUofkvlgAzsL/A8fVEItdfKfkb1vqRH6bqpe
         kD/TlUueWXY3/ayt/QFil/ZcJtOB8+rSh1Xu17LZYjn/GxDtCM06HGyPtf0BKljAq8
         4ZKMReM8T+FBxI0PcQ7eVb4Fy+b+cWna3KMSP4p5T5lM0l3NaBTmDGEE9dx/9jt17I
         sMDBfpXL5Pj4QXEJ9J9bnh7ul8Q3e7Yb6HxJXYl3fuwbbtIisx5N27ZJ9QARkQJ5fZ
         NQP2/hYmLDBTQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id AB76A2F3012;
        Sun, 16 Jan 2022 10:25:19 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Stickstoff <stickstoff@posteo.de>, lists@colorremedies.com,
        linux-btrfs@vger.kernel.org
Cc:     quwenruo.btrfs@gmx.com
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
 <13d3ebcb-f261-35eb-0675-3cb199ad3643@posteo.de>
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
Message-ID: <f8de013a-9b1b-f471-4af0-dbb587264774@cobb.uk.net>
Date:   Sun, 16 Jan 2022 10:25:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <13d3ebcb-f261-35eb-0675-3cb199ad3643@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 16/01/2022 09:31, Stickstoff wrote:
> On 1/15/22 9:45 PM, Chris Murphy wrote:
> [..]
>>
>> Take advantage of the fact you can mount the file system, and freshen
>> backups to prepare to abandon this file system. Depending on the
>> problem, it might be fixable with current btrfs-progs' btrfs check but
>> ... if it's extent tree damage it's going to take a really long time
>> to find out, and then only at the end when it either fails or makes
>> things worse do you find out.
> 
> Yes, that would be the safest way. If I can still get all data off the
> fs, that is.
> I would remove one of the two drives from the raid, create a new btrfs,
> then btrfs-send
> the volume and its snapshots to the new fs. And eventually format and
> add the other
> drive to form a raid again.
> Would in this procedure btrfs-send detect any data corruption, and
> hopefully continue to send?

I can't answer the questions definitely but if it was me, and the data
was important to me, I would not rely on complex operations (like
removing a drive) functioning completely correctly (not failing in the
middle). I would probably try what you are proposing but *before that*
take a complete copy of all the data, using traditional tools (tar,
rsync, or whatever) somewhere just in case some obscure problem
triggers. If you lost the btrfs filesystem subvolume structure you would
still have the actual data! Either on a spare disk, if you have one, or
to a cloud service (AWS S3 is slow but it isn't too expensive if you
never need to download the data again and just delete it after you are
sure you have recovered the problem).

> Scrub did abort, and force the fs read-only, but didn't unmount it.
> Also, my backupscheme depends on btrfs-send and the IDs of snapshots.
> Migrating from the
> old corrupted fs to a fresh one with btrfs-send should keep all the IDs
> as they were,
> so my backupscheme would not see any difference when picking up with the
> new fs?

I don't think send/receive preserves subvolume IDs. I think it only
preserves "Received UUID". But I may be wrong.

Graham
