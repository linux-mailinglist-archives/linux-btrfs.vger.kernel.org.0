Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A87CDD71
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJRNiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjJRNiD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 09:38:03 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EAC83
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Opwz1qyq3pqjVSIDEkZ+pFNTKwYh/PiliWssJ/Ia6Q0=; b=ZiWigBb0/js0kiXuyOQbkG6e00
        l2NDo+1ARsbERdH80LICmyX85ow71D6WriI1jshx9B8oOYWyCEOLrjxH9P3tgyK1gSdQfnAKKZmdz
        K+zf14fu7D7WLEE4VaRs1uoWRx1OyDXMJrbYTqON6Ul2wK5JUPuh+M3pktP79vew14m69yiGi2qIo
        OvIOvbr3Qqc+OOW9Hm8JRjjAhMPCcP5ET5OfmTrLFUCursBrjnrXpPqnH3hXCnnOG8KQ82MzGJeMS
        8rhSpLTnuKt4EPYmf5WCq5HC8qs/85HEenHHtaabc4KVP31piIfP+6HGrS0H4VoLsC3Gl9OUk3aL0
        nvzO+DeQ==;
Received: from 210.red-80-36-22.staticip.rima-tde.net ([80.36.22.210] helo=[10.0.20.175])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qt6kF-001opZ-Az; Wed, 18 Oct 2023 15:37:55 +0200
Message-ID: <179437dc-8be2-2ff1-e8c5-a322c29f13da@igalia.com>
Date:   Wed, 18 Oct 2023 15:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
 <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
 <20231009235910.GY28758@twin.jikos.cz>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20231009235910.GY28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/10/2023 01:59, David Sterba wrote:
> On Mon, Oct 09, 2023 at 01:37:22PM +0530, Anand Jain wrote:
>>>> Can Guilherme send an RFC patch for feedback from others and
>>>> copy suggested-by. Because, I haven't found a compelling reason
>>>> for the restriction, except to improve the user experience.
>>
>> My comments about the superblock flag are above.
>>
>> User experiences are subjective, so we need others to comment;
>> an RFC will help.
> 
> A few things changed, the incompat bit was supposed to prevent
> accidentally duplicated fsids but with your recent changes this is safe.
> This would need to let Guilherme check if the A/B use case still works
> but this seems to be so as I'm reading the changelog.
> 
> In a controlled environment the incompat bit will not bring much value
> other than yet another sanity check preventing some user error, but
> related only to the multiple devices.

Hi David and Anand, I've manage to test misc-next of today, that
includes both this patchset as well as the "support cloned-device mount
capability​" one.

It seems to be working fine for our use case, though I'll test a bit
more on Deck. I was able to mount the same filesystem (spread in 2 nvme
devices) at the same time, in any order...the second one always get the
temp-fsid. Tested also re-mounting the devices on other locations, and
it seems all consistent, with no error observed.

I also question the value of the incompat flag, not seeing much use for
that..looping Qu Wenruo as they first suggested this flag-based
approach, in case there is some more feedback...

Anyway, thanks for your improved approach Anand and to David: is it
expected to land on 6.7?
Cheers,


Guilherme
