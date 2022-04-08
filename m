Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D94F9B1B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiDHQ4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiDHQ4c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 12:56:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270B12C6DC
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 09:54:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AB43F1F861;
        Fri,  8 Apr 2022 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649436865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnVKaBjVRk0CM7kAE4YIbOEO5+xjmqr3Dk75HyuZlWM=;
        b=BotW81RqCKapEht0SUaG8lzg6K6Z7lY6lh2mr+sAWx3NUdWB5AJMLzbkU5m/KuanvHR7hM
        D0o8r0bNon1/eWMiprx9x/PiqsAtRtmGis7x1lpKIU2rnvT6ravyjA9Jazm6Yd1wvmNdmp
        3sqwftuP2o3zFXnhJmwIJzffvBaSNuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649436865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnVKaBjVRk0CM7kAE4YIbOEO5+xjmqr3Dk75HyuZlWM=;
        b=zNEnIwIftDzG6vhCij1e83AlXKmup+g7j5ixuTlyX5hrPDAvONxNzv/BOOY6a0BZ51f2tV
        GbXT+9DctEIFH0Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7D733A3B83;
        Fri,  8 Apr 2022 16:54:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD00DDA832; Fri,  8 Apr 2022 18:50:22 +0200 (CEST)
Date:   Fri, 8 Apr 2022 18:50:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs zoned fixlets
Message-ID: <20220408165022.GW15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220324165210.1586851-1-hch@lst.de>
 <20220408164101.GB31302@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408164101.GB31302@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 06:41:01PM +0200, Christoph Hellwig wrote:
> David, 
> 
> do you plan to pick these up?

Yes I do but I had some questions after the initial review and don't
know when I'll get back to it because of other patches being reviewed.
