Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB78B19A126
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgCaVqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 17:46:31 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:53066 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgCaVqa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 17:46:30 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 1400B9C424; Tue, 31 Mar 2020 22:46:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585691188;
        bh=/dnW5+HJh1JvqT+S0yKdDqJ8+1MNb2vgeycksza5Keg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LrJ7UEvlRDlnns2el4rNu5IXft/B44wiUb1FyJOFa7lFO/pnK+IC9yZ+/7Qrc+0lS
         8z0sztRvWzrvimt4APZoa+ZdvbaHKqp7wyP497hjnxkBSPUuSvMpd9mu6NKCbffV/A
         I24Bl+ShMu/o8UGfAbhcBLCTeSGJRcosuioqcJ1OMKtadVOqJdAe6YYzPCjjJ8wPQq
         +JedO8XWXQYVuOjufCu7a9gpkCbr4VTMT5e/NKEdJCl13bGkHP4tTIuf8ee5+FCB20
         EQEz7f7zSWhPUQkuPKL6FtTYDbsiXyfoyPkUCWVEMp+dOvvPi87/QDt07teVibjr6s
         v3gmycb2WA8gQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 75C4F9B92E;
        Tue, 31 Mar 2020 22:46:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585691179;
        bh=/dnW5+HJh1JvqT+S0yKdDqJ8+1MNb2vgeycksza5Keg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bgpmTutTb1JfuMPL8JfSq08mnfVzcjgAsSMPEj8xUyf73vYxF55jJwpITa65SVDm9
         JDNCrPxue1NU9mD7ikGgBLPmKzzBAco/o8KLP705BULFzshmPjRzXXfDTJt6y16H9v
         4CwXcoZrKwDxbhuVMfFwuFDBcSvsMyltoqIpFgN4Qcs2Re9i/Ej0I1SZsKHWWhOiNL
         5ln+keTbqMtyahN79c84a2DntTtuGwiYqW200YRChFH49zTHfAoW4kvqdP4TGC577+
         IhTQaOxrF41RWmErIha5qW7eYKpOHfPh9RgiQxoThMsxAQooAnbFqENTEXtCvzxCgH
         x1df+5TDbfJ5g==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 1D4D8DAD03;
        Tue, 31 Mar 2020 22:46:18 +0100 (BST)
Subject: Re: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
References: <20200331191045.8991-1-kreijack@libero.it>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
Date:   Tue, 31 Mar 2020 22:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331191045.8991-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/03/2020 20:10, Goffredo Baroncelli wrote:
> WARNING: ------------------------------------------------------
> WARNING: Detection of multiple profiles for a block group type:
> WARNING:
> WARNING: * DATA ->          [raid1c3, single]
> WARNING: * METADATA ->      [raid1, single]
> WARNING:
> WARNING: Please consider using 'btrfs balance ...' commands set
> WARNING: to solve this issue.
> WARNING: ------------------------------------------------------

The check is a good a idea but I think the warning is too strong. I
would prefer that the word "Warning" is reserved for cases and
operations that may actually damage data (such as reformating a
filesystem). [Note: in a previous job, my employer decided that the word
Warning was ONLY to be used if there was a risk of harm to a human - for
example, electrical safety]

Also, btrfs fi usage is something that I routinely run continuously in a
window (using watch) when a remove/replace/balance operation is in
progress to monitor at a glance what is happening - I don't want to
waste all that space on the screen. To say nothing of the annoyance of
having it shouting at me for weeks on end while **I AM TRYING TO FIX THE
DAMN PROBLEM!**.

I would suggest a more compact layout and factual tone. Something like:

Caution: This filesystem has multiple profiles for a block group type
so new block groups will have unpredictable profiles.
 * DATA ->          [raid1c3, single]
 * METADATA ->      [raid1, single]
Use of 'btrfs balance' is recommended as soon as possible to move all
blocks to a single profile for each of data and metadata.

