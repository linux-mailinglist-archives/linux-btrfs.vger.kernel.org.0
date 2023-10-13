Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B67C892E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjJMPz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMPzz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 11:55:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBCBD;
        Fri, 13 Oct 2023 08:55:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4ACA91FDA3;
        Fri, 13 Oct 2023 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697212552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKg0uGSiW90pKRVIVtWR17gshOXqltw2AyEhcFTpRFA=;
        b=TJe+XLETfLOlw1w8GbrDfQXfcmeD/NwKVAb6tH8oNZsuJydQE7nTTE2qA8b27I+h5I5MUr
        2CEBr5JxJg0JIRmPeravWQb2W9NRfILzRWnTQwaIrMvo848uR1nqzRWr30v3Xlj0h5k82k
        YDLjEpi/WOg4/3Fn5Vyotig5IFEhl4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697212552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKg0uGSiW90pKRVIVtWR17gshOXqltw2AyEhcFTpRFA=;
        b=CmRaF9d/+Jbed3EeDSe7l+RxYmJuonOvpxuuqfAu7vBiPtcYnRSQYllvxbjZBxs7mXNWeF
        vIqJnDMVcg1pIaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10F2B1358F;
        Fri, 13 Oct 2023 15:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gFL7AohoKWXHWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 15:55:52 +0000
Date:   Fri, 13 Oct 2023 17:49:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: clean up an error code in
 btrfs_insert_raid_extent()
Message-ID: <20231013154904.GP2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ce098f42-f12c-4bc2-b37f-2f35c572eecf@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce098f42-f12c-4bc2-b37f-2f35c572eecf@moroto.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.50
X-Spamd-Result: default: False [-4.50 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.70)[83.33%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 12:42:55PM +0300, Dan Carpenter wrote:
> It's more obvious to return a literal zero instead of "return ret;".
> Plus Smatch complains that ret could be uninitialized if the
> ordered_extent->bioc_list list is empty and this silences that
> warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

With a slightly changed subject added to misc-next, thanks.
