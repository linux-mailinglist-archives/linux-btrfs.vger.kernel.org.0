Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE62663154
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjAIUUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjAIUTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 15:19:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375B34D50
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 12:19:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01B5B5C1BB;
        Mon,  9 Jan 2023 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673295592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FU9yyuAz8PwbHk5LCPCzHs/PAKnphawAhbyu/c+tXGQ=;
        b=RIeSLlAKiqZqs+fCHoaYNjS9EJz36iBMSjTmMmotsR7zPhU56md4P1pOEGbvB0i6HK3xlj
        s/yquOauFE6Gj3gUNzwU3mUvuEWSt+Rpkcyp8kejTmWtT8zbi4WMGKceUxjmcQ1F/5MJhp
        GlhAYeQvqArv92e/Ty2FM/ciS68bj/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673295592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FU9yyuAz8PwbHk5LCPCzHs/PAKnphawAhbyu/c+tXGQ=;
        b=8Qq7aSCI5SlewLv3mDJ2zaVwhzi4f2oxxd9j0eGuBbb1BmaC7tVURhEVFXrZ8vHqxkmJxW
        9hMxn1ecQmmcYyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C427113583;
        Mon,  9 Jan 2023 20:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1m7MLud2vGNDZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Jan 2023 20:19:51 +0000
Date:   Mon, 9 Jan 2023 21:14:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: adjust error jump position
Message-ID: <20230109201417.GW11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 07, 2023 at 06:00:19PM +0800, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Since 'em' has been set to NULL, you can jump directly to out_err.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

With updated changelog added to misc-next, thanks.
