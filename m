Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5BA53E95E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiFFObv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 10:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbiFFObu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 10:31:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390C2F7483
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 07:31:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBAFB21A83;
        Mon,  6 Jun 2022 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654525907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/fniPRm9yDxqChMHy4cAUHMYV5Pl/jRXtsv9sFvmHk=;
        b=CRohzbfDODlRv1N7QnRDXQU/Xxb8kOCKIAODc4IEJmCZYldprLscmLBFf3GhLw6TQ18jVu
        D1IWcXhv+jV36ZMn1rxJ5WqOPaolfB3Fg9Pau9HdClpxDgU+CFmBuBl7MaBSYCdbXfNjIU
        PEtgNpYJDccctuJsH+1RoYMOb0D2c0s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB6B8139F5;
        Mon,  6 Jun 2022 14:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cP4TKtMPnmIwYgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 06 Jun 2022 14:31:47 +0000
Message-ID: <445c4c65-9b94-4961-c498-5c3d9b140a3d@suse.com>
Date:   Mon, 6 Jun 2022 17:31:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: btrfs-convert aborts with an assert
Content-Language: en-US
To:     =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>,
        linux-btrfs@vger.kernel.org
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.06.22 г. 17:03 ч., Torbjörn Jansson wrote:
> Hello
> 
> i tried to do a btrfs-convert of a ext4 filesystem and after a short 
> while after starting it i was greeted with:
> 
> # btrfs-convert /dev/xxxx
> btrfs-convert from btrfs-progs v5.16.2
> 
> convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` 
> failed, value 0
> btrfs-convert(+0xffb0)[0x557defdabfb0]
> btrfs-convert(main+0x6c5)[0x557defdaa125]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
> btrfs-convert(_start+0x2a)[0x557defdab52a]
> Aborted
> 
> Any idea whats going on?
> Is it a known bug?
> Is the btrfs-progs that come with my dist too old?
> FYI the ext4 filesystem is a bit large ~10tb of used data on it.
> 
> I assume the convert didn't even start in this case and nothing was 
> modified on the ext4 filesystem, correct? or?
> 

Care too run the following command and share the output:

echo "show_super_stats -h" | debugfs -f /dev/stdin /dev/loop0

change /dev/loop0 to wherever is your ext4 filesyste, however debugfs 
require the fs to be unmounted.
