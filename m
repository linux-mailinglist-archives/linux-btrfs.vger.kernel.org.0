Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DB504D2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiDRH0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiDRHZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:25:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B41613DEA
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA71A1F37E;
        Mon, 18 Apr 2022 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650266596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCFkis7CIXJUzPRdxlpLIxGQGX/VA9WmlscHlRyVoMk=;
        b=Jx7yea1DTGX3iZj/UyLSIrKO7UIk+SyocVDiSA125ruqsjLi8mO7ZGjsdXoSw7Ym3iWdBj
        lY5BRrtNe4orsCiK/ULU2RDWet3KfsOgMvkk8NYhQdpidUVTeKTCzXyP9OHaJQG04Ss4/4
        7Y0Fk5wmBIgD4gz++S4afSKY5LuMHw8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E41913A9B;
        Mon, 18 Apr 2022 07:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jA3OHuQRXWK2YwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Apr 2022 07:23:16 +0000
Message-ID: <c5c0df64-addf-362d-6e73-a440cb38919c@suse.com>
Date:   Mon, 18 Apr 2022 10:23:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: minor bio submission cleanups
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.04.22 г. 17:33 ч., Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up a few loose ends in the btrfs bio submission path.
> 
> Diffstat:
>   compression.c |   11 +++++------
>   compression.h |    4 ++--
>   ctree.h       |    5 ++---
>   disk-io.c     |   26 ++++++++++----------------
>   disk-io.h     |    4 ++--
>   extent_io.c   |   39 +++++++++++++++++++++++++++++++++++----
>   extent_io.h   |   18 ++----------------
>   inode.c       |   49 ++++++++++---------------------------------------
>   8 files changed, 68 insertions(+), 88 deletions(-)
> 

For the whole series:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
