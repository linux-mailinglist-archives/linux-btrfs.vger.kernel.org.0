Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF775442D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 07:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiFIFDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 01:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFIFDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 01:03:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2DF219125
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 22:03:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8547621B67;
        Thu,  9 Jun 2022 05:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654751019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8JPWy5Q3VXozuNSDBtWUCDwHVBxjVmR+aMy3lDMecp8=;
        b=mt1tht7xmeNFpPK14NmcdnHyugG2L4EAC5l7e50GBEcMsw2rgNXBPgiOvsEfUMQussgAzH
        9ELGyaSNXP9JEBtTaP4sx/XVOVNl4WCdbp/ANvzRISEoH0iIenrOlt3GtbiFOe2fiNa92m
        2TuWmAO8soD/6ikD4uWWKPF4HfeiFCE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D387137FA;
        Thu,  9 Jun 2022 05:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5gjfEyt/oWJVDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 09 Jun 2022 05:03:39 +0000
Message-ID: <63be7ae2-df2b-9cb4-1d48-1664ec63cfa6@suse.com>
Date:   Thu, 9 Jun 2022 08:03:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: don't set lock_owner when locking tree pages for
 reading
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.06.22 г. 5:39 ч., Zygo Blaxell wrote:
> In 196d59ab9ccc "btrfs: switch extent buffer tree lock to rw_semaphore"
> the functions for tree read locking were rewritten, and in the process
> the read lock functions started setting eb->lock_owner = current->pid.
> Previously lock_owner was only set in tree write lock functions.
> 
> Read locks are shared, so they don't have exclusive ownership of the
> underlying object, so setting lock_owner to any single value for a
> read lock makes no sense.  It's mostly harmless because write locks
> and read locks are mutually exclusive, and none of the existing code
> in btrfs (btrfs_init_new_buffer and print_eb_refs_lock) cares what
> nonsense is written in lock_owner when no writer is holding the lock.
> 
> KCSAN does care, and will complain about the data race incessantly.
> Remove the assignments in the read lock functions because they're
> useless noise.
> 
> Fixes: 196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
