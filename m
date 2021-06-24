Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA03B2A66
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhFXIef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhFXIef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 04:34:35 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB091C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 01:32:16 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 090349C348; Thu, 24 Jun 2021 09:32:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1624523530;
        bh=Vfg7NjcJzB+OAX4W3NdFa4PhhrLfj2kqtM0pd+2ovDc=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=M4p3RZUFEQ+KMvlXXbI8ov6sCoWoN1qG+MjyAv/BkyOvBzzkp9FTNBo/sIbtRyZLw
         ycykka3LedPhhwXMTyQmNpUTldLl1YDdnR7hzIQ/YY1R0e7gom3Dg85OfDGVQHzm0k
         ZycwtfaQaCL/06njqcXYSKRhNETOe5/btsxI9ZwRJAzJ5UA59ItC2WwEz2ss3x3k4A
         X6YabR8DTw3Lc4Rcn7XXkAB/ZNxKjuxLptV97GnVVCQCMX/lLnjJRkzNYZfazmqEHq
         kNNlBcVvx3PkV0xH9sUm4Ixhq/+JCNQJQfUnWavENrpEYYvOK+sswljs6AMcyFqONr
         GPW3Yl/tEt7Xw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 869789B9A4;
        Thu, 24 Jun 2021 09:32:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1624523526;
        bh=Vfg7NjcJzB+OAX4W3NdFa4PhhrLfj2kqtM0pd+2ovDc=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=M+J4c+FR3s33ezbUTtcMxMSFUPwgUR3ecpLbSVW+KEuH4lQXPCUfYca5iHXnjJ8Lr
         E3Q2Xt0y/OyQIO7ujNtokGBN6jcI7Qjfb4REeS8aN+UNd3zzbwJmOl3Rc8Y9Zayg3C
         Vm9CiOZHhL5OJd6OVaHaNv6at7p1s8eX8TJXW4ZO1nWyUUy6xf0lZVEokuMlk3FkID
         VwmYxXs00ZnqZcrtLX5a0uckMJw7+j+KNg7Cstwu2sI+bTaGGEsiFJhFXr4E/H3kd/
         L73exAWVHMtMT5eaNotBgqXJETJbmvl1s+PXAs+5o6gmya2uKrHD1cUQUCTtAHblPa
         /6hE/DXgMSZvg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 1DB58258EE4;
        Thu, 24 Jun 2021 09:32:06 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
 <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Message-ID: <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
Date:   Thu, 24 Jun 2021 09:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2021 08:45, Zhenyu Wu wrote:
> Thanks! this is some information of some programs.
> ```
> # boot from liveUSB
> $ btrfs check /dev/sda2
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> # after mount /dev/sda2 to /mnt/gentoo

Did you do 'mount -o subvolid=5 /dev/sda2 /mnt/gentoo' to make sure you
can see all subvolumes, not just the default subvolume? I guess it
doesn't matter for quota, but it matters if you are using tools like du.

You don't even need to use a liveUSB. On your normal mounted system you
can do...

mkdir /tmp/fulldisk
mount -o subvolid=5 /dev/sda2 /tmp/fulldisk
ls -lA /tmp/fulldisk

to see if there are other subvolumes which are not visible in /
