Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1963AD49
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiK1QGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiK1QF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:05:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977B24950
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:05:56 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v8so7552182qkg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYQJsbppuuzqjCmtKVRa8q+rEv8pNwptX+HdAkCIGNU=;
        b=DFPDYWqsFoy2GnfA9T1w8MsfGHJ/4ztAYIiJ9kzTF96qmC/n4QOaqCvtM9OXV85ELi
         R6t5kkkYX5j4CSzM2MWZklVrWmdcVgg13z8r0drW7kFI2U0xNm2rj4bSjWS1yWENu1rk
         GtmvsNDHvy/IQm8HVcT4QbjRceRsAWUwkD8DMzmRv6o25ssdtKnozhNjF+X7p0WKNx0l
         AkEvq0FZL0in4UbJgOcdY5T1ksgpHS+DV8gL5Ms8XapAS1sf8M7phiSloO/jrNeZsLh4
         Q7X6OS0c/X8bmdGINn+8br/g4qefenWq+lAf1gJsOBS1Bt5ru8A3OQmOs7oCcNtk+1nn
         hGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYQJsbppuuzqjCmtKVRa8q+rEv8pNwptX+HdAkCIGNU=;
        b=wdH1CMrMQMcx2Axsqy15bxCg9eT/GecBkwrt9SaaAdqcJUPQV1XmAHvx+EV+g7YjR8
         Mcd+8v5XJqxYxThsEKr69g2+J8A7L4/thF3xIaP6KGRDpmJItAAAJDKc6slrJyx7ps+G
         6wc9RHEfitZJyNAIMkbwULx3z30c8WWSnSpbhfXAeCGsX8yeXZ1sdnSvUoa//Am9GhAF
         +KM8/4I+5Eu+eIkJ2148t/nAI+royHfnD9qfKmC3UkVZAzcQF2/sUHWL1YmRRWBRcfQ1
         qwSVlWEkfAWF1M/oVwu07SD6r7ae8Oc3CLGN1ciLAkxBdYupDygb8PLTd9UA+n7oZNS5
         0h0A==
X-Gm-Message-State: ANoB5pl4oV8of1BZftYTxK7ZUb1SPkZ695v8l3VngHhATKHKm25b11ZN
        rusT2LwlaSxmH1l4JI6tadzgCw==
X-Google-Smtp-Source: AA0mqf46PFz+cFRyX1EyjGt2pP64KxkAQLJ3dkfbxW9enIbKmfvsAUzRC7vQeHQmUXBetjQr8ERU0Q==
X-Received: by 2002:a37:ace:0:b0:6fa:9e9f:8f9c with SMTP id 197-20020a370ace000000b006fa9e9f8f9cmr46444052qkk.694.1669651555492;
        Mon, 28 Nov 2022 08:05:55 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bk11-20020a05620a1a0b00b006fbdb9d04b1sm8605395qkb.40.2022.11.28.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:05:55 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:05:54 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 01/29] btrfs-progs: turn on more compiler warnings and
 use -Wall
Message-ID: <Y4TcYgzhVeyjKP82@localhost.localdomain>
References: <cover.1669242804.git.josef@toxicpanda.com>
 <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1669242804.git.josef@toxicpanda.com>
 <20221124205939.GO5824@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124205939.GO5824@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 24, 2022 at 09:59:39PM +0100, David Sterba wrote:
> On Wed, Nov 23, 2022 at 05:37:09PM -0500, Josef Bacik wrote:
> > In converting some of our helpers to take new args I would miss some
> > locations because we don't stop on any warning, and I would miss the
> > warning in the scrollback.  Fix this by stopping compiling on any error
> > and turn on the fancy compiler checks.
> 
> Werror depends on the compiler version and for example centos7 warns on
> { 0 } and this breaks the build. I think it could be more annoying than
> helpful. You can always use EXTRA_CFLAGS=-Werror if you're concerned
> about missing warnings but I'd rather not make it default. Perhaps it
> could be default once all reference builds are warning free.

Ahh good point, that's fair.  Thanks,

Josef
