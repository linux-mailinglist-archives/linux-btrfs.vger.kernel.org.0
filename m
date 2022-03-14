Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A94D8DD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 21:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiCNUIw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiCNUIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 16:08:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C140A13
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:07:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4A331F380;
        Mon, 14 Mar 2022 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647288459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXagOP+ipw3CLQp8RwmGslMKd2Vm1gE2+I3+l2I51Kw=;
        b=18aquqxLGr1LK9D13U4t5dJOHRmJUeXVm7ECjrYs2KAUz0Gme/cWGzP5AdGZl1bxk70wxM
        iYbAa4wLPkI0g4/lpoJdl6t3h0yG5762cG7ECN42D72Ix///90tO4nVlDA7Y0vwGqsmgbh
        aV4N1gme+P+MHpMROJ1Gk6GAZ/6HxyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647288459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXagOP+ipw3CLQp8RwmGslMKd2Vm1gE2+I3+l2I51Kw=;
        b=4AaRctdGqOYFqDnHuEkl4nykrcCUbgFWniu2X4XO2pfRJB+2r4DNJD3K91i9ZeWspagQqf
        Am/KRUEGGx27n8CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DBB0FA3B88;
        Mon, 14 Mar 2022 20:07:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FC0EDA7E1; Mon, 14 Mar 2022 21:03:41 +0100 (CET)
Date:   Mon, 14 Mar 2022 21:03:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics 
        <luca.bela.palkovics@gmail.com>
Subject: Re: [PATCH] btrfs: make device item removal and super block num
 devices update happen in the same transaction
Message-ID: <20220314200341.GT12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics <luca.bela.palkovics@gmail.com>
References: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
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

On Tue, Mar 08, 2022 at 01:36:38PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a report that a btrfs has a bad super block num devices.

People have reported this on IRC in the past too. In some cases it was a
report with two devices expected but one found and "I have never added
nor removed a device on this filesystem", so it was a bit mysterious.
The split update over the transaction is otherwise a clear cause.
Added to misc-next, thanks.
