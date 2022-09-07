Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988625AF80A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIFWfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 18:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIFWfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 18:35:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E192F7F;
        Tue,  6 Sep 2022 15:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B4B8B81AAA;
        Tue,  6 Sep 2022 22:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F9C433D6;
        Tue,  6 Sep 2022 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503749;
        bh=SrziL2ksriZvzaRiyin3M4bqxu4CfVpH4zWoap9kL4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3Xi9HKyhdaIoYXrOPcoww0jrVmOxKyr3FrKBmZ5lKp2YlaUEuCwjJQKAp6dUACuY
         vdvqLewk3pVml+5MLj41B8Z6EK8eL1b8qfmQS9rehckwM5NyRAdXhi36dfak1qA4sj
         hq22t70napGek+yn9yZxiRu5EodtVKrU2HyyA2teGU6z1yn4LTd5d98J9U2jKj2Qpp
         SPW8CUamqnLxWwMDRBv7XjpbXVg6Qh8LtH4EGlLNsmnWOwuZDXebfGIvqryMbW3S3C
         5/1kVvEs8IocFaQtQJl2A5gT5yLxRSB974DvbhijpOzIXP7NBE34ru8eUBWmE8mVlg
         7bCf7tkovWBeQ==
Date:   Tue, 6 Sep 2022 15:35:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/20] btrfs: add fscrypt integration
Message-ID: <YxfLQzL9BYnxwaXQ@quark>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662420176.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:15PM -0400, Sweet Tea Dorminy wrote:
> This is a changeset adding encryption to btrfs.

What git tree and commit does this apply to?

- Eric
