Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201594B5813
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 18:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiBNRKB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 12:10:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiBNRKA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 12:10:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2665171
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 09:09:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A8271F38A;
        Mon, 14 Feb 2022 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644858591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FcD6z1R3ockOtaZbXLVZ2u4te7b3xygoN61xQ61izWE=;
        b=sso5yddbBVljhCs1UqksoWn3jxo6juoElEq2FpLYg4KLhpiMqNIWCszzDCdFjUKKFUYjN4
        lgxaNWHL7qV2tr2lgxOeiBFaTJog7o0TPS7OfWHxmEp3G5oXiRVjtKQ2HEf8RfuUpVeaNA
        LNIMCRp0xmSJs0pkP+TlVuSFhf8h08Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644858591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FcD6z1R3ockOtaZbXLVZ2u4te7b3xygoN61xQ61izWE=;
        b=yzz3Wa+AO7SQc0shb15P5CPoerGGdtZJUX8v1tAIqZCABt8of74CbFLnBlDvbf7L9eWvF0
        BkfE3n2DGgCzbmAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 42164A3B84;
        Mon, 14 Feb 2022 17:09:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B71C9DA832; Mon, 14 Feb 2022 18:06:07 +0100 (CET)
Date:   Mon, 14 Feb 2022 18:06:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 6/8] btrfs: do not double complete bio on errors during
 compressed reads
Message-ID: <20220214170607.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1644532798.git.josef@toxicpanda.com>
 <800ebbe66b4998ec1ac7122cc201c4404d737f18.1644532798.git.josef@toxicpanda.com>
 <YgbpHjBvf49gtEbC@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgbpHjBvf49gtEbC@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 02:54:22PM -0800, Boris Burkov wrote:
> > @@ -821,9 +821,12 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> >  	read_lock(&em_tree->lock);
> >  	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
> >  	read_unlock(&em_tree->lock);
> > -	if (!em)
> > -		return BLK_STS_IOERR;
> > +	if (!em) {
> > +		ret = BLK_STS_IOERR;
> > +		goto out;
> > +	}
> >  
> > +	ret = BLK_STS_RESOURCE;
> 
> I think the error handling logic with all the special exit paths makes
> it worthwhile to set ret at each individual 'goto failX'.

Yeah, this is IMHO more clear which error is returned from the error
branches than some random value set before.
