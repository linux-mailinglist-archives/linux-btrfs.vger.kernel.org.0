Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1326A3F3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjB0KNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjB0KNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 05:13:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96181E2AD;
        Mon, 27 Feb 2023 02:13:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9EE1F8D9;
        Mon, 27 Feb 2023 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677492795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbuiOjOJzAJUYkqY1Ibzd1+u3Q5cuRoukaLCph7M6nY=;
        b=L76R8gOguvBHFVUtwObU6cDVg5pWdL0vbC3bl2cMtvZq1UDX4boWq9ii2STpbYwqnxLe8M
        Ao3Z5vNNuFfa3E70SxfI0v7B7CZzPcapBCXmU8Vhl4gwICMau5qOwdApc+WrVrsOcGHi9U
        VXt908VXu3BlrtcgD+1GsGQK7JGWZkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677492795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbuiOjOJzAJUYkqY1Ibzd1+u3Q5cuRoukaLCph7M6nY=;
        b=FR4+alGHE/pAneVhbVyqC0R7SpKjbu+2plsalpDxw5IljaycxC8DQB+RS/jrVt4xm8UXzk
        mErqgzqt8zmn1TCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32CD313A43;
        Mon, 27 Feb 2023 10:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QYDsCjuC/GM0bgAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 27 Feb 2023 10:13:15 +0000
Date:   Mon, 27 Feb 2023 11:14:41 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] common/rc: don't clear superblock for zoned scratch
 pools
Message-ID: <20230227111441.5eac2e29@echidna.fritz.box>
In-Reply-To: <0df9a175-b18d-4706-ae69-ed019b326924@wdc.com>
References: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
        <20230227102351.2fa21c70@echidna.fritz.box>
        <0df9a175-b18d-4706-ae69-ed019b326924@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 27 Feb 2023 09:31:53 +0000, Johannes Thumshirn wrote:

> On 27.02.23 10:22, David Disseldorp wrote:
> >> -		# to help better debug when something fails, we remove
> >> -		# traces of previous btrfs FS on the dev.
> >> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> >> +		# To help better debug when something fails, we remove
> >> +		# traces of previous btrfs FS on the dev. For zoned devices we
> >> +		# can't use dd as it'll lead to unaligned writes so simply
> >> +		# reset the first two zones.
> >> +		if [ "`_zone_type "$i"`" = "none" ]; then
> >> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> >> +		else
> >> +			blkzone reset -c 2 $i
> >> +		fi  
> > 
> > IIUC, any output from blkzone reset will cause test failures - is that
> > an intention here, or should output go to /dev/null like dd?
> > 
> > Looks fine otherwise.  
> 
> If all is well, blkzone reset won't have any output. So I guess we're fine.

Thanks for the confirmation. In that case:
Reviewed-by: David Disseldorp <ddiss@suse.de>
