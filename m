Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59795A712
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2019 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1Whq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 18:37:46 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:35488 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1Whp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 18:37:45 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 1FD49142BC3; Fri, 28 Jun 2019 23:37:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1561761463;
        bh=OJWma+H0ftDZ0RNLMkTevjhUUXIXDE36rZWPqmdxVhE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=aD/b9ZR37DDuJzoiSqG9B33aQseigSf731GlSV8UQ5HhrW1SZqadaU27fkr8u7vKj
         YdhfCGK8BBPmCoqkIzMHRo5NXId8BLYf1T0pqkQuBQW+QfpjpPfDn14ivl5nAaE3m/
         NsxzwJm6NmB9AhejpZyVENodctxmyRmDd1nYet9uQAC+DURqeSLdEP3x5w551RKvnp
         ho3ZL1s1sEK3KMiCIJT8JtyS2+qjGqLhgEaGtHJMFPwHK+Kje2tZ73fN3JN4PSADS+
         5QygJs9B1a2Ru9aNFWwqUfOLssF5WBVMsrDZ/d2MIgdSK3FUf/ShhJClQfP1U0I/LR
         PlfXuCCE9td6g==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D54CD142BC1;
        Fri, 28 Jun 2019 23:37:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1561761460;
        bh=OJWma+H0ftDZ0RNLMkTevjhUUXIXDE36rZWPqmdxVhE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=X9KbBXv54iZ752UFfe4Gwp4qLMInlC+/nQKT1wUoM5efYAY61AjsChocrM0QekZWb
         Cchgq+OG3g7p87g4iYGpX18cvaU0ewamom9JeWaSm828ihmq+xWgk6Grt+lU7Q/A3f
         UVL4lKoeP4ghcRjWTRFSl9lw2I+Ry6MRWXahx0wIFD+Sgez53Q2K02mX2rFzoRbPTN
         M0WucWFKavLLOPSRecLQoLpXuVS7hgbaqypfXCCnfnSBcvhRT7UAh+VbIlL0tLof8Z
         kWmPxgSzIBQ9KM2g2VBAiiuI/+DQfIwsN/c2gLL6Pt7T8PDg1nxizScIEOtTmnkRbk
         qBlg3LR9pPpRg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 8FAF4DD93;
        Fri, 28 Jun 2019 23:37:40 +0100 (BST)
Subject: Re: Btrfs progs pre-release 5.2-rc1
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190628174032.3382-1-dsterba@suse.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <5f8d8f28-7d43-e96f-6982-59a584f5f74b@cobb.uk.net>
Date:   Fri, 28 Jun 2019 23:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628174032.3382-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2019 18:40, David Sterba wrote:
> Hi,
> 
> this is a pre-release of btrfs-progs, 5.2-rc1.
> 
> The proper release is scheduled to next Friday, +7 days (2019-07-05), but can
> be postponed if needed.
> 
> Scrub status has been reworked:
> 
>   UUID:             bf8720e0-606b-4065-8320-b48df2e8e669
>   Scrub started:    Fri Jun 14 12:00:00 2019
>   Status:           running
>   Duration:         0:14:11
>   Time left:        0:04:04
>   ETA:              Fri Jun 14 12:18:15 2019
>   Total to scrub:   182.55GiB
>   Bytes scrubbed:   141.80GiB
>   Rate:             170.63MiB/s
>   Error summary:    csum=7
>     Corrected:      0
>     Uncorrectable:  7
>     Unverified:     0

Is it possible to include my recently submitted patch to scrub to
correct handling of last_physical and fix skipping much of the disk on
scrub cancel/resume?

Graham
