Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1651BA5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbiEEIbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbiEEIbS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 04:31:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A062FFC0
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 01:27:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F0D81F37F
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651739257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je4RYVhwVS2+1xEYKLVuPICsEGjaPoaarpSxdjrlNWI=;
        b=Rp3fswPPMgBq5cHrhH5ktoGINSVQTKjWSVRPx3gdwHSbGLIQMHQRN7eyO8Cfk2EQ75wgTQ
        ooSK1OYOAMD1J17Lb2Kt6bsCbDyP49D9l6vIQqNV05KNw3Mh4GaXkBIOn/wU3pqg5og2iG
        hG/kQNluMm+9pxKzulYJ8Q18EpcYgmM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7021A13B11
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tne0GHmKc2ISDQAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 May 2022 08:27:37 +0000
Message-ID: <09b97c23-5933-7814-9cd9-72e95b0ffadd@suse.com>
Date:   Thu, 5 May 2022 11:27:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Debian Bullseye install btrfs raid1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
 <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
 <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
 <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
 <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
 <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
 <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
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



On 4.05.22 г. 22:33 ч., richard lucassen wrote:
> On Wed, 4 May 2022 21:15:50 +0300
> Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> 
>> No, it will not. Some script(s), as part of startup sequence, will
>> decide that array can be started even though it is degraded and force
>> it to be started. Nothing in principle prevents your distribution from
>> adding scripts to mount btrfs in degraded mode in this case. Those
>> scripts are not part of btrfs, so you should report it to your
>> distribution.
> 
> Ok thnx! Would it damage btrfs if I add a permanent "rootflags=degraded"
> to the kernel?

The flag itself won't have any repercussions on stability but if your 
only remaining disk crashes while you are in degraded mode, because your 
other disk is already gone then you might lose data.

> 
