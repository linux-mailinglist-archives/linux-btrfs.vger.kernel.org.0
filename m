Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E3B7AAF83
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjIVKbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIVKbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:31:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398AAB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:31:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 299192197E;
        Fri, 22 Sep 2023 10:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695378698;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ASpj9yed/2HVPGMCxAPw4SqQTiO4Hm0o/Dd8mXW04Y=;
        b=n9sbS1h96i+vQDuSUVMNwXYsl4ZsUMJNj2//7zz3mh4IRj5lQNRhshunnSUb5QHxKbsFzD
        yGqumwxU5U/ifNGhKIfF/2FKgrvPVj+bza8uS5lnwkHy3dl6yVG/hApg2ga+OXABNz75Xg
        jaRTfY39WADvz0JahzCYeb6JLS9eFng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695378698;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ASpj9yed/2HVPGMCxAPw4SqQTiO4Hm0o/Dd8mXW04Y=;
        b=K3VSLSiE8Ij/x4CA3Pb8wzDwkNnU6iOhB9evCYonmCo8vNKm+mKIpKpGAL2CNWNov0mi5f
        AdkbbKfAmhfvopDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06EAE13597;
        Fri, 22 Sep 2023 10:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cbbNAAptDWUPfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 10:31:38 +0000
Date:   Fri, 22 Sep 2023 12:25:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230922102502.GB13697@suse.cz>
Reply-To: dsterba@suse.cz
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
 <20230920190547.GI2268@twin.jikos.cz>
 <CAL3q7H4Z79TMV6L3EM61-gCk1Z70OFT=VnPvN=fUbzCUm8oeKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Z79TMV6L3EM61-gCk1Z70OFT=VnPvN=fUbzCUm8oeKg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 11:50:24PM +0100, Filipe Manana wrote:
> On Wed, Sep 20, 2023 at 11:44 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> >
> > Added to misc-next, thanks.
> 
> So after this change, at least 2 test cases from fstests are failing
> with -ENOSPC on misc-next:
> 
> $ ./check btrfs/156 btrfs/177

Thanks, I've removed the patch from misc-next for now.
