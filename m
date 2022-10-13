Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7665FD715
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJMJ3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJMJ3J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 05:29:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDC9AC34
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 02:29:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1E211F385;
        Thu, 13 Oct 2022 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665653347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33RReNcWGxMholTY830wmDDKQC6V/I98xcWtsw0QGQs=;
        b=ndK+gZJrMVjYwo/9oKmIrEbR5b0L4RUZyigWclXb9WaPw++FT/H3EyBVtsgKORzyNaFJlv
        EotCiqcMmRqIGHs9O0hbwRAOCX/xOcrn5XxO5osS6OQxKj5GEvUTZfyrjVOAQwcxIgEsFh
        jrxcOF9g+YPbcp2+KdpWp2p+CWNvoPk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B99013AAA;
        Thu, 13 Oct 2022 09:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NDf6EWLaR2NLEQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Oct 2022 09:29:06 +0000
Message-ID: <2c0f8168-3c30-6826-e035-6ab018ed3074@suse.com>
Date:   Thu, 13 Oct 2022 12:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <89f06268-d610-1282-02aa-ba1c78fda772@suse.com>
 <0fc3dd35-de05-7654-b813-15367f2a71c0@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <0fc3dd35-de05-7654-b813-15367f2a71c0@gmx.com>
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



On 13.10.22 г. 12:22 ч., Qu Wenruo wrote:
>> ?
> 
> For adding a new sequence, one has to understand the dependency (if any).
> 
> If no dependency (which I believe is the most common case), then the
> generic idea is just to add it before the selftest.
> 
> 
> The question would be more critical for open_ctree(), in fact
> open_ctree() has a lot of cases that something can only be initialized
> after its dependency.
> 
> In that case, your concern is correct, one has to go through the init
> functions to find a proper location.
> And unlike the original code, it's one extra level of indirection.
> 
> But I'd say, for most part, the init function names should explain
> themselves, thus I hope it won't cause too much hassles in the future.


In this case I'd say open_ctree shouldn't be switched to this mechanism.
