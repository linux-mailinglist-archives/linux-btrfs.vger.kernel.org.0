Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BC519C88
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbiEDKKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347744AbiEDKKx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 06:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E824BCF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 03:07:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EA4F210DC
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651658835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8elQXjvO8x2zcUfIxzy+XrAl6BuYGTB1aQc/Zj2nGw=;
        b=U6NGNvHzaunaqqCqZxcxhFPzN29kuxRrmX+2vuX9a5kvsv3RcQ/UsYEgyZjMsAullfkVaC
        l65OUPGa/BQ/Fbp1hNgT0Y0Ze3bCwexQg2cjFIJ0IqjTHiakKNUH0k71WeCacjpW6R7MfZ
        kZk/4FxdYI1NPmHI/ZhjhJIhxGHxPZo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11B86131BD
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 10:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vv2oAVNQcmLrGgAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 May 2022 10:07:15 +0000
Message-ID: <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
Date:   Wed, 4 May 2022 13:07:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Debian Bullseye install btrfs raid1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
 <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
 <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.05.22 г. 13:02 ч., richard lucassen wrote:
> On Wed, 4 May 2022 12:27:29 +0300
> Nikolay Borisov <nborisov@suse.com> wrote:
> 
>>> Question: is this newbie trying to set up an impossible config or
>>> have I missed something crucial somewhere?
>>
>> That's the default behavior, the reasoning is if you are missing one
>> device of a raid1 your data is at-risk in case the 2nd device fails.
>> You can override this behavior by mounting in degraded mode, that is
>> mount -odegraded
> 
> Another thing: sda3/sdb3 is the root fs, so I need to tell grub that
> it's ok to mount a degraded array (one or another way, don't know
> if it's possible, I'm not a grub guru). Adding it to fstab makes
> no sense as there is no fstab at that time.
> 
> OTOH, when using md devices, the / fs is mounted as Degraded Array and
> the remaining device remembers that this had happened. If the second
> disk is replaced I have to add it manually using mdadm. The first disk
> is "master". Using md the system boots and mounts / and thus all tools
> are available to repair the array.
> 
> The wiki explains how to repair an array, but when the array is the
> root fs you will have a problem.
> 
> So, what should I do when the / fs is degraded?

In case of btrfs raid1 if you managed to mount the array degraded it's 
possible to add another device to the array and then run a balance 
operation so that you end up with 2 copies of your data. I.e I don't see 
a problem? Have I misunderstood you?
> 
> R.
> 
