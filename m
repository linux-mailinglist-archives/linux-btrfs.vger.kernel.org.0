Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835CB6A116A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBWUqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 15:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBWUqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 15:46:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D255C1F
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 12:46:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03E0637D65;
        Thu, 23 Feb 2023 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677185192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLjf4t2/QYl/xhvhqIr0Ift27PtzL4W//1HzhSoTflk=;
        b=YP5lnxqtz7lHAdLybeRJFCgnKb3f7HuXKqw1FzTaaS2ie7iaGfAJ5Hpa/iYbCr1+0EQ0nz
        0vK/0AsUJjh46dVXAuud9+b3ytqh9ZlXVW/GBnpI9j1NU2lnenRakNJ50yQDXO2xzVryWP
        vxPShYL/ptrHikcU8OzixzLTvQHQ9zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677185192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLjf4t2/QYl/xhvhqIr0Ift27PtzL4W//1HzhSoTflk=;
        b=MLznPQjm0gbo0cLoDb4nfxqvao33MLWCh262VKv0MzvaxLQW9NRnNEjkpnsQ3rk1/jhQNK
        DaM/YD8axMWUomAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6EFD13928;
        Thu, 23 Feb 2023 20:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SpSVL6fQ92M1ZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 20:46:31 +0000
Date:   Thu, 23 Feb 2023 21:40:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: compression code cleanups
Message-ID: <20230223204034.GA10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230210074841.628201-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 10, 2023 at 08:48:33AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series streamlines the compression code.  It embedds the I/O for the
> compressed I/O into the compressed_bio structure to avoid an extra memory
> allocation and duplicate fields, and tidies up various other loose bits.

Added to misc-next, thanks.
