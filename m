Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDF5817CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiGZQrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiGZQru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 12:47:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E925591;
        Tue, 26 Jul 2022 09:47:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72373381C7;
        Tue, 26 Jul 2022 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658854068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlF5ylZTd1i/4jYiq3gW88KJ0Xm5CfkpCnDnrAfO/I8=;
        b=l6rmovRJPsb56AguMBC6nvsJBGL/w1TMk1Nn9awTuUcWiCfq7gXGeUweTD6aj3HcDtbCFV
        pE8eu97caQQwaXx1rQIiBONKl1Dmr8gmH1DdAeAaBpbboTIRgwnUvU2yRKhisE7N1c6VjW
        OlfgEIGmdZxEFi1UwnBlD3xnjoEE1nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658854068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlF5ylZTd1i/4jYiq3gW88KJ0Xm5CfkpCnDnrAfO/I8=;
        b=dD3AtG0Sx3xeg5wJf/vSSKKTlO1wirZ66k3tIIWUdJT6w94+0JDn4jFKFag6hreAnNtRK9
        aWTjCorsSg9t7dAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5060C13322;
        Tue, 26 Jul 2022 16:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cjKgErQa4GLbdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 16:47:48 +0000
Date:   Tue, 26 Jul 2022 18:42:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20220726164250.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> Hi guys.
> Always with intensive writing on a btrfs volume, the message "BUG:
> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.

Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
tends to work.
