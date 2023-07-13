Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0073D752A74
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjGMSsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjGMSsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:48:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F432686
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:48:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA9BB1F37C;
        Thu, 13 Jul 2023 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689274097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oGbtpUYRmqaKW3wNQ9W1ZfJJdMG5CI9I0OTRmHTBOQ=;
        b=laghWV/phJyL/keSogQVNP5fSuAw14fSt73JXx5j+MvBC85puXs9MFf61FG0Q6l1m3yCAD
        OdMr8mqYvX7wYLF0ZVJ7K28avz0gN3Ln/2eLISgrPAQIwpD2TwXH5/ZhtC4GriCNqTKwt0
        JGxTYXT0A2HKuANRpDRG+A99ZA2aE/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689274097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oGbtpUYRmqaKW3wNQ9W1ZfJJdMG5CI9I0OTRmHTBOQ=;
        b=pNMuG8DWnARKd2yND8gsV908FKzlGyK+SL7KrVRYlVT/hWIJUI381NJmvQYjy3bWX3LsoY
        7CYC+mXhSsW6gpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B27913489;
        Thu, 13 Jul 2023 18:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UnM5JfFGsGQ0AwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:48:17 +0000
Date:   Thu, 13 Jul 2023 20:41:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs-progs: docs: update btrfstune --device option
Message-ID: <20230713184141.GB30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687943122.git.anand.jain@oracle.com>
 <8bfadf1467d7a5b7283d4bc4b5b00b7f070dd814.1687943122.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfadf1467d7a5b7283d4bc4b5b00b7f070dd814.1687943122.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:56:11PM +0800, Anand Jain wrote:
> Update the Documentation/btrfstune.rst to carry the new --device
> option.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  Documentation/btrfstune.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
> index 0510ad1f4c26..89f4494bbaf0 100644
> --- a/Documentation/btrfstune.rst
> +++ b/Documentation/btrfstune.rst
> @@ -46,6 +46,9 @@ OPTIONS
>          Allow dangerous changes, e.g. clear the seeding flag or change fsid.
>          Make sure that you are aware of the dangers.
>  
> +--device

Options that take a value should also document it.

> +        List of block devices or regular files that are part of the filesystem.
> +
>  -m
>          (since kernel: 5.0)
>  
> -- 
> 2.31.1
