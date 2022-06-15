Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E767654C913
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiFOMuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348299AbiFOMu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 08:50:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E364A3E9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 05:49:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C54A721C5A;
        Wed, 15 Jun 2022 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655297379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq80E36Pn3qoprSLAhu3sDTpb5DD072Rxa596JqF4ws=;
        b=I+hMCUJcjbGVb34bsPRUfZjqs4YNuMqSIwICiGSg3GU3bZcd9ZUydzLWa53qjTCaWiIijp
        cD0YezIvW2DExld/NUJedtaBltvapcH7HMk+Ud1sPCP/3O7JYdmZ8gLBAE96e5gshsCSUz
        NQvqsntyYQYS2WISuOjpUgd1MZo19Qs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AFB813A35;
        Wed, 15 Jun 2022 12:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZX94G2PVqWIOFQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Jun 2022 12:49:39 +0000
Message-ID: <574ed867-c1fe-6fa5-6182-6c6b588a07fe@suse.com>
Date:   Wed, 15 Jun 2022 15:49:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] btrfs: Add the capability of getting commit stats
 in BTRFS
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-2-iangelak@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220614222231.2582876-2-iangelak@fb.com>
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



On 15.06.22 г. 1:22 ч., Ioannis Angelakopoulos wrote:
> First we add  "struct btrfs_commit_stats" data structure under "fs_info"
> in fs/btrfs/ctree.h to store the commit stats for BTRFS that will be
> exposed through sysfs.
> 
> The stats exposed are: 1) The number of commits so far, 2) The duration of
> the last commit in ms, 3) The maximum commit duration seen so far in ms
> and 4) The total duration for all commits so far in ms.
> 
> The update of the commit stats occurs after the commit thread has gone
> through all the logic that checks if there is another thread committing
> at the same time. This means that we only account for actual commit work
> in the commit stats we report and not the time the thread spends waiting
> until it is ready to do the commit work.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>

<snip>

Since you are using the super_lock I think it should be mentioned 
explicitly in the changelog why - likely the reason is this is a 
non-contended spinlock used in only some specific cases and it obviates 
the need to grow btrfs_fs_info by yet another lock. Alternatively such 
description could be added to the comment block above super_lock's 
definition in btrfs_fs_info.

> +	spin_lock(&fs_info->super_lock);
> +	update_commit_stats(fs_info, interval);
> +	spin_unlock(&fs_info->super_lock);
> +
>   	return ret;
>   
>   unlock_reloc:
