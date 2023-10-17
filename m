Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269657CCE7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJQUpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 16:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344367AbjJQTqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 15:46:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E43FF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 12:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACC7121D0A;
        Tue, 17 Oct 2023 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697571964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILcR7dytKkwv86ZOHX73Q9yGFvto7ahBUly1tMdiY24=;
        b=UM+TJoSp8J4gofk3y0InEf56MnKsA3UHRmHqKUgmNW0UPxQzzApQ/tvjqHbUn3bNQmjaI7
        DsIyryEB3e50HftUZmIw1cXkLhM7+re4+cRW9J5nQxrIwt+Gr1S9d8hP/opgksLAQAOJSZ
        8RlXI9w248H2eRWWauQszCh7KZF6eoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697571964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILcR7dytKkwv86ZOHX73Q9yGFvto7ahBUly1tMdiY24=;
        b=a+4CSrtV/vFLpffCOgmf01rITsYCtLN9qmQ2aFZNEfxGJq/+nfrg5RETcDWqvzjns9a3pK
        +SH3QNq9x/Bg7WBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81F5413597;
        Tue, 17 Oct 2023 19:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bIzYHnzkLmVXOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 19:46:04 +0000
Date:   Tue, 17 Oct 2023 21:39:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: wait for data BG to be finished on direct
 IO allocation
Message-ID: <20231017193914.GC2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.85
X-Spamd-Result: default: False [-3.85 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.05)[59.91%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 17, 2023 at 05:00:31PM +0900, Naohiro Aota wrote:
> Running the fio command below on a ZNS device results in "Resource
> temporarily unavailable" error.
> 
> fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=117440512, buflen=16777216
> fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=134217728, buflen=16777216
> ...
> 
> This happens because -EAGAIN error returned from btrfs_reserve_extent()
> called from btrfs_new_extent_direct() is splling over to the userland.
> 
> btrfs_reserve_extent() returns -EAGAIN when there is no active zone
> available. Then, the caller should wait for some other on-going IO to
> finish a zone and retry the allocation.
> 
> This logic is already implemented for buffered write in cow_file_range(),
> but it is missing for the direct IO counterpart. Implement the same logic
> for it.
> 
> Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allocation didn't progress")
> CC: stable@vger.kernel.org # 6.1+
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

With fixed spelling and added fio command, patch added to misc-next,
thanks.
