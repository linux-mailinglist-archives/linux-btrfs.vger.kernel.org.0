Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979205AA8AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiIBHU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiIBHUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 03:20:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0763F23
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 00:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EF5E34064;
        Fri,  2 Sep 2022 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662103250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7TJqMA+1ZvQPED7KrX/UWoIdxKEnmvBKRAgGOXF72g=;
        b=anMhhyrioSrg4bYD0EcKgDsgYdWOkLXAbca1dMdE+7iYJxyIjPcH0vPFJA5sJdKaLVWKlc
        2rTQBgzuBRoVtrfjZqD0HZzmDcNntwGGK3WjmYuzbznw6chAyzedeIHAPgzv2eSadPvKP+
        GmMPIzYBhCBuFvsSAJz+DAKtMkVYvBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662103250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7TJqMA+1ZvQPED7KrX/UWoIdxKEnmvBKRAgGOXF72g=;
        b=b7fJyPpwJF7aAS+to7zTGgHq6iAE+qOVgthA5NpQSUI3KOlIuzfP+N+hje2CcZN2cjWw2e
        9n+1LeUaeY1dFPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E103813328;
        Fri,  2 Sep 2022 07:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pj0NNtGuEWM1WgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 07:20:49 +0000
Date:   Fri, 2 Sep 2022 09:15:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.19
Message-ID: <20220902071529.GO13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <20220816135149.GC13489@suse.cz>
 <8c5da92490778450db962564528ad9db5b8f7348.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c5da92490778450db962564528ad9db5b8f7348.camel@scientia.org>
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

On Thu, Sep 01, 2022 at 07:01:10PM +0200, Christoph Anton Mitterer wrote:
> Hey.
> 
> 
> I've just wondered whether:
> 
> On Tue, 2022-08-16 at 15:51 +0200, David Sterba wrote:
> > Changelog:
> >    * send: support protocol version 2
> 
> means that send/receive v2 would now already be used when using
> btrfsprogs v.19?

Progs use the highest version supported by the running kernel, the
version is detected from sys/fs/btrfs/features/send_stream_version . Not
using the latest version is up to the user in case the receiving side
does not support the version.

> Especially,... is it considered stable?

I'd say yes, the new features in v2 are not intrusive, eg. fileattr,
otime are only informative, the fallocate is not yet emitted on kernel
side and the encoded data have to be explicitly selected on the send
side. It's basically v1 with unless told otherwise.
