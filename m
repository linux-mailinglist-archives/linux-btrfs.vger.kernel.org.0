Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1657876E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiGRQbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGRQas (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:30:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C302A953
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:30:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32FE834614;
        Mon, 18 Jul 2022 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658161846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/QRuv49bjiF31S+8BhW1JvHYWdgFWpOjfIoC2UQQlQ=;
        b=fDPwHYAtmJ4iRMWWpPPVj902hY4iajCxu9PDJ7dtBDpxb3dt9Q3qxZ+n+ZRON/BaWaJXLk
        3J9Y/JhwLVxdKPM+yFpki2UjgBuGszVcvXaarphd11OBZWNBAcY4wT+aG4xTPF9ibIU2ZZ
        322QM/7GLVoJTvP35xukBHktXFDb2F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658161846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/QRuv49bjiF31S+8BhW1JvHYWdgFWpOjfIoC2UQQlQ=;
        b=Vbjc7lbp0CvbH5ip2v+LfkqRer6Q8Dxa5P0qmZBsDTAxOxr3VHamp06TEdpyvCxrufOmHE
        Y7H+9kOju/WZJxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1424D13A37;
        Mon, 18 Jul 2022 16:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vBjuA7aK1WL8dwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 16:30:46 +0000
Date:   Mon, 18 Jul 2022 18:25:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: Re: [PATCH] btrfs-progs: save item data end in u64 to avoid overflow
 in btrfs_check_leaf()
Message-ID: <20220718162553.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org, Wenqing Liu <wenqingliu0120@gmail.com>
References: <20220222090528.1211-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222090528.1211-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 22, 2022 at 05:05:28PM +0800, Su Yue wrote:
> Similar to kernel check_leaf(), calling btrfs_item_end_nr() may get a
> reasonable value even an item has invalid offset/size due to u32
> overflow.
> 
> Fix it by use u64 variable to store item data end in btrfs_check_leaf()
> to avoid u32 overflow.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215299
> Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
> Signed-off-by: Su Yue <l@damenly.su>

Added to devel, thanks.
