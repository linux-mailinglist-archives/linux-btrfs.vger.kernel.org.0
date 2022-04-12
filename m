Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5C4FE921
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiDLTzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiDLTzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 15:55:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A26EB1C
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 12:47:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 66E271F856;
        Tue, 12 Apr 2022 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649792875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU4r5yHt8+mZLx2OfR+5TudxS2sV5raca2xBMiF+OxY=;
        b=y9vCGyrGdmpzewwa/dBrQYtshcNUUmEv4LklK7qat3y8M9hBMn17xEmaURCUggKtYTAEWW
        U1ea/KSVec/1WvrCaCkWp6dwJ6n1B0q+DJ4GYIxL8Xj0gZ9bG0T5LWle5008nRXQdFeGcV
        PMsiBQ46DLvTX05l5SfgU15zSWzdonE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649792875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU4r5yHt8+mZLx2OfR+5TudxS2sV5raca2xBMiF+OxY=;
        b=wSkCXw+ajCw8Yf9b61pYpNiDm9S0u9TL+7aC1ihR3/fSioJI56kClgUuZ9qWcDV8By9IAN
        QgXMp4AZglWVzaBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B05FA3B87;
        Tue, 12 Apr 2022 19:47:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28E37DA7B0; Tue, 12 Apr 2022 21:43:50 +0200 (CEST)
Date:   Tue, 12 Apr 2022 21:43:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: fixes for handling of split direct I/O bios
Message-ID: <20220412194349.GZ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324160628.1572613-1-hch@lst.de>
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

On Thu, Mar 24, 2022 at 05:06:26PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes two problems in the direct I/O code where the
> file_offset field in the dio_private structure is used in a context where
> we really need the file_offset for the given low-level bios and not for
> the bio submitted by the iomap direct I/O as recorded in the dio_private
> structure.  To do so we need a new file_offset in the btrfs_dio
> structure.
> 
> Found by code inspection as part of my bio cleanups.
> 
> Diffstat:
>  extent_io.c |    1 +
>  inode.c     |   18 ++++++++----------
>  volumes.h   |    3 +++
>  3 files changed, 12 insertions(+), 10 deletions(-)

Added to to misc-next, thanks.
