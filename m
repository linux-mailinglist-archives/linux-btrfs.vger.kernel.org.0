Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270654B304
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbiFNOUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiFNOUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 10:20:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674942DEC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 07:20:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 003031F9A1;
        Tue, 14 Jun 2022 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655216403;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk4lJZpw1SJWbwAsa0i2JapkLFHy4PQsA7C12ZCQJ/s=;
        b=3G65zN/Qd97WVA1JVYSZW0CCuiD2yPPI5J06r0yF5eQZ9CnDX0ygQ3b/dWcDOgJb0epePj
        fvpcaYTm/pF9AyUqVU+V8N+e7fRjfVL65oC5+dEDRccJHyB8Dmv8gb3wjTC3qonL1QXUnV
        nht15cw6H5ehv7Gz3tM4El3I2v3bbCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655216403;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk4lJZpw1SJWbwAsa0i2JapkLFHy4PQsA7C12ZCQJ/s=;
        b=rzIWmykF5FXpqcw2nDe2xQRxqStSk+cOgg5g9IoCUi9HwWqbSXLMMaXVkQ2b7dWiujywqk
        tC/CRaZWbqJcyzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D01EE139EC;
        Tue, 14 Jun 2022 14:20:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4urnMRKZqGJAQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 14:20:02 +0000
Date:   Tue, 14 Jun 2022 16:15:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: Add the capability of getting commit stats in
 BTRFS
Message-ID: <20220614141529.GM20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220610205406.301397-1-iangelak@fb.com>
 <20220610205406.301397-2-iangelak@fb.com>
 <4ecbbf88-4f83-92e3-d8ca-90dec9f1a053@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ecbbf88-4f83-92e3-d8ca-90dec9f1a053@dorminy.me>
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

On Mon, Jun 13, 2022 at 05:05:05PM -0400, Sweet Tea Dorminy wrote:
> > +	/* Update the total commit duration */
> > +	fs_info->commit_stats->total_commit_dur += interval / 1000000;
> > +}
> 
> Why not store as ns? You could do the conversion at display time for a 
> slight increase in accuracy of total_commit_dur (consider samples of 2.8 
> ms, 2.8 ms, 1.4 ms: this code would print total duration of 5 ms, if I 
> understand rightly, but 7 ms is the actual total).

Good point, what's the reasonable granularity and precision? Tracking in
ns but printing as ms sounds OK to me and should cover most use cases.

A think a full commit could be faster than 1ms on contemporary systems,
eg. memory backed device, small amount of data to write, but that's
probably an edge case. You could also gather some samples so we get a
better idea.
