Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B65FD6CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJMJPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJMJOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 05:14:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2EFA031
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 02:14:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 369D81F38A;
        Thu, 13 Oct 2022 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665652463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFUoteMCfr3nunelTjCxvYe9OL51/Pc+GdJtGRXKDOA=;
        b=Q04ptbwGPGGoPEM1vKqC7zJhbeIZIBXaWRwsmOA2JLCZ0QQcC/vD9s8pNTdWwGw/s1Zfc1
        45Yfx+icTIlDPlT1H8rlxAKl0y98sS2n96Dz7KzxSyLRGiKFpYLcIEXjraVtkRGF5lL8kq
        eJOwN85vhNAJ2maV3qjjGwnZSBgZs5k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B643D13AAA;
        Thu, 13 Oct 2022 09:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FCG0J+7WR2NvBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Oct 2022 09:14:22 +0000
Message-ID: <89f06268-d610-1282-02aa-ba1c78fda772@suse.com>
Date:   Thu, 13 Oct 2022 12:14:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.22 г. 12:22 ч., Qu Wenruo wrote:
> [BACKGROUND]
> In theory init_btrfs_fs() and exit_btrfs_fs() should match their
> sequence, thus normally they should look like this:
> 
>      init_btrfs_fs()   |   exit_btrfs_fs()
> ----------------------+------------------------
>      init_A();         |
>      init_B();         |
>      init_C();         |
>                        |   exit_C();
>                        |   exit_B();
>                        |   exit_A();
> 
> So is for the error path of init_btrfs_fs().
> 
> But it's not the case, some exit functions don't match their init
> functions sequence in init_btrfs_fs().
> 
> Furthermore in init_btrfs_fs(), we need to have a new error tag for each
> new init function we added.
> This is not really expandable, especially recently we may add several
> new functions to init_btrfs_fs().
> 
> [ENHANCEMENT]
> The patch will introduce the following things to enhance the situation:
> 
> - struct init_sequence
>    Just a wrapper of init and exit function pointers.
> 
>    The init function must use int type as return value, thus some init
>    functions need to be updated to return 0.
> 
>    The exit function can be NULL, as there are some init sequence just
>    outputting a message.
> 
> - struct mod_init_seq[] array
>    This is a const array, recording all the initialization we need to do
>    in init_btrfs_fs(), and the order follows the old init_btrfs_fs().
> 
>    Only one modification in the order, now we call btrfs_print_mod_info()
>    after sanity checks.
>    As it makes no sense to print the mod into, and fail the sanity tests.
> 
> - bool mod_init_result[] array
>    This is a bool array, recording if we have initialized one entry in
>    mod_init_seq[].
> 
>    The reason to split mod_init_seq[] and mod_init_result[] is to avoid
>    section mismatch in reference.
> 
>    All init function are in .init.text, but if mod_init_seq[] records
>    the @initialized member it can no longer be const, thus will be put
>    into .data section, and cause modpost warning.
> 
> For init_btrfs_fs() we just call all init functions in their order in
> mod_init_seq[] array, and after each call, setting corresponding
> mod_init_result[] to true.
> 
> For exit_btrfs_fs() and error handling path of init_btrfs_fs(), we just
> iterate mod_init_seq[] in reverse order, and skip all uninitialized
> entry.
> 
> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
> expand and will always follow the strict order.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> RFC->v1:
> - Change the mod_init_seq[] array to static const
> 
> v1->v2:
> - Rebased to latest misc-next to handle new init/exit entries


Only thing I'm worried with this is whether it will have any long-term 
maintenance repercussion if someone wants to add a new sequence, i.e is 
it sufficient to tack it at the end of the array, or shall one go 
through the list of pointers, inspect what actions each function do and 
decide where in init_sequence to put the new functionality?
