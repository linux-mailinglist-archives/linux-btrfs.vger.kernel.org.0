Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75130667D6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 19:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjALSFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbjALSDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 13:03:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F11CB3F
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 09:28:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A45E3F8E6;
        Thu, 12 Jan 2023 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673544515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaGreeW4SlcR9F8SaDtKkhssqgNzx6666vYSasXu8Fg=;
        b=XFxkqqHHSxKRmHV6THNVytRgtvnZMvSG8ZgXM6Hbi7YCASbUt6Y1OWn/U+3k3u5f80YkOh
        0Ux62jkqgxiAAz8u27WW8WPovhV5M6HAq25HeFxo+j1f7ToyQrhoHuHLJUxth2WMwpvlCu
        WCOwAuz+p4fDODFzrCOftagppK1MOQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673544515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaGreeW4SlcR9F8SaDtKkhssqgNzx6666vYSasXu8Fg=;
        b=Xx2AdYd7VBFjHaRLGAqtNRNz1s6NW6Js/Uyfr+BVOKx/MPGOC/NfbqZXH5/UISDgezFJz4
        oaTXP1qcIZVJqyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BA6213776;
        Thu, 12 Jan 2023 17:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VUU9GUNDwGOJYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Jan 2023 17:28:35 +0000
Date:   Thu, 12 Jan 2023 18:23:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: add sysfs doc
Message-ID: <20230112172300.GP11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7634ce2b8d9f2e7e0b6c927e9f49f5f12c93b085.1672987414.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7634ce2b8d9f2e7e0b6c927e9f49f5f12c93b085.1672987414.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 06, 2023 at 02:43:39PM +0800, Qu Wenruo wrote:
> This patch will add a dedicated section for btrfs sysfs interfaces.
> 
> It will include:
> 
> - Directory layout explanation
>   Including:
>   * Description
>   * Introduced in which kernel version
> 
> - Files explanation
>   Including:
>   * RW/RO type
>   * Description
>   * Introduced in which kernel version
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
