Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E4513292
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiD1LlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiD1LlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 07:41:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FA554BB
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 04:37:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40D681F37F;
        Thu, 28 Apr 2022 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651145869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmuly5zKKpeZmCHYwEoGzWIF3SqNPxJg+6b3E6RR7Zc=;
        b=Jrdoq96CGPthRaJPFOi5074rlX0qm27jKbgB21QQGiLiPNuJmhdk13IyP2iS/HdmrZn+cc
        VuJHKK1lWFNP8XOIfWyMEGpt6BPfB+ocxAWmCi4e63CyvRzuTW2StVbglUSdNuFYnIeEqw
        zy4FVmdbcfx84G8klLFL+p2uZLngXcA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B06B13491;
        Thu, 28 Apr 2022 11:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v8UXBI18amIWDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Apr 2022 11:37:49 +0000
Message-ID: <db9c1003-ef3e-86fb-7bfc-9b7042485fa6@suse.com>
Date:   Thu, 28 Apr 2022 14:37:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
References: <20220426214525.14192-1-gniebler@suse.com>
 <b110e69e-d371-a29e-fd89-f810a4391e7b@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <b110e69e-d371-a29e-fd89-f810a4391e7b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.04.22 г. 17:51 ч., Gabriel Niebler wrote:
> 
> Naming things is hard. Here are some ideas I've had:
> 
> BTRFS_ROOT_IN_XARRAY is obvious, but it also includes kind of a needless 
> implementation detail.
> 
> BTRFS_ROOT_IN_(FS_)ROOTS would be technically accurate, but might be 
> confusing for the reader (e.g. if they don't know about 
> btrfs_fs_indo->fs_roots of the top off their head).
> 
> BTRFS_ROOT_IN_FS_INFO_ROOTS makes that a bit clearer (someone might 
> think it refers to fbtrfs_fs_info->roots, but when they find that 
> doesn't exist they'd quickly catch on, I think), but a bit lengthy.
> 
> BTRFS_ROOT_IN_FS_INFO_FS_ROOTS is probably the most accurate, but really 
> quite long...
> 
> Does anyone else have any ideas?


BTRFS_ROOT_ACCESSIBLE/BTRFS_ROOT_REGISTERED/BTRFS_ROOT_PUBLIC/BTRFS_ROOT_INITIALIZED

because when a root goes into the root registry (either xarray or radix) 
it's essentially published to this "registry" and can be referenced by 
other parts of the filesystem. And this registration is part of the 
root's initialization sequence.
