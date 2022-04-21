Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20450A0EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386925AbiDUNho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386635AbiDUNhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 09:37:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC92ED69;
        Thu, 21 Apr 2022 06:34:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86C1B21112;
        Thu, 21 Apr 2022 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650548086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qgPbeJku+RNXshFugf23ScOYaCPL7JosHkqEkkCRV8=;
        b=sSZYuuysmtC4n9vqK2M5DCRNt7TGE3o9b7A0kMXbYFJghM7PhP9jO9cZnTpgJEOxzHJG15
        AqNPKLrM2kubosD+9cLqwbxmkN6C5hGtUG6TYPx7rkjiURGEPOKNP+4ZGSOPZYWDCIMLVw
        HjAkyr9p2PJ93ZSiar92m/Svnk1VVc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650548086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qgPbeJku+RNXshFugf23ScOYaCPL7JosHkqEkkCRV8=;
        b=yFupKRRRZmlsnMambH8lX6PvtV7HIBfIA4yzpkB5CpnVLcA07im+mCysSX7xmFsgC/7MCA
        +2PvS84xq+4AsKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 492F713446;
        Thu, 21 Apr 2022 13:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yzr2EHZdYWJONwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Apr 2022 13:34:46 +0000
Date:   Thu, 21 Apr 2022 15:30:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Message-ID: <20220421133041.GA18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
 <2aeffa33-e591-acad-f96f-59cfadb5aeb2@suse.com>
 <c7d16718-1071-2b57-fc77-968945cfb4f5@suse.com>
 <d351b938-93c8-acc3-8c0f-eb471af8676d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d351b938-93c8-acc3-8c0f-eb471af8676d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 02:34:47PM +0300, Nikolay Borisov wrote:
> <snip>
> 
> > 
> > Actually to simplify further:
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 7a6974e877f4..bbda55d41a06 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4353,6 +4353,7 @@ static long btrfs_ioctl_balance(struct file *file, 
> > void __user *arg)
> >          bargs = memdup_user(arg, sizeof(*bargs));
> >          if (IS_ERR(bargs)) {
> >                  ret = PTR_ERR(bargs);
> > +               bargs = NULL;
> >                  goto out;
> >          }
> 
> Unf, this also leads to the double free ...

Please send me an incremental diff that I can fold to the patch, thanks.
