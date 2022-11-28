Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CE63AEBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 18:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiK1RUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiK1RUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 12:20:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC578C45
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 09:20:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94EF621BC1;
        Mon, 28 Nov 2022 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669656014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6FY1FfCtyZIVnq36qEawJUXD47P/pW+HmW/7uIq3NI=;
        b=o55YddGS6JTXlKTWRrKPRmVFkLUrlXJLyCer/6DOVihDMpt6fcqnqHpu6QRLMeE7dYKATB
        zV7gjuewmLNLKidg71eI0IOmHmpzltrm76jDVkQG3IjuT3kefBx8s/iUN4h/dDLF9oQla9
        GkrL/VMGQWx45eZ4T+uMkr6A3Rv2MmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669656014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6FY1FfCtyZIVnq36qEawJUXD47P/pW+HmW/7uIq3NI=;
        b=Wyd5Wdmvf15k8LYmi7CQ836LkPAkRNii6KCl3/knaa0t3HweTxEevPZJAqWPCPFiWrFxes
        AvIGrmGII0+4eMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7101813273;
        Mon, 28 Nov 2022 17:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JJKJGs7thGOvAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Nov 2022 17:20:14 +0000
Date:   Mon, 28 Nov 2022 18:19:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 03/29] btrfs-progs: properly test for
 send_stream_version
Message-ID: <20221128171941.GS5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1669242804.git.josef@toxicpanda.com>
 <e7ca4d3f79485396cc1e2d7e8d635983a1c2e2a9.1669242804.git.josef@toxicpanda.com>
 <9bd99a08-5821-09e8-af7a-efe0433ea997@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd99a08-5821-09e8-af7a-efe0433ea997@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 01:04:06PM +0530, Anand Jain wrote:
> On 11/24/22 04:07, Josef Bacik wrote:
> > We want to notrun if this test fails, not if it succeeds.  Additionally
> > we want -s, as -q will still print an error if it gets ENOENT from the
> > file we're trying to grep.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
> Patch:
>      btrfs-progs: tests: update stream version checks in misc/058
>                                                 should be 053 ^^^
> Fixed the check for the older version.

Right, it's in 053, however the patch has been already merged to v6.0.1
and with a fixup.
