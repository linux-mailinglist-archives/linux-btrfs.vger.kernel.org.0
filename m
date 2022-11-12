Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F7626831
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Nov 2022 09:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiKLIsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Nov 2022 03:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLIsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Nov 2022 03:48:37 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 00:48:33 PST
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27C55BE
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 00:48:31 -0800 (PST)
Received: from [192.168.1.27] ([84.220.130.49])
        by smtp-17.iol.local with ESMTPA
        id tmAhokCNCYULYtmAhoTIKU; Sat, 12 Nov 2022 09:47:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1668242847; bh=mULBhmO4EbSPhS4vIbglTTUwaHSgHEr6X3Kba1RM5oM=;
        h=From;
        b=CNNWXCyLtP7HVXSvUiCVSg/veLwj/L6IKqdrf9tDFIpX4vdqsKrbwj2N+Jtkoev02
         Z1q7MDRPHmJW84jDCO8J/PlMxENkhNdNY2GPgVkroyvyttHqCPOmxKGNleG132sA8b
         UFZ5sku49t6oJwCYBoGZfqulDh900glpyXbCnXm8DzYZnNKQn75w9gk9kvEo1OZwXh
         5sszW1O3EOeYp/99aEPxOP9voWcAAPBgKBW2NFLEv4+5s2Gp3b4JmrKyHJ2JgvQLOo
         inuKfCL+EGmQBxdlH7hLjWW9BTmxk5oDngmgGxZVMuwBF8xnx3jVPQ28KDotS9n8Bg
         Q9MqIVxr6Ay/w==
X-CNFS-Analysis: v=2.4 cv=DbfSFthW c=1 sm=1 tr=0 ts=636f5d9f cx=a_exe
 a=SdbLdwgxGF07xCE66nLfvA==:117 a=SdbLdwgxGF07xCE66nLfvA==:17
 a=IkcTkHD0fZMA:10 a=Ds2bGRqI_9CkinKiL-gA:9 a=QEXdDO2ut3YA:10
Message-ID: <21e6a2cc-707d-f66f-d75f-2835f88b9313@libero.it>
Date:   Sat, 12 Nov 2022 09:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: btrfstune: add -B option to convert back to
 extent tree
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
 <20220923103945.GQ32411@twin.jikos.cz>
 <5f23506e-a505-0a37-5ceb-c55a02b114ed@gmx.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <5f23506e-a505-0a37-5ceb-c55a02b114ed@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN9IlLd49lKrd6TEvR+kdOqCWwbCcyaFD7wSjamqf9Z0PcCfiihKt9F3n0jRFEbpl190AHS+uBlmKVqsHnUqxb0ttDxVesgvODXY+LL8V6/rZtGsVmJP
 6iQiwQe9g/vToreF27lTBbeMNZsO7RrSJIBXVwTYIvEWzWvp1oelTy2wMqLw7dgqK56K4bEx8OR7FovqeBbMEBtSdknoF8ymMgqAPtcz4rjT9RlC/0rUOh56
 dciHDf6KRmwzutm3iwn59nWXQg+9jIywcseGYuFeUkg=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/09/2022 13.56, Qu Wenruo wrote:
> Thus what about "btrfs tune/convert feature 1/0"?

My 2¢ to the brainstorming:

reasonable to replace the old "btrfstune" with a link to btrfs. Then when btrfs is called as btrfstune, it should behave as btrfstune as far as possible, i.e. it should have the same switch.

Otherwise we can spread the btrfstune options to different btrfs sub-commands, and then we can use different switch.

In this case I would like to differentiate filesystem/online actions from device/offline actions; some thing like

  - btrfs filesystem update  <xxxx>  -> something that can act to an online filesystem

- btrfs dev update <xxxx> -> something that can act to an offline filesystem


In any case I consider a value the consistency:  if we want to use "btrfs tune" as replacement of btrfstune, this should be done in a way that it is

I would avoid  creating a "btrfs tune" subcommand with different switches from "btrfstune". This would create confusion. The same for btrfsconvert/btrfs convert.


BR

G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

