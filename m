Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FD5971B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiHQOpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiHQOpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:45:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7B9AF93
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:45:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFEDC37ED9;
        Wed, 17 Aug 2022 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660747502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGDH2cmzfdhUDYi2Nx5VoisHSOZrZCZjXhMREjrX97E=;
        b=DNvbIQBlNFPy2q1lTNQ0+1KD2DZid9kaP/aOP9D+snLLlG4ZuggMs5DBrke4nrgg/tgN25
        92vIsbVGbOBQ46JtfPyMtdBcELjW/OaLSPURW8UmnmvWO/v3Tcxlcjs4bcN3QdKRL9iuk8
        jovPooMA/mBx6eMoRNAitCVpV0TYTL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660747502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGDH2cmzfdhUDYi2Nx5VoisHSOZrZCZjXhMREjrX97E=;
        b=wXSHet7QyxGR+NCyN4FxbBukcjh3ztBrdflPQp8ZbrXpPkiWPIdhNoOy9/BMWM95iUvd1j
        YA0gqEA4HogXVTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8446A13428;
        Wed, 17 Aug 2022 14:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1ElVH+7+/GJVfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 17 Aug 2022 14:45:02 +0000
Date:   Wed, 17 Aug 2022 16:39:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH v2] btrfs: Check if root is readonly while setting
 security xattr
Message-ID: <20220817143951.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, fdmanana@kernel.org
References: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
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

On Tue, Aug 16, 2022 at 04:42:56PM -0500, Goldwyn Rodrigues wrote:
> For a filesystem which has btrfs read-only property set to true, all
> write operations including xattr should be denied. However, security
> xattr can still be changed even if btrfs ro property is true.
> 
> This happens because xattr_permission() does not have any restrictions
> on security.*, system.*  and in some cases trusted.* from VFS and
> the decision is left to the underlying filesystem. See comments in
> xattr_permission() for more details.
> 
> This patch checks if the root is read-only before performing the set
> xattr operation.
> 
> Testcase: 
> 
> #!/bin/bash
> 
> DEV=/dev/vdb
> MNT=/mnt
> 
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> echo "file one" > $MNT/f1
> 
> setfattr -n "security.one" -v 2 $MNT/f1
> btrfs property set /mnt ro true
> 
> # Following statement should fail
> setfattr -n "security.one" -v 1 $MNT/f1
> 
> umount $MNT
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
