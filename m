Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33611220B6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEQXP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 19:15:29 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:43746 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfEQXP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 19:15:28 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id EF02A142BC3; Sat, 18 May 2019 00:15:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1558134926;
        bh=1nRSrl/8y0h2QZddE1PvBXrrQ6Hsf64l0cH1nGeItxw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=twlMWf/rD4mVx9G+MLg/yKtFhihdze1UB6mwLlHN7pp/MkRM+XO81CvluvXk7QC2/
         Rshs+1Wnnjey/xXv1UgO0qv57VgBl6H5xXSJtsPHJM+PHwoFxaCiBjvqYMkCesfJDe
         EiHR8qvQz7vtJlxbYQTzRLUKBJNo9Bv6l1yWQOjNZHevZmsdkhD6lwYlAbaogGDNN9
         NqgXy1vOtYn/ug4BYCavXkL5zWqmKSXjVOveySQsuQQ2LO8ijM5NZmZ5y7liVu9LmQ
         0XoLkiI2NpEuPp8lAWmvzIR2Je4mTipIWVPa8atHw136cU4s/V1yRwTorRy/LX7/4z
         mP7wG9YjRqjOw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 7C5BF142BC2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2019 00:15:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1558134926;
        bh=1nRSrl/8y0h2QZddE1PvBXrrQ6Hsf64l0cH1nGeItxw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=twlMWf/rD4mVx9G+MLg/yKtFhihdze1UB6mwLlHN7pp/MkRM+XO81CvluvXk7QC2/
         Rshs+1Wnnjey/xXv1UgO0qv57VgBl6H5xXSJtsPHJM+PHwoFxaCiBjvqYMkCesfJDe
         EiHR8qvQz7vtJlxbYQTzRLUKBJNo9Bv6l1yWQOjNZHevZmsdkhD6lwYlAbaogGDNN9
         NqgXy1vOtYn/ug4BYCavXkL5zWqmKSXjVOveySQsuQQ2LO8ijM5NZmZ5y7liVu9LmQ
         0XoLkiI2NpEuPp8lAWmvzIR2Je4mTipIWVPa8atHw136cU4s/V1yRwTorRy/LX7/4z
         mP7wG9YjRqjOw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 4476268DFA
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2019 00:15:26 +0100 (BST)
Subject: Re: Used disk size of a received subvolume?
To:     linux-btrfs@vger.kernel.org
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
 <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
 <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
 <24f44d54-a560-0b6e-5fe0-026626d1d2c5@steev.me.uk>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <04d3b1ac-2a3e-f79e-59be-513c00eb8bb1@cobb.uk.net>
Date:   Sat, 18 May 2019 00:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <24f44d54-a560-0b6e-5fe0-026626d1d2c5@steev.me.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2019 17:39, Steven Davies wrote:
> On 17/05/2019 16:28, Graham Cobb wrote:
> 
>> That is why I created my "extents-list" stuff. This is a horrible hack
>> (one day I will rewrite it using the python library) which lets me
>> answer questions like: "how much space am I wasting by keeping
>> historical snapshots", "how much data is being shared between two
>> subvolumes", "how much of the data in my latest snapshot is unique to
>> that snapshot" and "how much space would I actually free up if I removed
>> (just) these particular directories". None of which can be answered from
>> the existing btrfs command line tools (unless I have missed something).
> 
> I have my own horrible hack to do something like this; if you ever get
> around to implementing it in Python could you share the code?
> 

Sure. The current hack (using shell and command line tools) is at
https://github.com/GrahamCobb/extents-lists. If the python version ever
materialises I expect it will end up there as well.
