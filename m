Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB9520F64
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiEJIKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiEJIKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 04:10:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D149FAF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 01:06:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE9DA21C34;
        Tue, 10 May 2022 08:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652169980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAfqk1grvkVx9niH4N3xyDbvCZPFpA5dPAP3PbBPt8M=;
        b=lnkUlnihGxePb+7MZt+v5QTg3wFa2wHY2B7Xf5NiFaBesY5O2a+z1BN+xH0acMgCIH9Gvq
        f79gniNhsI+vY8uq2tu9sp2T1IP86d4E9N/JrKBaWY9/C89VWdUY2wpY5YAhmx7/kVdcbR
        WIvHeAeW/CmoBHi25svvaQEWfnMba8U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85F7613AC1;
        Tue, 10 May 2022 08:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OlUIHvwcemLnCQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 10 May 2022 08:06:20 +0000
Message-ID: <40341642-2a12-0692-c3a9-61ed80ff1be6@suse.com>
Date:   Tue, 10 May 2022 11:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: add "0x" prefix for unsupported optional features
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bc87beb85ce5b31157385eb2bc55a0bfacefc9d4.1652166589.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <bc87beb85ce5b31157385eb2bc55a0bfacefc9d4.1652166589.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.05.22 г. 10:10 ч., Qu Wenruo wrote:
> The following error message lack the "0x" obviously:
> 
>    cannot mount because of unsupported optional features (4000)
> 
> Just add the prefix before any complains.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Though it doesn't make the output any more readable for humans :)
