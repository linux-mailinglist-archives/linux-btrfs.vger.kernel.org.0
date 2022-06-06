Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5A53EA5C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiFFKhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiFFKhQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 06:37:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8B36685;
        Mon,  6 Jun 2022 03:37:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D01F01F8E0;
        Mon,  6 Jun 2022 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654511832;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oh+d6xs/K5RIwfQPbMAzdhItVAYJFXKNL7LJl57ehAM=;
        b=bPKpmiyhz5lNEZwWCzDasHkLoIUoLL62YrN/yZ34r7ZM4pf2D4HhO/xvEibPxInlEIGuh0
        SAJQLM2tOvlPAAY7LbbAstor4eRXw5weUbAtg1DRHvnoYS/txMFv4YyhcOiNx7qpLdz5aX
        63ikj2Mkt1jBQStstNqXYaxNRMvC7ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654511832;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oh+d6xs/K5RIwfQPbMAzdhItVAYJFXKNL7LJl57ehAM=;
        b=IMgLerAkV7auCiJ3umE2EWX9E0t2J1XAeDV8xhe3la5pKfB0fz1f67ADla3hilkSGS7LEd
        FoCkbsTLfIzdqhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B790139F5;
        Mon,  6 Jun 2022 10:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MKEXIdjYnWKlGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 10:37:12 +0000
Date:   Mon, 6 Jun 2022 12:32:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <20220606103243.GZ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
 <YpjVKAGz+GuI4GB0@infradead.org>
 <20220602162840.GV20633@twin.jikos.cz>
 <1793713.atdPhlSkOF@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1793713.atdPhlSkOF@opensuse>
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

On Sun, Jun 05, 2022 at 05:11:48PM +0200, Fabio M. De Francesco wrote:
> On giovedì 2 giugno 2022 18:28:40 CEST David Sterba wrote:
> > On Thu, Jun 02, 2022 at 08:20:08AM -0700, Christoph Hellwig wrote:
> > I've just hit the crash too, so I've removed the patches from misc-next
> > until there's fixed version.
> > 
> Finally I've been able to run xfstests on a QEMU + KVM 32 bits VM. Since I 
> have very little experience with filesystems it was a bit hard to setup and 
> run.
> 
> I can confirm that the problems are only from conversions in patch 3/3. 

Thanks.

> Since I've been spending long time to setup xfstests and make it run, I 
> haven't yet had time to address the issued in patch 3/3 and making the 
> further changes I've been asked for.
> 
> Can you please start with taking only patches 1/3 and 2/3 and dropping 3/3?
> I'd really appreciate it because, if you can, I'll see that part of my work 
> has already been helpful somewhat and have no need to carry those patches 
> on to the next series :-) 

Yes I can pick 1 and 2. Removing the whole series is needed in case it
crashes tests as it affects everybody.
