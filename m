Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32572CD4B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgLCLiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgLCLiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 06:38:11 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB441C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 03:37:30 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id C9DD09C321; Thu,  3 Dec 2020 11:37:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606995445;
        bh=QZH/nkCpcqGkFkKyRy5ISn4EPDporrVoAn/sv49p67s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZG5CJPCXEASrO8rwUVkOmObNy7xCt/4CRI3fv8noz1azvqmYICoTlkv+22+s13TOx
         MHYwww40pvbUjefOqwGSnIZoa2eFcoyA8eAXw6C9BRBk62BDzD0/XXpeZcO02VQDQX
         iOIlLMICGFvz7GPnUeqtrPgmdoIoIEUe2udDgG0vPSOMb9t177PMqjdXLZ6QJHum8h
         BDhg9KnT3YttzpwmPRI5GAL8hAknotVzxLlPEvkxb5cNmHSjGHikeuTKdPluPEBZkJ
         d9ZV33ergGDidwwOKyDIcDWIwQjujLwTZdeUx24qjaKwu1WT2lph9gLDSgaAY0AGth
         xiG3bBkhNR2Cw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 803089BB6D;
        Thu,  3 Dec 2020 11:37:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606995442;
        bh=QZH/nkCpcqGkFkKyRy5ISn4EPDporrVoAn/sv49p67s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=l8OCpsuyRXW1MlK4pMowEv1txnT2wplB/u9M+pmzbTBwCYgGB4vGqQ/WosJl06skl
         vwNMKi6nKo5LUG4TlylQ6j2nMnTB4PlmoBBJNk3Rz8xZylxsHw5Kis3K0FeEGI4cii
         grgrlqN2TRv4G1l2rLEluPNm7ivQ4U8Da4LoxVMM2NmvL2zu8V8qEozcv841laN0xp
         +QECPlCMP83YolN6C+prfdxYqjG42IAy+wnvIb/JadBr0S6q4+eI1Roe42WbgSt5aP
         HRwDA6TKA0IuaCWjzzqXgbNlyJ+78/tMCp6uTjNd/7rIpgqEA0ztC8E6Ih3vMmxQvo
         O1jB0CVpEZQzg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 2DDF91B1C91;
        Thu,  3 Dec 2020 11:37:22 +0000 (GMT)
Subject: Re: Best practice for encrypted BTRFS: LUKS or something else?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <3575501.kQq0lBPeGt@merkaba>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <b6503509-b0f2-ac91-1990-75e250b58f5d@cobb.uk.net>
Date:   Thu, 3 Dec 2020 11:37:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3575501.kQq0lBPeGt@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/12/2020 08:07, Martin Steigerwald wrote:
> Hi!
> 
> I am plannung to deploy a new (used) laptop.
> 
> This time I like to encrypt it all, not just part of it.

On my personal laptop I encrypt primarily in case the laptop is lost or
stolen. A secondary consideration is that when the disk dies, I can just
send it to recycling without having to physically destroy it.

I use BTRFS over LVM over LUKS/dm-crypt. It works well, although it is a
bit slow on this laptop (which has an old and slow processor, very
little memory, and encrypted swap). However, I do find that
suspend/resume is not reliable - I am not sure how much of that is due
to the complex setup. But BTRFS copes when the system is booted after a
resume failure!

A bit more detail...

I have one disk (a rotating disk). I have 2 partitions: an unencrypted
ext2 partition for /boot, and then all the rest of the disk in one data
partition. The data partition is encrypted with LUKS (prompts for
password during boot) and is one LVM PV and VG. That VG has two LVs: one
for swap and one for the btrfs filesystem.

When I next rebuild it, I will probably make the setup closer to what I
run on my home workstation and home server: 4 partitions (bios_boot,
unencrypted /boot, swap partition, data partition). On those systems the
swap partition is encrypted (although not included in LVM) - I probably
won't bother with encrypted swap on the laptop next time, to make it faster.

Anyway, my experience with BTRFS over LVM over LUKS is that it works
well on all these systems. On the server, some of those BTRFS
filesystems use BTRFS RAID1 (using LVs which are on different disks, of
course).

But test that suspend/resume works reliably for you (including when
suspend is triggered by the battery running down).

Graham

P.S. Let me know off-list if you would like me to send you my personal
"cheat sheet" reminding me of the steps needed to set up this configuration.
