Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC61FFD00
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFRU7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRU7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 16:59:14 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDAC06174E
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UXZ0VQOl6vn3/glpPaeNW6lS1GF5H3Go+ZQ7Ff7myy8=; b=gxjRy3zvXQLY7giMvjoZByoKQD
        OzMggPzqASmk31UHq1aDlRLM9poL8w6Bq5NMZ47Ggb+2Ci/Btpn71ito+ejHWw5bzcr/fGq3EB3NT
        AnazVKnmXMWqFkgC7WSb8NDtYNvtl20Qxd5Tssre7RjtQuzNuXxY+PgSbbXrLjSQIpl3G+TJJLXt/
        Ve+YVmXvN6S/hKGbBy0ftETnqteEXKtGQw3PSQSas1eqDfuR9d7KX1zRnQOtNTUptq8dVjMlxGYJT
        SWM6jwX6DBhQDeB+2c5KFz6nDlbVtnepy0f/kxsJfApOoQ2IRZxzvw6Q0Eu7uFgpRURoojTlRQOEA
        7YSGcJ+A==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:8870 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jm1cs-0001D8-SM; Thu, 18 Jun 2020 22:59:10 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <878f01ec-eb07-e8ba-bd32-143997bce422@dirtcellar.net>
Date:   Thu, 18 Jun 2020 22:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have pointed this out before , but I would like to use the opportunity 
again. I, as just a regular user of btrfs would feel more comfortable if 
the dedupe tool was part of btrfs such as for example btrfs filesystem 
dedupe -r /somewhere

Regular users that are somewhat technically able may not know that the 
dedupe fuctions are kernel api's that should not destroy anything even 
if the calling program went berserk.

While this may be obvious to btrfs developers, it is not to regular 
users that may be concerned that a particular tool may wreck havoc on 
their filesystem.

DanglingPointer wrote:
> btrfs-dedupe is currently broken and no longer actively supported.
> 
> It no longer builds with current rustc v1.44.0 with cargo
> 
> It is in the official btrfs Deduplication wiki:
> 
>      https://btrfs.wiki.kernel.org/index.php/Deduplication
> 
> There's no real active community and proper QA, reviewing and vetting.
> 
> A poster in the issues area of the projects Github location stated that 
> even if fixed, it may not function correctly due to BTRFS having evolved 
> since the tool was designed created.
> 
> There's just too many unknowns with this BTRFS specific dedupe tool.
> 
> People using your official wiki and trying to use that deduplication 
> program could inadvertently destroy their data through nativity or 
> accident.  Especially if they start trying to fix the code.
> 
> I recommend you remove it from your website or at least put large 
> warnings there that it is broken (which looks ugly, I would rather only 
> stuff that works were there since it isn't your project anyway but some 
> 3rd party).
> 
