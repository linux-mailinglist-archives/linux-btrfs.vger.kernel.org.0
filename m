Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC03E7CF85E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjJSMJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbjJSMIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:08:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BDB210C
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 05:06:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 724FF21A79;
        Thu, 19 Oct 2023 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697717195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxa3NTZuPNJE/bNds61TFwiCEUomI66JrQFp6lS1ppI=;
        b=e4tF7dO21PcefZAuQyIaFe1gIuOGkbG2C8hCpj8a+C7HYdCn7bMFH2XjPoQPIMj/Ffk+9F
        L0T7HntuY4llLxn5tJ23ts05RyjTtUUIK+nq6Z3vhficHjqJLoBev4srohXAg0XkUde790
        VedRFpYJkywoPoIUhbmQnEvXBITbVEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697717195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxa3NTZuPNJE/bNds61TFwiCEUomI66JrQFp6lS1ppI=;
        b=uYKL5SRoyn6JaqAq3di7K8zspSP4MUn88kIeWi7O3RNUp7yVVlPWWfsLE5xLMDEjGI1DK2
        SDXfs8DIdfa1VVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A768139C2;
        Thu, 19 Oct 2023 12:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d7c5EcsbMWU1MwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Oct 2023 12:06:35 +0000
Date:   Thu, 19 Oct 2023 13:59:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: Re: [PATCH 0/2 v2] btrfs-progs: mkfs: testing cloned-device
Message-ID: <20231019115944.GE26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696304038.git.anand.jain@oracle.com>
 <20231017234945.GB26353@twin.jikos.cz>
 <59f12862-f48a-4117-af58-cd6cd66bd308@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f12862-f48a-4117-af58-cd6cd66bd308@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.69
X-Spamd-Result: default: False [-5.69 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.89)[94.41%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 07:02:45AM +0530, Anand Jain wrote:
> 
> 
> On 10/18/23 05:19, David Sterba wrote:
> > On Tue, Oct 03, 2023 at 11:46:12AM +0800, Anand Jain wrote:
> >> v2:
> >> Worked on review comments from David.
> >>
> >> --- v1 ---
> >> This patchset adds support for testing cloned-device in mkfs.
> >> So using mkfs.btrfs both option -U and -P a new device can be created
> >> to match the FSID and UUID of an existing device. This is useful for
> >> testing cloned-device.
> >>
> >> Anand Jain (2):
> >>    btrfs-progs: document allowing duplicate fsid
> 
> 
> 
> +        must not already exist on any currently present filesystem.

Fixed.
