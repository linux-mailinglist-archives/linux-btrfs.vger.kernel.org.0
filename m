Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54C543E80
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiFHVYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiFHVYi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:24:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E50B0A79;
        Wed,  8 Jun 2022 14:24:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD55F1FD42;
        Wed,  8 Jun 2022 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654723475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xv+4uQrrTakP3KnxIQgdrzZcegHCXASlvH7JzPuS3/g=;
        b=CnFhx+sj2FpBl88LIpsas+PafUhM8T5ER+AEhId8tOjgQQ0LoCbiokdJaw2V44cJLKTQaF
        vol2HmAudPtksWVGXp7wvZ28uyCCn1xO3yAY6A0CWyqn/E0aUosvKi250CmYQsBikeX2YX
        TeyCW4ZDHEWoOd0wJ6K61RXL7DyxLwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654723475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xv+4uQrrTakP3KnxIQgdrzZcegHCXASlvH7JzPuS3/g=;
        b=TrIYudiCW6NR5RfIorfnylRra0nNoRFo5demygjiHyhgfII7jyODV3guHgX4TvRu+QiPde
        Sm92tn+aTieTf6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B4A413A15;
        Wed,  8 Jun 2022 21:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 14vPHJMToWJ5DgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 08 Jun 2022 21:24:35 +0000
Date:   Wed, 8 Jun 2022 23:20:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] btrfs: Remove the unused function
 scrub_calc_parity_bitmap_len()
Message-ID: <20220608212005.GR20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yang Li <yang.lee@linux.alibaba.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220608012158.109334-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608012158.109334-1-yang.lee@linux.alibaba.com>
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

On Wed, Jun 08, 2022 at 09:21:58AM +0800, Yang Li wrote:
> bitmap_len = scrub_calc_parity_bitmap_len(), the only call point of this
> function has been deleted, so it should also be removed.
> 
> Fix the following W=1 kernel warning:
> fs/btrfs/scrub.c:2857:19: warning: unused function 'scrub_calc_parity_bitmap_len'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks, fix folded to the patch as it's still in the development branch.
