Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006964F9A10
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiDHQGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiDHQGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 12:06:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7220C191
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 09:04:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CD0D1F865;
        Fri,  8 Apr 2022 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649433882;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjohbSFsd+NiBTIy4Hs33V4IHYhM5qgd8w6t13FpSpA=;
        b=hP9vvJHnah9QcczlUhwvgzCbS/juMwjg6TBcLc/7szXKqBvt6YZcXW3hUwvnuNpQRAFEMa
        aBPKbUsCRt98fCvWEK0xsBXycsHnEgdkKUEYBPYt8p/q4+nhj0gmqirt0VgGd6aAXwHdLZ
        o9epWDttwcdRa4LqTG3Bvlg+kYC+Zkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649433882;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjohbSFsd+NiBTIy4Hs33V4IHYhM5qgd8w6t13FpSpA=;
        b=CzonyeigLTJg2aKNirA9/hwGpPIqIC9oWTqUV+SuFRO/8nEKJNWOkTuMXmgyOrLUJA18DY
        zzrGjqaxv6TuaiBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE1E3A3B82;
        Fri,  8 Apr 2022 16:04:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 001E2DA832; Fri,  8 Apr 2022 18:00:38 +0200 (CEST)
Date:   Fri, 8 Apr 2022 18:00:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 1 v2
Message-ID: <20220408160038.GS15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 07:08:27AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series  moves btrfs to use the new as of 5.18 bio interface and
> cleans up a few close by areas.  Larger cleanups focussed around
> the btrfs_bio will follow as a next step.
> 
> Changes since v1:
>  - rebased to btrfs/misc-next
>  - improve a commit log

Series added to misc-next, thanks. I compared the version I had locally
with the v2, there were only 2 lines swapped, besides the minor style
fixups and reworded subjects when they were too generic.
