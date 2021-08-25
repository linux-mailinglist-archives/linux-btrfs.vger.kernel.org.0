Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A313F75E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhHYNbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 09:31:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57838 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhHYNbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 09:31:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5DA2E221EF;
        Wed, 25 Aug 2021 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629898231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEQLW6beWUioTIwPOerARHawQ6fTYxKWmJSjqjPJM5g=;
        b=H8o8DJsQls7SC50io2mzUIbgNO4PuYd+zqncY77LoVDpuktmNI2+VnJa00AdiCTU8S4aKQ
        WoM3Ne7khGGeUQ8ktk6YG/yc57j/ZkkML6k/K8UJUMDRfSdKWuPPfiyC7t9EbpPdw5KMwl
        GdFRYhz2BJXHkezLZtZKfOcmZMDH0BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629898231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEQLW6beWUioTIwPOerARHawQ6fTYxKWmJSjqjPJM5g=;
        b=SHdYjmDQn3rZBk3Vw6mrR5hc41ODH5UzFNr+cO10t1CyfC5zfqJWrQzAiOiHtxfu+LDIeO
        KsMsXVIV/Ziv7UBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5538BA3B8B;
        Wed, 25 Aug 2021 13:30:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0D61DA799; Wed, 25 Aug 2021 15:27:43 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:27:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 8/9] btrfs-progs: test: add a test image with a
 corrupt block group item
Message-ID: <20210825132743.GJ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629746415.git.josef@toxicpanda.com>
 <f55af588317b5c3f1d70634b0202c6fa19bb19a8.1629746415.git.josef@toxicpanda.com>
 <20210824170020.GF3379@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824170020.GF3379@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 07:00:20PM +0200, David Sterba wrote:
> On Mon, Aug 23, 2021 at 03:23:12PM -0400, Josef Bacik wrote:
> > This image has a broken used field of a block group item to validate
> > fsck does the correct thing.
> 
> Should there be a new image or are you just adding the
> .lowmem_repairable file to trigger lowmem repair?

Merged with patch from v2 that contained the image.
