Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E39571AC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiGLNFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGLNFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 09:05:43 -0400
X-Greylist: delayed 13045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 06:05:41 PDT
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7033A2C
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 06:05:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0672013A;
        Tue, 12 Jul 2022 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657631140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCS/XDCBrnuAfaOSthRBM4wKJVonJNn5dTlvPNFWEqE=;
        b=jhiw0O+aJAzPEjqmjOQi7LzpsF3y6qrvA4tjGe7mbnxvbCb4TNDdmoQf5sjuwulQwt4C9C
        1Pf+GBkfYjR1YY1PtO1bECGB9EhePYwySurjVVS2dvuaEhxOdM7iPcf/w30Ze9g4/A4P1l
        XAlNcrlwBdqOYvVU2G2qBarCma7Uga8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A4913A94;
        Tue, 12 Jul 2022 13:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QhMPCaRxzWKIOAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 13:05:40 +0000
Message-ID: <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com>
Date:   Tue, 12 Jul 2022 16:05:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: BIG_METADATA - dont understand fix or implications
Content-Language: en-US
To:     Peter Allebone <allebone@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.07.22 г. 15:24 ч., Peter Allebone wrote:
> Hi there,
> 
> Apologies in advance, I dont understand how I am affected by this issue here:
> 
> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos.cz/
> 
> I have a problem where if I run "sudo btrfs inspect-internal
> dump-super /dev/sdbx" on some disks it  shows the BIG_METADATA flag
> and some disks it does not. I posted about it here on reddit:
> 
> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectinternal_command_not_show_big/
> 
> My concern is what effect does this have and how do I fix it, once the
> patch makes its way down to me. Is there any concern with data on that
> disk changing in an unexpected way?
> 
> Many thanks for any insight you can shed. I did read the thread but
> was not able to easily follow or understand what was implied or what
> would happen to someone affected by the issue.
> 
> Thank you again in advance. Sorry for emailing in. Hope that is ok. I
> was just concerned.

If you are using recent kernels i.e stable ones then there are no 
practical implications, because as soon as you mount the filesystem with 
a kernel which has the patch this flag would be correctly set. As said 
in the changelog of the patch this can be a potential problem for 
pre-3.10 kernels (very old) so the conclusion is you have nothing too 
worry about.

> 
> Kind regards
> Peter
