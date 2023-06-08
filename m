Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DC728054
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjFHMoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjFHMow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:44:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9526B1
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:44:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A71481FDCA;
        Thu,  8 Jun 2023 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686228289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kJ3YGhuFlEaeraXqe0PY2abfl8lmVgTHhb1btzMklM=;
        b=EpcO3Mtj+5s07YMK3MK9pzkiD5f1ZDpjDwyd4tCbJlKt6FY5jj5EKLl/XE9LCzDFOf2EHx
        olMLNm3T2rMgpbciDubiloiOXgKs+aPvHK8Aag279mhuOotzKX+ADM2D3xC3FJpRVgL5X4
        MlNUSK5Q5GLv48VRwovEANfx6iHxR8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686228289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kJ3YGhuFlEaeraXqe0PY2abfl8lmVgTHhb1btzMklM=;
        b=2KwnDOASOzgucqClGC2Lj7ntXHrcYSuJj/H2EmK8dcDNemjCfwgG2rTiuTZoteWACq1wX7
        CFxJaSbWXRDITCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E6C013480;
        Thu,  8 Jun 2023 12:44:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yxYFIkHNgWSBSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:44:49 +0000
Date:   Thu, 8 Jun 2023 14:38:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs-progs: check_mounted_where: pack varibles type
 by size
Message-ID: <20230608123833.GG28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686202417.git.anand.jain@oracle.com>
 <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
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

On Thu, Jun 08, 2023 at 02:00:59PM +0800, Anand Jain wrote:
> Pack variables by their type; it may save some space.

AFAIK compiler does not stick to the order defined in the sources on
stack and is free to reorder variables or completely optimize them out
so I don't see point in doing such changes.

> Also, fixes a line
> indentation.

And we don't want whitespace-only patches unless it's something that
really annoys us. Argument formatting is mixed and as long as it's
readable it should not be changed. Acceptable styles are one or two tabs
or align under the openeing ( .
