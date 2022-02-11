Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AF4B2A87
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiBKQiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:38:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351608AbiBKQh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CAFD
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:37:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55430210DF;
        Fri, 11 Feb 2022 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644597475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeW7HEy7ukXRr/WPJGA6BevPVOke0vEzPNq5XR7+UBQ=;
        b=D0qUXfEqWPFgTzYuGnaP7NYGHtivf81U6e3KhUp9+JEZjDsNGWhFJRmPtDK1mtZsIaGJRi
        4GhMfflMhh6puXjNFsD5oIFK1UWITYpUv4TD8UJLCMt8o8wTFp9WsP9TARI/fzjafdYLVy
        tkkv60gSVwv4Kw5JLFwaR3NLKJtTyvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644597475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeW7HEy7ukXRr/WPJGA6BevPVOke0vEzPNq5XR7+UBQ=;
        b=Lv1S3ESG5INfIVp51gcfttx1q2cOtPOyknQeDG8wMOc/6TZPgilNBh1+kpvH7cJiFzmSYw
        jwI6zKQ1yvKa0mDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4A772A3B83;
        Fri, 11 Feb 2022 16:37:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58BDEDA823; Fri, 11 Feb 2022 17:34:13 +0100 (CET)
Date:   Fri, 11 Feb 2022 17:34:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Remove outdated TODO comments
Message-ID: <20220211163413.GZ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220211134829.4790-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211134829.4790-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 01:48:29PM +0000, Sidong Yang wrote:
> These comments are too old and outdated. It seems that it doesn't help.
> So we can remove those.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to misc-next, thanks.
