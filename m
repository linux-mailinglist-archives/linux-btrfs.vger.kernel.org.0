Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB856A8EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiGGRBP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiGGRBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 13:01:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7F5A2DD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 10:01:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B39061F9B2;
        Thu,  7 Jul 2022 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657213270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnpAEftipfe+Loe3M9epWKW41JwfEvU55QwJo5WEQTc=;
        b=JDE8YxbXWS4CyPgUvSHEMfVEoVaoW92Y4m20xVEcWh//I2NqNj0f14KkYAvFA+p4a+4ucj
        RUTmSIEkzeSp78me21eDKSYPgmZqGgdO44T5vtvBx/bD042ZKYYZpBrQ7D6yweYC7dhAtq
        vgV2qpGBumo5mn8UKgZsMddmzlymKUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657213270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnpAEftipfe+Loe3M9epWKW41JwfEvU55QwJo5WEQTc=;
        b=sGM5USYhO5JzqKAbw58Gjvej1NHPryuu2LFoJSv5DTJIW2pCsdaqSuGtJaj9ytatiB+gH+
        IHkhNGfzZMWXPTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8756413461;
        Thu,  7 Jul 2022 17:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oXAtIFYRx2JbcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 17:01:10 +0000
Date:   Thu, 7 Jul 2022 18:56:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Denis Roy <denisjroy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Message-ID: <20220707165623.GI15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Denis Roy <denisjroy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 10:19:53AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/7 09:32, Denis Roy wrote:
> > I am using netgate readynas firmware 6.10.7, 5 drives ,X-RAID.  I had a
> > power failure, but the nas never did a full shutdown. Nevertheless, the
> > raid was in RO when I notice there was a problem. At the time I thought
> > it was plex app, so I rebooted and then the raid never cam up.  Ever
> > where you read up on BTRFS, they say don’t try commands you can do more
> > dameage. So here I am. I added some info I believe you need and if there
> > anything else, let me know.
> 
> That error message means, a tree node is pointing to a location which is
> not aligned to sectorsize (the minimal unit of btrfs read/write).
> 
> But there are several problems:
> 
> - The bytenr 12567101254720864896, is aligned to 4096
>    A quick python run shows:
>    >>> 12567101254720864896 / 4096.0
>    3068139954765836.0

You should not rely on floats but do either hex() or '% 4096', because
both show that the value is not aligned to 4096:

  >>> hex(12567101254720864896)
  '0xae6750020000c280L'

the expected pattern is 3 trailing zeros of the value, or

  >>> 12567101254720864896 % 4096
  640L

The hex value does not resemble any pattern, more data from the physical
block could tell more if it's completely random or eg. leftover from
other memory or overwrite.

The block offset checks are done after checksum verification so the data
were corrupted and then written, ie. it happened before the write.
