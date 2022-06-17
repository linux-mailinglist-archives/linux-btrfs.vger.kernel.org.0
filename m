Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A3054F97C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382778AbiFQOqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382552AbiFQOqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:46:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F482427D0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:46:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1601F86A;
        Fri, 17 Jun 2022 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655477172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhcW7DNcarBaOsNsKvBqM0Yn2w4swFo+xGcIzJZMt6c=;
        b=baKIqkzGdQCXz26U01dB9mUsoAyYy1RVdxpwQbQ50XmeXMAvmvXL2SJIKmuBXA6Yg0+JqA
        OL8BSOGNoCPfufWfi8SpwKhepIxPiOXixQEU1Tgnp73fhoqnTri8mj8Gpb/HBqwzBjgPw+
        GEPo3How1PyCvpxLkabGTyKMdzjlP5A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB4FD1348E;
        Fri, 17 Jun 2022 14:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RIfpKrOTrGJjNwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 17 Jun 2022 14:46:11 +0000
Message-ID: <b02bb59e-3677-ef20-c3b1-505d24bb369e@suse.com>
Date:   Fri, 17 Jun 2022 17:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220616080224.953968-1-hch@lst.de>
 <20220617143148.GM20633@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220617143148.GM20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.06.22 г. 17:31 ч., David Sterba wrote:
> Nikolay, you did some experiments with larger dio, but IIRC it was on
> the bio layer. This looks like a fix for the same issue but I'm not
> sure.

AFAIR I did create some patches to limit the size of the bios due to the 
memory we needed in order to save the csums for those as we were having 
some OOM situation. Still what I remember is we eventually settled to 
using vmalloc and those patches never really materialized upstream.
