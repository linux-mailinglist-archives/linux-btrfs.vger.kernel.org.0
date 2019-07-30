Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7A7B623
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 01:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfG3XNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 19:13:24 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:59722 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfG3XNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 19:13:24 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id D7277142BC3; Wed, 31 Jul 2019 00:13:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1564528400;
        bh=z0mBSs5dzs7dafBoH35hluyxpOGeHYaq+46JoqJEEEo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ky0ipiKTmabQ1O1FcqyUPOS0B5LyG1o2OKKopT1+dE7VpM87Tp4ccKU6Ft55fB67g
         srTxCkRIEe7dnZTucXQcA7VpxPaEBC8TqiBZbeRUA9rDN154RVcHApbQU+ko6tsUE5
         gTGrqSZBMpq8M+as/FRRAxSOC6ZgqVfRUGxHmnctInU6s2k3bNQ+uC4YrkKUnuf6Wn
         JVjxvH0uuEHEB8+FeUeHVX5dO+6K0/ZO3MyroqxvcGC51acZT8UMgfSqy/XiGBN9Oz
         jm4/Z8m/f9zt9/LX7QsUmIRVdy9MuIllZuzyH/WuyvIdj33ZNLRzrPOS8Ln/sY1TT1
         t6HhQ3Csz9zog==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 77A86142BC2;
        Wed, 31 Jul 2019 00:13:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1564528400;
        bh=z0mBSs5dzs7dafBoH35hluyxpOGeHYaq+46JoqJEEEo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ky0ipiKTmabQ1O1FcqyUPOS0B5LyG1o2OKKopT1+dE7VpM87Tp4ccKU6Ft55fB67g
         srTxCkRIEe7dnZTucXQcA7VpxPaEBC8TqiBZbeRUA9rDN154RVcHApbQU+ko6tsUE5
         gTGrqSZBMpq8M+as/FRRAxSOC6ZgqVfRUGxHmnctInU6s2k3bNQ+uC4YrkKUnuf6Wn
         JVjxvH0uuEHEB8+FeUeHVX5dO+6K0/ZO3MyroqxvcGC51acZT8UMgfSqy/XiGBN9Oz
         jm4/Z8m/f9zt9/LX7QsUmIRVdy9MuIllZuzyH/WuyvIdj33ZNLRzrPOS8Ln/sY1TT1
         t6HhQ3Csz9zog==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 306EC20448;
        Wed, 31 Jul 2019 00:13:20 +0100 (BST)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
 <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com>
 <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com>
 <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
 <CAJCQCtTSu4XdUmEPHD_8QL71U3O3M8-0m+SweqhPonkKRMUMeg@mail.gmail.com>
 <d76a038d-fc7f-5910-ec2d-ac783891f001@petaramesh.org>
 <CAJCQCtR3pW7T7=DxuAyqwfG+4ii-jg2AVqQL2wVEAx2VrGAY8g@mail.gmail.com>
 <1d80844d-9932-03a8-ae59-c8cbf48a1f57@petaramesh.org>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <a73770f4-5ee9-176a-5591-5700864f75b9@cobb.uk.net>
Date:   Wed, 31 Jul 2019 00:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d80844d-9932-03a8-ae59-c8cbf48a1f57@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/07/2019 23:44, Swâmi Petaramesh wrote:
> Still, losing a given FS with subvols, snapshots etc, may be very
> annoying and very time consuming rebuilding.

I believe that in one of the earlier mails, Qu said that you can
probably mount the corrupted fs readonly and read everything.

If that is the case then, if I were in your position, I would probably
buy another disk, create a a new fs, and then use one of the subvol
preserving btrfs clone utilities to clone the readonly disk onto the new
disk.

Not cheap, and would still take some time, but at least it could be
automated.
