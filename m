Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813853E8D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiFFOPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiFFOO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 10:14:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001FC2CCB0
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 07:14:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2F81F92D;
        Mon,  6 Jun 2022 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654524897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuPcrTNXZmTwinzh5BJX/Bvcr5Z8wPMTySmGF8G7BYE=;
        b=UTFE3Kuom5+BI+Bao8LLNS9mTPaU+gQvxxy/z5Jo5TH8bi9XjThtwyEzLkFwYKmq6pWGVL
        zyuJuFInWKBCXxByT+H4idGKSPFtFWW8okjZfOcMrOwgueAWSF92nL/CgW9iKKe8EibUW/
        WSsws6fdTRXwWDN1GMep4ync3NyreNA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB9B13A5F;
        Mon,  6 Jun 2022 14:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XT20DuELnmKCXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 06 Jun 2022 14:14:57 +0000
Message-ID: <b4211a54-c491-2b8f-8586-efb8c570bba3@suse.com>
Date:   Mon, 6 Jun 2022 17:14:56 +0300
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

This suggests that btrfs progs is unable to properly read/parse the 
superblock of the ext4 filesystem. So you are right that convert hasn't 
even started in this case so your ext4 is intact.

However, that's strange since for ext* related queries we do use libext2fs.
