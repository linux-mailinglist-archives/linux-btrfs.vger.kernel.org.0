Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283523DA0D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhG2KKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhG2KKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 06:10:20 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A4C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 03:10:17 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id D8B6E9C34F; Thu, 29 Jul 2021 11:10:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627553415;
        bh=E7n8jJKQaj7xcdxn+mL2IKFB16i6UT4QEg+MQxS7LoA=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=xpe6IS/E9wX+kOvpqtdPu2m9o8OU6P+BPa5Sxdof/dxA2kxQfAu2vshKAapEc8kfO
         fpLeJYGaJRHO/Gb7BNgGvyv/p5CZtg9/Is5SrhJZYAcMh5lK2q3eNmc566u+xVUY2U
         +RJ7CLCKkOeVnojbrz0t0f5qPQvzypAOupmwd5I9RH5NwZNrrdHJU2dINSP4Eno/oW
         ZF7rkROxC0p+HoKprH7Zs574HsqVKXWn6kZg+M9FvU8Qxum5bhWi1uPmvATfkxYyMu
         /JE7EnmoAm7HTePY6yHQdoZ4rqNEt6oc3KGwEEOX6sOS/8g1LsAL8V9jM/s9V9MtQJ
         ItsXIQmP5XG+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.1 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 518779BC8E;
        Thu, 29 Jul 2021 11:10:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627553414;
        bh=E7n8jJKQaj7xcdxn+mL2IKFB16i6UT4QEg+MQxS7LoA=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=c2ZP8/8DXBpfJl340HNiKSF1nDHGEHzjQIpDlFlykksbHiiSW7aNVTNhHjwMCLkju
         /a+6HteHpLXhPtyt2ErWcb+yNJqAS5RyiY/RvfPGARHjdgwIUff72/ihLCHaUqjStm
         NcLkAuFzln7JIPFY4wSACIRKguBJ+0JgXlDbZcD+B8+NP9TQrWE2B6x6g8w4h4/3ln
         4w4MHrKkSiyQlemhPxXQFZmqb+pkITjdrbJ5Cg5SNnx7EEP+hO/6o5mexkPIZhlnF2
         1DtoML+AE7uMD/vMHWol3BPG+crAAUWoVHwnVLTSZLINxOGUCce4ikSOIYn4W+U2kP
         anH6uHex4Zgzw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 337B9275B06;
        Thu, 29 Jul 2021 11:10:14 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
 <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
 <CAGdWbB7-nebkXTrFRDADLYYLqBi3xhibucySpeKUWqGjFJMzng@mail.gmail.com>
Subject: Re: reorganizing my snapshots: how to move a readonly snapshot?
 (btrbk)
Message-ID: <78d162f8-98c4-16c5-e16a-a7231f5d5ee8@cobb.uk.net>
Date:   Thu, 29 Jul 2021 11:10:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB7-nebkXTrFRDADLYYLqBi3xhibucySpeKUWqGjFJMzng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2021 01:57, Dave T wrote:
> I tried the btrbk archive feature. It doesn't fit my use case.
> ERROR: Source and target subvolumes are on the same btrfs filesystem!

Ah, yes, I remember now. When I used it I was moving to a new backup
disk at the same time as reorganising. You would need a spare disk (at
least temporarily) or enough space on your current disk to create a new
filesystem in a separate partition.

My only other suggestion would be to take a temporary copy of your
latest snapshots somewhere else (such as external disk, or cloud
service) then delete all your snapshots and set up btrbk again. Of
course, that would lose your snapshot history.

Sorry
