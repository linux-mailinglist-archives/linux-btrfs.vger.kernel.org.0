Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7316D8509
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjDERlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:41:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958AB5FCF
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:41:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDB5921EAC;
        Wed,  5 Apr 2023 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680716463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/fnvBy6KbpsNepA1qbiLCSis4zcJLpEQwnkM4atEi0=;
        b=AY721VHsdpCULhWT3UW2zxjw7I1vsEAPSeBbixBq2D+nyKX8ELA34JosZWhBFSlN5XV5IU
        H3TnMHeRK8hypdTnlDzOzgka2Llhrf+GZq46Gpt65B9FqsldKIo86nELV5x/gq67Rfjfnz
        jSr9qDLYdmFLwfRa1hnKMSYZmraB0Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680716463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/fnvBy6KbpsNepA1qbiLCSis4zcJLpEQwnkM4atEi0=;
        b=kzsTmSfJmEssuU/svOCGs+CFoceqmyfKkoJaqvk5B7Hk1kABR+Eb4wH4MP9CHzrD/8pxdc
        VpqBQRRzAIrA+2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEF6813A10;
        Wed,  5 Apr 2023 17:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uKAFKq+yLWTmbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 17:41:03 +0000
Date:   Wed, 5 Apr 2023 19:41:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] minor cleanups for device close and free functions
Message-ID: <20230405174101.GN19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680619177.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680619177.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 10:55:10PM +0800, Anand Jain wrote:
> This patch series includes fixes for minor issues identified in the
> btrfs_close_one_device() and btrfs_free_device() functions.
> 
> Anand Jain (2):
>   btrfs: warn for any missed cleanup at btrfs_close_one_device
>   btrfs: remove redundant release of alloc_state

Added to misc-next, thanks.
