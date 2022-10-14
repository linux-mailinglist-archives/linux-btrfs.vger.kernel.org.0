Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF095FECC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJNKyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNKyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 06:54:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2C2D776;
        Fri, 14 Oct 2022 03:54:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 588281F385;
        Fri, 14 Oct 2022 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665744861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pguAO3vEPBQg0J0sEYPkmLs6dwBdOADMzk1zfhCozHk=;
        b=hhMyRzFBp2PASgQlm0JuAfr1+BGRf8KxerV4FdO6oHIiz8PezEgt/cWJJ2KQI+59/Fvt3A
        ks5ifJBB4ikykIvbLU3nBzJfSMRh/N5HFDsB2MLuWQpQWylTgk49Y5pXj9MJZi4t9zsxI5
        S02Q0AF3ktI4caPDX0z4u5XA+pl7Ssk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665744861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pguAO3vEPBQg0J0sEYPkmLs6dwBdOADMzk1zfhCozHk=;
        b=EQf1DaSdYUaSKX5GfbiC73q5i115U+MPnwon/P5FL/glROEidewQdhG19/4Rei1Y4YNjmD
        soXmP08+dUPS+8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FEC113451;
        Fri, 14 Oct 2022 10:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a43CBt0/SWOxUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 10:54:21 +0000
Date:   Fri, 14 Oct 2022 12:54:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC v2 00/16] btrfs: add fscrypt integration
Message-ID: <20221014105413.GD13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
 <c8d135f8-8fbf-2314-9efc-ec172233150f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d135f8-8fbf-2314-9efc-ec172233150f@collabora.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 05:14:09PM +0500, Muhammad Usama Anjum wrote:
> Hello,
> 
> I see no comment on this RFC. Is there any next version?

Yes, there will be another version.
