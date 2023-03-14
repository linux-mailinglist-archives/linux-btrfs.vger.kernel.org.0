Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED466B9E23
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCNSUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCNSUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 14:20:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DC6425F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 11:20:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEBDA21AC0;
        Tue, 14 Mar 2023 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678818001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sus0DwPf3xKAEOk5dN57ctSOa3Nm2Kit1AkEa38Ppus=;
        b=qziH2/6zT+eA0tlPkRKO5vOX0a+HvW7ui9a44X1QkUMUx02F6UZkt0bEXoh48HpO1asfof
        c+DuY7DSzScTE50LATkFJNtmueg8egKdjb4dK7cMkC/64UPbXac/wzTCE0xGIAO/kJLENb
        42iZGjh0Nawor0XGaEFO5l/NdadOQYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678818001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sus0DwPf3xKAEOk5dN57ctSOa3Nm2Kit1AkEa38Ppus=;
        b=wCkzHfRSe8QUWLjSsyAIZ/B7lBGmei6FV8TV/GZh0uIVbwsu9GU3slwJTAZhcTGWNNPyBE
        wOL0FDZtAJAUIEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0CC313A26;
        Tue, 14 Mar 2023 18:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nbb9LNG6EGRlIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 18:20:01 +0000
Date:   Tue, 14 Mar 2023 19:13:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: zoned: replace active_total_bytes counter
Message-ID: <20230314181355.GQ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1678689012.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678689012.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 13, 2023 at 04:06:12PM +0900, Naohiro Aota wrote:
> This series depends on clean up part (patches 1 and 2) of Josef's series.
> 
> https://lore.kernel.org/linux-btrfs/cover.1677705092.git.josef@toxicpanda.com/
> 
> The naming of space_info->active_total_bytes is misleading. It counts not
> only active block groups but also full ones which are previously active but
> now inactive. That confusion results in a bug not counting the full BGs
> into active_total_bytes on mount time.
> 
> Instead, we can count the whole region of a newly allocated block group as
> zone_unusable. Then, once that block group is activated, release [0
> .. zone_capcity] from the zone_unusable counters. With this, we can
> eliminate the confusing ->active_total_bytes and the code will be common
> among regular and the zoned mode.
> 
> Naohiro Aota (2):
>   btrfs: zoned: count fresh BG region as zone unusable
>   btrfs: zoned: drop space_info->active_total_bytes

Added to misc-next with the two patches from Josef's series, thanks.
