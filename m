Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADA7BEE91
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378944AbjJIWyS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 18:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378939AbjJIWyR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 18:54:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062CA4
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 15:54:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1227521833;
        Mon,  9 Oct 2023 22:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696892055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=db/TCOSzGatonO8SWLjKdoO1lZTnjaAjCuGrXwzFT7Q=;
        b=0Owksmg2lfYZUPrTgTc2OqMiQw2Dbwqc3iddCmaCnk+vzvh3t1FOb1KaxZXViWfnn/zwRm
        TYYL27T4sF02btmbZ2CboV1M6ev039G3NfTZ919N0gyT/iMLq1Wodmmgn8SCAiCd/IFQrm
        mocYS110Bpfx2Zaeph1Cy9XUOJgCFwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696892055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=db/TCOSzGatonO8SWLjKdoO1lZTnjaAjCuGrXwzFT7Q=;
        b=XsGtvAxkh5/4FzqpfYBelsjyRjS7eT9B5LXfejKlioZIPOLOGry9CvWVas/FjIOgaGamjm
        rBizZ5aGK7D6FyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB0A913586;
        Mon,  9 Oct 2023 22:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id elqKOJaEJGUPdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 22:54:14 +0000
Date:   Tue, 10 Oct 2023 00:47:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: move inode cache removal to rescue group
Message-ID: <20231009224729.GW28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696826531.git.wqu@suse.com>
 <1d5cc97d664fc10c0244ff2c255f2fc4bbf58dfa.1696826531.git.wqu@suse.com>
 <20231009142314.GP28758@twin.jikos.cz>
 <9f582ea7-d75b-43f8-9381-649c6bbbf622@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f582ea7-d75b-43f8-9381-649c6bbbf622@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 07:20:58AM +1030, Qu Wenruo wrote:
> On 2023/10/10 00:53, David Sterba wrote:
> > On Mon, Oct 09, 2023 at 03:17:00PM +1030, Qu Wenruo wrote:
> >> --- a/check/main.c
> >> +++ b/check/main.c
> >> @@ -10242,6 +10242,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
> >>   	}
> >>   
> >>   	if (clear_ino_cache) {
> >> +		warning("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead.")
> > 
> > No "." at the end of the text and the ";" is missing, does not
> > compile.
> 
> My bad, I noticed the warning is missing thus added it in the last minute...
> 
> Do I need to resend or you have already fixed it during merge?

No need to resend.
