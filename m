Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAA3F649B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhHXRFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:05:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhHXRDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:03:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4193A2006F;
        Tue, 24 Aug 2021 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629824587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZd7O33uCh698RLdjsO7VmX9aFpbnzBwA+vkamP9X2M=;
        b=t1mdELS+YrqyrImwQaOaBsdLm+yZtTZnozqP5tlNI/1Iz4hdUcMb6AGItijWvJ1waJQzAr
        Pyz9QenHDvySgckdKqz2M8nwDGHdw+JSmRQkldgSTkaLuXc72cY5XMit2IgyrbTeaEXwuc
        UuXgEHCzSYcSQMMCBVaMyzeZ6KdL22k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629824587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZd7O33uCh698RLdjsO7VmX9aFpbnzBwA+vkamP9X2M=;
        b=awRIRs0nRzWZFM9tRfpKB0JwRDAZeuunaOfgzOJaMyG91S8tmPFkbZ6qlPTrtSUtvXlCYq
        fpZuYAxQHh8Gy0Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3A88AA3BBD;
        Tue, 24 Aug 2021 17:03:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B5B6DA85B; Tue, 24 Aug 2021 19:00:20 +0200 (CEST)
Date:   Tue, 24 Aug 2021 19:00:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 8/9] btrfs-progs: test: add a test image with a
 corrupt block group item
Message-ID: <20210824170020.GF3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629746415.git.josef@toxicpanda.com>
 <f55af588317b5c3f1d70634b0202c6fa19bb19a8.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55af588317b5c3f1d70634b0202c6fa19bb19a8.1629746415.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 03:23:12PM -0400, Josef Bacik wrote:
> This image has a broken used field of a block group item to validate
> fsck does the correct thing.

Should there be a new image or are you just adding the
.lowmem_repairable file to trigger lowmem repair?
