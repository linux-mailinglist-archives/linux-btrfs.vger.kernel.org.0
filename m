Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F944BC02E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiBRTTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 14:19:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiBRTTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 14:19:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A9F2838D8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:19:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C84DD1F380;
        Fri, 18 Feb 2022 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645211974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIngq5UDFozhtd5l0U4MMR91nYX5C8aJK5Fc8DH+niA=;
        b=B08Z6S3UvbgozC5LKQuSS50i7FCE2CQhfggEBzNYyKkBHzDgBoukJVoduGxs15J2XMWpp0
        Qvcsh4qnjlX88mUmi2Asob4tJNrfjv67GYKoyRoHMZhE0HYqDn937MF/iB+o6SA5rukySI
        QqRnoLcnrgppBXFCI7Ph9PozFK3YoKQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADBAA13C9F;
        Fri, 18 Feb 2022 19:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ytQgKUbxD2IUAwAAMHmgww
        (envelope-from <ailiop@suse.com>); Fri, 18 Feb 2022 19:19:34 +0000
Date:   Fri, 18 Feb 2022 20:19:34 +0100
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: enable default zlib compression in
 btrfs-image
Message-ID: <Yg/xRrJOXiVunUPk@technoir>
References: <20220215171213.5173-2-ailiop@suse.com>
 <20220218142533.GV12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218142533.GV12643@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 03:25:33PM +0100, David Sterba wrote:
> On Tue, Feb 15, 2022 at 06:12:13PM +0100, Anthony Iliopoulos wrote:
> > The btrfs-image utility supports zlib compression natively, but it is
> > disabled by default. Enable it at the zlib-defined default compression
> > level (6).
> 
> Makes sense to me, I don't think that there's a reason why the dump
> should not be compressed.
> 
> However this patch breaks the tests, there are several image dumps
> with crated data for some test cases, so this needs to be adapted first.

That's actually my bad, the tests that do image restoration are failing
because of the options sanity checking as they find compress_level set
during restore. I'll send a v2 to fix this.
