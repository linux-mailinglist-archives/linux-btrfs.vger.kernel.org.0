Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4F6A3F39
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjB0KM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 05:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB0KM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 05:12:28 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA51EFEC;
        Mon, 27 Feb 2023 02:12:27 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.2.41.146])
        by gnuweeb.org (Postfix) with ESMTPSA id 0AA57831B7;
        Mon, 27 Feb 2023 10:12:23 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677492747;
        bh=u3qEqFkeE4T56u3EXIG5jqUluJKgXayls8LqFRGaOXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eG75+PgTq7DreIVmOOQw7VyWdnNRBRFjCcC+90aFE5bCGwCCi/QGppSsDVLgn4HTm
         QnqOtn8wyOteG5g6B9iz3VygFBB0jJJdNCj0/vQaHFesbll71fvd0HTObdLfToyyhF
         ujDs5/HC1GOElAdXxfYMq6LHXNl6EeW+35t+Ye3n8Vpr98okLc5MJx/tZiXKc4nD1J
         zXvDuAeLB3jVwq5L9pcdJPnfV0M8SjbTzszidWba8gYuVqchpLUpzv/T3i/lNdxXfn
         xXjMj5Q+BYbycoodkcg9rorM5vd13h76qIxe7GS1YzOtOeTNLk35pCiTeUXv8Dj0lL
         G5xEgjhDG5GiQ==
Date:   Mon, 27 Feb 2023 17:12:20 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 1/2] Documentation: btrfs: Document wq_cpu_set
 mount option
Message-ID: <Y/yCBKfBHCfvqWhB@biznet-home.integral.gnuweeb.org>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
 <20230226162639.20559-2-ammarfaizi2@gnuweeb.org>
 <Y/wUUBf9fuIAPsNw@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/wUUBf9fuIAPsNw@debian.me>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 09:24:16AM +0700, Bagas Sanjaya wrote:
> "*cpu_set* is a dot-separated list of CPU numbers. Both individual
> number and range (inclusive) can be listed".

Folded in.

> "... replaced by dots, since commas has already been used as mount
> options separator".

Folded in with s/commas/comma/.

> "If both options are set ..."

Folded in.

Thanks,

-- 
Ammar Faizi

