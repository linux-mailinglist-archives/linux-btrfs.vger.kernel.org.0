Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5684663116
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjAIUL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 15:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjAIULl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 15:11:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46F34D45
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 12:11:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 084AF40213;
        Mon,  9 Jan 2023 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673295083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh+LFgwkz7M6vjhPvNV+hMnb3aPoYSG2jrFqIY/p7xs=;
        b=Fo/WRENaqTUnCGhspxnImVWu3K0N3CBi+3MpSY9dP1bLMi0CC5pca+G/dIj7hsGlz/eIAv
        FlDm/WYOaViQ4EAuXqrf8U58w3GrDJTjJocIKgG8DuI9Iy/eNw1244PtWCN9JESk7QY5kY
        DXw5SqBnrn7tsNhO64l/ercOESPDNQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673295083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh+LFgwkz7M6vjhPvNV+hMnb3aPoYSG2jrFqIY/p7xs=;
        b=hEG8sVp+PWi2ipBm7O6UU5rPkrtvxKEWid05cL9mTBt75BG+RqG2oIDIMH0sN004dUIExc
        nFV2bqwc/I/DXbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFB0E13583;
        Mon,  9 Jan 2023 20:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C72tMep0vGMJYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Jan 2023 20:11:22 +0000
Date:   Mon, 9 Jan 2023 21:05:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Hao Peng <flyingpenghao@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: adjust error jump position
Message-ID: <20230109200548.GV11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
 <a4d6650d-1055-a06a-6277-bc055436f117@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d6650d-1055-a06a-6277-bc055436f117@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 07, 2023 at 06:23:46PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/7 18:00, Hao Peng wrote:
> > From: Peng Hao <flyingpeng@tencent.com>
> > 
> > Since 'em' has been set to NULL, you can jump directly to out_err.
> 
> Then why not remove out_err tag completely? Since free_extent_map() can 
> handle empty pointers, and only keep one exit tag is helpful.
> Otherwise it provides no benefit and even compiler can optimize it better.

You're right that free_extent_map can handle NULL but I'd rather keep
the pattern consistent so the cleanup labels and the functions that
cause the error are properly nested.
