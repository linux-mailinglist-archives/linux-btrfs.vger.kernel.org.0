Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010E5786E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiGRQEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiGRQEM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:04:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5660D1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:04:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 16BE61FE07;
        Mon, 18 Jul 2022 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658160250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wFaR9KuQLp+1jMbih8n5QaUcxlXNRI5c0NKD29iFfo=;
        b=K0Y2fgeUqTtOOYamlybWxiegQSvqa5pR0rsLS9ANpSX5v2rvrczkMHmo1r5W4KoM6tZIC/
        l+m0iSoRelXSvmcmGhQOc7Goi/tgsD0bsNHnGnGptOfN8RElqMcjBEjitZmvuVIeHQMlas
        FX3QaTh71Jkr+ka8O8OCqplyfFyiwLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658160250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wFaR9KuQLp+1jMbih8n5QaUcxlXNRI5c0NKD29iFfo=;
        b=nmThgjyFRbnUXXoNsltBHJL2TE2PbhPwxZ//LLaMEVbmAVx+2uar2XUrF5VrsqjUTTAXFW
        1nmaP6zs4p7fbMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1BBD13754;
        Mon, 18 Jul 2022 16:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EZEzNnmE1WLibAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 16:04:09 +0000
Date:   Mon, 18 Jul 2022 17:59:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Message-ID: <20220718155917.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220329083042.1248264-1-nborisov@suse.com>
 <2e4435e8-3bfc-99b8-d474-247fd6c015d8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e4435e8-3bfc-99b8-d474-247fd6c015d8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 11:35:45AM +0300, Nikolay Borisov wrote:
> 
> 
> On 29.03.22 г. 11:30 ч., Nikolay Borisov wrote:
> > Currently when a device is missing for a mounted filesystem the output
> > that is produced is unhelpful:
> > 
> > Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> > 	Total devices 2 FS bytes used 128.00KiB
> > 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> > 	*** Some devices missing
> > 
> > While the context which prints this is perfectly capable of showing
> > which device exactly is missing, like so:
> > 
> > Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> > 	Total devices 2 FS bytes used 128.00KiB
> > 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> > 	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
> > 
> > This is a lot more usable output as it presents the user with the id
> > of the missing device and its path.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> Ping

Sorry for late reponse, added to devel, thanks.
