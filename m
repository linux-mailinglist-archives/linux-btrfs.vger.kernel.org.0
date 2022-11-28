Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2673D63AD3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiK1QFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiK1QFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:05:13 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480261F2E2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:05:12 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id c2so7565937qko.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm82NvcJJ0TxIYxxYEelbagbGPMEJqHr0oesk9tE2nc=;
        b=5VrvLLvjqdFh2WYlS7m/ryvM/KefenAEGp1DPVzuFStoHGqka3L20RfLDZa3RgKIsL
         jwf4LtBpc6MQ/BE6hybtoaIfWSlM04gquWJOjPqmuEQhLNdaIEmu4HY1GKS2YlFwbzvK
         25u9D18BV/+g61wV2aHnSN3cS4hKG4NyI+DpPBFFV5P2hbVxxMW/GtWOKeedm/GJ1W30
         gUjb8GCpG6uIj+eCNvvNt0Z8Mc00aquN2pDO9+5TDHMCUU+v/h8625yjZFDYZ3FlZ3NW
         1IlJESnUhoPcfCLR2bC5NjPKQSsn7g1UAttz2fXCIRLpiK0esbtC4S/iqrSbjwB6Gsd6
         9RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm82NvcJJ0TxIYxxYEelbagbGPMEJqHr0oesk9tE2nc=;
        b=BC5rzMzOsNtt/1MHzihX5cWQM/KcOUX1YLuWiMiiYxzhHcG6KvJ9Hssd6UBBvAYgOM
         Iblu51cMVrITEaM7s6nOI5tX0XGbS5xKbSrclaAz+S6GbKF2acBtsymxluR8lGKk9v9k
         jPLw0PR6ikuUO6kLqimILgC28mTAV1XGIsE6C2AKa9D1bJMNWAedYkHXMxrbxN/+blAG
         SQ6kTU8zJVrjDnFTDv71aYyFBczLjOwVM+eXV5lzrv3CTgrbMkOqavTNFwXTA4fzapgI
         Le+Fq0LJ5fXI9c3LCxF4cakq48c9jsHkFhKaNb9JWFFg6fHdSR589In9BFB1szxKGSUi
         SgrQ==
X-Gm-Message-State: ANoB5plybWG9zU1ycD0Vqh+TDQK6SSP7uFbKb4PfuN9/NH6Sq9vxVjqY
        IfQlB55jyHeZgqnKPlcp1c5zjQ==
X-Google-Smtp-Source: AA0mqf40qPHG7nDHyLejwqfBGVWPykNYrd8qg2I2zuEdkHUYsZM8mtoXWflz0H7wWdeORfO0onK47A==
X-Received: by 2002:a37:acd:0:b0:6ee:9097:ccc1 with SMTP id 196-20020a370acd000000b006ee9097ccc1mr46895930qkk.484.1669651511230;
        Mon, 28 Nov 2022 08:05:11 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l18-20020ac848d2000000b0035ce8965045sm7109676qtr.42.2022.11.28.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:05:10 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:05:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] fstests/btrfs: add a test case for send v2 and an
 update
Message-ID: <Y4TcNbwq4DXfP3Ac@localhost.localdomain>
References: <cover.1669636339.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669636339.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 12:07:20PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This adds a test case specific for send v2 with some preparatory work in
> order to allow for that. Support for v2 send streams was added in
> btrfs-progs v5.19 and the kernel support introduced with kernel 6.0.
> 
> More send v2 specific tests will be added later.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the whole series, thanks,

Josef
