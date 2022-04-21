Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F150A481
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390248AbiDUPoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390296AbiDUPoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 11:44:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5C4888B
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 08:41:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7D561F388;
        Thu, 21 Apr 2022 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650555674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9g4Pf2exWfGZPTlSlHPZrsZBRI2CEqykr/85GMGVdw=;
        b=HJyYfm7ta/1QzKVDYQtsj53S0wrspuJ80YRw0GpwhTWzeEW99DR+htxWDvYhLWOby4AKUN
        wafjpY+hwJzUQdtmrKfNOFx3epfPXPDDtlatVmVwEoQpvViQAT/EeMADabASz3k0VR1r/N
        gjxjg4oU+g4Rn0vkyycn3cS1n/mfEd0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B895813446;
        Thu, 21 Apr 2022 15:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i3+pKhp7YWLQaAAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 21 Apr 2022 15:41:14 +0000
Message-ID: <ad8a68f9-a016-0546-38f4-d6bcd1d05402@suse.com>
Date:   Thu, 21 Apr 2022 17:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Turn fs_info member 'buffer_radix' into an XArray
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220421134226.12059-1-gniebler@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220421134226.12059-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First line of commit message doesn't start with "btrfs: ".

Resubmitting...

Sorry for the inconvenience!
