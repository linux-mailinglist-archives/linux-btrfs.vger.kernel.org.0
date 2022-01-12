Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73648C76D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354721AbiALPlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 10:41:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbiALPle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 10:41:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EED161F39B;
        Wed, 12 Jan 2022 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642002092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUgJSzs3nA4LVMlV8n/oix+dcymZFQKBPO4Yqn8l2l0=;
        b=P7fC2W93l17lzlNJbSWohDCY1cAx1hZWSvDd4v36Rf5qSinon+V1Gmra7t8XvdJcaegVQp
        SHeIFesOs2ael2H5v6rOBJfqUsRF7TRA1HaTX/3KqgrhPW3DLmzdRNuklGHMSmESYxHYft
        jnhdjqGHnxhe8mbQ5bfAdvliijoQyPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642002092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUgJSzs3nA4LVMlV8n/oix+dcymZFQKBPO4Yqn8l2l0=;
        b=USnu9xhKF3hkOGfOOe7vOtdpa0/+7aLA0+k6w7UJyUI+ioZXP7PEvSWUt+VDhmpq9ooPKo
        X8/nn8ngdFXK5nCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id ED4A8A3B81;
        Wed, 12 Jan 2022 15:41:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2745ADA7A3; Wed, 12 Jan 2022 16:40:59 +0100 (CET)
Date:   Wed, 12 Jan 2022 16:40:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Move missing device handling in a dedicate
 function
Message-ID: <20220112154058.GY14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220111160026.1900599-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111160026.1900599-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 11, 2022 at 06:00:26PM +0200, Nikolay Borisov wrote:
> This simplifies the code flow in read_one_chunk and makes error handling
> when handling missing devices a bit simipler by reducing it to a single
> check if something went wrong. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
