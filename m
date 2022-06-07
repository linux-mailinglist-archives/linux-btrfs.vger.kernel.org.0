Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179353F844
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiFGIgC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiFGIf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 04:35:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D61D2457
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 01:35:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E75E1F97D
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654590946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jACfJDxw56BHc7npho66lvibWRuyaZVivlBbGoEUo8=;
        b=FYngXhoBgdhOrGPVUQX6eJbsRm67WPFLL2e0+NU2gBS3GZTcUKUXoefnC1YZQFeShBfMJK
        TJnWEKHE2TF0sSSD/DfvIOwJvQjOwD7Ho3tHQqH/KQuFXgQC3y55VgIl8ijW9a6SR6JhbY
        81/sq0yrOvQ2WMytVOUS9aHsdauvsTE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3115F13A88
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 08:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GGUqCeINn2J9GwAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 08:35:46 +0000
Message-ID: <2e4435e8-3bfc-99b8-d474-247fd6c015d8@suse.com>
Date:   Tue, 7 Jun 2022 11:35:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220329083042.1248264-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220329083042.1248264-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.03.22 г. 11:30 ч., Nikolay Borisov wrote:
> Currently when a device is missing for a mounted filesystem the output
> that is produced is unhelpful:
> 
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	*** Some devices missing
> 
> While the context which prints this is perfectly capable of showing
> which device exactly is missing, like so:
> 
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
> 
> This is a lot more usable output as it presents the user with the id
> of the missing device and its path.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>


Ping
