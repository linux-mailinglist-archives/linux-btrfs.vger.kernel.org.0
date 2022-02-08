Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E424ACD85
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbiBHBGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 20:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiBHA23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 19:28:29 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 16:28:28 PST
Received: from xweb105.xsoli.com (mail.xsoli.com [170.39.196.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94651C0612A4
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 16:28:28 -0800 (PST)
Received: from [10.72.103.152] (bras-base-blolpq2201w-grc-22-76-68-192-161.dsl.bell.ca [76.68.192.161])
        (Authenticated sender: sylvainf.xsoli)
        by xweb105.xsoli.com (Postfix) with ESMTPSA id ADA04C0086;
        Mon,  7 Feb 2022 19:19:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xsoli.com; s=2017;
        t=1644279565; bh=AYDAx8fdOL1xBdkJQUAhs81pJTy1kBEYmiHha5ouraE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JnKAjDtpwHHxhGmPDSxKX48W+tw8PwLlyVTTxMLWBZv0e/AlXDBStRBzjvAI5Cvof
         NsqUaTCqMZc7uyX9R5Hrs0cnQHnwQPeoxANeSWSdPqdMdBmP4r/5gRiaVV8MsjiqKO
         qrdZ/nPRbl6QwMKjL2YPdmtABosR23AFWyOtk5txdY/2a9tO5HgV0exnagafVZEadt
         NnB1rsjpQmgEsqhNJEcrskf7uREpO5Sphm029ReXWkl0/BSHXmEroRUsMACNCtk51w
         M9Idl5aZw5u3zfHTLV/H0sqKzJqUGsBJ1p4naKaEVf0kB+OzggDLfeNgsJ7H/YU0s7
         VBZ3mA4Yt4BMw==
Message-ID: <c3bdb18e-d59e-76b8-c54c-f5febe22e6df@xsoli.com>
Date:   Mon, 7 Feb 2022 19:19:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: ENOSPC during balance with filesystem switching read-only
Content-Language: en-US
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <a12e234f-7085-03af-eaa9-1e1e4b3ad03f@xsoli.com>
 <5bf0501f-c0ae-98f8-9dba-93603af5ed26@tnonline.net>
 <af3d001.f997db31.17eca28822d@tnonline.net>
From:   Sylvain Falardeau <sylvainf@xsoli.com>
In-Reply-To: <af3d001.f997db31.17eca28822d@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Thank you for your response and sorry for the delay, I had to copy the 
data elsewhere before trying anything else.

On 2022-02-05 08:52, Forza wrote:

> I was too quick in my answer...
> 
> It is probably better to use "-dconvert=raid1, soft -mconvert=raid1,soft" as it avoids rewriting chunks that  already are using raid1.
> 
> You can actually try this before trying with additional devices:
> 
> # mount /srv/backups && btrfs balance start -mconvert=raid1,soft /srv/backups
> 
> The idea here is that next metadata allocation should be a raid1 block group instead of a raid10. Raid1 only needs space on 2 devices, whereas raid10 requires space on 4 devices.
> 

I tried to start a balance with && after the mount but without success. 
It goes read-only before doing anything useful. The log has the same 
error and stack trace as before.

I tried your other solution to add two 10G file backed loopback devices 
with `btrfs dev add` but the command returns without error but *without 
adding the devices*. Then the ENOSPC error is back in the log and 
running `btrfs dev add` again does not give anything difference (not 
even an error).

Thank you for your help. I will head to the IRC channel like you suggested.

-- 
Sylvain Falardeau
