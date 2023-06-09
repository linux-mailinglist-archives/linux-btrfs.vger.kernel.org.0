Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF4729391
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbjFIIpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFIIpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 04:45:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2036F18D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 01:45:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCC691FDF3;
        Fri,  9 Jun 2023 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686300309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ehr0Z8iNn/EYTuDJrjhnzwujq5t1oW216kAqRJAVR3I=;
        b=iRck2XF1SnPSWg7QjHEZeJGTX/RiRbD+lunBsrwR2D6CGp/2rV1FBinrT7hgQpN6b/dufg
        L/CPLjaMp6BwNG2PdFNYl07bGVh3d2yvmOnrU4uiBGugF12cz7mbpkBXV3HisqyXD0VkGi
        qfhYp67Z8YmHH+UyoV0fipd1fKWKsb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686300309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ehr0Z8iNn/EYTuDJrjhnzwujq5t1oW216kAqRJAVR3I=;
        b=fHB62u5CtLQSqQSlmnG2WmVQ+L6HR9i1i1/EJQmlx1aomxOes88YQrPuKwITAga5lAPqB+
        ij46VbmHDXYyx4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC5C13A47;
        Fri,  9 Jun 2023 08:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I8XJIZXmgmSqZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Jun 2023 08:45:09 +0000
Date:   Fri, 9 Jun 2023 10:38:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: always assign false literal to ref head
 processing field
Message-ID: <20230609083852.GM28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0a50236c4f79f588c48f44dfd80519423bbacb1c.1686298104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a50236c4f79f588c48f44dfd80519423bbacb1c.1686298104.git.fdmanana@suse.com>
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

On Fri, Jun 09, 2023 at 09:12:21AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a couple places at extent-tree.c assigning a 0 to a ref head's
> is_processing field, but that field was recently changed from an int
> type to a bool type (patch "btrfs: use bool type for delayed ref head
> fields that are used as booleans"). While this is not a problem in the
> sense the end result is the same, as a 0 is equivalent to false, use a
> literal false to make the code a bit more clear.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> Note, this can be folded into patch:
> 
>   "btrfs: use bool type for delayed ref head fields that are used as booleans"

Folded, thanks.
