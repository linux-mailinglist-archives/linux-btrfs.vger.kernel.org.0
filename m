Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35F06704B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfGLNl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 09:41:56 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:44310 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfGLNly (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 09:41:54 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 08D4C142BC4; Fri, 12 Jul 2019 14:41:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562938912;
        bh=XdUyV87aPKPFuX6C3uTy2bY85PYx6mGfscI/0NAvAcQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pwZfgPdCUsCHdmKZfXPG5+vWYiGeH5IMFGkkWMs4TP9UPqWu2AZhhcLJE77gBjCCq
         UqMlPTUunFrWjvXHnYe3ek8t/1eoqJ9Mn0CDNYaOYXv9exLvkBdRyCzk3gO7ymIVOA
         mFQFEPmwLKhhVKLMdy49AE2T7u8UZllShrNhAjGHT2V58ZVfw9Yt2lp4fF75dnuTUk
         dmTpMnRlV7N/mQHfgYx5bkcjp8olyaFr6PFcjHaLwpsr8RMugIlTD4pQI4EO6OUNF6
         3Y3Jv1JCft7iwGXJoSMceO58BvJTJ7c47rjgChznwsWOtBw9hx2g5V2gBngdV5Qjtr
         /qv/IT9F8hdhQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id C52DD142BC1;
        Fri, 12 Jul 2019 14:41:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562938909;
        bh=XdUyV87aPKPFuX6C3uTy2bY85PYx6mGfscI/0NAvAcQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aZCbNcwRjLlzXsMQO68VrLcBXawi4Z2CsYTi83dCnJt97gPHu/22zXWo2Z4vZZDa+
         xHf+EgjXEpvYz+BeuUIh/pD8wW9z9w1J+Z08rB7Dry4ytWZQBu6gttMuWg3KsUQwF1
         nXds7Ypt7iLBF1dO74H7RsxN1m9ch9XXen7iMFtRX0invOAu3Q49wrJOmf5RiR3FZ6
         tXqgxr+ftf7PrssLwGECuVmwkV+X/4AR4y4xLKFggwD6HvW0hOZ3zhBXYMfBAwNCUa
         duNfasvY2yhkqFzoavXz4FCrUY3Y2a1Jt/7w253AlbaNoHCbbu+uf0cvcAlgB7h+nE
         YDtQqjddlWsdA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 518DF17C62;
        Fri, 12 Jul 2019 14:41:49 +0100 (BST)
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     Patrik Lundquist <patrik.lundquist@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, calestyo@scientia.net
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
 <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
 <7766d592-525e-67fa-5db0-bcfff17fbf83@oracle.com>
 <CAA7pwKM_Le3FO8qprqn4busbTzWHeUTB+9h1zwBQ+KOjKqZuvw@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <70d6130b-6ad1-5e25-ba7d-37ffe0b1c3dc@cobb.uk.net>
Date:   Fri, 12 Jul 2019 14:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAA7pwKM_Le3FO8qprqn4busbTzWHeUTB+9h1zwBQ+KOjKqZuvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/07/2019 14:35, Patrik Lundquist wrote:
> On Fri, 12 Jul 2019 at 14:48, Anand Jain <anand.jain@oracle.com> wrote:
>> I am unable to reproduce, I have tried with/without dm-crypt on both
>> oraclelinux and opensuse (I am yet to try debian).
> 
> I'm using Debian testing 4.19.0-5-amd64 without problem. Raid1 with 5
> LUKS disks. Mounting with the UUID but not(!) automounted.
> 
> Running "btrfs device scan --all-devices" doesn't trigger the fsid move.

Thanks Patrik. So is it something to do with LVM, not dm-crypt, I
wonder? Note that in my case I am using LVM-over-dm-crypt, and it is the
LV that I mount, not the encrypted partition.

