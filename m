Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFF6F47EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 18:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEBQGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 12:06:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184673AA0
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 09:06:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA7241FD71;
        Tue,  2 May 2023 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683043564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FH/Rak+5EZ5QiBYHENx7iDnWxnMkTcDYFMzKZFUcCkA=;
        b=yC4lgSaUeBe7v94nql9Xa1dI6UBPMfuLZzmgTfaGEht66lVoIVlHoqKSy+xNHyP/mXHD/2
        Xi4r1Uttd2vGp05eMzVlCa6djdV0bKuWaNeOeZF8iCXYhDuE3b4xX3/E78wHxoVpOmwmMi
        K8EvHCxDkGy7CO66B5nhfITrVuSJJnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683043564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FH/Rak+5EZ5QiBYHENx7iDnWxnMkTcDYFMzKZFUcCkA=;
        b=CmJOKbJkufiPzczwcJHvB/XpurFr3p6kUHJZDAmJg7jjn5VJU9/1uUnnQs0JYGR9uW5Psm
        GDmZu4YatJgMiaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B055B134FB;
        Tue,  2 May 2023 16:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DitAKuw0UWRMNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 16:06:04 +0000
Date:   Tue, 2 May 2023 18:00:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use SECTOR_SHIFT to convert phy to lba
Message-ID: <20230502160009.GJ8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bf0d31958fd2b40483146e2a8ec483c1f54796d6.1681544908.git.anand.jain@oracle.com>
 <703d830a41f97b60e2cd2c59e3b15432a01220fa.1681551217.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703d830a41f97b60e2cd2c59e3b15432a01220fa.1681551217.git.anand.jain@oracle.com>
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

On Sat, Apr 15, 2023 at 05:51:23PM +0800, Anand Jain wrote:
> Use SECTOR_SHIFT while converting a physical address to an LBA, makes
> it more readable.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Dave,
>  I found some more places where we can use SECTOR_SHIFT.
>  Can you please fold this into the patch sent earlier? Thanks.

Folded and added to misc-next, thanks.
