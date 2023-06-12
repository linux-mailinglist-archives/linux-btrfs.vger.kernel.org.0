Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5672C387
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFLL4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjFLLzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 07:55:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E591BF0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 04:55:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94B5B201A7;
        Mon, 12 Jun 2023 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686570913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g74RzVS4N2F0Q7zSIbrxzRm6ppU6G7FlrqwbEsXP1/I=;
        b=IugFJXDw76AS0lhIkq5AIHTYmVO5jofKE6ySbjIdxvK9CNK5pXp8QjzKQYkL2B7i7SJjek
        xCEzxFg95aqQe/qrouLvkMPuRfZG0vY8Ht9I1PnIUFNyeBBTEc2qrbMO+Rh+hg/A+SAOVo
        TiJNfyz2zN022y9ScMdtrjwjifKJz1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686570913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g74RzVS4N2F0Q7zSIbrxzRm6ppU6G7FlrqwbEsXP1/I=;
        b=bjDJE60oBjE7AtJsVIlowjo6M5yzN8iBYx7cboNTroSCe1i3zGCZYpGX7ghgABG65Uldhe
        +GwDS++wZTeP3vDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A3F81357F;
        Mon, 12 Jun 2023 11:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IJ+qBqEHh2TrVAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Mon, 12 Jun 2023 11:55:13 +0000
Date:   Mon, 12 Jun 2023 06:55:45 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not clear EXTENT_LOCKED in
 try_release_extent_state()
Message-ID: <4d6ycqrxcsn5t5aelxigz3wmwlymygqkb4olthopmed6m7swgd@2prntyhxanyw>
References: <r3pglf6fh5hqqfd6iwt5eklmalm4idnumjxo5v23buu7zfjdfm@ixnvwldw5yjg>
 <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14:25 09/06, Filipe Manana wrote:
> On Fri, Jun 9, 2023 at 2:20 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > clear_bits unsets EXTENT_LOCKED in the else branch of checking
> > EXTENT_LOCKED.
> 
> It doesn't. Because of the negation operator:
> 
> u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM | ...
> 
> > At this point, it is not possible that EXTENT_LOCKED bits
> > are set, so do not clear EXTENT_LOCKED.
> 
> And it doesn't clear them because of ~

Yes, apparently I have to re-learn to read code.
This patch is incorrect.


-- 
Goldwyn
