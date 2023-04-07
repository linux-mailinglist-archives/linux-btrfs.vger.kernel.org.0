Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781C96DAE67
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDGNzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjDGNyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 09:54:51 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A7DE;
        Fri,  7 Apr 2023 06:53:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 27A3D640BA7;
        Fri,  7 Apr 2023 13:51:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A1BE8640A4E;
        Fri,  7 Apr 2023 13:51:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680875508; a=rsa-sha256;
        cv=none;
        b=8TH02B/AOI4GWf2QyncXdDHlqw6ctjY7jjNZ7EvGk9sfeTnotAa+nzHKeqJhTnzCSSD4+2
        VD1+6771oGjT1JmtQHnGL6MX++7K9RI418M9bO+rZKyj33yXV+Mi+U1vkALuu+i0oZox9O
        ZI5R7R1wrfYlVwQgcgFdgjkl8HcRiKvpdrAXlLdHhXB13A6iZHIcEZ4PnRCzsa8lqr/RLP
        uWrhu2Z3Es1RT432lhOGrRq1e15N6ddF3gjgI7Q232zs8QBai4/8mKgAcYkRgAS/KoRvqj
        fw/pJRE0rPw1qjUJzwfHa1cAxLsUlnHeVgtGr6ceQ7R4qHbr0Owg50dfrLMkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680875508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=TMRN6q7owjGGN5u/NWFzsarFjf8XwvRjrUktuZa8bfo=;
        b=ESAjxDlKK5wyI3GzcmnNnL3n5ZA5/GuP99Pvr95u1in+mX+xwc1EasMwO+EFbfOLLU6zxH
        Wh2ifc9ZNoEKe8PPzKABVtNLgbi1wAzHF3BQnG03Rc1uiG1biy+pPbipNxrjp8sqmoEMxd
        gwJefM7maWuqR/I0uUmaBPLI68dF1LI8+cRinCM9+boaJkx3XAGTePEY3sQ/R5LSK+35fV
        SPt6NdDSiLJzwuQmkqQbF3EPseJ4ahE9+vBzZcIypw65Qk5UYsUmlsSMzGHvhCUKdiPJaC
        CvmOOckfiAP+VMjuxkiZse9zGwnbuDioBfYghJXFs7UxJVjcYxuwLRvdygIyBw==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-5m7p7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Name-Turn: 64c75ff54d8ca3c7_1680875508937_1928882780
X-MC-Loop-Signature: 1680875508937:1525149477
X-MC-Ingress-Time: 1680875508936
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.200 (trex/6.7.2);
        Fri, 07 Apr 2023 13:51:48 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4PtKXz6Tzwz1v;
        Fri,  7 Apr 2023 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1680875508;
        bh=TMRN6q7owjGGN5u/NWFzsarFjf8XwvRjrUktuZa8bfo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hm4LmFK/aVQPa4qSZHYvIpqeOfJbiPKnB8JqcqfuZJ6YGLvusiong9WbfFZYpQ8Sz
         z1TBucFTeIto7bAcc2MekOk3AK9TEWtv9y+eQw0SrQgBRg6pI0z2WT0kFlELxPyELU
         Icwzy1ClVkFG8qTBiJeOfLDNJhxr+tranCGcTgYI=
Date:   Fri, 7 Apr 2023 21:51:44 +0800
From:   Nur Hussein <hussein@unixcat.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid potential integer overflow when
 left-shifting 32-bit int
Message-ID: <ZDAf8Cv3HR728on3@gandalf>
References: <20230406192406.2300379-1-hussein@unixcat.org>
 <353b44f3-fb95-ac43-53ba-0d3b45fff574@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353b44f3-fb95-ac43-53ba-0d3b45fff574@gmx.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 08:35:40AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/7 03:24, Nur Hussein wrote:
> > In scrub_stripe(), the 32-bit signed value returned by the
> > nr_data_stripes(map) function call should be cast to u64
> > before being shifted left by BTRFS_STRIPE_LEN_SHIFT (16),
> > as a cautionary measure to avoid potential overflows. We
> > then assign it to a u64 value anyway, so a cast before a
> > shift seems prudent.
> 
> I'd say it's a little overkilled.
> 
> For nr_data_stripes(), it's at most hundreds of stripes (which is already
> insane).
> Even with 16 bits left shift, we need to get 2 ** 16 stripes to overflow
> 32bits.

Perhaps so, but it was flagged by Coverity, and it's a little safer with
the cast, with no cost. It's up to y'all if you want it though.

- Nur
