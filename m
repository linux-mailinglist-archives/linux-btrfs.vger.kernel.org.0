Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868B4FF8CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiDMOUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiDMOUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 10:20:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317960DB2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 07:18:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D02731F85A;
        Wed, 13 Apr 2022 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649859487;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMLifnT9Xlj4fc6eYqnPBvsYCerDocMA1vWGXa7Pw9M=;
        b=oPlO77tgUPFjmduM/aniKc4n0uiAFXNLd/xtpXf/NPQ52XSJHbRY2Jkd2KY8Vrc5bxO+8t
        yZDBpykel8IL6/1/x39/EnHDiTOdI50takA8Utl+dOsKUmtzcBX3qgtJaHR6FsICxGowSA
        0APnwzIDfxXVSmRRLTwRjf3bd4FHvfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649859487;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMLifnT9Xlj4fc6eYqnPBvsYCerDocMA1vWGXa7Pw9M=;
        b=DlRPScLpcLr5WDeTStXfZ7F6s58dA4c+9Wbe9B1sR5fwmEr6//GxxBVvDehb7OlGDteZuw
        r7gl+fTazKkuM7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A747313A91;
        Wed, 13 Apr 2022 14:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U6kNKJ/bVmLGFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Apr 2022 14:18:07 +0000
Date:   Wed, 13 Apr 2022 16:14:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220413141401.GJ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220412123546.30478-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412123546.30478-1-gniebler@suse.com>
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

On Tue, Apr 12, 2022 at 02:35:46PM +0200, Gabriel Niebler wrote:
> … in the btrfs_root struct. Also adjust all usages of this object to use
> the XArray API.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
> 
> Notes:
>     XArrays offer a somewhat nicer API than radix trees and were implemented
>     specifically to replace the latter. They utilize the exact same underlying
>     data structure, but their API is notionally easier to use, as it provides
>     array semantics to the user of radix trees. The higher level API also
>     takes care of locking, adding even more ease of use.
>     
>     The btrfs code uses radix trees in several places. This patch only
>     converts the `delayed_nodes_tree` member of the btrfs_root struct.

You've put this under the --- marker which means this is not supposed to
be in the changelog (as we do for various patch revision commments) but
then there would be basically no useful changelog left. That the
conversion is done is clear, maybe there are some useful notes or
comments what changed and how, eg. the locking.
