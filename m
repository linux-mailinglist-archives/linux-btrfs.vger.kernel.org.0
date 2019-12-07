Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42C115A61
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 01:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLGArH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 19:47:07 -0500
Received: from mail.virtall.com ([46.4.129.203]:33732 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfLGArH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 19:47:07 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 0AE8439A8F9D;
        Sat,  7 Dec 2019 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1575679625; bh=8dmlRdm4KkQiRj+6FPNGKKrN8YVVdyxr18BNadMLOew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NgR5LgIIx/IMG7QtDXtY7Yn4oE+Wk39YLTQkJwCdsD40BA9lMAhmGssNF5ep0Q8Fo
         KFGOtwbM0EE16usISUNCu2cJfHYIfMIV/JI85s+lkyK2pKZUAKuK00yPy92EqeLK5W
         DHt/m+mRkm5MK7C9TSz5r3ZRK6kmRaCt0uOqwoyHN+W33zjShSTxiMWIgSMElPfWe9
         xH6Of91TZKhm4qoo+3tU0W3uGnM/Tej0ZMZKPvIpRyN55GXDX70fm6YMX/TZzoRFfT
         gJ7OvtItpTGuykOgbLGOTGNRsd9+NgRly28Wl98BJH2xJVffO1gEVfOVj6bp+6PUxw
         BGPtu/TZcIOJw==
X-Fuglu-Suspect: df9fbe7057a14e9ba9173c60f3f40525
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Sat,  7 Dec 2019 00:47:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Dec 2019 09:47:01 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 100% disk usage reported by "df", 60% disk usage reported by
 "btrfs fi usage" - this breaks userspace behaviour
In-Reply-To: <CAJCQCtQ9Vg9VuT66diid6KdRMDqicxj9xLigTBF4sbMgqD=5jQ@mail.gmail.com>
References: <eb9cfb919176c239d864f78e5756f1db@wpkg.org>
 <CAJCQCtQ9Vg9VuT66diid6KdRMDqicxj9xLigTBF4sbMgqD=5jQ@mail.gmail.com>
Message-ID: <c768a339fee28c7b4296d94b02beff12@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-12-06 12:54, Chris Murphy wrote:

> What version of coreutils?

This is Ubuntu 18.04 LTS, with coreutils 8.28.


> Maybe attach a strace of df? (I'm not sure of the list attach size
> limit but it's preferred, but something like a pastebin is OK also)

"Unfortunately" I did run a balance, which "recovered" the space for df.


Tomasz
